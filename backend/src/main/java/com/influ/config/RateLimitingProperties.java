package com.influ.config;

import lombok.Getter;
import lombok.Setter;
import org.springframework.boot.context.properties.ConfigurationProperties;
import org.springframework.stereotype.Component;

import java.time.Duration;

@Component
@ConfigurationProperties(prefix = "rate-limiting")
@Getter
@Setter
public class RateLimitingProperties {

    private int authRequestsPerMinute = 10;
    private int refreshRequestsPerMinute = 5;
    private int websocketConnectsPerMinute = 30;
    private int maxCacheSize = 10_000;
    private Duration cacheExpiry = Duration.ofMinutes(10);
    private boolean trustProxy = false;
}
