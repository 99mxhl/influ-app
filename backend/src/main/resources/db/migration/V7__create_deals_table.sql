CREATE TABLE deals (
    id UUID PRIMARY KEY,
    campaign_id UUID NOT NULL REFERENCES campaigns(id) ON DELETE CASCADE,
    influencer_id UUID NOT NULL REFERENCES users(id) ON DELETE CASCADE,
    client_id UUID NOT NULL REFERENCES users(id) ON DELETE CASCADE,
    status VARCHAR(50) NOT NULL DEFAULT 'INVITED',
    agreed_amount DECIMAL(10, 2),
    platform_fee DECIMAL(10, 2),
    notes TEXT,
    created_at TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT NOW(),
    updated_at TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT NOW(),
    deleted_at TIMESTAMP WITH TIME ZONE,
    lock_version BIGINT NOT NULL DEFAULT 0
);

CREATE INDEX idx_deals_campaign_id ON deals(campaign_id);
CREATE INDEX idx_deals_influencer_id ON deals(influencer_id);
CREATE INDEX idx_deals_client_id ON deals(client_id);
CREATE INDEX idx_deals_status ON deals(status);
CREATE INDEX idx_deals_deleted_at ON deals(deleted_at) WHERE deleted_at IS NULL;
CREATE UNIQUE INDEX idx_deals_active_unique ON deals(campaign_id, influencer_id)
    WHERE deleted_at IS NULL AND status NOT IN ('CANCELLED', 'COMPLETED');
