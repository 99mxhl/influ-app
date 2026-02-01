package com.influ.auth;

import io.jsonwebtoken.Claims;
import io.jsonwebtoken.JwtException;
import io.jsonwebtoken.Jwts;
import io.jsonwebtoken.security.Keys;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.core.env.Environment;
import org.springframework.stereotype.Service;

import javax.crypto.SecretKey;
import java.nio.charset.StandardCharsets;
import java.time.Instant;
import java.util.Arrays;
import java.util.Base64;
import java.util.Date;
import java.util.UUID;

@Slf4j
@Service
public class JwtService {

    private static final int MIN_SECRET_BYTES = 32; // 256 bits

    private final SecretKey secretKey;
    private final long accessExpirationMs;
    private final long refreshExpirationMs;

    public JwtService(
            @Value("${jwt.secret}") String secret,
            @Value("${jwt.access-expiration-ms}") long accessExpirationMs,
            @Value("${jwt.refresh-expiration-ms}") long refreshExpirationMs,
            Environment environment) {
        validateSecret(secret, environment);
        this.secretKey = Keys.hmacShaKeyFor(secret.getBytes(StandardCharsets.UTF_8));
        this.accessExpirationMs = accessExpirationMs;
        this.refreshExpirationMs = refreshExpirationMs;
    }

    private void validateSecret(String secret, Environment environment) {
        boolean isProduction = Arrays.asList(environment.getActiveProfiles()).contains("prod");
        boolean isWeak = !hasValidEntropy(secret);

        if (isWeak) {
            if (isProduction) {
                throw new IllegalStateException(
                    "JWT secret too weak. Use a base64-encoded secret with at least 256 bits.");
            }
            log.warn("Using weak JWT secret. Set a strong JWT_SECRET for production.");
        }
    }

    private boolean hasValidEntropy(String secret) {
        if (secret == null || secret.isEmpty()) {
            return false;
        }
        // Try base64 first
        try {
            byte[] decoded = Base64.getDecoder().decode(secret);
            if (decoded.length >= MIN_SECRET_BYTES) {
                return true;
            }
        } catch (IllegalArgumentException e) {
            // Not base64, check raw bytes
        }
        // Accept raw strings with sufficient byte length
        return secret.getBytes(java.nio.charset.StandardCharsets.UTF_8).length >= MIN_SECRET_BYTES;
    }

    public String generateAccessToken(UUID userId, String email) {
        Instant now = Instant.now();
        return Jwts.builder()
                .subject(userId.toString())
                .claim("email", email)
                .issuedAt(Date.from(now))
                .expiration(Date.from(now.plusMillis(accessExpirationMs)))
                .signWith(secretKey)
                .compact();
    }

    public String generateRefreshToken() {
        return UUID.randomUUID().toString();
    }

    public Instant getRefreshTokenExpiration() {
        return Instant.now().plusMillis(refreshExpirationMs);
    }

    public UUID extractUserId(String token) {
        Claims claims = extractClaims(token);
        return UUID.fromString(claims.getSubject());
    }

    public String extractEmail(String token) {
        Claims claims = extractClaims(token);
        return claims.get("email", String.class);
    }

    public boolean isTokenValid(String token) {
        try {
            Claims claims = extractClaims(token);
            return claims.getExpiration().after(new Date());
        } catch (JwtException | IllegalArgumentException e) {
            return false;
        }
    }

    private Claims extractClaims(String token) {
        return Jwts.parser()
                .verifyWith(secretKey)
                .build()
                .parseSignedClaims(token)
                .getPayload();
    }
}
