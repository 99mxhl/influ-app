package com.influ.deal.dto;

import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.Pattern;
import jakarta.validation.constraints.Size;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class SubmitDeliverableRequest {

    @NotBlank(message = "Content URL is required")
    @Size(max = 2048, message = "Content URL must not exceed 2048 characters")
    @Pattern(
            regexp = "^https://[a-zA-Z0-9][-a-zA-Z0-9]*(?:\\.[a-zA-Z0-9][-a-zA-Z0-9]*)+(?:/[\\w\\-.~:/?#\\[\\]@!$&'()*+,;=%]*)?$",
            message = "Content URL must be a valid HTTPS URL"
    )
    private String contentUrl;

    @Size(max = 2048, message = "Thumbnail URL must not exceed 2048 characters")
    @Pattern(
            regexp = "^https://[a-zA-Z0-9][-a-zA-Z0-9]*(?:\\.[a-zA-Z0-9][-a-zA-Z0-9]*)+(?:/[\\w\\-.~:/?#\\[\\]@!$&'()*+,;=%]*)?$",
            message = "Thumbnail URL must be a valid HTTPS URL"
    )
    private String thumbnailUrl;
}
