package com.influ.deal;

import com.influ.campaign.Campaign;
import com.influ.campaign.CampaignRepository;
import com.influ.campaign.CampaignStatus;
import com.influ.common.dto.PageResponse;
import com.influ.common.exception.BusinessRuleViolationException;
import com.influ.common.exception.ResourceNotFoundException;
import com.influ.deal.dto.*;
import com.influ.user.User;
import com.influ.user.UserRepository;
import com.influ.user.UserType;
import lombok.RequiredArgsConstructor;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.security.access.AccessDeniedException;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.math.BigDecimal;
import java.math.RoundingMode;
import java.util.UUID;

@Service
@RequiredArgsConstructor
public class DealService {

    private static final BigDecimal PLATFORM_FEE_PERCENT = new BigDecimal("0.10");

    private final DealRepository dealRepository;
    private final DealTermsRepository dealTermsRepository;
    private final CampaignRepository campaignRepository;
    private final UserRepository userRepository;
    private final DealMapper dealMapper;
    private final DealAccessHelper dealAccessHelper;

    @Transactional
    public DealResponse apply(User influencer, ApplyToDealRequest request) {
        if (influencer.getType() != UserType.INFLUENCER) {
            throw new BusinessRuleViolationException("Only influencers can apply to campaigns");
        }

        Campaign campaign = campaignRepository.findByIdWithClient(request.getCampaignId())
                .orElseThrow(() -> new ResourceNotFoundException("Campaign", "id", request.getCampaignId()));

        if (campaign.getStatus() != CampaignStatus.ACTIVE) {
            throw new BusinessRuleViolationException("Campaign is not accepting applications");
        }

        if (dealRepository.existsActiveDeal(campaign.getId(), influencer.getId())) {
            throw new BusinessRuleViolationException("You already have an active deal for this campaign");
        }

        Deal deal = new Deal();
        deal.setCampaign(campaign);
        deal.setInfluencer(influencer);
        deal.setClient(campaign.getClient());
        deal.setStatus(DealStatus.APPLIED);
        deal = dealRepository.save(deal);

        if (request.getProposedAmount() != null) {
            createInitialTerms(deal, influencer, request.getProposedAmount(),
                    request.getDeliverables(), request.getNotes());
            deal.setStatus(DealStatus.NEGOTIATING);
            deal = dealRepository.save(deal);
        }

        return dealMapper.toDealResponse(deal);
    }

    @Transactional
    public DealResponse invite(User client, InviteToDealRequest request) {
        if (client.getType() != UserType.CLIENT) {
            throw new BusinessRuleViolationException("Only clients can invite influencers");
        }

        Campaign campaign = campaignRepository.findByIdWithClient(request.getCampaignId())
                .orElseThrow(() -> new ResourceNotFoundException("Campaign", "id", request.getCampaignId()));

        if (!campaign.getClient().getId().equals(client.getId())) {
            throw new AccessDeniedException("You can only invite to your own campaigns");
        }

        if (campaign.getStatus() != CampaignStatus.ACTIVE) {
            throw new BusinessRuleViolationException("Campaign is not active");
        }

        User influencer = userRepository.findByIdWithProfiles(request.getInfluencerId())
                .orElseThrow(() -> new ResourceNotFoundException("User", "id", request.getInfluencerId()));

        if (influencer.getType() != UserType.INFLUENCER) {
            throw new BusinessRuleViolationException("User is not an influencer");
        }

        if (dealRepository.existsActiveDeal(campaign.getId(), influencer.getId())) {
            throw new BusinessRuleViolationException("An active deal already exists for this influencer and campaign");
        }

        Deal deal = new Deal();
        deal.setCampaign(campaign);
        deal.setInfluencer(influencer);
        deal.setClient(client);
        deal.setStatus(DealStatus.INVITED);
        deal = dealRepository.save(deal);

        if (request.getProposedAmount() != null) {
            createInitialTerms(deal, client, request.getProposedAmount(),
                    request.getDeliverables(), request.getNotes());
            deal.setStatus(DealStatus.NEGOTIATING);
            deal = dealRepository.save(deal);
        }

        return dealMapper.toDealResponse(deal);
    }

    @Transactional
    public DealResponse proposeTerms(User user, UUID dealId, ProposeTermsRequest request) {
        Deal deal = dealAccessHelper.getDealWithParticipantAccess(dealId, user);

        if (!deal.getStatus().allowsTermProposal()) {
            throw new BusinessRuleViolationException("Cannot propose terms in current deal status: " + deal.getStatus());
        }

        DealTerms currentTerms = deal.getCurrentTerms();
        if (currentTerms != null && currentTerms.getStatus() == DealTermsStatus.PROPOSED) {
            if (currentTerms.getProposedBy().getId().equals(user.getId())) {
                throw new BusinessRuleViolationException("You already have a pending proposal. Wait for the other party to respond.");
            }
            currentTerms.setStatus(DealTermsStatus.SUPERSEDED);
            dealTermsRepository.save(currentTerms);
        }

        // Calculate next version from already-loaded termsList
        int nextVersion = deal.getTermsList().stream()
                .mapToInt(DealTerms::getVersion)
                .max()
                .orElse(0) + 1;

        DealTerms newTerms = new DealTerms();
        newTerms.setDeal(deal);
        newTerms.setVersion(nextVersion);
        newTerms.setProposedBy(user);
        newTerms.setAmount(request.getAmount());
        newTerms.setDeliverables(request.getDeliverables());
        newTerms.setNotes(request.getNotes());
        newTerms.setStatus(DealTermsStatus.PROPOSED);

        deal.setStatus(DealStatus.NEGOTIATING);
        deal.getTermsList().add(0, newTerms);
        deal = dealRepository.save(deal);  // Cascades to save newTerms

        return dealMapper.toDealResponse(deal);
    }

