# Consolidated API result repairs

The finite checklist remains 1,415 unique operations: 343 with recorded unit evidence, nine retired, 1,049 pending and 14 explicitly blocked. This package implements no new business API, grants no authority and retires no operation. Request, transport and caller repairs receive zero API completion credit.

| Result | Evidence | Repair |
| --- | --- | --- |
| Three synthetic 400 responses | Canonical contracts and handlers forbid bodies for both session revocations and booking-request cancellation | Preserve the absence of a request body in Postman, the safe Newman view and the loopback adapter. Tests retain 400 for an injected `{}` and observe 401 for bodyless unauthenticated requests. |
| PSW notifications uses a missing hyphenated endpoint | The screen consumes a notifications collection; the existing self-owned read defines its fields and actor scope | Use `GET /v1/auth/me/notifications` through an owner notification repository, validate its envelope and timestamps, clear stale errors after successful retries, and propagate errors without fallback or owner overrides. The distinct pending `POST /v1/psw/notifications` remains unresolved. |
| Business-development errors appear successful | Transport fallback fabricated lead/deal/pipeline metrics after missing routes or network errors | Preserve server errors and return 503 for transport failures. Exclude these paths and self notifications from path-only cache/fabricated fallback. Real successful server responses still pass through. |

Login, forgot-password and reset-password correctly reject the diagnostic empty object; these responses are not handler defects. Authentication-required responses do not prove authorized workflow behavior. Four method-rejected declarations remain blocked because report/submission authority is undefined. Pending 404s require actual caller, business-contract and ownership evidence before implementation; generic method forwarding would hide missing workflows.

The new focused CI tests the transport and notification repository with the existing authentication and provider regressions, analyzes the changed clinic screen with actual app dependencies, and retains the full Worker unit/type/PostgreSQL gates. The reproducible report continues to cover all 1,406 active exact methods and paths without database or external-network execution.
