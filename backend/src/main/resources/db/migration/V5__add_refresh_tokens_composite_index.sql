-- Add composite index for efficient lookup of active refresh tokens by user
-- Used by RefreshTokenRepository.revokeAllByUserId which filters by user_id AND revoked_at IS NULL
CREATE INDEX idx_refresh_tokens_user_id_revoked_at ON refresh_tokens(user_id, revoked_at)
    WHERE revoked_at IS NULL;
