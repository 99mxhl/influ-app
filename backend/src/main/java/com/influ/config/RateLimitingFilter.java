package com.influ.config;

import com.github.benmanes.caffeine.cache.Cache;
import com.github.benmanes.caffeine.cache.Caffeine;
import io.github.bucket4j.Bandwidth;
import io.github.bucket4j.Bucket;
import io.github.bucket4j.ConsumptionProbe;
import io.github.bucket4j.Refill;
import jakarta.servlet.FilterChain;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.lang.NonNull;
import org.springframework.stereotype.Component;
import org.springframework.web.filter.OncePerRequestFilter;

import java.io.IOException;
import java.time.Duration;
import java.util.concurrent.TimeUnit;
import java.util.regex.Pattern;

@Slf4j
@Component
public class RateLimitingFilter extends OncePerRequestFilter {

    private static final int AUTH_REQUESTS_PER_MINUTE = 10;
    private static final int REFRESH_REQUESTS_PER_MINUTE = 5;
    private static final int MAX_CACHE_SIZE = 10_000;
    private static final Duration CACHE_EXPIRY = Duration.ofMinutes(10);

    private static final Pattern IP_PATTERN = Pattern.compile(
            "^((25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\\.){3}(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)$|" +
            "^([0-9a-fA-F]{1,4}:){7}[0-9a-fA-F]{1,4}$"
    );

    private final Cache<String, Bucket> authBuckets;
    private final Cache<String, Bucket> refreshBuckets;
    private final boolean trustProxy;

    public RateLimitingFilter(@Value("${rate-limiting.trust-proxy:false}") boolean trustProxy) {
        this.trustProxy = trustProxy;
        this.authBuckets = Caffeine.newBuilder()
                .maximumSize(MAX_CACHE_SIZE)
                .expireAfterAccess(CACHE_EXPIRY)
                .build();
        this.refreshBuckets = Caffeine.newBuilder()
                .maximumSize(MAX_CACHE_SIZE)
                .expireAfterAccess(CACHE_EXPIRY)
                .build();
    }

    @Override
    protected void doFilterInternal(
            @NonNull HttpServletRequest request,
            @NonNull HttpServletResponse response,
            @NonNull FilterChain filterChain) throws ServletException, IOException {

        String path = request.getRequestURI();
        String clientIp = getClientIp(request);

        if (isAuthEndpoint(path)) {
            Bucket bucket = authBuckets.get(clientIp, this::createAuthBucket);
            ConsumptionProbe probe = bucket.tryConsumeAndReturnRemaining(1);
            addRateLimitHeaders(response, AUTH_REQUESTS_PER_MINUTE, probe);
            if (!probe.isConsumed()) {
                log.warn("Rate limit exceeded for auth endpoint from IP: {}", clientIp);
                sendRateLimitResponse(response, probe.getNanosToWaitForRefill());
                return;
            }
        } else if (isRefreshEndpoint(path)) {
            Bucket bucket = refreshBuckets.get(clientIp, this::createRefreshBucket);
            ConsumptionProbe probe = bucket.tryConsumeAndReturnRemaining(1);
            addRateLimitHeaders(response, REFRESH_REQUESTS_PER_MINUTE, probe);
            if (!probe.isConsumed()) {
                log.warn("Rate limit exceeded for refresh endpoint from IP: {}", clientIp);
                sendRateLimitResponse(response, probe.getNanosToWaitForRefill());
                return;
            }
        }

        filterChain.doFilter(request, response);
    }

    private boolean isAuthEndpoint(String path) {
        return path.equals("/api/auth/login") || path.equals("/api/auth/register");
    }

    private boolean isRefreshEndpoint(String path) {
        return path.equals("/api/auth/refresh");
    }

    private Bucket createAuthBucket(String key) {
        return Bucket.builder()
                .addLimit(Bandwidth.classic(AUTH_REQUESTS_PER_MINUTE,
                        Refill.greedy(AUTH_REQUESTS_PER_MINUTE, Duration.ofMinutes(1))))
                .build();
    }

    private Bucket createRefreshBucket(String key) {
        return Bucket.builder()
                .addLimit(Bandwidth.classic(REFRESH_REQUESTS_PER_MINUTE,
                        Refill.greedy(REFRESH_REQUESTS_PER_MINUTE, Duration.ofMinutes(1))))
                .build();
    }

    private String getClientIp(HttpServletRequest request) {
        if (trustProxy) {
            String xForwardedFor = request.getHeader("X-Forwarded-For");
            if (xForwardedFor != null && !xForwardedFor.isEmpty()) {
                String ip = xForwardedFor.split(",")[0].trim();
                if (isValidIp(ip)) {
                    return ip;
                }
                log.warn("Invalid IP in X-Forwarded-For header: {}", ip);
            }
        }
        return request.getRemoteAddr();
    }

    private boolean isValidIp(String ip) {
        return ip != null && IP_PATTERN.matcher(ip).matches();
    }

    private void addRateLimitHeaders(HttpServletResponse response, int limit, ConsumptionProbe probe) {
        response.setHeader("X-RateLimit-Limit", String.valueOf(limit));
        response.setHeader("X-RateLimit-Remaining", String.valueOf(probe.getRemainingTokens()));
        long resetSeconds = TimeUnit.NANOSECONDS.toSeconds(probe.getNanosToWaitForRefill());
        response.setHeader("X-RateLimit-Reset", String.valueOf(System.currentTimeMillis() / 1000 + resetSeconds));
    }

    private void sendRateLimitResponse(HttpServletResponse response, long nanosToWait) throws IOException {
        long retryAfterSeconds = TimeUnit.NANOSECONDS.toSeconds(nanosToWait) + 1;
        response.setHeader("Retry-After", String.valueOf(retryAfterSeconds));
        response.setStatus(HttpStatus.TOO_MANY_REQUESTS.value());
        response.setContentType(MediaType.APPLICATION_JSON_VALUE);
        response.getWriter().write(
                "{\"success\":false,\"error\":{\"code\":\"RATE_LIMITED\",\"message\":\"Too many requests. Please try again later.\"},\"timestamp\":\"" +
                java.time.Instant.now() + "\"}");
    }
}
