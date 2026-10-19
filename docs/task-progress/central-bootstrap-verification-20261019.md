# First central administrator workflow attempt

Workflow: `auth.bootstrap-first-central-admin`.

Production attempt **311** is committed. Verification status: **blocked**. Test status: **scoped_pass**. Live pinned requirements inspection: https://github.com/shaikhrais/primecare-platform/actions/runs/39309138927 . Definition SHA256 `37ba0a56137ce040952225ca11eddcc785c0f60333cfededa1e63bb403748358`.

The pinned definition explicitly leaves the approved deployment operator identity and execution environment unbound. Registered `founder-v1` policy gives central administrators global scope but excludes central peers from assignable roles. No bootstrap API or new application operator role is registered. Do not invent grants or bootstrap production.

Added six native PostgreSQL 16 cases proving actual account/audit persistence and bcrypt credentials, tenant eligibility, preservation of existing mixed-case foreign-tenant accounts, invalid input rejection before SQL, audit-failure rollback and retry, and a single winner across independent concurrent connections. Six existing simulated contract cases also passed: **12 passed, 0 failed**. All synthetic schemas were dropped. Native test code rejects production credential variables and requires loopback database `bootstrap`. No production business account was created.

Evidence: https://github.com/shaikhrais/primecare-platform/actions/runs/39310836913/artifacts/12215313513
Post-merge execution and committed tracking: https://github.com/shaikhrais/primecare-platform/actions/runs/39310836913 .
Cleanup and production handoff: https://github.com/shaikhrais/primecare-platform/actions/runs/39311013329 .

PR https://github.com/shaikhrais/primecare-platform/pull/211 merged candidate `2030c4d8c0d26ee84a87d717d661c553248f145b` into main at `1a66e2ceebb427fa1cd009e489d8938a08e0bc6b`. All six PR checks passed; two production-only checks were correctly skipped on the PR. Post-merge native and protected tracking jobs passed. PR closed; exact merged remote work ref deleted; no local work branch was created. Independent workflow review gates remain unproven, and this scoped change does not mark the business process verified.

Credential login, permitted console/API/database/reload, deployed routing, denied-role/session/offline checks, video and required reviews remain unproven. Resolve the governed operator identity/environment dependency before full protected bootstrap acceptance.

Production checkpoint and `recovery-handoff-current` snapshot record main `2386ec6509f3377424a2a5187b33b5247e027bde`, no active work branch, 0 open PRs, evidence, cleanup and next action. This final documentation update and removal of the completed operational cleanup workflow follow that checkpoint without changing tested business sources.

Live counts after attempt 311: **147 = 11 missing + 133 implemented-unverified + 0 verified + 3 blocked**. DONE=0; PENDING=147. Supporting screen/action/API guides were excluded.

Next workflow: `auth.bootstrap-first-ceo` — Bootstrap the first CEO through protected setup. Read its live definition, source links, role/API records and previous checkpoint before isolated acceptance. Do not repeat the central-admin native cases unless source, specification or evidence changes.
