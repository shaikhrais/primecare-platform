# Flutter login response validation — 2026-10-20

Existing scope: registered login API and shared Flutter auth controller. No routes, roles, grants or bootstrap policy added.

## Repair

Reject missing, blank and incorrectly typed role/user identifiers and non-string tenant identifiers rather than coercing malformed data into authenticated state. A valid issued token from a rejected or superseded response is revoked by its captured value. Revocation failure cannot grant local authority or replace an existing actor. Existing serial persistence and session revision protections remain.

## Validation

Added 21 regression cases: eight malformed identities, each with successful and failed revocation, and five malformed payload/token cases. They assert rejection, captured-token cleanup, unchanged actor and unchanged stored identity. Existing startup, logout, out-of-order login, transport and route guard tests remain required. Auth Gateway Verification now runs on relevant main pushes and supports manual dispatch, consistent with the main-only repository policy.

CI results are pending for this commit; no device, PWA, manual screen-reader or independent review signoff is asserted. Earlier real Cloudflare email and native PostgreSQL/browser receipts remain documented in auth-recovery-feedback-20261020.md.

## Remaining acceptance

Four governed policy items remain blocked: approved operator/environment bindings for first CEO, central administrator and platform administrator, and the role-switch grants/session/audit policy. Physical-device/PWA/manual assistive-technology acceptance and the nine independent review gates remain open. This repair does not mark those complete.
