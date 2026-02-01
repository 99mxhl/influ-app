package com.influ.user.dto;

import lombok.Builder;
import lombok.Getter;

@Getter
@Builder
public class ProfileResponse {

    private String displayName;
    private String avatarUrl;
    private String bio;
}
