package com.influ.campaign;

import com.influ.campaign.dto.CampaignResponse;
import com.influ.campaign.dto.CreateCampaignRequest;
import com.influ.campaign.dto.UpdateCampaignRequest;
import com.influ.common.dto.ApiResponse;
import com.influ.common.dto.PageResponse;
import com.influ.user.User;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.tags.Tag;
import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import org.springframework.data.domain.Pageable;
import org.springframework.data.web.PageableDefault;
import org.springframework.http.HttpStatus;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.web.bind.annotation.*;

import java.util.UUID;

@RestController
@RequestMapping("/api/campaigns")
@RequiredArgsConstructor
@Tag(name = "Campaigns", description = "Campaign management endpoints")
public class CampaignController {

    private final CampaignService campaignService;

    @PostMapping
    @ResponseStatus(HttpStatus.CREATED)
    @Operation(summary = "Create a new campaign")
    public ApiResponse<CampaignResponse> createCampaign(
            @AuthenticationPrincipal User client,
            @Valid @RequestBody CreateCampaignRequest request) {
        return ApiResponse.success(campaignService.createCampaign(client, request));
    }

    @GetMapping
    @Operation(summary = "Get all active campaigns")
    public ApiResponse<PageResponse<CampaignResponse>> getAllCampaigns(
            @PageableDefault(size = 20) Pageable pageable) {
        return ApiResponse.success(campaignService.getAllCampaigns(pageable));
    }

    @GetMapping("/mine")
    @Operation(summary = "Get my campaigns")
    public ApiResponse<PageResponse<CampaignResponse>> getMyCampaigns(
            @AuthenticationPrincipal User client,
            @PageableDefault(size = 20) Pageable pageable) {
        return ApiResponse.success(campaignService.getMyCampaigns(client, pageable));
    }

    @GetMapping("/{id}")
    @Operation(summary = "Get campaign by ID")
    public ApiResponse<CampaignResponse> getCampaignById(@PathVariable UUID id) {
        return ApiResponse.success(campaignService.getCampaignById(id));
    }

    @PutMapping("/{id}")
    @Operation(summary = "Update campaign")
    public ApiResponse<CampaignResponse> updateCampaign(
            @AuthenticationPrincipal User client,
            @PathVariable UUID id,
            @Valid @RequestBody UpdateCampaignRequest request) {
        return ApiResponse.success(campaignService.updateCampaign(client, id, request));
    }

    @DeleteMapping("/{id}")
    @ResponseStatus(HttpStatus.NO_CONTENT)
    @Operation(summary = "Delete campaign")
    public ApiResponse<Void> deleteCampaign(
            @AuthenticationPrincipal User client,
            @PathVariable UUID id) {
        campaignService.deleteCampaign(client, id);
        return ApiResponse.success();
    }
}
