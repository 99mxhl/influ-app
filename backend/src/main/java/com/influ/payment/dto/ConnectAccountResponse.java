package com.influ.payment.dto;

import lombok.Builder;
import lombok.Getter;

@Getter
@Builder
public class ConnectAccountResponse {

    private String accountId;
    private String onboardingUrl;
}
