# Tenant email configuration review — 2026-10-19

The pinned production PostgreSQL governance database is the only live authority. This is one business process, not a new screen/API duty.

| Workflow ID | Issue found | Fix | Test result | Status | Evidence | Published execution source |
| --- | --- | --- | --- | --- | --- | --- |
| auth.inspect-email-config | Configuration API/controls unregistered; FR/ES labels remain English; control IDs and semantics redirect fail | Recorded exact failures and governance dependencies; no unsupported application/grant changes | Four actual credential/UI/API/PostgreSQL/reload cases and eight scoped groups executed; functional/security checks passed, acceptance failed | blocked; test_status failed | [Receipt, screenshots, four videos and replay](https://github.com/shaikhrais/primecare-platform/actions/runs/39346443108/artifacts/12231615328) | 5d88ebe2b2d5363dddd2a50c6d1a89ad70f4ce10 |

## Live registration
Definition SHA:6150401698099eb793f1d2fb6f78a27e861818ca9064b94527608b376646f7da. Existing actor roles are CEO and maintenance. Screen1264 (MAINTENANCE_CONFIGURATION), route /maintenance/configuration, is active. Its source is packages/primecare_ui/lib/src/features/maintenance/maintenance_configuration_screen.dart. Role-screen rows6587/6588 permit maintenance65 and CEO20 to view/create/edit; no new roles or grants were inferred.

Production api_endpoints contains no route matching maintenance/configuration, including the implemented /v1/auth/maintenance/configuration. Screen1264 has no screen_api_links, required elements, sections/elements or components for this surface. No maintenance-prefixed translations were found. Current TypeScript presentation uses hardcoded English and does not reference live registered labels for its configuration chrome.

The draft definition contains an unresolved composite CEO->maintenance creation-policy reference and no resolved workflow source links. The recorder inspects the actual creation-policy row by actor_role_id/target_role_id; that resolves supporting creation metadata only and is not an API permission grant. A supported production metadata writer must register/reconcile the exact existing read contract, authorization, safe response, validation, rate/audit/error ownership, UI control/resource bindings and specification source links before implementation repair. Do not run legacy SQLite registration scripts or invent routes/grants.

## Executed browser and native checks
Actual current-main main.ts, existing login and maintenance presentation, gateway and inherited auth service ran against an isolated synthetic PostgreSQL16 schema. Actual production-style credential hashing/session login was used; production business accounts and secrets were never used in this fixture.

Recorded browser cases:
- CEO EN at320px.
- Maintenance EN at1440px.
- Maintenance FR at768px.
- Maintenance ES at1280px.

All cases reached the existing configuration UI after credential login. Sender, revision, templates, readiness and latest20 audit entries matched the native tenant records. Reload reread authoritative state without configuration/audit mutation. A maintenance browser recovered after offline reload by returning online and reloading. No save or test-email button was invoked.

Eight scoped groups demonstrated safe reads and exact masked data, four browser journeys, denied roles/tenant isolation, missing/invalid/expired sessions, unsupported methods, corrupt-timestamp rollback/retry, eight concurrent reads plus external synthetic revision reread, and zero email sends. Stored legacy credential, server encryption key and DB URL never entered the response or displayed configuration. Foreign tenant records remained isolated. An unregistered tenantId query was ignored and could not select another tenant; no undocumented400 contract is asserted.

## Acceptance failures
| Criterion | Reproduction | Expected | Actual | Source/evidence |
| --- | --- | --- | --- | --- |
| ui.localization | Maintenance login; FR/ES configuration page with locale and semantics query | Governed FR/ES configuration chrome | English heading and labels remain in both locale pages | maintenance.ts; FR/ES videos, screenshots, receipt |
| ui.stable-test-ids | Inspect sender and configuration controls in all four browser cases | Stable IDs derived from registered controls | Sender/maintenance controls lack governed data-cy IDs; screen1264 has no registered elements/components | maintenance.ts; receipt and live governance |
| ui.semantics-navigation | Login with returnUrl=/maintenance/configuration and enable-semantics=true | Internal redirect retains required semantics query per AGENTS23 | All four internal redirects omit the query; explicit subsequent test entry/reload URLs include it | auth-screen.ts; recorded actual navigation |

These failures remain open. No new approved control IDs, translations or API policy were fabricated. The producer is a diagnostic collector: successful job execution means the audit completed, while results.json explicitly has passed=false and wholeTaskVerified=false. Production test_status is failed. This is not a passing acceptance run or a verified workflow.

Full deployed edge/cookie behavior, Flutter/mobile execution, accessibility/PWA/performance, governed playback and independent reviews remain pending. The earlier standalone real mail roundtrip is separate infrastructure evidence and does not establish this business process.

## Inventory and handoff
Expected post-attempt verification totals, recalculated by the production recorder:147 =11 missing +129 implemented-unverified +0 verified +7 blocked. DONE=0; PENDING=147. Twelve other workflows have scoped_pass; this failed acceptance is not added to that number.

The full overlapping catalogue remains5338 definitions:147 business_process,954 screen_journey,1760 action_journey,2474 api_contract and3 legacy_candidate. Attempt IDs are history identifiers, not workflow counts.

The synthetic schema was dropped. No production business data/grants changed and no email was sent. No implementation/work branch or feature PR was opened. This documentation commit removes inspect-email-config.yml and record-email-config.yml; the already-started protected recorder verifies exact current-main source bindings, final main checks, one remote branch/main and zero open PRs before saving the workflow checkpoint and recovery-handoff-current.

EMAIL_CONFIG_ATTEMPT_COMMITTED and EMAIL_CONFIG_HANDOFF_COMMITTED contain the authoritative attempt ID, totals, issue criteria, evidence and final SHA. EMAIL_CONFIG_NEXT_LIVE identifies the next not_run, unblocked business process from fresh production records, avoiding already-completed attempts.
