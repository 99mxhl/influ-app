-- Create a sample client user for campaigns (if not exists)
INSERT INTO users (id, email, password_hash, type, created_at, updated_at, lock_version)
VALUES
    ('11111111-1111-1111-1111-111111111111', 'styleco@example.com', '$2a$10$dummyhashfordevonly', 'CLIENT', NOW(), NOW(), 0),
    ('22222222-2222-2222-2222-222222222222', 'techcorp@example.com', '$2a$10$dummyhashfordevonly', 'CLIENT', NOW(), NOW(), 0),
    ('33333333-3333-3333-3333-333333333333', 'fitlife@example.com', '$2a$10$dummyhashfordevonly', 'CLIENT', NOW(), NOW(), 0),
    ('44444444-4444-4444-4444-444444444444', 'glowbeauty@example.com', '$2a$10$dummyhashfordevonly', 'CLIENT', NOW(), NOW(), 0)
ON CONFLICT (id) DO NOTHING;

-- Create profiles for the client users
INSERT INTO profiles (id, user_id, display_name, bio, created_at, updated_at, lock_version)
VALUES
    ('11111111-aaaa-1111-aaaa-111111111111', '11111111-1111-1111-1111-111111111111', 'StyleCo', 'Leading fashion brand for sustainable clothing', NOW(), NOW(), 0),
    ('22222222-aaaa-2222-aaaa-222222222222', '22222222-2222-2222-2222-222222222222', 'TechCorp', 'Innovative technology solutions company', NOW(), NOW(), 0),
    ('33333333-aaaa-3333-aaaa-333333333333', '33333333-3333-3333-3333-333333333333', 'FitLife', 'Your partner in health and fitness', NOW(), NOW(), 0),
    ('44444444-aaaa-4444-aaaa-444444444444', '44444444-4444-4444-4444-444444444444', 'GlowBeauty', 'Premium beauty and skincare products', NOW(), NOW(), 0)
ON CONFLICT (id) DO NOTHING;

-- Insert sample campaigns
INSERT INTO campaigns (id, client_id, title, description, budget_min, budget_max, status, start_date, end_date, requirements, target_audience, created_at, updated_at, lock_version)
VALUES
    ('aaaaaaaa-0001-0001-0001-000000000001', '11111111-1111-1111-1111-111111111111',
     'Summer Fashion Collection 2026',
     'We are looking for fashion influencers to showcase our new sustainable summer collection. Create engaging content featuring our eco-friendly clothing line.',
     500, 2000, 'ACTIVE', '2026-02-01', '2026-04-30',
     'Must have at least 10K followers. Experience with fashion content required. High-quality photography skills preferred.',
     'Fashion-conscious millennials and Gen Z interested in sustainable fashion',
     NOW() - INTERVAL '2 days', NOW(), 0),

    ('aaaaaaaa-0002-0002-0002-000000000002', '22222222-2222-2222-2222-222222222222',
     'Tech Product Review Series',
     'Looking for tech reviewers to create in-depth reviews of our new smart home devices. Must be able to demonstrate product features clearly.',
     1000, 3000, 'ACTIVE', '2026-02-01', '2026-05-31',
     'Tech-focused channel with engaged audience. Previous product review experience required. Must be able to create professional video content.',
     'Tech enthusiasts aged 25-45 interested in smart home technology',
     NOW() - INTERVAL '5 days', NOW(), 0),

    ('aaaaaaaa-0003-0003-0003-000000000003', '33333333-3333-3333-3333-333333333333',
     'Fitness App Launch Campaign',
     'Help us launch our revolutionary fitness app! We need fitness influencers to demonstrate workout features and share their experience.',
     800, 2500, 'ACTIVE', '2026-02-15', '2026-04-15',
     'Active fitness influencer with authentic engagement. Must be comfortable demonstrating workouts on camera.',
     'Fitness enthusiasts looking for digital workout solutions',
     NOW() - INTERVAL '1 week', NOW(), 0),

    ('aaaaaaaa-0004-0004-0004-000000000004', '44444444-4444-4444-4444-444444444444',
     'Beauty Product Unboxing',
     'Create exciting unboxing content for our new skincare line. Show the products, share first impressions, and create a skincare routine video.',
     600, 1500, 'ACTIVE', '2026-02-01', '2026-03-31',
     'Beauty/skincare focused content creator. Must have good lighting setup. Authentic and honest reviews appreciated.',
     'Beauty enthusiasts aged 18-35 interested in skincare routines',
     NOW() - INTERVAL '3 days', NOW(), 0),

    ('aaaaaaaa-0005-0005-0005-000000000005', '11111111-1111-1111-1111-111111111111',
     'Street Style Photography Campaign',
     'Looking for urban fashion content creators to capture street style looks featuring our latest collection in city settings.',
     400, 1200, 'ACTIVE', '2026-03-01', '2026-05-31',
     'Strong photography portfolio. Urban/street style aesthetic. Based in or able to travel to major cities.',
     'Young urban professionals interested in street fashion',
     NOW() - INTERVAL '1 day', NOW(), 0),

    ('aaaaaaaa-0006-0006-0006-000000000006', '22222222-2222-2222-2222-222222222222',
     'Gaming Headset Review',
     'We need gaming influencers to review and showcase our new premium gaming headset during live streams and dedicated review videos.',
     1500, 4000, 'ACTIVE', '2026-02-01', '2026-03-15',
     'Gaming content creator with established audience. Must stream regularly. Able to demonstrate audio quality effectively.',
     'Gamers aged 16-35 looking for premium gaming accessories',
     NOW() - INTERVAL '4 days', NOW(), 0);

-- Insert campaign categories
INSERT INTO campaign_categories (campaign_id, category) VALUES
    ('aaaaaaaa-0001-0001-0001-000000000001', 'FASHION'),
    ('aaaaaaaa-0001-0001-0001-000000000001', 'LIFESTYLE'),
    ('aaaaaaaa-0002-0002-0002-000000000002', 'TECH'),
    ('aaaaaaaa-0003-0003-0003-000000000003', 'FITNESS'),
    ('aaaaaaaa-0003-0003-0003-000000000003', 'LIFESTYLE'),
    ('aaaaaaaa-0004-0004-0004-000000000004', 'BEAUTY'),
    ('aaaaaaaa-0005-0005-0005-000000000005', 'FASHION'),
    ('aaaaaaaa-0006-0006-0006-000000000006', 'GAMING'),
    ('aaaaaaaa-0006-0006-0006-000000000006', 'TECH');

-- Insert campaign platforms
INSERT INTO campaign_platforms (campaign_id, platform) VALUES
    ('aaaaaaaa-0001-0001-0001-000000000001', 'INSTAGRAM'),
    ('aaaaaaaa-0001-0001-0001-000000000001', 'TIKTOK'),
    ('aaaaaaaa-0002-0002-0002-000000000002', 'YOUTUBE'),
    ('aaaaaaaa-0003-0003-0003-000000000003', 'INSTAGRAM'),
    ('aaaaaaaa-0003-0003-0003-000000000003', 'YOUTUBE'),
    ('aaaaaaaa-0004-0004-0004-000000000004', 'INSTAGRAM'),
    ('aaaaaaaa-0004-0004-0004-000000000004', 'TIKTOK'),
    ('aaaaaaaa-0005-0005-0005-000000000005', 'INSTAGRAM'),
    ('aaaaaaaa-0006-0006-0006-000000000006', 'YOUTUBE'),
    ('aaaaaaaa-0006-0006-0006-000000000006', 'TIKTOK');
