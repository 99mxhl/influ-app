package com.influ.config;

import jakarta.annotation.PostConstruct;
import lombok.Getter;
import lombok.RequiredArgsConstructor;
import lombok.Setter;
import lombok.extern.slf4j.Slf4j;
import org.springframework.boot.context.properties.ConfigurationProperties;
import org.springframework.core.env.Environment;
import org.springframework.stereotype.Component;

import java.util.Arrays;
import java.util.List;

@Slf4j
@Component
@ConfigurationProperties(prefix = "cors")
@RequiredArgsConstructor
@Getter
@Setter
public class CorsProperties {

    private final Environment environment;

    private List<String> allowedOriginPatterns = List.of("http://localhost:*");
    private List<String> allowedMethods = List.of("GET", "POST", "PUT", "DELETE", "PATCH", "OPTIONS");
    private List<String> allowedHeaders = List.of("Authorization", "Content-Type", "Accept", "Origin", "X-Requested-With");
    private List<String> exposedHeaders = List.of("Authorization");
    private boolean allowCredentials = true;
    private long maxAge = 3600L;

    @PostConstruct
    public void validateCorsConfiguration() {
        boolean isProduction = Arrays.asList(environment.getActiveProfiles()).contains("prod");

        if (isProduction && allowedOriginPatterns != null) {
            for (String pattern : allowedOriginPatterns) {
                if ("*".equals(pattern)) {
                    throw new IllegalStateException(
                            "Wildcard CORS origin pattern '*' is not allowed in production. " +
                            "Please specify explicit allowed origins.");
                }
            }
        }
    }
}
