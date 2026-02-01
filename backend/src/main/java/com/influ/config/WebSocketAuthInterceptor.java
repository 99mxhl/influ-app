package com.influ.config;

import com.influ.auth.JwtService;
import com.influ.user.User;
import com.influ.user.UserRepository;
import lombok.RequiredArgsConstructor;
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

import java.util.List;
import java.util.UUID;

@Slf4j
@Component
@RequiredArgsConstructor
public class WebSocketAuthInterceptor implements ChannelInterceptor {

    private static final String AUTH_FAILED_MESSAGE = "Authentication failed";

    private final JwtService jwtService;
    private final UserRepository userRepository;

    @Override
    public Message<?> preSend(@NonNull Message<?> message, @NonNull MessageChannel channel) {
        StompHeaderAccessor accessor = MessageHeaderAccessor.getAccessor(message, StompHeaderAccessor.class);

        if (accessor != null && StompCommand.CONNECT.equals(accessor.getCommand())) {
            authenticateConnection(accessor);
        }

        return message;
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
