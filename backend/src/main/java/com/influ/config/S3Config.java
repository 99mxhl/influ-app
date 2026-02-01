package com.influ.config;

import jakarta.annotation.PostConstruct;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.core.env.Environment;
import software.amazon.awssdk.auth.credentials.AwsBasicCredentials;
import software.amazon.awssdk.auth.credentials.StaticCredentialsProvider;
import software.amazon.awssdk.regions.Region;
import software.amazon.awssdk.services.s3.S3Client;
import software.amazon.awssdk.services.s3.presigner.S3Presigner;

import java.util.Arrays;

@Configuration
@Slf4j
public class S3Config {

    private final Environment environment;

    @Value("${aws.access-key-id:}")
    private String accessKeyId;

    @Value("${aws.secret-access-key:}")
    private String secretAccessKey;

    @Value("${aws.region:us-east-1}")
    private String region;

    public S3Config(Environment environment) {
        this.environment = environment;
    }

    @PostConstruct
    public void validateConfiguration() {
        boolean isProduction = Arrays.asList(environment.getActiveProfiles()).contains("prod");
        boolean credentialsMissing = accessKeyId.isEmpty() || secretAccessKey.isEmpty();

        if (credentialsMissing) {
            if (isProduction) {
                throw new IllegalStateException(
                    "AWS credentials not configured. Set AWS_ACCESS_KEY_ID and AWS_SECRET_ACCESS_KEY environment variables.");
            }
            log.warn("AWS credentials not configured. S3 will use default credential chain (IAM role, env vars, etc.)");
        }
    }

    @Bean
    public S3Client s3Client() {
        if (accessKeyId.isEmpty() || secretAccessKey.isEmpty()) {
            return S3Client.builder()
                    .region(Region.of(region))
                    .build();
        }

        return S3Client.builder()
                .region(Region.of(region))
                .credentialsProvider(StaticCredentialsProvider.create(
                        AwsBasicCredentials.create(accessKeyId, secretAccessKey)))
                .build();
    }

    @Bean
    public S3Presigner s3Presigner() {
        if (accessKeyId.isEmpty() || secretAccessKey.isEmpty()) {
            return S3Presigner.builder()
                    .region(Region.of(region))
                    .build();
        }

        return S3Presigner.builder()
                .region(Region.of(region))
                .credentialsProvider(StaticCredentialsProvider.create(
                        AwsBasicCredentials.create(accessKeyId, secretAccessKey)))
                .build();
    }
}
