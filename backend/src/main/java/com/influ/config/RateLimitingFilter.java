package com.influ.config;

import io.github.bucket4j.Bandwidth;
import io.github.bucket4j.Bucket;
import io.github.bucket4j.Refill;
import jakarta.servlet.FilterChain;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.lang.NonNull;
import org.springframework.stereotype.Component;
import org.springframework.web.filter.OncePerRequestFilter;

import java.io.IOException;
import java.time.Duration;
import java.util.concurrent.ConcurrentHashMap;

@Slf4j
@Component
public class RateLimitingFilter extends OncePerRequestFilter {

    private static final int AUTH_REQUESTS_PER_MINUTE = 10;
    private static final int REFRESH_REQUESTS_PER_MINUTE = 5;

    private final ConcurrentHashMap<String, Bucket> authBuckets = new ConcurrentHashMap<>();
    private final ConcurrentHashMap<String, Bucket> refreshBuckets = new ConcurrentHashMap<>();

    @Override
    protected void doFilterInternal(
            @NonNull HttpServletRequest request,
            @NonNull HttpServletResponse response,
            @NonNull FilterChain filterChain) throws ServletException, IOException {

        String path = request.getRequestURI();
        String clientIp = getClientIp(request);

        if (isAuthEndpoint(path)) {
            Bucket bucket = authBuckets.computeIfAbsent(clientIp, this::createAuthBucket);
            if (!bucket.tryConsume(1)) {
                sendRateLimitResponse(response);
                return;
            }
        } else if (isRefreshEndpoint(path)) {
            Bucket bucket = refreshBuckets.computeIfAbsent(clientIp, this::createRefreshBucket);
            if (!bucket.tryConsume(1)) {
                sendRateLimitResponse(response);
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
        String xForwardedFor = request.getHeader("X-Forwarded-For");
        if (xForwardedFor != null && !xForwardedFor.isEmpty()) {
            return xForwardedFor.split(",")[0].trim();
        }
        return request.getRemoteAddr();
    }

    private void sendRateLimitResponse(HttpServletResponse response) throws IOException {
        response.setStatus(HttpStatus.TOO_MANY_REQUESTS.value());
        response.setContentType(MediaType.APPLICATION_JSON_VALUE);
        response.getWriter().write(
                "{\"success\":false,\"error\":{\"code\":\"RATE_LIMITED\",\"message\":\"Too many requests. Please try again later.\"},\"timestamp\":\"" +
                java.time.Instant.now() + "\"}");
    }
}
