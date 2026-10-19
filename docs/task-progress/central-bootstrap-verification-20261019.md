# First central administrator workflow attempt

Workflow: `auth.bootstrap-first-central-admin`.

Live pinned production inspection: https://github.com/shaikhrais/primecare-platform/actions/runs/39309138927 . Definition SHA256 `37ba0a56137ce040952225ca11eddcc785c0f60333cfededa1e63bb403748358`; registered source is `scripts/bootstrap-first-central-admin.mjs`. Registered `founder-v1` policy gives central administrators global scope but excludes central peers from assignable roles. No bootstrap API or new application operator role is registered.

The definition explicitly leaves the approved deployment operator identity and approved execution environment unbound. Those requirements block full protected-operator acceptance. Do not infer a new grant or run bootstrap against production. Credential login, permitted console and reload, deployed routing, negative UI/session/offline cases, video and independent review gates are still unproven.

Existing six simulated database checks passed locally. Added six native PostgreSQL checks for actual account/audit persistence, bcrypt credential validation, existing-account and foreign-tenant preservation, invalid input, transaction rollback/retry and racing first-admin calls through independent connections. Each uses a disposable schema and explicitly rejects production credentials. This is scoped backend evidence, not workflow verification. Native execution and final production attempt/checkpoint recording are pending CI and merge.

No business implementation defect was confirmed by the simulated tests or source inspection. This change closes the missing native transaction coverage. The live catalogue at inspection contains 147 business processes: 11 missing, 134 implemented-unverified, 0 verified, 2 blocked. Recalculate after recording this attempt.
