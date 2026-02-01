CREATE TABLE influencer_profiles (
    id UUID PRIMARY KEY,
    user_id UUID NOT NULL UNIQUE REFERENCES users(id) ON DELETE CASCADE,
    base_rate DECIMAL(10, 2),
    instagram_handle VARCHAR(100),
    instagram_followers INTEGER,
    tiktok_handle VARCHAR(100),
    tiktok_followers INTEGER,
    youtube_handle VARCHAR(100),
    youtube_followers INTEGER,
    twitter_handle VARCHAR(100),
    twitter_followers INTEGER,
    avg_rating DECIMAL(3, 2),
    total_ratings INTEGER DEFAULT 0,
    total_earnings DECIMAL(12, 2) DEFAULT 0,
    completed_deals INTEGER DEFAULT 0,
    created_at TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT NOW(),
    updated_at TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT NOW(),
    deleted_at TIMESTAMP WITH TIME ZONE,
    lock_version BIGINT NOT NULL DEFAULT 0
);

CREATE TABLE influencer_categories (
    influencer_profile_id UUID NOT NULL REFERENCES influencer_profiles(id) ON DELETE CASCADE,
    category VARCHAR(100) NOT NULL,
    PRIMARY KEY (influencer_profile_id, category)
);

CREATE INDEX idx_influencer_profiles_user_id ON influencer_profiles(user_id);
CREATE INDEX idx_influencer_profiles_avg_rating ON influencer_profiles(avg_rating DESC NULLS LAST);
CREATE INDEX idx_influencer_categories_category ON influencer_categories(category);
