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
# Backend (requires Java 21)
# If using Homebrew OpenJDK, set JAVA_HOME first:
export JAVA_HOME=/opt/homebrew/Cellar/openjdk@21/21.0.10/libexec/openjdk.jdk/Contents/Home

docker-compose up -d postgres
./gradlew flywayMigrate
./gradlew bootRun --args='--spring.profiles.active=dev'
./gradlew test
./gradlew compileJava --quiet  # Quick validation of Java changes

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
- **Merge commits:** Never use default "Merge pull request #X from ..." messages. Use descriptive messages following conventional commit format, e.g., `feat(mobile): add platform badges and colors`
- **Before pushing:** Always check if there are new PR reviews to address. Fix all issues before pushing to avoid triggering multiple CI workflows.
- **False positive reviews:** If reviewer flags issues that don't exist in actual code (e.g., claims missing dependency that exists, or N+1 query where JOIN FETCH is used), ignore them. Refactoring can happen later on main branch.

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

## Workflow Orchestration

### 1. Plan Mode Default
- Enter plan mode for ANY non-trivial task (3+ steps or architectural decisions)
- If something goes sideways, STOP and re-plan immediately - don't keep pushing
- Use plan mode for verification steps, not just building
- Write detailed specs upfront to reduce ambiguity

### 2. Subagent Strategy to keep main context window clean
- Offload research, exploration, and parallel analysis to subagents
- For complex problems, throw more compute at it via subagents
- One task per subagent for focused execution

### 3. Self-Improvement Loop
- After ANY correction from the user: update 'tasks/lessons.md' with the pattern
- Write rules for yourself that prevent the same mistake
- Ruthlessly iterate on these lessons until mistake rate drops
- Review lessons at session start for relevant project

### 4. Verification Before Done
- Never mark a task complete without proving it works
- Diff behavior between main and your changes when relevant
- Ask yourself: "Would a staff engineer approve this?"
- Run tests, check logs, demonstrate correctness

### 5. Demand Elegance (Balanced)
- For non-trivial changes: pause and ask "is there a more elegant way?"
- If a fix feels hacky: "Knowing everything I know now, implement the elegant solution"
- Skip this for simple, obvious fixes - don't over-engineer
- Challenge your own work before presenting it

### 6. Bug Fixing Workflow
- Don't start by trying to fix a bug - first write a failing test that reproduces it
- Use subagents to implement the fix and verify it passes the test
- Confirm the test passes before committing

## Task Management
1. **Plan First**: Write plan to 'tasks/todo.md' with checkable items
2. **Verify Plan**: Check in before starting implementation
3. **Track Progress**: Mark items complete as you go
4. **Explain Changes**: High-level summary at each step
5. **Document Results**: Add review to 'tasks/todo.md'
6. **Capture Lessons**: Update 'tasks/lessons.md' after corrections

## Core Principles
- **Simplicity First**: Make every change as simple as possible. Impact minimal code.
- **No Laziness**: Find root causes. No temporary fixes. Senior developer standards.
- **Minimal Impact**: Changes should only touch what's necessary. Avoid introducing bugs.
