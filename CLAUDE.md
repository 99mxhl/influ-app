# CLAUDE.md - Influ App

Influencer marketing platform: brands + influencers, chat-based deal negotiation, escrow payments, content approval.

## Tech Stack

| Layer | Tech |
|-------|------|
| Mobile | Flutter 3.x + Riverpod |
| Backend | Spring Boot 3.x (Java 21) |
| Database | PostgreSQL 15 + Flyway |
| Real-time | WebSocket + STOMP |
| Payments | Stripe Connect (escrow) |
| Storage | AWS S3 |
| Auth | JWT + Spring Security |

## Project Structure

```
influ-app/
├── backend/src/main/java/com/influ/
│   ├── config/          # Security, WebSocket, CORS, S3, OpenAPI
│   ├── auth/            # JWT auth, login/register
│   ├── user/            # User, Profile, InfluencerProfile
│   ├── campaign/        # Campaign CRUD
│   ├── deal/            # Deal, DealTerms, Deliverable
│   ├── chat/            # Conversation, Message, WebSocket
│   ├── payment/         # Stripe, escrow, webhooks
│   └── common/          # BaseEntity, exceptions, ApiResponse
├── backend/src/main/resources/db/migration/  # Flyway V1-V8
├── mobile/lib/
│   ├── core/            # DI, routing, network, storage
│   ├── features/        # auth, campaigns, deals, chat, payments, profile
│   └── shared/          # models, widgets, utils
└── docker-compose.yml
```

## Core Entities

All entities extend `BaseEntity`: `id` (UUID), `createdAt`, `updatedAt`, `deletedAt` (soft delete), `lockVersion` (@Version).

| Entity | Key Fields |
|--------|------------|
| User | email, passwordHash, type (INFLUENCER\|CLIENT), stripeAccountId, stripeCustomerId |
| Profile | userId, displayName, avatarUrl, bio |
| InfluencerProfile | categories[], baseRate, social handles/followers, avgRating, totalEarnings |
| Campaign | clientId, title, budgetMin/Max, status, categories[], platforms[] |
| Deal | campaignId, influencerId, clientId, status, agreedAmount, platformFee |
| DealTerms | dealId, version, proposedById, amount, deliverables (JSON), status |
| Deliverable | dealId, platform, contentType, contentUrl, status |
| Payment | dealId, amount, status (PENDING→ESCROW_HELD→RELEASED), stripePaymentIntentId |
| Message | conversationId, senderId, type (TEXT\|TERMS_PROPOSAL\|SYSTEM), content |

## Deal State Machine

```
IDLE → INVITED/APPLIED → NEGOTIATING ⇄ TERMS_ACCEPTED → ACTIVE → CONTENT_SUBMITTED → COMPLETED/DISPUTED
                                                           ↑____________revision_____|
Any state → CANCELLED
```

## Payment Flow

1. Terms accepted → Client card charged → **ESCROW_HELD**
2. Influencer submits content → Client approves
3. Platform transfers to influencer (minus 10% fee) → **RELEASED**

## API Endpoints

**Auth:** `POST /api/auth/register|login|refresh|logout` · `GET /api/auth/me`

**Users:** `GET /api/users/:id` · `PUT /api/users/me` · `GET /api/influencers`

**Campaigns:** `GET|POST /api/campaigns` · `GET|PUT|DELETE /api/campaigns/:id` · `GET /api/campaigns/mine`

**Deals:** `GET /api/deals` · `POST /api/deals/apply|invite` · `POST /api/deals/:id/terms` · `PUT /api/deals/:id/terms/accept|reject|cancel`

**Deliverables:** `POST /api/deals/:id/deliverables/:did/submit|approve|reject`

**Chat:** `GET /api/deals/:id/messages` · WebSocket: `/ws/chat` (STOMP)

**Payments:** `POST /api/payments/connect-account` · `POST /api/payments/:dealId/capture|release` · `POST /api/webhooks/stripe`

**Files:** `POST /api/files/presign|confirm`

**Response format:** `{ success, data, error, timestamp }` · Pagination: `?page=0&size=20`

## Commands

```bash
# Backend
docker-compose up -d postgres
./gradlew flywayMigrate
./gradlew bootRun --args='--spring.profiles.active=dev'
./gradlew test

# Mobile
flutter pub get
flutter pub run build_runner build --delete-conflicting-outputs
flutter run
flutter test
```

## Key Patterns

- **Optimistic locking:** `@Version` on Deal, DealTerms, Payment → 409 Conflict on concurrent modification
- **Webhook idempotency:** Track Stripe event IDs in `StripeEvent` table
- **Circuit breaker:** Resilience4j on Stripe/S3 calls
- **WebSocket auth:** JWT validated on STOMP CONNECT, subscription scoped to conversation participants

## Environment Variables

```
DATABASE_URL, JWT_SECRET, JWT_ACCESS_EXPIRATION_MS (15min), JWT_REFRESH_EXPIRATION_MS (7d)
STRIPE_SECRET_KEY, STRIPE_WEBHOOK_SECRET, STRIPE_PLATFORM_FEE_PERCENT
AWS_ACCESS_KEY_ID, AWS_SECRET_ACCESS_KEY, AWS_S3_BUCKET, AWS_REGION
```

## Git Rules

**Claude must ask permission before any git operation.**

- Branches: `main` (prod), `develop` (staging), `feature/*`, `fix/*`, `hotfix/*`
- Commits: `type(scope): description` — types: feat, fix, docs, refactor, test, chore
- PRs: feature/* → develop → main

## Code Style

- Java: Google style, `@RequiredArgsConstructor`, thin controllers, DTOs only (no entities in API)
- Dart: Effective Dart, Riverpod, freezed for models, feature-first structure
