package com.influ.deal.dto;

import com.influ.campaign.Platform;
import com.influ.deal.ContentType;
import jakarta.validation.constraints.NotNull;
import jakarta.validation.constraints.Size;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class CreateDeliverableRequest {

    @NotNull(message = "Platform is required")
    private Platform platform;

    @NotNull(message = "Content type is required")
    private ContentType contentType;

    @Size(max = 500, message = "Description must be at most 500 characters")
    private String description;
}
