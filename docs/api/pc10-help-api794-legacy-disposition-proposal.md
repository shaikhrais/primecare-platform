# API794 legacy grant disposition — decision required

Status: proposal only. No archive, deletion, grant, baseline amendment or production change is authorized or executed by this document.

## Confirmed conflict

Release run `43663586841`, job `132658066893`, stopped at the catalogue identity check before the auth upload. The registered Help endpoint is API794, `POST /v1/psw/help-support`, permission `psw_published_help_read`. Its 64 legacy grant rows instead identify registry794 / api_id5041, `GET /v1/clinical-director-quality-metrics`, permission `api_permission_api_v1_clinical_director_quality_metrics_list_get`. Their referenced runtime artifact1 is absent; no canonical replacement endpoint was found. They must never be retargeted to Help or treated as PSW reader authority.

Independent reconstruction from preserved readback `43653313127` / `132626318293` proves the 64 grant rows and origin are unchanged. Only the referenced endpoint permission key changed during accepted Help registration:

| Context | Exact fingerprint |
| --- | --- |
| Original endpoint permission key null | `182c1f5cb6e7d1bb2ceee25db7407187aa40f1234d52b09a6dc9b73d91b68605` |
| Registered Help permission key | `393d8cfbcbc2d0d93170408674329463ec65e6f620996cec105b45319b33f238` |

The guard correctly rejects a changed, still-invalid group. Repeating the workflow cannot repair it. The original quarantine baseline, diagnostic reasons and fail-closed guard remain unchanged.

## Recommended disposition for approval

Retire these exact 64 invalid rows from active `govt_api_permissions` into a reviewed production quarantine/archive that preserves their full original rows. This changes their active disposition; it is not permitted by the earlier instruction to preserve active grants without a new decision. No other permission is removed or changed. No legacy grant is reassigned, enabled or converted into a Help grant.

The alternative is to leave all 64 rows active and retain the release blocker until a legitimate canonical operation/runtime identity is supplied. Do not guess a target from registry.api_id5041 or create runtime artifact1.

| Item | Proposed result |
| --- | --- |
| All 64 original rows | Exact full-row archive, including internal ordinal, IDs, role, flags, key, artifact reference and timestamps |
| Active legacy group | Removed only after archive equality is established inside the same transaction |
| API794 Help contract | Preserved unchanged |
| Other grants, Guest screen permissions, control779, content, secrets and runtime flags | Preserved unchanged |
| Existing quarantine baseline and source admission history | Preserved unchanged |
| New PSW Help access | Not granted by retirement; requires separate legitimate artifact/control/access registration |
| Auth deployment | Not authorized by retirement alone; existing source, schema, key/binding/schedule preservation and release checks still apply |

## Required implementation and verification after the decision

1. Independently read the actual full grant rows, import ordinals, table constraints, inbound foreign/logical references and any existing production quarantine storage. Abort if retiring the rows would break an unreviewed consumer/reference; no related row may be altered under this proposal. Never redirect the offline SQLite quarantine writer to PostgreSQL.
2. Review/register the specific archive storage and narrowly scoped production writer before implementation/apply. Do not assume a table already exists or copy a SQLite schema.
3. Require the pinned production authority, fresh main, exact API794 contract, exact 64-member fingerprint/origin, absent legitimate artifact and explicit retirement opt-in. Lock and revalidate all affected metadata; an unexpected row or context must abort.
4. Archive every original row and its source/operation/manifest context; compare the archived JSON values against the original locked rows. Remove only the exact verified legacy members atomically. No partial archival or deletion commit is permitted.
5. Independently read back exactly64 preserved originals, zero active members of this legacy key, unchanged Help endpoint, unchanged unrelated grant rows and unchanged baseline bytes. A repeat must prove the same retired state rather than create another archive or delete another group.
6. Run isolated native PostgreSQL rollback, concurrent-writer, changed-row, wrong-operation, idempotence and independent-readback cases. Inspect actual Actions results before any production application. No authored tests count as passes.
7. Re-run the existing catalogue check on fresh metadata only after the verified retirement. The guard already allows a fully removed violation; it must not be weakened to accept the changed fingerprint.

Rollback after archival is not an automatic restoration of invalid active access. Preserve archive evidence. Any restoration must have a separately reviewed canonical operation/runtime identity and must fail if it would conflict with later Help registration or permissions.

This proposal does not resolve the separate registered PSW screen/control, legitimate Help runtime, actual scheduled-purge, mounted-reader, device or human acceptance gates.
