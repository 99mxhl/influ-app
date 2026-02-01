package com.influ.deal.dto;

import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.Size;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class RequestRevisionRequest {

    @NotBlank(message = "Revision notes are required")
    @Size(max = 2000, message = "Revision notes must not exceed 2000 characters")
    private String revisionNotes;
}
