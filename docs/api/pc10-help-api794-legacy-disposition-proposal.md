# API794 legacy grants — retirement verified

Status: the user-approved “Move it” operation is executed and independently verified in production. This completes the exact legacy-grant retirement, not Task 1 or Help activation.

## Verified result

| Check | Actual production result |
| --- | --- |
| Exact legacy rows archived | 64 complete original eight-column rows |
| Active rows for the legacy key | 0 (previously 64) |
| Unrelated permissions | All 79,947 unchanged |
| PUBLIC archive privileges | Mandatory zero-privilege checks passed before commit and fresh readbacks |
| New role grants / runtime activation | 0 / false |
| Catalogue guard | Passed with 0 new violations against the unchanged baseline |

[Production run 43670904250](https://github.com/shaikhrais/primecare-platform/actions/runs/43670904250), production job 132680762295, succeeded on source `4a9bb9d7da610771751a403a79bfb2af470e77f2`. The apply committed 64 archived/0 active; its fresh-connection readback and the separate `--readback` process agreed. The unchanged catalogue guard passed at 2026-11-15T03:10:41Z (22:10:41 Toronto on November 14).

The original 22:00 Toronto checkpoint was missed by 10m 41s. Verification finished 4m 19s before the corrected 22:15 checkpoint. The wider backlog remains behind; retirement alone establishes no Help reader authority.

Machine-readable actual receipts: [pc10-help-api794-legacy-retirement.json](evidence/pc10-help-api794-legacy-retirement.json).

## Preserved identity and data

The retired rows retain permission key `api_permission_api_v1_clinical_director_quality_metrics_list_get`, API794, registry794 / original api_id 5041, and original operation `GET /v1/clinical-director-quality-metrics`. They were never retargeted to the registered Help operation `POST /v1/psw/help-support` / `psw_published_help_read`. Runtime artifact 1 remained absent; no replacement was invented.

Storage is `governance_68b0b02dd1215f58630d2c1a.govt_help_legacy_grant_archive`. Each original PostgreSQL JSONB row retains its import ordinal, grant/API/role/artifact IDs, key, access flag and timestamp text, alongside immutable operation/manifest/source context. The source rows were copied server-side, compared for exact equality, then removed atomically. Unrelated source values were compared with a SQL snapshot before commit.

| Preserved proof | SHA256 |
| --- | --- |
| Ordered complete original-row texts | `76c84a508c9ea77fa080fbf0c251a856690bb519b8d00fe9e0d6d7d705eb0269` |
| All 79,947 unrelated permissions | `047322986e302dc04ca51a589f61df4b572fb57fda7b4677393838e86b7467c9` |
| Exact retired member/context fingerprint | `393d8cfbcbc2d0d93170408674329463ec65e6f620996cec105b45319b33f238` |

The pre-Help quarantine fingerprint `182c1f5cb6e7d1bb2ceee25db7407187aa40f1234d52b09a6dc9b73d91b68605` remains historical evidence; it was not substituted for the approved current context.

## Verification and safeguards

Native PostgreSQL 16 job 132680487552 passed 32/32 tests, 0 failures, 0 skips. Tests cover full-row preservation, rollback, changed members/context, idempotence, incoming references, default PUBLIC privilege rejection and real concurrent source/artifact writes blocked by locks. PGlite passed 30 cases with only the 2 native-only concurrency cases skipped. Independent reviewers checked the frozen source and actual native/production receipts.

The writer retains explicit opt-ins, fresh-main and pinned-authority checks, exact source/shape/manifest/reference digests, source/archive write locks, context/reference SHARE locks, equality-before-delete and fresh-connection readbacks. Unexpected rows, references, triggers, RLS, archive shape or PUBLIC privileges abort. The only outside business-table operation was the reviewed count-only OTP reference check; it found 0 matches and exposed no payload.

Production initially denied the specific `REVOKE` statement with 42501 despite reported ownership/privileges. The final reviewed SQL omits that privilege change and instead requires effective PUBLIC privileges already be zero immediately after CREATE and before COMMIT or row copying. Unexpected PUBLIC defaults roll back creation; no GRANT, role switch, ACL repair, transport change or weaker locking was introduced.

The baseline and guard are byte-for-byte unchanged from the pre-operation main:

- Quarantine baseline Git blob: `a709f95c3fc3ba0ef826cee6634c0299e9ecbadd`.
- Catalogue guard Git blob: `0f2462321b3f0a5552d74fb47ca56ddb2ef41563`.

The guard reports 2,493 currently quarantined groups and 7 cumulative removed/repaired groups; those cumulative removals are not all attributed to this operation. It establishes no business authority.

## Scope remaining separate

No PSW Help access, Guest screen permission, control 779, content, auth deployment or runtime activation was added by this operation. Registered screen/control, legitimate Help runtime/access, scheduled purge, mounted reader, device and human acceptance must be verified separately before Task 1 is complete.

Restoring invalid active access is not an automatic rollback. Preserve the archive; any restoration requires a separately reviewed canonical operation/runtime identity and compatibility with later registrations.
