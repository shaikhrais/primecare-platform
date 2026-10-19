# Legacy role outline status

Database: `.agents/governance/governance.db`, table `workflow_definitions`.

`status` remains the registration lifecycle (currently active). `verification_status` is a separate, exclusive classification: missing, implemented-unverified, verified or blocked. `verification_reason` records the explanation and `verification_checked_at` records the classification audit time, not a successful test time.

Scope correction: these 98 registrations are role/app process outlines, not 98 individual business workflows. Use `business_workflow_specs` and `business_workflow_verification_summary` for explicitly defined business processes. `role_outline_verification_summary` is an alias for this legacy count.

Initial outline audit: 98 registrations, all blocked. Their 368 steps have no API bindings and only “Success” as expected results. This is a specification blocker; zero missing does not mean all functionality exists. No implementation completeness is inferred. Legacy runtime flags are not promoted to verified evidence.

Query live totals:

```sql
SELECT * FROM workflow_verification_summary;
```

Total = missing + implemented_unverified + verified + blocked.

Reproduce schema registration and export with `python3 tools/workflow-verification/register_workflow_status.py`. Rerunning preserves reviewed classifications. The export is `registered-workflow-status.json`; live database values take precedence. New definitions default to blocked awaiting audit. Change a classification only after recording its supporting audit; verified additionally requires full workflow criteria and evidence gates. The SQL enum constrains values, not evidence quality.

These counts cover role outlines in workflow_definitions only. Generic workflows and legacy runtime entries must be reconciled before calling this the complete platform inventory.
