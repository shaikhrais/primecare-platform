# Infrastructure Security Policies & Measures

This document outlines the core security measures implemented within the `infrastructure` package to protect the PrimeCare API and backend services against common web vulnerabilities, specifically focusing on SaaS Subscription endpoints.

## 1. BOLA / IDOR Protection (Horizontal Privilege Escalation)
### Context-Driven Tenant Validation
The backend does **not** rely on client-provided tenant identifiers (e.g., in JSON payload bodies) for sensitive operations like Subscription Promo Code applications.
Instead:
- The `tenantIsolation` middleware synchronously decodes and validates the secure `Auth-Token` JWT.
- A verified `tenantId` is placed into the localized request context (`c.get('tenantId')`).
- Route handlers (like `/saas/promo/apply`) exclusively derive the target `tenantId` from this internal context, neutralizing any malicious attempts to pass arbitrary UUIDs in the request body to execute actions on behalf of other organizations.
- Zod validation schemas strictly enforce the absence of these obsolete validation fields from generic endpoints.

## 2. DDoS & Brute Force Rate Mitigation
### STRICT Bucket Processing
The `rate-limiter.ts` middleware actively filters requests based on sensitivity.
- **DEFAULT**: Standard limits for generic `GET` data fetching.
- **STRICT**: Critical mutation endpoints, authentication, and unvetted access layers (such as `/api-keys`, `/payment`, `/webhook`, and `/saas/promo/`) are routed to the `STRICT` profile.
- Operations inside the `STRICT` profile are subjected to highly constrained sliding-window thresholds (e.g., 30 requests per minute) to inherently deter brute-forcing (such as guessing promo codes) or resource starvation DDoS attacks before business logic executes.

## 3. Database Concurrency Protection
### Pessimistic ACID Race Condition Handling
To prevent "code replay" vulnerabilities where highly concurrent identical requests bypass usage limits:
- Transactions (e.g., applying a promo code limit) are shielded via Prisma's `$transaction` scopes.
- A sequential locking block atomically increments usage (e.g., `update({ data: { currentUses: { increment: 1 } } })`).
- A post-increment conditional gate verifies if the value *now* exceeds the permitted maximum (`updatedPromo.currentUses > promo.maxUses`). If so, a forced transaction failure effectively rolls back the race-condition breach, ensuring single-use or limited-capacity invariants hold true under heavy multi-threading.
