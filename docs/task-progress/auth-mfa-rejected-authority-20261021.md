# Rejected MFA response authority — 2026-10-21

The native Flutter client rejected malformed MFA replies locally, but cleanup captured a factor token only after validating its envelope. A response with a token and an invalid HTTP status, envelope status or token format therefore bypassed exact-token revocation. An initial MFA challenge with an unexpected token was also rejected without cleanup.

The challenge branch now revokes any unexpected nonempty string token and returns without presenting the challenge. Factor verification captures a token before envelope validation so its existing finally block can revoke rejected authority without installing it as the active actor. Cleanup remains best effort if the transport itself fails; no rejected response establishes local authority.

Four new regressions cover unexpected challenge authority and rejected factor HTTP status, envelope status and token format. They require exact-token revocation, no identity-confirmation request, no stored credentials and no authenticated actor. The challenge regression additionally requires no MFA prompt or factor request. Existing valid success/retry, identity mismatch and cancellation/logout race cases remain in the required suite.

This repairs existing registered MFA behavior; no UI, API, permission, schema or production business data is added. No independent review, lost-factor recovery or whole-platform acceptance credit is claimed.

Source295600f230509d13a4eaa98d5b4bb148f79b5499. Verification39694084077 passed 308 core/session tests, 104 UI/auth tests, four clinic routing tests, static analysis, registered catalog reproduction and the clinic release web build. Contract review39694083999 passed both jobs.

All nine portal deployments succeeded, including final live source-stamp and JavaScript hash checks: clinic39694084229, marketing39694084183, corporate39694084298, support39694084119, enterprise-blueprint39694084069, client39694084172, franchise39694084217, business-development39694084150 and governance39694084140. No API deployment or database migration was required. These checks do not replace independent review or real-device MFA acceptance.

Auth Gateway Verification39694084092 also passed all 11 jobs, including Flutter auth and shared auth checks for eight apps.
