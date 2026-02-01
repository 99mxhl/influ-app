package com.influ.config;

import com.stripe.Stripe;
import jakarta.annotation.PostConstruct;
import lombok.Getter;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Configuration;
import org.springframework.core.env.Environment;

import java.math.BigDecimal;
import java.util.Arrays;

@Configuration
@Getter
@Slf4j
public class StripeConfig {

    private final Environment environment;

    @Value("${stripe.secret-key:sk_test_placeholder}")
    private String secretKey;

    @Value("${stripe.webhook-secret:whsec_placeholder}")
    private String webhookSecret;

    @Value("${stripe.platform-fee-percent:0.10}")
    private BigDecimal platformFeePercent;

    public StripeConfig(Environment environment) {
        this.environment = environment;
    }

    @PostConstruct
    public void init() {
        validateConfiguration();
        Stripe.apiKey = secretKey;
    }

    private void validateConfiguration() {
        boolean isProduction = Arrays.asList(environment.getActiveProfiles()).contains("prod");

        if (secretKey.contains("placeholder")) {
            if (isProduction) {
                throw new IllegalStateException(
                    "Stripe secret key not configured. Set STRIPE_SECRET_KEY environment variable.");
            }
            log.warn("Using placeholder Stripe secret key. Set STRIPE_SECRET_KEY for production.");
        }

        if (webhookSecret.contains("placeholder")) {
            if (isProduction) {
                throw new IllegalStateException(
                    "Stripe webhook secret not configured. Set STRIPE_WEBHOOK_SECRET environment variable.");
            }
            log.warn("Using placeholder Stripe webhook secret. Set STRIPE_WEBHOOK_SECRET for production.");
        }
    }
}
