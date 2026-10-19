# Employee operations foundation

The user requested a company-wide task master, operation records, deadline accountability, employee rights and a structure for large organizations. The initial catalog covers 11 existing admin/marketing roles, with 65 unique duty templates. Clinical and client users do not receive employee duties automatically.

`foundation-seed.json` defines duties, owner/reviewer roles, evidence, acceptance criteria, cadence and planning estimates. `register-workforce-foundation.py` validates active governance roles, stores local template/policy/document rows and exports the shared catalog. It creates zero real employee assignments and changes no active role grants, payroll or public API.

`WorkAccountability` is a backend foundation evaluator, not an exposed service. It retains original/effective deadlines, distinguishes on-time submission from manager review delay, classifies system/dependency/leave blockers for human review and never produces a wage deduction. Twelve tests cover catalog invariants, deadline boundaries, timezone offsets, evidence, independent acceptance, extensions, cancellation and fair aggregate categories.

Current APIs have a narrower open/done task model. Recurring employee job assignments, working calendars, manager acceptance, time records, payroll integration and appeals remain future implementation phases. The new catalog does not certify those workflows. Estimated minutes are planning guidance, not hours worked or a pay formula.

The 30-page guide includes organization hierarchy, operation records, permission design, dashboards, payroll separation, company safeguards, large-organization architecture, rollout gates, examples and every task template. Ontario employment-standard statements were checked against official sources on 14 October 2026. Company safeguards are draft policy for adoption, not a blanket legal statement for every jurisdiction.

Reproduce: `python scripts/register-workforce-foundation.py`, `node --test scripts/test-workforce-foundation.mjs`, then `python scripts/create-workforce-foundation-guide.py`. The PDF requires ReportLab, Pillow and DejaVu fonts. Actual employee assignment requires an authorized roster, employment/job relationships, calendars and approved templates; no fictitious employee assignment is used as evidence.
