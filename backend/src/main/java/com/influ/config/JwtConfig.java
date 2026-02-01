package com.influ.config;

import jakarta.annotation.PostConstruct;
import lombok.Getter;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Configuration;
import org.springframework.core.env.Environment;

import java.util.Arrays;

@Configuration
@Getter
@Slf4j
public class JwtConfig {

    private final Environment environment;

    @Value("${jwt.secret:}")
    private String secret;

    @Value("${jwt.access-expiration-ms:900000}")
    private long accessExpirationMs;

    @Value("${jwt.refresh-expiration-ms:604800000}")
    private long refreshExpirationMs;

    public JwtConfig(Environment environment) {
        this.environment = environment;
    }

    @PostConstruct
    public void validateConfiguration() {
        boolean isProduction = Arrays.asList(environment.getActiveProfiles()).contains("prod");
        boolean isWeakSecret = secret.isEmpty() || secret.contains("development-only") || secret.length() < 32;

        if (isWeakSecret) {
            if (isProduction) {
                throw new IllegalStateException(
                    "JWT secret not configured or too weak. Set JWT_SECRET environment variable with at least 256 bits.");
            }
            log.warn("Using weak JWT secret. Set JWT_SECRET environment variable for production.");
        }
    }
}
