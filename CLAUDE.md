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
│   ├── common/          # BaseEntity, exceptions, ApiResponse
│   ├── config/          # Security, WebSocket, CORS, S3, OpenAPI
│   ├── auth/            # JWT auth, login/register
│   ├── user/            # User, Profile, InfluencerProfile
│   ├── campaign/        # Campaign CRUD
│   ├── deal/            # Deal, DealTerms, Deliverable
│   ├── chat/            # Conversation, Message, WebSocket
│   └── payment/         # Stripe, escrow, webhooks
├── backend/src/main/resources/db/migration/
├── mobile/lib/
│   ├── core/            # DI, routing, network, storage
│   ├── features/        # auth, campaigns, deals, chat, payments, profile
│   └── shared/          # models, widgets, utils
└── docker-compose.yml
```

## Core Entities

**Business entities** extend `BaseEntity`: `id` (UUID), `createdAt`, `updatedAt`, `deletedAt` (soft delete), `lockVersion` (@Version).

**Supporting entities** (e.g., `RefreshToken`) may have their own lifecycle patterns when soft delete semantics don't apply.

See `backend/src/main/java/com/influ/*/` for current entity fields.

**Key relationships:**
- User → Profile (1:1), User → InfluencerProfile (1:1, INFLUENCER type only)
- Campaign → Deals (1:N)
- Deal → DealTerms (1:N), Deal → Deliverables (1:N), Deal → Payment (1:1), Deal → Conversation (1:1)
- Conversation → Messages (1:N)

## Business Flows

### Deal State Machine

```
IDLE → INVITED/APPLIED → NEGOTIATING ⇄ TERMS_ACCEPTED → ACTIVE → CONTENT_SUBMITTED → COMPLETED/DISPUTED
                                                           ↑____________revision_____|
Any state → CANCELLED
```

### Payment Flow (Escrow)

1. Terms accepted → Client card charged → **ESCROW_HELD**
2. Influencer submits content → Client approves
3. Platform transfers to influencer (minus 10% fee) → **RELEASED**

## API

See OpenAPI docs at `/swagger-ui.html` when running locally.

**Response format:** `{ success, data, error, timestamp }`
**Pagination:** `?page=0&size=20`

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

### Data & Concurrency
- **Optimistic locking:** `@Version` on entities → 409 Conflict on concurrent modification
- **Soft deletes:** `@SQLRestriction("deleted_at IS NULL")` on all entities
- **Lazy fetch:** Use `FetchType.LAZY` for collections, join fetch where needed

### Security
- **JWT validation:** 256-bit entropy required in prod, 8KB max token length
- **Rate limiting:** Bucket4j on auth endpoints (10 req/min login/register, 5 req/min refresh)
- **Password limits:** BCrypt with max 72 chars (prevents DoS)
- **CORS:** Explicit origins only, no wildcards (including WebSocket)
- **Input validation:** `@Valid` on all request DTOs, `@Size`/`@Pattern` on query params

### External Services
- **Webhook idempotency:** Track Stripe event IDs in `StripeEvent` table
- **WebSocket auth:** JWT validated on STOMP CONNECT, subscription scoped to conversation participants

## Environment Variables

```
DATABASE_URL, JWT_SECRET, JWT_ACCESS_EXPIRATION_MS (15min), JWT_REFRESH_EXPIRATION_MS (7d)
STRIPE_SECRET_KEY, STRIPE_WEBHOOK_SECRET, STRIPE_PLATFORM_FEE_PERCENT
AWS_ACCESS_KEY_ID, AWS_SECRET_ACCESS_KEY, AWS_S3_BUCKET, AWS_REGION
```

## Git Rules

**Claude must ask permission before any git operation.**

- Branches: `main` (prod), `feature/*`, `fix/*`, `hotfix/*`
- Commits: `type(scope): description` — types: feat, fix, docs, refactor, test, chore
- PRs: feature/* → main
- **Before pushing:** Always check if there are new PR reviews to address. Fix all issues before pushing to avoid triggering multiple CI workflows.
- **False positive reviews:** If reviewer flags issues that don't exist in actual code (e.g., claims missing dependency that exists, or N+1 query where JOIN FETCH is used), ignore them. Refactoring can happen later on main branch.

## Bug Fixing Workflow

When a bug is reported, don't start by trying to fix it. Instead:

1. **Write a failing test** that reproduces the bug
2. **Use subagents** to implement the fix and verify it passes the test
3. **Confirm** the test now passes before committing

## Code Style

### Java
- Google style
- `@RequiredArgsConstructor` for DI
- Thin controllers, logic in services
- DTOs only in API (no entities)
- `@Validated` on controllers with query param validation

### Dart
- Effective Dart
- Riverpod for state
- Freezed for models
- Feature-first structure
