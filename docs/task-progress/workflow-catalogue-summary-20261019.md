# PrimeCare workflow catalogue summary

Production snapshot: **2026-10-19 19:59:42 UTC**. Source: https://github.com/shaikhrais/primecare-platform/actions/runs/39315497634/artifacts/12217811389 . The pinned PostgreSQL `govt_` tables remain the live authority. This is an exported report.

## Business processes

Only `govt_virtual_workflow_definitions` rows with `flow_kind='business_process'` count as business workflows.

| Area | Workflows |
|---|---:|
| Authentication and accounts | 23 |
| Care delivery | 35 |
| Growth and marketing | 57 |
| Platform administration | 32 |
| **TOTAL** | **147** |

147 is the complete current registered business-process catalogue, not a fixed limit or proof that every real-world duty has been registered. The attached workbook lists each of the 147 stable IDs, titles, statuses, notes, blockers, next actions, latest attempt IDs, evidence URLs and source paths.

## Supporting entries

| Workflow-definition entry type | Rows |
|---|---:|
| Business processes | 147 |
| Screen journeys | 954 |
| Action journeys | 1,760 |
| API contracts | 2,474 |
| Legacy candidates | 3 |
| **All definition entries** | **5,338** |

The 5,191 supporting/legacy entries overlap business workflows and must not be counted as additional business processes. Another 98 role-flow guides are separate supporting records, excluded from both definition-entry and business-process totals.

## Verification

| Verification status | Workflows |
|---|---:|
| Missing | 11 |
| Implemented-unverified | 131 |
| Verified | 0 |
| Blocked | 5 |
| **TOTAL** | **147** |

DONE=0. PENDING=147. Scoped tests do not establish whole-workflow completion. Definition compilation, screenshots and narrow tests cannot satisfy the remaining evidence/review gates.

## Attempt IDs

There are **314 verification-attempt records**, with latest attempt ID **314** at this snapshot. Attempts are history records, not additional workflows. A single workflow can have multiple failures, repairs and retests.

- Attempt 312: CEO bootstrap failure reproduction.
- Attempt 313: CEO bootstrap repair checks and focused issue resolutions.
- Attempt 314: platform-admin bootstrap scoped checks.

## Latest completed attempt

| Workflow ID | Issue found | Fix | Tests | Verification status | Evidence | Published source |
|---|---|---|---|---|---|---|
| auth.bootstrap-first-platform-admin | No new implementation defect found in scoped checks; operator identity/environment remain unbound | No unsupported business change | 8 existing contract/native regression cases and 3 native transaction probes passed | blocked; test_status=scoped_pass | https://github.com/shaikhrais/primecare-platform/actions/runs/39315054009/artifacts/12217517903 | main 51a8ca6561cd7b1dd00c5de2fd5dba39bb1cc584 |

The native probes confirmed suppressed account/audit writes roll back and recover, and concurrent first-admin requests for different tenants have exactly one global winner. Disposable native test schemas were dropped; no production business bootstrap was executed.

Full credential UI login, permitted console/API/database/reload, denied roles/session/offline recovery, video and required reviews remain unproven. Bind the protected deployment operator identity and approved execution environment in governed requirements before full acceptance.

No work branch or PR was opened for these operational inspection/test/recording steps. Temporary operational workflows were removed. The final production checkpoint waits for this documentation commit's CI and captures the actual main SHA and branch/PR counts.

Next: inspect `auth.credential-login` from live production, its existing checkpoint, registered API/auth metadata, roles and source before isolated UI/API/database/reload acceptance. Do not repeat passing platform bootstrap cases unless their source/specification/evidence bindings change.
