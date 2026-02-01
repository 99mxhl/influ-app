package com.influ.user.dto;

import jakarta.validation.constraints.Size;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class ProfileUpdateRequest {

    @Size(max = 100, message = "Display name must be at most 100 characters")
    private String displayName;

    private String avatarUrl;

    @Size(max = 500, message = "Bio must be at most 500 characters")
    private String bio;
}
