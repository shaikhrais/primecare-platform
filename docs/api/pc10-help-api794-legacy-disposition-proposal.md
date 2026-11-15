# API794 legacy grant disposition — approved retirement

Status: the user explicitly approved this exact disposition with “Move it”. Production archival remains pending native PostgreSQL proof, inspection and independent readback. This approval covers only the exact64-row retirement described below.

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

## Approved execution checkpoint

Read-only production discovery [43668252604](https://github.com/shaikhrais/primecare-platform/actions/runs/43668252604), job132672350917, succeeded on source `6266498e83d01266b4afcd24f288f62fb76a7f9a`. It preserved64 complete8-column source rows; full ordered raw-row SHA256 is `76c84a508c9ea77fa080fbf0c251a856690bb519b8d00fe9e0d6d7d705eb0269`. No physical inbound foreign keys were found. The exact source-reviewed `public.communication_voice_otp.grant_id` column has zero aggregate matches to source IDs/import ordinals; no OTP payload was read. The immutable manifest's two API-permission SQL objects, actual table shape and reference inventory are pinned by the retirement definition.

The new archive stores the original PostgreSQL JSONB values and operation context. The writer compares originals before deletion, snapshots unrelated permission values, locks source/archive/context/reference relations, rejects reference or schema drift and independently reconnects after commit. The first workflow publication disables the production job so the native proof can be inspected before enabling the already-approved move. Source publication alone is not execution evidence.
