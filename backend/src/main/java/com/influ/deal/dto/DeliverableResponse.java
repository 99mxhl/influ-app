package com.influ.deal.dto;

import com.influ.campaign.Platform;
import com.influ.deal.ContentType;
import com.influ.deal.DeliverableStatus;
import lombok.Builder;
import lombok.Getter;

import java.time.Instant;
import java.util.UUID;

@Getter
@Builder
public class DeliverableResponse {

    private UUID id;
    private UUID dealId;
    private Platform platform;
    private ContentType contentType;
    private String description;
    private String contentUrl;
    private String thumbnailUrl;
    private DeliverableStatus status;
    private String rejectionReason;
    private String revisionNotes;
    private Instant createdAt;
    private Instant updatedAt;
}
