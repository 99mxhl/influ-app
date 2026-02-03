-- Remove FACEBOOK platform associations from campaigns
-- FACEBOOK is no longer a supported platform in the application
DELETE FROM campaign_platforms WHERE platform = 'FACEBOOK';
