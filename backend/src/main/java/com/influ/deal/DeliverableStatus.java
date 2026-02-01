package com.influ.deal;

public enum DeliverableStatus {
    PENDING,
    SUBMITTED,
    APPROVED,
    REJECTED,
    REVISION_REQUESTED;

    /**
     * Check if the deliverable can be submitted (new or revised).
     */
    public boolean canBeSubmitted() {
        return this == PENDING || this == REVISION_REQUESTED;
    }

    /**
     * Check if the deliverable can be reviewed (approved/rejected/revision requested).
     */
    public boolean canBeReviewed() {
        return this == SUBMITTED;
    }
}
