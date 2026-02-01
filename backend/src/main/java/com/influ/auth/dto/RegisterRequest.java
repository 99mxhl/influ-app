package com.influ.auth.dto;

import com.influ.user.UserType;
import jakarta.validation.constraints.Email;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotNull;
import jakarta.validation.constraints.Size;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class RegisterRequest {

    @NotBlank(message = "Email is required")
    @Email(message = "Invalid email format")
    @Size(max = 255, message = "Email must not exceed 255 characters")
    private String email;

    // Note: @Size validates character count, but BCrypt has a 72-byte limit.
    // Unicode characters can be multi-byte, so service-layer validates byte length separately.
    @NotBlank(message = "Password is required")
    @Size(min = 8, max = 72, message = "Password must be between 8 and 72 characters")
    private String password;

    @NotNull(message = "User type is required")
    private UserType type;

    @Size(max = 100, message = "Display name must not exceed 100 characters")
    private String displayName;
}
