package com.influ.deal;

import com.influ.common.exception.ResourceNotFoundException;
import com.influ.user.User;
import lombok.RequiredArgsConstructor;
import org.springframework.security.access.AccessDeniedException;
import org.springframework.stereotype.Component;

import java.util.UUID;

/**
 * Centralized helper for deal access control.
 * Eliminates duplicate access check logic across DealService and DeliverableService.
 */
@Component
@RequiredArgsConstructor
public class DealAccessHelper {

    private final DealRepository dealRepository;

    /**
     * Get deal if user is either the influencer or the client.
     */
    public Deal getDealWithParticipantAccess(UUID dealId, User user) {
        Deal deal = findDealOrThrow(dealId);

        if (!isParticipant(deal, user)) {
            throw new AccessDeniedException("You don't have access to this deal");
        }

        return deal;
    }

    /**
     * Get deal if user is the influencer.
     */
    public Deal getDealWithInfluencerAccess(UUID dealId, User user) {
        Deal deal = findDealOrThrow(dealId);

        if (!deal.getInfluencer().getId().equals(user.getId())) {
            throw new AccessDeniedException("Only the influencer can perform this action");
        }

        return deal;
    }

    /**
     * Get deal if user is the client.
     */
    public Deal getDealWithClientAccess(UUID dealId, User user) {
        Deal deal = findDealOrThrow(dealId);

        if (!deal.getClient().getId().equals(user.getId())) {
            throw new AccessDeniedException("Only the client can perform this action");
        }

        return deal;
    }

    /**
     * Check if user is a participant (influencer or client) in the deal.
     */
    public boolean isParticipant(Deal deal, User user) {
        return deal.getInfluencer().getId().equals(user.getId()) ||
               deal.getClient().getId().equals(user.getId());
    }

    private Deal findDealOrThrow(UUID dealId) {
        return dealRepository.findByIdWithDetails(dealId)
                .orElseThrow(() -> new ResourceNotFoundException("Deal", "id", dealId));
    }
}
