package com.influ.deal;

import com.influ.common.dto.ApiResponse;
import com.influ.common.dto.PageResponse;
import com.influ.deal.dto.*;
import com.influ.user.User;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.tags.Tag;
import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import org.springframework.data.domain.Pageable;
import org.springframework.data.web.PageableDefault;
import org.springframework.http.HttpStatus;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;

import java.util.UUID;

@RestController
@RequestMapping("/api/deals")
@RequiredArgsConstructor
@Validated
@Tag(name = "Deals", description = "Deal management endpoints")
public class DealController {

    private final DealService dealService;

    @PostMapping("/apply")
    @ResponseStatus(HttpStatus.CREATED)
    @Operation(summary = "Apply to a campaign as an influencer")
    public ApiResponse<DealResponse> apply(
            @AuthenticationPrincipal User influencer,
            @Valid @RequestBody ApplyToDealRequest request) {
        return ApiResponse.success(dealService.apply(influencer, request));
    }

    @PostMapping("/invite")
    @ResponseStatus(HttpStatus.CREATED)
    @Operation(summary = "Invite an influencer to a campaign as a client")
    public ApiResponse<DealResponse> invite(
            @AuthenticationPrincipal User client,
            @Valid @RequestBody InviteToDealRequest request) {
        return ApiResponse.success(dealService.invite(client, request));
    }

    @GetMapping
    @Operation(summary = "Get my deals")
    public ApiResponse<PageResponse<DealResponse>> getMyDeals(
            @AuthenticationPrincipal User user,
            @PageableDefault(size = 20) Pageable pageable) {
        return ApiResponse.success(dealService.getMyDeals(user, pageable));
    }

    @GetMapping("/{id}")
    @Operation(summary = "Get deal by ID")
    public ApiResponse<DealResponse> getDealById(
            @AuthenticationPrincipal User user,
            @PathVariable UUID id) {
        return ApiResponse.success(dealService.getDealById(user, id));
    }

    @GetMapping("/campaign/{campaignId}")
    @Operation(summary = "Get deals for a campaign (client only)")
    public ApiResponse<PageResponse<DealResponse>> getDealsByCampaign(
            @AuthenticationPrincipal User user,
            @PathVariable UUID campaignId,
            @PageableDefault(size = 20) Pageable pageable) {
        return ApiResponse.success(dealService.getDealsByCampaign(user, campaignId, pageable));
    }

    @PostMapping("/{id}/terms")
    @Operation(summary = "Propose new terms")
    public ApiResponse<DealResponse> proposeTerms(
            @AuthenticationPrincipal User user,
            @PathVariable UUID id,
            @Valid @RequestBody ProposeTermsRequest request) {
        return ApiResponse.success(dealService.proposeTerms(user, id, request));
    }

    @PutMapping("/{id}/terms/accept")
    @Operation(summary = "Accept current terms")
    public ApiResponse<DealResponse> acceptTerms(
            @AuthenticationPrincipal User user,
            @PathVariable UUID id) {
        return ApiResponse.success(dealService.acceptTerms(user, id));
    }

    @PutMapping("/{id}/terms/reject")
    @Operation(summary = "Reject current terms")
    public ApiResponse<DealResponse> rejectTerms(
            @AuthenticationPrincipal User user,
            @PathVariable UUID id) {
        return ApiResponse.success(dealService.rejectTerms(user, id));
    }

    @PutMapping("/{id}/cancel")
    @Operation(summary = "Cancel the deal")
    public ApiResponse<DealResponse> cancelDeal(
            @AuthenticationPrincipal User user,
            @PathVariable UUID id) {
        return ApiResponse.success(dealService.cancelDeal(user, id));
    }
}
