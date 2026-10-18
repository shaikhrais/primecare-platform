# Virtual process catalogue — definitions before execution

The current registered scope has been written to governance.db as virtual plans. No business workflow was executed or promoted to verified by this registration pass. This is a planning catalogue, not proof that implementations or permissions work.

| Kind | Count | Scope |
| --- | ---: | --- |
| Business process definitions | 147 | 35 care, 57 growth, 32 platform/report/training/theme, 23 authentication/account processes |
| Registered screen journeys | 953 | All screen registrations, including one inactive entry retained as inactive |
| Registered action guides | 1,760 | All action definitions; 1,718 navigation, 42 other actions |
| API contract guides | 2,469 | 1,220 current endpoints and 1,249 separate legacy mocked contracts |
| Generic legacy process candidates | 3 | Intake, billing and scheduling registrations awaiting concrete specification |
| **Virtual definitions and guides** | **5,332** | Supporting guide categories overlap; this is not 5,332 distinct business processes |
| Role/app guides | 98 | Separate outlines linked to screen journeys and business processes |
| Ordered virtual steps | 18,731 | Start/actions/expected outcome stored for subsequent review and testing |

Business-process definition quality: 115 source-mapped, 32 drafts requiring further binding/requirement reconciliation. Source-mapped means existing policy/code references support the virtual description. It does not mean reviewed, implemented completely, executable automatically or tested successfully. All 5,332 catalogue rows have test_status=not_run and verification_status=blocked while review and execution are outstanding. The earlier narrow PSW availability specification and its scoped evidence remain unchanged and cross-linked.

## Database locations

- `virtual_workflow_definitions`: stable ID, kind, title, roles, trigger, preconditions, outcome, definition JSON, definition quality, blockers, source/spec hash and test status.
- `virtual_workflow_steps`: ordered actions, expected results, known method/path and database effect. Unvalidated legacy endpoints are kept only as declarations in source JSON, not executable bindings.
- `virtual_workflow_source_links`: exact registered primary-key provenance with key-column metadata; table-wide theme provenance is explicitly labelled table_snapshot. Unresolved references stay in the definition gaps.
- `virtual_role_flow_guides`: 98 role/app outlines with screen journey and relevant process links.
- `virtual_flow_catalog_snapshots`: `current` summary, `source-gaps` IDs and `legacy-source-audit` analysis.
- `virtual_flow_status_summary`: exclusive status counts by kind. Within a kind: total = missing + implemented_unverified + verified + blocked.

A user can participate in multiple processes. The current care authorization implementation supports one exact role string, not simultaneous multi-role grants. The catalogue introduces no permissions or account changes.

## Read the saved plans

```sql
SELECT * FROM virtual_flow_status_summary;
SELECT flow_id,title,definition_status,test_status,blocker_json
FROM virtual_workflow_definitions
WHERE flow_kind='business_process'
ORDER BY flow_id;
SELECT step_order,action_text,expected_text,api_method,api_path,database_effect_json
FROM virtual_workflow_steps
WHERE flow_id='care.plan.author-submit-review'
ORDER BY step_order;
SELECT guide_json FROM virtual_role_flow_guides WHERE outline_id=23;
```

## Reproduce definitions only

`python3 tools/workflow-verification/register_virtual_flows.py`

Domain planning sources are `tools/workflow-verification/virtual-processes/care.json` and `enterprise.json`; screen/action/API guides derive from current governance records. Repeating registration preserves identical definitions. A changed plan or referenced source hash resets its catalogue status to blocked/not_run. Historical rows remain available; current coverage is checked against current source IDs. A source change invalidates derived status when the catalogue is refreshed; this registrar is not a continuous monitoring service.

## Recorded gaps

- Most legacy requirements are templates. No unregistered business result, route or permission has been invented to fill them.
- Legacy API contracts and current endpoints have no exact method/path equivalence in this audit. The legacy endpoint registry is a mirror and is not counted again.
- 45 modern screen/API link rows reference missing screens; 23 screen-permission rows reference missing screens; 21,952 API-permission rows reference missing endpoints. Their IDs are retained in the source-gaps snapshot. These declarations are not effective runtime authority.
- Global foreign-key checking is blocked by the pre-existing translations/languages schema mismatch. The newly created catalogue tables pass their own foreign-key checks; database integrity is ok.

Coverage is complete for the explicitly named registered sources and derived process families. Unknown or unregistered business processes are outside this finite scope; role outlines are guides, not evidence that every possible future duty has been discovered.

## Later testing

Review each virtual definition, resolve its exact blockers, then execute real login → UI → API → isolated database assertions → reload. Include denials, tenant isolation and relevant failure/retry paths. Save source-bound results, video URLs and required review references. Neither metadata coverage nor virtual step creation counts as workflow acceptance.
