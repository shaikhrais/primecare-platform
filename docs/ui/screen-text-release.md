# Screen text production release

Repository-managed deployment uses existing GitHub production secrets. No
credentials are copied into the coding workspace. Merge this release wiring
before the device-cache feature: installing this workflow alone does not
publish an older UI. A subsequent screen-text change merged to main starts
verification, the additive 20261013_screen_text migration, the existing Workers
and Pages workflows, and public catalog/bundle verification in that order.

All jobs use the triggering source commit. Production jobs are skipped on pull
requests. The workflow does not commit or publish the SQLite governance database.
The smoke check reads public text catalogs and website bundles only; it does
not create users or change production business data. Any verification/migration
failure prevents later deployment jobs. Actual rollout success must be reported
from the workflow results and live checks, never inferred from configured secrets.
