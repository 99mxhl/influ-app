package com.influ.deal;

import com.influ.common.dto.ApiResponse;
import com.influ.deal.dto.CreateDeliverableRequest;
import com.influ.deal.dto.DeliverableResponse;
import com.influ.deal.dto.RejectDeliverableRequest;
import com.influ.deal.dto.RequestRevisionRequest;
import com.influ.deal.dto.SubmitDeliverableRequest;
import com.influ.user.User;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.tags.Tag;
import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import org.springframework.http.HttpStatus;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.UUID;

@RestController
@RequestMapping("/api/deals/{dealId}/deliverables")
@RequiredArgsConstructor
@Validated
@Tag(name = "Deliverables", description = "Deliverable management endpoints")
public class DeliverableController {

    private final DeliverableService deliverableService;

    @PostMapping
    @ResponseStatus(HttpStatus.CREATED)
    @Operation(summary = "Create a new deliverable (client only)")
    public ApiResponse<DeliverableResponse> createDeliverable(
            @AuthenticationPrincipal User user,
            @PathVariable UUID dealId,
            @Valid @RequestBody CreateDeliverableRequest request) {
        return ApiResponse.success(deliverableService.createDeliverable(user, dealId, request));
    }

    @GetMapping
    @Operation(summary = "Get all deliverables for a deal")
    public ApiResponse<List<DeliverableResponse>> getDeliverables(
            @AuthenticationPrincipal User user,
            @PathVariable UUID dealId) {
        return ApiResponse.success(deliverableService.getDeliverables(user, dealId));
    }

    @GetMapping("/{id}")
    @Operation(summary = "Get deliverable by ID")
    public ApiResponse<DeliverableResponse> getDeliverable(
            @AuthenticationPrincipal User user,
            @PathVariable UUID dealId,
            @PathVariable UUID id) {
        return ApiResponse.success(deliverableService.getDeliverable(user, dealId, id));
    }

    @PostMapping("/{id}/submit")
    @Operation(summary = "Submit deliverable content (influencer only)")
    public ApiResponse<DeliverableResponse> submitDeliverable(
            @AuthenticationPrincipal User user,
            @PathVariable UUID dealId,
            @PathVariable UUID id,
            @Valid @RequestBody SubmitDeliverableRequest request) {
        return ApiResponse.success(deliverableService.submitDeliverable(user, dealId, id, request));
    }

    @PostMapping("/{id}/approve")
    @Operation(summary = "Approve deliverable (client only)")
    public ApiResponse<DeliverableResponse> approveDeliverable(
            @AuthenticationPrincipal User user,
            @PathVariable UUID dealId,
            @PathVariable UUID id) {
        return ApiResponse.success(deliverableService.approveDeliverable(user, dealId, id));
    }

    @PostMapping("/{id}/reject")
    @Operation(summary = "Reject deliverable (client only)")
    public ApiResponse<DeliverableResponse> rejectDeliverable(
            @AuthenticationPrincipal User user,
            @PathVariable UUID dealId,
            @PathVariable UUID id,
            @Valid @RequestBody RejectDeliverableRequest request) {
        return ApiResponse.success(deliverableService.rejectDeliverable(user, dealId, id, request));
    }

    @PostMapping("/{id}/revision")
    @Operation(summary = "Request revision (client only)")
    public ApiResponse<DeliverableResponse> requestRevision(
            @AuthenticationPrincipal User user,
            @PathVariable UUID dealId,
            @PathVariable UUID id,
            @Valid @RequestBody RequestRevisionRequest request) {
        return ApiResponse.success(deliverableService.requestRevision(user, dealId, id, request));
    }
}
