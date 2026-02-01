package com.influ.deal.dto;

import jakarta.validation.constraints.NotBlank;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class RejectDeliverableRequest {

    @NotBlank(message = "Rejection reason is required")
    private String reason;

    private String revisionNotes;
}
