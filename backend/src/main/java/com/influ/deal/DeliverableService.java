package com.influ.deal;

import com.influ.common.exception.BusinessRuleViolationException;
import com.influ.common.exception.ResourceNotFoundException;
import com.influ.deal.dto.CreateDeliverableRequest;
import com.influ.deal.dto.DeliverableResponse;
import com.influ.deal.dto.RejectDeliverableRequest;
import com.influ.deal.dto.SubmitDeliverableRequest;
import com.influ.user.User;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.UUID;

@Service
@RequiredArgsConstructor
public class DeliverableService {

    private final DealRepository dealRepository;
    private final DeliverableRepository deliverableRepository;
    private final DealMapper dealMapper;
    private final DealAccessHelper dealAccessHelper;

    @Transactional
    public DeliverableResponse createDeliverable(User user, UUID dealId, CreateDeliverableRequest request) {
        Deal deal = dealAccessHelper.getDealWithClientAccess(dealId, user);

        if (!deal.getStatus().allowsDeliverableOperations()) {
            throw new BusinessRuleViolationException("Cannot add deliverables in current deal status: " + deal.getStatus());
        }

        Deliverable deliverable = new Deliverable();
        deliverable.setDeal(deal);
        deliverable.setPlatform(request.getPlatform());
        deliverable.setContentType(request.getContentType());
        deliverable.setDescription(request.getDescription());
        deliverable.setStatus(DeliverableStatus.PENDING);
        deliverable = deliverableRepository.save(deliverable);

        return dealMapper.toDeliverableResponse(deliverable);
    }

    @Transactional
    public DeliverableResponse submitDeliverable(User user, UUID dealId, UUID deliverableId, SubmitDeliverableRequest request) {
        Deal deal = dealAccessHelper.getDealWithInfluencerAccess(dealId, user);

        if (!deal.getStatus().allowsDeliverableOperations()) {
            throw new BusinessRuleViolationException("Cannot submit deliverables in current deal status: " + deal.getStatus());
        }

        Deliverable deliverable = getDeliverableForDeal(deliverableId, dealId);

        if (!deliverable.getStatus().canBeSubmitted()) {
            throw new BusinessRuleViolationException("Deliverable cannot be submitted in current status: " + deliverable.getStatus());
        }

        deliverable.setContentUrl(request.getContentUrl());
        deliverable.setThumbnailUrl(request.getThumbnailUrl());
        deliverable.setStatus(DeliverableStatus.SUBMITTED);
        deliverable = deliverableRepository.save(deliverable);

        updateDealStatusAfterSubmission(deal);

        return dealMapper.toDeliverableResponse(deliverable);
    }

    @Transactional
    public DeliverableResponse approveDeliverable(User user, UUID dealId, UUID deliverableId) {
        Deal deal = dealAccessHelper.getDealWithClientAccess(dealId, user);

        if (!deal.getStatus().allowsDeliverableOperations()) {
            throw new BusinessRuleViolationException("Cannot approve deliverables in current deal status: " + deal.getStatus());
        }

        Deliverable deliverable = getDeliverableForDeal(deliverableId, dealId);

        if (!deliverable.getStatus().canBeReviewed()) {
            throw new BusinessRuleViolationException("Only submitted deliverables can be approved");
        }

        deliverable.setStatus(DeliverableStatus.APPROVED);
        deliverable = deliverableRepository.save(deliverable);

        checkAndCompleteDeal(deal);

        return dealMapper.toDeliverableResponse(deliverable);
    }

