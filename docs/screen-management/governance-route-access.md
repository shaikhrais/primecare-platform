# Governance route access

The governance router now requests `/v1/governance/workspace` before entering native or dynamic business routes. Only an exact route in the authenticated response `screens` projection can authorize navigation, and the local presentation registration must also exist. The response user and role must match the captured session; token, tenant, user and role changes invalidate pending decisions. Navigation rechecks grants rather than caching them. The API retains responsibility for server session, tenant and business-record authorization.

Login uses the server landing only when that exact route is both visible and locally registered. Suffix matches, role-name guesses, arbitrary dashboards, inventory entries and placeholder fallback no longer authorize navigation. Errors, missing identity, non-200 responses and malformed or duplicate route projections deny access through the existing auth-error route. Existing shared public auth and authenticated account/consent routes keep their existing handling.

The six unmapped native business routes and fallback remain denied until authoritative mappings exist. No aliases, roles or production grants are created. This guard does not certify the production freshness of the server catalog or implementation of the underlying business tasks.

Validation: `governance_route_access_test.dart` exercises exact grants, malformed/foreign identities, inventory exclusion, similar CEO paths, revocation on subsequent navigation and stale-session responses. `governance_route_guard_test.dart` exercises the actual router redirect across every native route, non-200 responses, valid landing and session replacement. These Flutter tests must pass on the published head before this change is accepted. Native widget presentation tests that mount builders directly remain presentation-only evidence.

The route-site digest update covers the changed router container, not a grant or production-readiness approval. Full staging, API authorization, accessibility, localization and workflow acceptance remain separate release gates.
