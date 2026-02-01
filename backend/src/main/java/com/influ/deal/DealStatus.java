package com.influ.deal;

import java.util.Set;

public enum DealStatus {
    INVITED,
    APPLIED,
    NEGOTIATING,
    TERMS_ACCEPTED,
    ACTIVE,
    CONTENT_SUBMITTED,
    COMPLETED,
    DISPUTED,
    CANCELLED;

    /**
     * Statuses that allow deal cancellation.
     */
    public static final Set<DealStatus> CANCELLABLE_STATUSES = Set.of(
            INVITED,
            APPLIED,
            NEGOTIATING,
            TERMS_ACCEPTED
    );

    /**
     * Statuses that allow proposing new terms.
     */
    public static final Set<DealStatus> TERM_PROPOSABLE_STATUSES = Set.of(
            INVITED,
            APPLIED,
            NEGOTIATING
    );

    /**
     * Statuses that allow deliverable operations.
     */
    public static final Set<DealStatus> DELIVERABLE_ACTIVE_STATUSES = Set.of(
            ACTIVE,
            CONTENT_SUBMITTED
    );

    public boolean isCancellable() {
        return CANCELLABLE_STATUSES.contains(this);
    }

    public boolean allowsTermProposal() {
        return TERM_PROPOSABLE_STATUSES.contains(this);
    }

    public boolean allowsDeliverableOperations() {
        return DELIVERABLE_ACTIVE_STATUSES.contains(this);
    }
}