    @Transactional
    public DeliverableResponse rejectDeliverable(User user, UUID dealId, UUID deliverableId, RejectDeliverableRequest request) {
        Deal deal = dealAccessHelper.getDealWithClientAccess(dealId, user);

        if (!deal.getStatus().allowsDeliverableOperations()) {
            throw new BusinessRuleViolationException("Cannot reject deliverables in current deal status: " + deal.getStatus());
        }

        Deliverable deliverable = getDeliverableForDeal(deliverableId, dealId);

        if (!deliverable.getStatus().canBeReviewed()) {
            throw new BusinessRuleViolationException("Only submitted deliverables can be rejected");
        }

        deliverable.setStatus(DeliverableStatus.REJECTED);
        deliverable.setRejectionReason(request.getReason());
        deliverable = deliverableRepository.save(deliverable);

        return dealMapper.toDeliverableResponse(deliverable);
    }

    @Transactional
    public DeliverableResponse requestRevision(User user, UUID dealId, UUID deliverableId, RejectDeliverableRequest request) {
        Deal deal = dealAccessHelper.getDealWithClientAccess(dealId, user);

        if (!deal.getStatus().allowsDeliverableOperations()) {
            throw new BusinessRuleViolationException("Cannot request revision in current deal status: " + deal.getStatus());
        }

        Deliverable deliverable = getDeliverableForDeal(deliverableId, dealId);

        if (!deliverable.getStatus().canBeReviewed()) {
            throw new BusinessRuleViolationException("Only submitted deliverables can have revision requested");
        }

        deliverable.setStatus(DeliverableStatus.REVISION_REQUESTED);
        deliverable.setRevisionNotes(request.getRevisionNotes());
        deliverable = deliverableRepository.save(deliverable);

        deal.setStatus(DealStatus.ACTIVE);
        dealRepository.save(deal);

        return dealMapper.toDeliverableResponse(deliverable);
    }

    @Transactional(readOnly = true)
    public List<DeliverableResponse> getDeliverables(User user, UUID dealId) {
        dealAccessHelper.getDealWithParticipantAccess(dealId, user);
        List<Deliverable> deliverables = deliverableRepository.findByDealId(dealId);
        return dealMapper.toDeliverableResponseList(deliverables);
    }

    @Transactional(readOnly = true)
    public DeliverableResponse getDeliverable(User user, UUID dealId, UUID deliverableId) {
        dealAccessHelper.getDealWithParticipantAccess(dealId, user);
        Deliverable deliverable = getDeliverableForDeal(deliverableId, dealId);
        return dealMapper.toDeliverableResponse(deliverable);
    }

    private Deliverable getDeliverableForDeal(UUID deliverableId, UUID dealId) {
        Deliverable deliverable = deliverableRepository.findByIdWithDeal(deliverableId)
                .orElseThrow(() -> new ResourceNotFoundException("Deliverable", "id", deliverableId));

        if (!deliverable.getDeal().getId().equals(dealId)) {
            throw new ResourceNotFoundException("Deliverable", "id", deliverableId);
        }

        return deliverable;
    }

    private void updateDealStatusAfterSubmission(Deal deal) {
        long totalDeliverables = deliverableRepository.countTotalDeliverables(deal.getId());
        if (totalDeliverables > 0 && !deliverableRepository.hasUncompletedDeliverables(deal.getId())) {
            deal.setStatus(DealStatus.CONTENT_SUBMITTED);
            dealRepository.save(deal);
        } else if (deal.getStatus() == DealStatus.ACTIVE) {
            boolean anySubmitted = deliverableRepository.findByDealId(deal.getId()).stream()
                    .anyMatch(d -> d.getStatus() == DeliverableStatus.SUBMITTED);
            if (anySubmitted) {
                deal.setStatus(DealStatus.CONTENT_SUBMITTED);
                dealRepository.save(deal);
            }
        }
    }

    private void checkAndCompleteDeal(Deal deal) {
        if (!deliverableRepository.hasUncompletedDeliverables(deal.getId())) {
            long approvedCount = deliverableRepository.countApprovedDeliverables(deal.getId());
            if (approvedCount > 0) {
                deal.setStatus(DealStatus.COMPLETED);
                dealRepository.save(deal);
            }
        }
    }
}
