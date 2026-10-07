# API execution inventory

Recorded declarations and local unit-fixture status only. Unrecorded means inspect implementation, not proof of absent code. PostgreSQL/production evidence is not inferred from CI or registry labels.

Declared operations: 1412

| Recorded verification state | Operations |
| --- | --- |
| blocked | 10 |
| unit_fixtures_recorded | 344 |
| verification_pending | 1058 |

| Missing contract field | Operations |
| --- | --- |
| permission | 1058 |
| requestSchema | 1058 |
| responseSchema | 1058 |
| screenLink | 1013 |

The JSON inventory includes every registered API, linked screens, apps, roles and missing fields. Use `/v1/governance/api-execution-status` with existing inventory authority to query this snapshot. `search`, `app`, `role` and `screen` filters plus bounded paging are supported.

Remaining priority workflows: governed tenant-wide administration; booking approval/rejection and visit assignment; invoice/payment writes; provider document upload/verification; availability writes; compliance findings; clinical notes, consent and medication workflows. These require explicit registered business and authorization contracts; do not synthesize broad access or claim completed workflows from placeholder bindings.

Release gates: apply additive migrations in the normal deployment workflow, verify PostgreSQL CI, deploy APIs separately, and run authenticated production checks. UI readiness is outside this API-only work.
