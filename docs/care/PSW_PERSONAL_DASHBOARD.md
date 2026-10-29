# PSW personal dashboard

PSW and HSW accounts open their personal workspace at `/care` or `/psw`. It uses the approved worker-first layout. Operations roles keep the coordinator workspace; Code Admin can open **PSW personal dashboard · demo** without gaining access to live clinical records.

## Live data and actions

The `/v1/governance/care/personal` API authenticates the current active session and tenant. A worker sees their own profile, authorized appointments, native `care_time_records`, actual staffing windows, saved preferences and personal requests. Weekly time uses the actual shift-start date in Toronto; gross, unpaid-break, reported, pending, returned and approved minutes remain distinct. No pay rate, payday or paid statement is invented. Real care actions and time correction use the existing CareClient/CareRepository workflow, preserving plan version, consent, qualification, independent review, staffing checks and immutable care events.

Extra-work requests, nonclinical team queries and expense claims save in `psw_personal_requests`. Tenant operations review them at `/psw-requests`; responses appear in the worker inbox and can be acknowledged. Self-review is prohibited. Resolving a request does not independently approve leave, assign work, approve time or pay money. The requests queue does not send email, SMS or emergency notifications. Clinical concerns, no-access reports and care amendments use the assigned care record.

## Marked demo and fresh start

`?dataset=demo&experience=personal` uses `data_kind=synthetic_training`. There are no real demo employee accounts, native client records or clinical approvals. Each active tenant receives one shared management preview; PSW/HSW staff have private practice workspaces.

**Clear demo data** empties only the selected personal practice workspace and clears its obsolete demo idempotency responses. It does not remove real appointments, real time records, live requests, other workspaces or immutable audit history. Reading a cleared dataset does not silently reseed it. **Load demo data** explicitly restores the synthetic sample. Production seeding preserves existing edits and cleared workspaces.

All saves use explicit server commands, versions and idempotency keys. A failed save restores the previous saved UI state and shows an error. There is no localStorage persistence or offline-success claim.

## Registry and release

`packages/shared/src/psw-personal/catalog.json` contains 50 questions, 18 coded tasks, 12 screen/view definitions, controls, native API reuse and workflow mappings. `psw_personal_registration.py` applies only its hash-pinned namespace to the existing production PostgreSQL governance authority. It registers screen requirements, sections, elements, shared component mappings, role grants, API schemas/links, English resource labels and source-mapped screen journeys. These journeys do not inflate the business-process count. Independent clinical/payroll policy and full multilingual review remain explicitly unverified.

Acceptance covers exact hours, actual profile/time reads, tenant/account isolation, server consent and command restrictions, request/reply/acknowledgement, idempotent retry, concurrent versions, immutable audit and cleanup preserving live data. Browser QA uses the real project renderer and care API with disposable synthetic database fixtures. Release receipts report migration coverage and registry counts without logging patient records or credentials.
