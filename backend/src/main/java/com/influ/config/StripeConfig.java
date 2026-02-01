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

@Slf4j
@Configuration
@Getter
public class StripeConfig {

    private static final String PLACEHOLDER_SECRET = "sk_test_placeholder";
    private static final String PLACEHOLDER_WEBHOOK = "whsec_placeholder";

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
        boolean isProduction = Arrays.asList(environment.getActiveProfiles()).contains("prod");

        if (isProduction) {
            if (PLACEHOLDER_SECRET.equals(secretKey) || PLACEHOLDER_WEBHOOK.equals(webhookSecret)) {
                throw new IllegalStateException(
                    "Stripe configuration contains placeholder values. Set STRIPE_SECRET_KEY and STRIPE_WEBHOOK_SECRET environment variables.");
            }
        } else if (PLACEHOLDER_SECRET.equals(secretKey)) {
            log.warn("Using placeholder Stripe secret key. Set STRIPE_SECRET_KEY for production.");
        }

        Stripe.apiKey = secretKey;
    }
}
