# Master-connected web release — November 22, 2026

The nine live TypeScript portals now import internal PrimeCare APIs through
`packages/primecare_master/web`. Named exports, default exports, import aliases,
class identities, methods, URLs and business logic are preserved. An AST-based
comparison against the previous main confirmed that all 92 application-source
changes alter module specifiers only. The one EMS test fixture follows the new
module path so its existing mount/disposal assertions still exercise the host.

Scope: the nine keys in `websites/typescript/projects.json`. The independently
reconstructed Flutter apps and Dart service hosts are excluded from this release.
Their complete master-only migration remains in the integration checkpoint;
this publication does not claim to have released those targets. API Workers,
database schemas, permission grants and registered dashboard activations are
unchanged.

Previous verified release: `19ed9f8071abca3e02e7b2bf18b542a351c3d640`, GitHub
Actions run https://github.com/shaikhrais/primecare-platform/actions/runs/45040631184.
The release pipeline verifies and retains each target's live stamp and exact
assets separately before publication. That successful run also retains the
previous deployable portal artifacts for recovery. The new publication reuses
the existing production lock, governed build, production metadata checks and
per-portal source/asset verification.

Local validation: all 25 existing publisher regression commands passed (2,990
Node tests, plus the deployment Python suites). The foundation and web-boundary
suite passed 12 tests; the catalog suite passed 5 tests. Workspace lock validation
passed `npm ci --dry-run --ignore-scripts --offline`. Web boundary verification
found 168 master imports across 130 consumer files and verified 95 gateways.
Negative import probes are rejected and class/JSON object identities are retained.

`.github/workflows/release-master-web.yml` additionally requires browser password
acceptance for the exact candidate commit in Chromium, Firefox and WebKit before
calling the existing website publisher. Browser fixture acceptance and live
source/asset verification are separate evidence; neither certifies every signed-in
business process. GitHub Actions results are authoritative for publication status.

Compatibility follow-up: master TypeScript specifiers keep the existing
extensionless style, including the generated re-exports. The Vapi compiler
configuration therefore needs no relaxed flags, and the existing theme preference
host lifecycle fixture continues to intercept the same module names. This fixes
TS5097 and lifecycle fixture export failures found by the first CI candidate.

## Publication reconciliation

The existing automatic business-plan publisher deployed the corrected source
`12ec8b021b249d5eea50fc8e81f2ef095612c4a3` to all nine portals in run
https://github.com/shaikhrais/primecare-platform/actions/runs/45058806088.
Its publication job reported all nine completed Pages deployments and the live
business-planning authentication denial check passed. Three-browser acceptance
passed for the same source in run 45058806040. The dedicated master check passed
in run 45058806038; that wrapper's baseline check correctly stopped its second
publication because the prior live source had already changed.

`verify-master-live.yml` reconciles these receipts and independently checks each
live source stamp and exact asset hashes against the already published source.
It contains no publication step, production credentials or database writes.
The complete workflow result and retained nine live stamps determine whether
post-publication verification succeeded.
