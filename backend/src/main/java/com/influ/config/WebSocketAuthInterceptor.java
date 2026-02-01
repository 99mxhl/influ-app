package com.influ.config;

import com.github.benmanes.caffeine.cache.Cache;
import com.github.benmanes.caffeine.cache.Caffeine;
import com.influ.auth.JwtService;
import com.influ.user.User;
import com.influ.user.UserRepository;
import io.github.bucket4j.Bandwidth;
import io.github.bucket4j.Bucket;
import io.github.bucket4j.Refill;
import lombok.extern.slf4j.Slf4j;
import org.springframework.lang.NonNull;
import org.springframework.messaging.Message;
import org.springframework.messaging.MessageChannel;
import org.springframework.messaging.MessageDeliveryException;
import org.springframework.messaging.simp.stomp.StompCommand;
import org.springframework.messaging.simp.stomp.StompHeaderAccessor;
import org.springframework.messaging.support.ChannelInterceptor;
import org.springframework.messaging.support.MessageHeaderAccessor;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Component;

import java.net.InetSocketAddress;
import java.time.Duration;
import java.util.List;
import java.util.Map;
import java.util.UUID;
import java.util.regex.Pattern;

@Slf4j
@Component
public class WebSocketAuthInterceptor implements ChannelInterceptor {

    private static final String AUTH_FAILED_MESSAGE = "Authentication failed";
    private static final String RATE_LIMITED_MESSAGE = "Too many connection attempts";
    private static final Pattern IP_PATTERN = Pattern.compile(
            "^((25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\\.){3}(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)$|" +
            "^([0-9a-fA-F]{1,4}:){7}[0-9a-fA-F]{1,4}$"
    );

    private final JwtService jwtService;
    private final UserRepository userRepository;
    private final RateLimitingProperties rateLimitingProperties;
    private final Cache<String, Bucket> connectionBuckets;

    public WebSocketAuthInterceptor(
            JwtService jwtService,
            UserRepository userRepository,
            RateLimitingProperties rateLimitingProperties) {
        this.jwtService = jwtService;
        this.userRepository = userRepository;
        this.rateLimitingProperties = rateLimitingProperties;
        this.connectionBuckets = Caffeine.newBuilder()
                .maximumSize(rateLimitingProperties.getMaxCacheSize())
                .expireAfterAccess(rateLimitingProperties.getCacheExpiry())
                .build();
    }

    @Override
    public Message<?> preSend(@NonNull Message<?> message, @NonNull MessageChannel channel) {
        StompHeaderAccessor accessor = MessageHeaderAccessor.getAccessor(message, StompHeaderAccessor.class);

        if (accessor != null && StompCommand.CONNECT.equals(accessor.getCommand())) {
            String clientIp = extractClientIp(accessor);
            checkRateLimit(clientIp);
            authenticateConnection(accessor);
        }

        return message;
    }

    private void checkRateLimit(String clientIp) {
        Bucket bucket = connectionBuckets.get(clientIp, this::createConnectionBucket);
        if (!bucket.tryConsume(1)) {
            log.warn("WebSocket rate limit exceeded for IP: {}", clientIp);
            throw new MessageDeliveryException(RATE_LIMITED_MESSAGE);
        }
    }

    private Bucket createConnectionBucket(String key) {
        int limit = rateLimitingProperties.getWebsocketConnectsPerMinute();
        return Bucket.builder()
                .addLimit(Bandwidth.classic(limit, Refill.greedy(limit, Duration.ofMinutes(1))))
                .build();
    }

    /**
     * Extracts and validates client IP from WebSocket session.
     * Note: trustProxy should only be enabled when behind a trusted reverse proxy.
     *
     * @throws MessageDeliveryException if IP cannot be determined (prevents shared bucket DoS)
     */
    private String extractClientIp(StompHeaderAccessor accessor) {
        Object sessionAttributes = accessor.getSessionAttributes();
        if (sessionAttributes instanceof Map<?, ?>) {
            @SuppressWarnings("unchecked")
            Map<String, Object> attrs = (Map<String, Object>) sessionAttributes;

            // Check for X-Forwarded-For if proxy is trusted
            if (rateLimitingProperties.isTrustProxy()) {
                List<String> forwardedHeaders = accessor.getNativeHeader("X-Forwarded-For");
                if (forwardedHeaders != null && !forwardedHeaders.isEmpty()) {
                    String headerValue = forwardedHeaders.get(0);
                    if (headerValue != null && !headerValue.trim().isEmpty()) {
                        String ip = headerValue.split(",")[0].trim();
                        if (isValidIp(ip)) {
                            return ip;
                        }
                        log.warn("Invalid IP in X-Forwarded-For header: {}", ip);
                    }
                }
            }

            // Try to get from session attributes
            Object remoteAddress = attrs.get("org.springframework.web.socket.handler.REMOTE_ADDRESS");
            if (remoteAddress instanceof InetSocketAddress) {
                String ip = ((InetSocketAddress) remoteAddress).getAddress().getHostAddress();
                if (isValidIp(ip)) {
                    return ip;
                }
            }
        }

        // Reject connections with unknown IPs to prevent shared bucket DoS
        log.warn("WebSocket connection rejected: unable to determine client IP");
        throw new MessageDeliveryException(AUTH_FAILED_MESSAGE);
    }

    private boolean isValidIp(String ip) {
        return ip != null && IP_PATTERN.matcher(ip).matches();
    }

    private void authenticateConnection(StompHeaderAccessor accessor) {
        List<String> authHeaders = accessor.getNativeHeader("Authorization");

        if (authHeaders == null || authHeaders.isEmpty()) {
            log.warn("WebSocket connection rejected: missing Authorization header");
            rejectConnection();
            return;
        }

        String authHeader = authHeaders.get(0);
        if (!authHeader.startsWith("Bearer ")) {
            log.warn("WebSocket connection rejected: invalid Authorization header format");
            rejectConnection();
            return;
        }

        String token = authHeader.substring(7);

        try {
            UUID userId = jwtService.extractUserIdIfValid(token);
            if (userId == null) {
                log.warn("WebSocket connection rejected: invalid or expired token");
                rejectConnection();
                return;
            }

            User user = userRepository.findByIdWithProfiles(userId).orElse(null);

            if (user == null || !user.isEnabled()) {
                log.warn("WebSocket connection rejected: user validation failed");
                rejectConnection();
                return;
            }

            UsernamePasswordAuthenticationToken authToken =
                    new UsernamePasswordAuthenticationToken(user, null, user.getAuthorities());
            accessor.setUser(authToken);
            SecurityContextHolder.getContext().setAuthentication(authToken);
            log.debug("WebSocket authenticated for user: {}", user.getEmail());

        } catch (MessageDeliveryException e) {
            throw e;
        } catch (Exception e) {
            log.warn("WebSocket connection rejected: token processing failed");
            rejectConnection();
        }
    }

    private void rejectConnection() {
        SecurityContextHolder.clearContext();
        throw new MessageDeliveryException(AUTH_FAILED_MESSAGE);
    }
}
