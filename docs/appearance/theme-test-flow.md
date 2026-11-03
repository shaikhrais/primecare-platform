# PrimeCare test flow

Run the Platform Admin database and browser acceptance workflow on main. It uses synthetic accounts and an isolated PostgreSQL schema. Read the numbered R04_THEME_BATCH entries in Actions and download the browser receipt, screenshots and test log. A failed step stops its sequence. Fix it and rerun the full sequence on the corrected commit.

## R04 Platform Admin sequence

The master-record step repeats for each configured record family. Actions logs use the expanded runtime step numbers.

1. Sign in as platform administrator
2. Create a tenant
3. Create a tenant administrator
4. Change a tenant account role
5. Deactivate an account
6. Create a registered master record
7. Update a master record
8. Review the audit trail
9. Generate the platform report
10. Download the report PDF
11. Email the report with consent
12. Switch interface language
13. Keep navigation visible while scrolling
14. Check a mobile browser
15. Navigate with the platform sidebar
16. Search authorized tenants and records
17. Verify tenant switching clears search records
18. Open administrator training
19. Customize the shared theme and layout
20. Save the Platform Admin layout and verify the sidebar after reload
21. Export and validate the XML layout
22. Save a named personal theme
23. Restore and export the personal theme
24. Change own platform password
25. Sign in with the new password
26. Sign out

The first run with step reporting is [41675732186](https://github.com/shaikhrais/primecare-platform/actions/runs/41675732186). Record acceptance only after reading the completed result.

The [verified acceptance run](https://github.com/shaikhrais/primecare-platform/actions/runs/41690559227) passed all 28 expanded browser steps and the administrative and growth accessibility gate on `a200676`. Download the `platform-admin-workflow-video` artifact for the browser and accessibility receipts. This receipt covers the isolated Platform Admin run.

## R05 native workspace sequence

1. Run [Native workspace layout parity](https://github.com/shaikhrais/primecare-platform/actions/workflows/native-workspace-layout.yml) on the candidate commit. Check the web contract oracle, Linux/Windows/macOS widget suites, and native-to-web round trips.
2. On each supported physical device, install the candidate app and record its build revision, OS and app host. Sign in as the registered role and open the shared workspace.
3. Save a layout, fully restart the app, and verify the layout is restored. Sign in as a second scoped actor and verify the first actor's layout is absent.
4. Sign out and verify the protected workspace cannot be reopened. Attach the device results separately from the automated parity receipts.

## Remaining flows and their gates

| Package | Test flow in execution order | Evidence required |
|---|---|---|
| R00 | Select registered host → launch as registered role → trace rendered controls to their registered actions | Actual host, role and action IDs |
| R01 | Read affected identities → compare against approved baseline → verify permitted and denied actions | Existing 192-row acceptance and new regression evidence for any identity changes |
| R02 | Select supported business action → locate handler and role policy → exercise allowed, denied and foreign-tenant requests | Matching contract, source and authority evidence per action |
| R03 | Recover archived portal → pair with auth → verify login, protected action, reload and denial → rehearse exact Worker restore in preview | Isolated clinic rehearsal accepted. Provider restore and production writer coordination remain open |
| R04 | Run Platform Admin sequence above → cover denied deep links, dirty forms, footer and overlays → repeat with supported hosts and locales | Browser receipts for each supported host and role |
| R05 | Install native app → sign in → open shared host → save and restart → sign out | Results from supported physical devices |
| R06 | Save preference → lose response → retry original request → reload → verify one write and correct tenant scope | Local recovery receipts, then approved cloud host and persistence evidence |
| R07 | Add, edit, move and remove a registered widget → remount → reload → verify persisted order and tenant isolation | Browser and database readback for each supported control |
| R08 | Sign in as each registered actor → complete owned work action → reload → verify audit and unauthorized denial | Approved action contracts and end-to-end business readback |
| R09 | Check role and provider setup → send, receive or manage a file → verify delivery, tenant denial and retention | Registered provider and synthetic delivery and lifecycle receipts |
| R10 | Execute each registered application or finance transition → check duplicate submission, denial and audit | Approved contract and isolated database readback |
| R11 | Trace each asset → verify license, localized labels, keyboard access and contrast | Asset inventory and accessibility evidence |
| R12 | Run eligible flows against the release candidate → verify deployed source and smoke checks → rehearse rollback → obtain review | Source-bound receipts and independent acceptance |

Rows describe the coverage required. Run an existing suite where available and record a blocker when a registered contract, device or isolated test environment is missing.
