# Help reader host registration proposal

Status: DRAFT FOR REVIEW. No production registration, permission, runtime activation or deployment is performed by this document.

Initial review baseline: 1d34466887ef2f19ff720da1e0c9c55e748e6b43. Continued code-only review baseline: 3b34ad84c312b6c036ddf2f17bb2c6033ca38cea. Existing policy remains PSW-only, current-tenant published EN/FR/ES guides, 30 reads per 60 seconds per tenant/user, and 30-day metadata-only audit. Legacy FAQ rows remain unowned/unpublished. No publishing/editorial, messaging, payment or other write authority is requested.

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

The concrete inactive governance/gateway composition is now present in services/governance_api/worker/help-reader.ts, help-reader-activation.ts, governance-help-service.ts and services/api_gateway/worker/help-gateway.ts. The fixed binding file remains null. The active service owner must still supply legitimate producer/source/deployment evidence for that exact composition. Bind only that reviewed source to its real runtime artifact, Worker identity, bundle digest and deployment/version receipt. These values are intentionally absent from this proposal; no arbitrary artifact ID, accepted source hash, deployment receipt or success status is allocated.

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

The UI remains closed while these registrations, legitimate producer evidence and the registered reader host are missing. The composition source now exists; source existence does not activate it. Native and web reader controllers are unmounted. No fabricated content, generic dashboard or simulated success substitutes for a guide reader.

Tests/builds/runtime verification not performed, as requested. Code review alone is not feature acceptance, deployed-source verification, accessibility approval or device/human approval.

## Unmounted reader state controllers

packages/shared/src/help-reader/session.ts and packages/flutter_core/lib/help_reader/help_reader_controller.dart prepare the read-only presentation lifecycle independently of control allocation. They use the existing captured-session reader clients; no network endpoint, permission, resource key or UI control is added.

Both support locale selection, search with offset reset, bounded next/previous pages, article reading, returning to the list and explicit retry. Pending changes clear prior private results; superseded completions are ignored. Session loss, denied access and scope conflict retire the controller and clear articles, items, query and retry descriptors. Dispose clears state before transport cleanup. Hosts must connect their existing session/navigation observers to sessionChanged/retire/dispose, use the exposed next/previous/retry availability, and allocate a new controller for a new captured session.

Native transport failures are normalized to the existing public code/status pairs. The native lifetime repair also rechecks ownership before propagating a typed failure, so denial-response cleanup cannot expose a stale result after disposal. Web controller cancellation settles its own await even if underlying response cleanup is uncooperative.

These are source-only, unmounted controller implementations. They are not the registered guide interface, a runtime plan, deployment approval, or acceptance evidence. No tests, builds, analyzer or runtime checks were performed in this continuation.

## Service-owner follow-up from code inspection

In services/governance_api/worker/help-reader.ts, best-effort request/response body cleanup should not be awaited on the denial path: an uncooperative cancellation promise can delay the safe response indefinitely. This finding was handed to the current service owner; this continuation does not overlap that owner's files.

Before activation, the reviewer must also confirm legitimate active artifact/source/deployment status values from the actual authority. Matching arbitrary text fields to a staged snapshot alone is not a substitute for that reviewed active-version policy. No status values are invented in this proposal.

## Row-level registration review checklist

The concrete activation loader now defines the required snapshots. Review these exact fields against the pinned production schema before preparing any additive migration:

| Relation | Required reader record |
| --- | --- |
| api_permissions | api_id=794, role_id=51, permission_key=psw_published_help_read, can_access=1, legitimate runtime_artifact_id matching the endpoint and artifact |
| role_screen_permissions | New allocated id; role_id=51, screen_id=685, can_view=1, can_create=0, can_edit=0, can_delete=0, can_export=0 |
| role_screen_map | New allocated id; role_id=51, screen_id=685, can_view=1, can_edit=0 |
| screen_components | New allocated id for screen685; reviewed component_code, component_name, component_type, data_cy, file_path and implementation_status for the actual reader host |
| runtime_artifacts | Real allocated id and reviewed artifact_type/code/name, physical_path, status, health_status, deployment_status, version and checksum bound to actual producer evidence |

Retain Guest permission6157/map603, unrelated control779 and the completed legacy permission archive. The draft does not allocate replacements or revive retired rows. Source/deployment/status values must come from the legitimate producer and authority; none can be filled by a request or an environment-only enable flag. A read-only list/detail host needs no create/edit/delete/export/content-publication authority.
