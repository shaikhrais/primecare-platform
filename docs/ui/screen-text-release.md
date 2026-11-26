# Screen text production release

Repository-managed deployment uses existing GitHub production secrets. No
credentials are copied into the coding workspace. Merge this release wiring
before the device-cache feature: installing this workflow alone does not
publish an older UI. A subsequent screen-text change merged to main starts isolated verification only.
The legacy ordered production release requires a separate manual dispatch with
explicit RELEASE_CURRENT_MAIN confirmation and the exact reviewed main SHA.
Do not publish from a code push or build approval.

All jobs use the triggering source commit. Production jobs are skipped on pull requests and pushes. The workflow does not commit or publish the SQLite governance database.
Before release tests, it stops standalone Flutter Pages deployments for this
same main commit, preventing competing builds from overwriting the TypeScript
portal release. Native builds and releases of other commits are untouched.
The smoke check reads public text catalogs and website bundles only; it does
not create users or change production business data. Any verification/migration
failure prevents later deployment jobs. Actual rollout success must be reported
from the workflow results and live checks, never inferred from configured secrets.
