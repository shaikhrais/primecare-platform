# Confirm Platform Admin sign-out before clearing browser state

Workflow: auth.logout. Actor: Platform Admin (`platform_admin`).

The current native PostgreSQL baseline reproduced the same defect in EN/FR/ES:
a failed logout DELETE returned HTTP 503, but the Platform Admin UI cleared its
browser token and navigated to login while the server session still authenticated.
Baseline evidence: https://github.com/shaikhrais/primecare-platform/actions/runs/39322477891/artifacts/12220063802

The shared auth transport now requires a successful `signed_out` acknowledgement.
The Platform Admin UI uses that transport and the existing localized unavailable
message before allowing retry. A response for an earlier token reloads the current
session instead of deleting a replacement browser token. Confirmed sign-out uses
the required semantics query on the login route.

The transport regressions cover request shape, non-success responses, malformed
acknowledgements, delayed parsing and network/body failures, alongside existing
credential-login tests. The native browser regression executes the actual main
router, gateway and inherited worker dispatcher against disposable PostgreSQL 16,
covering database failure, offline retry, malformed success, response loss after
commit, replacement-session races, foreign-session preservation and denied reload
in EN/FR/ES. The isolated CI mode explicitly uses synthetic metadata/theme fixtures
without production credentials; it does not replace live governance authority or
claim deployed visual/accessibility/PWA verification. A protected post-merge
production-governance attempt binds fresh evidence and records the current status.

No API, route, role grant or production business record is added by this repair.
The existing endpoint is POST /v1/auth/logout. Its formal registry metadata and
generic missing/expired-session alternatives still need reconciliation with the
existing idempotent server contract before whole-workflow verification. Other role
UI surfaces, full cookie/deployment behavior, governed recording delivery and
independent review gates remain pending. This change does not mark the business
process verified.
