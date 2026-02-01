package com.influ.deal.dto;

import jakarta.validation.constraints.NotBlank;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class SubmitDeliverableRequest {

    @NotBlank(message = "Content URL is required")
    private String contentUrl;

    private String thumbnailUrl;
}