    @Transactional
    public DealResponse acceptTerms(User user, UUID dealId) {
        Deal deal = dealAccessHelper.getDealWithParticipantAccess(dealId, user);

        if (deal.getStatus() != DealStatus.NEGOTIATING) {
            throw new BusinessRuleViolationException("Cannot accept terms in current deal status: " + deal.getStatus());
        }

        DealTerms currentTerms = deal.getCurrentTerms();
        if (currentTerms == null || currentTerms.getStatus() != DealTermsStatus.PROPOSED) {
            throw new BusinessRuleViolationException("No pending terms to accept");
        }

        if (currentTerms.getProposedBy().getId().equals(user.getId())) {
            throw new BusinessRuleViolationException("You cannot accept your own proposal");
        }

        currentTerms.setStatus(DealTermsStatus.ACCEPTED);
        dealTermsRepository.save(currentTerms);

        deal.setStatus(DealStatus.TERMS_ACCEPTED);
        deal.setAgreedAmount(currentTerms.getAmount());
        deal.setPlatformFee(currentTerms.getAmount().multiply(PLATFORM_FEE_PERCENT).setScale(2, RoundingMode.HALF_UP));
        deal = dealRepository.save(deal);

        return dealMapper.toDealResponse(deal);
    }

    @Transactional
    public DealResponse rejectTerms(User user, UUID dealId) {
        Deal deal = dealAccessHelper.getDealWithParticipantAccess(dealId, user);

        if (deal.getStatus() != DealStatus.NEGOTIATING) {
            throw new BusinessRuleViolationException("Cannot reject terms in current deal status: " + deal.getStatus());
        }

        DealTerms currentTerms = deal.getCurrentTerms();
        if (currentTerms == null || currentTerms.getStatus() != DealTermsStatus.PROPOSED) {
            throw new BusinessRuleViolationException("No pending terms to reject");
        }

        if (currentTerms.getProposedBy().getId().equals(user.getId())) {
            throw new BusinessRuleViolationException("You cannot reject your own proposal");
        }

        currentTerms.setStatus(DealTermsStatus.REJECTED);
        dealTermsRepository.save(currentTerms);

        return dealMapper.toDealResponse(deal);
    }

    @Transactional
    public DealResponse cancelDeal(User user, UUID dealId) {
        Deal deal = dealAccessHelper.getDealWithParticipantAccess(dealId, user);

        if (!DealStatus.CANCELLABLE_STATUSES.contains(deal.getStatus())) {
            throw new BusinessRuleViolationException("Cannot cancel deal in current status: " + deal.getStatus());
        }

        deal.setStatus(DealStatus.CANCELLED);
        deal = dealRepository.save(deal);

        return dealMapper.toDealResponse(deal);
    }

    @Transactional
    public DealResponse activateDeal(UUID dealId) {
        Deal deal = dealRepository.findByIdWithDetails(dealId)
                .orElseThrow(() -> new ResourceNotFoundException("Deal", "id", dealId));

        if (deal.getStatus() != DealStatus.TERMS_ACCEPTED) {
            throw new BusinessRuleViolationException("Deal must have accepted terms before activation");
        }

        deal.setStatus(DealStatus.ACTIVE);
        deal = dealRepository.save(deal);

        return dealMapper.toDealResponse(deal);
    }

    @Transactional(readOnly = true)
    public DealResponse getDealById(User user, UUID dealId) {
        Deal deal = dealAccessHelper.getDealWithParticipantAccess(dealId, user);
        return dealMapper.toDealResponse(deal);
    }

    @Transactional(readOnly = true)
    public PageResponse<DealResponse> getMyDeals(User user, Pageable pageable) {
        Page<Deal> deals = dealRepository.findByUserId(user.getId(), pageable);
        return PageResponse.from(
                deals,
                deals.getContent().stream()
                        .map(dealMapper::toDealResponse)
                        .toList()
        );
    }

    @Transactional(readOnly = true)
    public PageResponse<DealResponse> getDealsByCampaign(User user, UUID campaignId, Pageable pageable) {
        Campaign campaign = campaignRepository.findByIdWithClient(campaignId)
                .orElseThrow(() -> new ResourceNotFoundException("Campaign", "id", campaignId));

        if (!campaign.getClient().getId().equals(user.getId())) {
            throw new AccessDeniedException("You can only view deals for your own campaigns");
        }

        Page<Deal> deals = dealRepository.findByCampaignId(campaignId, pageable);
        return PageResponse.from(
                deals,
                deals.getContent().stream()
                        .map(dealMapper::toDealResponse)
                        .toList()
        );
    }

    private void createInitialTerms(Deal deal, User proposedBy, BigDecimal amount, String deliverables, String notes) {
        DealTerms terms = new DealTerms();
        terms.setDeal(deal);
        terms.setVersion(1);
        terms.setProposedBy(proposedBy);
        terms.setAmount(amount);
        terms.setDeliverables(deliverables);
        terms.setNotes(notes);
        terms.setStatus(DealTermsStatus.PROPOSED);
        dealTermsRepository.save(terms);
        deal.getTermsList().add(terms);
    }
}
