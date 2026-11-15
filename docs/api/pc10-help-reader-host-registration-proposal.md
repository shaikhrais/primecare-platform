# Help reader host registration proposal

Status: DRAFT FOR REVIEW. No production registration, permission, runtime activation or deployment is performed by this document.

Reviewed source baseline: 1d34466887ef2f19ff720da1e0c9c55e748e6b43. Existing policy remains PSW-only, current-tenant published EN/FR/ES guides, 30 reads per 60 seconds per tenant/user, and 30-day metadata-only audit. Legacy FAQ rows remain unowned/unpublished. No publishing/editorial, messaging, payment or other write authority is requested.

## Exact existing business identity

| Record | Required value |
| --- | --- |
| API | 794 |
| Method/path | POST /v1/psw/help-support |
| Permission key | psw_published_help_read |
| Service | governance |
| Reader role | 51 / psw |
| Screen | 685 / psw_help_support |
| Registered screen route | /generated/psw-help-support |
| Screen/API link purpose | Published current-tenant PSW Help guides |

Retain the accepted request and response schemas in tools/governance-production/pc10-help-reader-contract.json. List and read are the only operations. Never revive the retired 64 legacy API794 permissions or reuse their unrelated artifact identity.

## Required runtime registration before activation

The active service owner must first supply a real inactive governance/gateway producer containing the concrete reader, authentication, quota and audit composition. Bind only that reviewed source to its real runtime artifact, Worker identity, bundle digest and deployment/version receipt. These values are intentionally absent from this proposal; no arbitrary artifact ID, accepted source hash, deployment receipt or success status is allocated.

The endpoint's imported tagged artifact reference, the exact reader permission's artifact reference and the registered runtime artifact must identify the same legitimate implementation. Mere row existence is insufficient. Activation must reject missing, malformed, unrelated, stale or retired source/deployment bindings before database effects or guide content.

Existing cloudflare/workers source and accepted Auth provenance remain unchanged by this proposal. Do not repair an unrelated release compiler error by enabling raw deployment or changing live settings.

## Required additive access/control registration

1. Re-read the pinned production manifest, exact table constraints and current screen/role mappings. Stop on drift.
2. Preserve Guest13 screen permissions/maps, existing control779 on screen2534, retired-grant archives and unrelated permissions.
3. Register only the reviewed reader-only PSW51/screen685 view/map binding and exact psw_published_help_read API permission, referencing the legitimate runtime artifact above.
4. Review the current screen's conflicting Guest/support/mutation blueprint. Register a separate explicit reader disposition rather than inheriting submit-feedback, contact-support, create, edit, export or content-publication actions.
5. Allocate control/section/element IDs through the existing authority for locale selection, search, guide list, article read, pagination and state/retry presentation. Their IDs are pending; none is invented here.
6. Bind approved shared controls and EN/FR/ES resource values to those allocated records. Existing navigation.items.psw_help_support and workspace.no_data/unavailable/forbidden labels are sufficient only for the closed legacy shell, not the full reader interface.
7. Require architecture/security/access review and independent fresh-connection readback before populating a runtime activation plan.

This is a reviewable definition of the missing changes, not executable SQL against guessed imported schemas and not evidence that access exists.

## Web/native host wiring after registration

Reuse the scoped TypeScript reader client and packages/flutter_core/lib/help_reader.dart. Both request the canonical POST endpoint; the native transport additionally checks authenticated self identity before and after the read, validates exact response keys/projections/scope, bounds UTF-8 bytes and UTF-16 strings, returns immutable data, and never uses the legacy ApiClient cache/mock fallback.

The host must capture origin, token and tenant/user/role/dataset from its existing authenticated context; callers cannot choose another actor. Connect navigation/logout/session observers to cancelPending/dispose and clear rendered private state. A borrowed HTTP client remains owned by its creator. New reads retire previous reads. Render only registered list/detail and EN/FR/ES controls, with explicit loading/empty/denied/unavailable/rate-limit/retry states.

The clinic's existing Help menu can open its existing closed Help entry instead of Compliance. That navigation correction does not grant API794 access or authorize mounting the reader. The canonical screen685 host mapping still needs the registration above.

## Current limitations

The UI remains closed while these registrations and the service-owned composition are missing. The new native transport is unmounted. No fabricated content, generic dashboard or simulated success substitutes for a guide reader.

Tests/builds/runtime verification not performed, as requested. Code review alone is not feature acceptance, deployed-source verification, accessibility approval or device/human approval.
