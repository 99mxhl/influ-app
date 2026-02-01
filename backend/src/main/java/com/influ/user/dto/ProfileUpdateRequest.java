package com.influ.user.dto;

import jakarta.validation.constraints.Pattern;
import jakarta.validation.constraints.Size;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class ProfileUpdateRequest {

    @Size(max = 100, message = "Display name must be at most 100 characters")
    private String displayName;

    @Size(max = 2048, message = "Avatar URL must be at most 2048 characters")
    @Pattern(regexp = "^(https://[a-zA-Z0-9][-a-zA-Z0-9]*\\.[-a-zA-Z0-9.]+.*)?$", message = "Avatar URL must be a valid HTTPS URL")
    private String avatarUrl;

    @Size(max = 500, message = "Bio must be at most 500 characters")
    private String bio;
}
