package com.influ.campaign;

import com.influ.campaign.dto.CampaignResponse;
import com.influ.campaign.dto.CreateCampaignRequest;
import com.influ.campaign.dto.UpdateCampaignRequest;
import com.influ.common.dto.PageResponse;
import com.influ.common.exception.BusinessRuleViolationException;
import com.influ.common.exception.ResourceNotFoundException;
import com.influ.user.User;
import com.influ.user.UserType;
import lombok.RequiredArgsConstructor;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.security.access.AccessDeniedException;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.math.BigDecimal;
import java.time.LocalDate;
import java.util.UUID;

@Service
@RequiredArgsConstructor
public class CampaignService {

    private void validateBudgetAndDates(BigDecimal budgetMin, BigDecimal budgetMax,
                                        LocalDate startDate, LocalDate endDate) {
        if (budgetMin != null && budgetMax != null && budgetMin.compareTo(budgetMax) > 0) {
            throw new BusinessRuleViolationException("Minimum budget cannot exceed maximum budget");
        }
        if (startDate != null && endDate != null && startDate.isAfter(endDate)) {
            throw new BusinessRuleViolationException("Start date cannot be after end date");
        }
    }

    private final CampaignRepository campaignRepository;
    private final CampaignMapper campaignMapper;

    @Transactional
    public CampaignResponse createCampaign(User client, CreateCampaignRequest request) {
        if (client.getType() != UserType.CLIENT) {
            throw new BusinessRuleViolationException("Only clients can create campaigns");
        }

        validateBudgetAndDates(request.getBudgetMin(), request.getBudgetMax(),
                request.getStartDate(), request.getEndDate());

        Campaign campaign = new Campaign();
        campaign.setClient(client);
        campaign.setTitle(request.getTitle());
        campaign.setDescription(request.getDescription());
        campaign.setBudgetMin(request.getBudgetMin());
        campaign.setBudgetMax(request.getBudgetMax());
        campaign.setStartDate(request.getStartDate());
        campaign.setEndDate(request.getEndDate());
        campaign.setRequirements(request.getRequirements());
        campaign.setTargetAudience(request.getTargetAudience());

        if (request.getCategories() != null) {
            campaign.setCategories(request.getCategories());
        }
        if (request.getPlatforms() != null) {
            campaign.setPlatforms(request.getPlatforms());
        }
        if (request.getStatus() != null) {
            campaign.setStatus(request.getStatus());
        }

        campaign = campaignRepository.save(campaign);
        return campaignMapper.toCampaignResponse(campaign);
    }

    @Transactional(readOnly = true)
    public CampaignResponse getCampaignById(UUID id) {
        Campaign campaign = campaignRepository.findByIdWithClient(id)
                .orElseThrow(() -> new ResourceNotFoundException("Campaign", "id", id));
        return campaignMapper.toCampaignResponse(campaign);
    }

    @Transactional
    public CampaignResponse updateCampaign(User client, UUID campaignId, UpdateCampaignRequest request) {
        Campaign campaign = campaignRepository.findByIdWithClient(campaignId)
                .orElseThrow(() -> new ResourceNotFoundException("Campaign", "id", campaignId));

        if (!campaign.getClient().getId().equals(client.getId())) {
            throw new AccessDeniedException("You can only update your own campaigns");
        }

        // Validate with current values as fallback
        BigDecimal newBudgetMin = request.getBudgetMin() != null ? request.getBudgetMin() : campaign.getBudgetMin();
        BigDecimal newBudgetMax = request.getBudgetMax() != null ? request.getBudgetMax() : campaign.getBudgetMax();
        LocalDate newStartDate = request.getStartDate() != null ? request.getStartDate() : campaign.getStartDate();
        LocalDate newEndDate = request.getEndDate() != null ? request.getEndDate() : campaign.getEndDate();
        validateBudgetAndDates(newBudgetMin, newBudgetMax, newStartDate, newEndDate);

        if (request.getTitle() != null) {
            campaign.setTitle(request.getTitle());
        }
        if (request.getDescription() != null) {
            campaign.setDescription(request.getDescription());
        }
        if (request.getBudgetMin() != null) {
            campaign.setBudgetMin(request.getBudgetMin());
        }
        if (request.getBudgetMax() != null) {
            campaign.setBudgetMax(request.getBudgetMax());
        }
        if (request.getStatus() != null) {
            campaign.setStatus(request.getStatus());
        }
        if (request.getStartDate() != null) {
            campaign.setStartDate(request.getStartDate());
        }
        if (request.getEndDate() != null) {
            campaign.setEndDate(request.getEndDate());
        }
        if (request.getCategories() != null) {
            campaign.setCategories(request.getCategories());
        }
        if (request.getPlatforms() != null) {
            campaign.setPlatforms(request.getPlatforms());
        }
        if (request.getRequirements() != null) {
            campaign.setRequirements(request.getRequirements());
        }
        if (request.getTargetAudience() != null) {
            campaign.setTargetAudience(request.getTargetAudience());
        }

        campaign = campaignRepository.save(campaign);
        return campaignMapper.toCampaignResponse(campaign);
    }

    @Transactional
    public void deleteCampaign(User client, UUID campaignId) {
        Campaign campaign = campaignRepository.findByIdWithClient(campaignId)
                .orElseThrow(() -> new ResourceNotFoundException("Campaign", "id", campaignId));

        if (!campaign.getClient().getId().equals(client.getId())) {
            throw new AccessDeniedException("You can only delete your own campaigns");
        }

        campaign.softDelete();
        campaignRepository.save(campaign);
    }

    @Transactional(readOnly = true)
    public PageResponse<CampaignResponse> getAllCampaigns(Pageable pageable) {
        Page<Campaign> campaigns = campaignRepository.findAllActive(pageable);
        return PageResponse.from(
                campaigns,
                campaigns.getContent().stream()
                        .map(campaignMapper::toCampaignResponse)
                        .toList()
        );
    }

    @Transactional(readOnly = true)
    public PageResponse<CampaignResponse> getMyCampaigns(User client, Pageable pageable) {
        Page<Campaign> campaigns = campaignRepository.findByClientId(client.getId(), pageable);
        return PageResponse.from(
                campaigns,
                campaigns.getContent().stream()
                        .map(campaignMapper::toCampaignResponse)
                        .toList()
        );
    }
}
