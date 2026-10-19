# Workflow repair checkpoint

The live source is governance.db, business processes only. `WORKFLOW_EXECUTION_STATUS.md` and `workflow-execution-status.json` export the current classifications and next actions. The 98 legacy role outlines and supporting screen/action/API guides are excluded from business totals.

## Completed repairs and scoped evidence

| Workflow | Reproduced issue | Change and evidence | Completion |
| --- | --- | --- | --- |
| care.psw.submit-availability | Login rendered outside shared shell | Source-governed login now uses existing shared shell with hidden chrome; six real credential/browser cases prove shell, save, exact database fields, audit, receipt, displayed reload values and offline recovery | Implemented-unverified |
| auth.credential-login | Failed /me confirmation retained provisional browser session and navigated to success | Validate safe identity before browser storage; failure retains login and attempts server revocation; injected503 regression passes | Implemented-unverified |
| auth.read-current-session | Virtual definition incorrectly demanded tenant projection from identity-only endpoint | Corrected definition to actual existing safe user/role projection; real authenticated read agrees with stored session, invalidated reads deny | Implemented-unverified |
| auth.logout | Further UI acceptance needed | Scoped real API logout deletes current hashed session; me and care deny revoked token | Implemented-unverified |

There are six EN/FR/ES browser cases at320/768/1440 widths and four browser time zones, plus eight API/security/recovery groups. Tests use actual credential, auth and care handlers with isolated synthetic data in embedded PostgreSQL. They do not prove deployed routing, native multi-connection locking, complete accessibility/PWA acceptance, governed video playback or required review approval.

The time fields explicitly say UTC in all three locales. Tests preserve those instants across browser time zones; no unrequested timezone reinterpretation was implemented.

Two recorded browser defects retain their original failed receipts and criterion-bound successful resolution records. Eleven additional source-audited missing UI/behavior outcomes and exact remaining blockers are saved per workflow. Source inspection is not a workflow test pass.

The latest immutable recording is `docs/task-progress/evidence/runs/8010af8b-7a5c-45e0-b1bf-42b7dc862ac3/availability.webm`; its repository URL is saved with a hash in virtual_workflow_evidence. No current app recording-playback API/UI was found, so that acceptance gap remains explicit.

## Resume safely

On a fresh checkout, first run:

```sh
python3 tools/workflow-verification/restore_checkpoint.py
```

The full remotely published database is the verified compressed checkpoint. A known baseline is preserved before restoration; unknown modified data is not overwritten.

Refresh and export live status:

```sh
python3 tools/workflow-verification/execution.py --db .agents/governance/governance.db --refresh --export
```

Read the next action:

```sql
SELECT d.flow_id,d.verification_status,d.test_status,c.next_action
FROM virtual_workflow_definitions d
LEFT JOIN virtual_workflow_checkpoints c ON c.flow_id=d.flow_id
WHERE d.flow_kind='business_process' AND d.verification_status<>'verified'
ORDER BY d.verification_status,d.flow_id;
```

Reproduce the scoped runtime checks:

```sh
node scripts/test-care-availability-workflow.mjs
python3 tools/workflow-verification/test_execution.py
python3 tools/workflow-verification/test_restore_checkpoint.py
```

Browser execution requires the CI-installed Chromium or the documented care browser environment variables. Do not use production credentials or databases.

Record each later attempt with execution.py --attempt path/to/result.json. Preserve original issues, source/spec hashes, artifact hashes, evidence URLs and next actions. Resolving an issue requires its exact criterion rerun and affected source bindings; unrelated passing evidence cannot close it. Only full criterion receipts, video/security/database/browser evidence and all seven current review gates may tick a workflow verified.

Current implementation classifications come from147 source-anchored readiness audits. Four paths additionally have scoped runtime evidence. CI/reviews remain separate gates; no bypass or main merge is claimed here.

Live checkpoint: **147 = 11 missing + 135 implemented-unverified + 0 verified + 1 blocked. DONE = 0; PENDING = 147.** Four workflows have scoped runtime passes. Fourteen report/training/operations registration blockers were reconciled without granting new business permissions. The remaining blocked process is `auth.switch-role`: approved role assignment and tenant-bound switching semantics are absent.

Next unblocked action: reproduce and repair growth dashboard loading/error rendering outside the shared shell. This component defect affects the shared surface used by 55 processes; it does not make those whole processes verified.

## 2026-10-18 growth work-queue attempt

Shared loading/error shell repaired; browser replay is blocked by missing Chromium and invalid browser downloads. Component bundle passes and 21 workflow-recorder tests pass. Full build fails at existing client invoice canonical-owner registration; partial build mutations were reverted. No browser success, video or workflow completion is claimed. See evidence/growth-loading-attempt.json.

Live totals: 147 = 11 missing + 134 implemented-unverified + 0 verified + 2 blocked. DONE=0; PENDING=147. Next action: obtain working Chromium, replay the focused growth renderer, then run isolated real credential/API/database/reload acceptance; reconcile the invoice registration conflict before release.
