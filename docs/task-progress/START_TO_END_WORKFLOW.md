# Defining and proving a business process

A process begins with a trigger and preconditions, and ends with a measurable business outcome. Roles are participants, not process definitions. A user may participate in several processes. Multi-role accounts are a desired capability but the current care module authorizes one exact role string; that capability is not being claimed here.

The 98 legacy workflow_definitions entries are role/app outlines. New mapped processes are registered in governance.db table business_workflow_specs; their independent summary is business_workflow_verification_summary. One mapped process is not the platform-wide total: discovery across the outlines is still incomplete.

## First process: PSW submits their own availability

Stable ID: `care.psw.submit-availability`. Definition: `definition_json` in business_workflow_specs. Reproducible registration source: `tools/workflow-verification/specs/care.psw.submit-availability.json`.

| Step | User action | Required proof |
| --- | --- | --- |
| Start | PSW has synthetic active account and tenant, no browser session | Isolated prerequisites; no successful business state pre-seeded |
| 1 | Sign in with email and password | Real login API establishes session; invalid login does not |
| 2 | Open Care | API returns own permitted records; shared layout and staffing panel render |
| 3 | Choose availability and enter start/end and note | Own staff ID; valid instants and visible form values |
| 4 | Save | API returns id/version; window, staffing event, access log and request receipt commit atomically |
| End | Reload the browser and find the saved availability | UI, fresh API response and database agree on staff, tenant, times, active status and version |

Availability becomes active immediately; it requires no approval. Withdrawing availability is a separate process. Requesting leave and independent leave approval are separate processes. Do not introduce approval into this process.

## How testing follows the definition

1. Reset an isolated test database and create only synthetic prerequisites.
2. Execute each recorded action through the real browser and API. Correlate the returned record ID with database assertions; do not treat a screenshot as data proof.
3. Reload and confirm the original business outcome, including audit and receipt rows.
4. Exercise acceptance branches: denied roles, other staff, foreign tenant, invalid input, expired session, lost-response retry and audit-failure rollback. Assert no unauthorized business writes.
5. Check loading/empty/error/offline/retry behavior, locales and responsive layout in this actual authenticated process. Review the current datetime-local-to-UTC behavior before claiming correct local-time support.
6. Save video and source/spec-bound results through the governed evidence mechanism. Required reviews and all seven gates must pass before verified status is possible. The registration script never executes a workflow or upgrades it to verified.

Existing evidence is five grouped sequential embedded PostgreSQL API tests with pre-created sessions. It is not a real credential login/browser proof. Native PostgreSQL execution, complete browser failure cases, video publication and reviews are outstanding.

## Reproduce and inspect

```sh
python3 tools/workflow-verification/test_business_workflow_specs.py
python3 tools/workflow-verification/register_business_workflows.py
node --test scripts/test-care-availability-api.mjs
```

```sql
SELECT workflow_id,name,verification_status,verification_reason
FROM business_workflow_specs;
SELECT * FROM business_workflow_verification_summary;
SELECT definition_json FROM business_workflow_specs
WHERE workflow_id='care.psw.submit-availability';
```

The seed validates existing role, screen, policy, API and source references. Re-registering identical specifications preserves status; changing a definition invalidates prior completion and returns it to implemented-unverified. This is specification storage and validation, not yet an automatic end-to-end runner or an end-user process editor.
