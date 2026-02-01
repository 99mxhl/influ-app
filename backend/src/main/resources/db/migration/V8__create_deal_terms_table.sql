CREATE TABLE deal_terms (
    id UUID PRIMARY KEY,
    deal_id UUID NOT NULL REFERENCES deals(id) ON DELETE CASCADE,
    version INTEGER NOT NULL,
    proposed_by_id UUID NOT NULL REFERENCES users(id) ON DELETE CASCADE,
    amount DECIMAL(10, 2) NOT NULL,
    deliverables TEXT,
    notes TEXT,
    status VARCHAR(50) NOT NULL DEFAULT 'PROPOSED',
    created_at TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT NOW(),
    updated_at TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT NOW(),
    deleted_at TIMESTAMP WITH TIME ZONE,
    lock_version BIGINT NOT NULL DEFAULT 0
);

CREATE INDEX idx_deal_terms_deal_id ON deal_terms(deal_id);
CREATE INDEX idx_deal_terms_proposed_by_id ON deal_terms(proposed_by_id);
CREATE INDEX idx_deal_terms_status ON deal_terms(status);
CREATE UNIQUE INDEX idx_deal_terms_version ON deal_terms(deal_id, version);
