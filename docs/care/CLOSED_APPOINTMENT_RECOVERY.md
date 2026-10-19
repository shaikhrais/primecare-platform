# Closed appointment reassignment recovery

Recovery base: `dd6e76a` on the published `work/care-recovered-20261017` branch. The unpublished local branch and its later audit/browser receipts were removed by workspace maintenance. This increment restores one known fix; it does not reconstruct that missing history or carry its verification counts forward.

The existing care requirement distinguishes cancelling an assignment from cancelling the client's source appointment. The registered EN/FR/ES cancellation guidance already states that reassigning staff cannot restart a cancelled appointment. Existing tenant administrator/scheduler roles, the care screen, reassignment control and protected case-action API are reused. The existing registrar reproduces the missing generated care metadata from the repository's approved seed without creating real assignments.

The shared action policy now excludes reassignment when the source appointment is cancelled, rejected or completed. Assignment-only cancellation on an active source appointment retains its valid restart path. The UI continues rendering the actions supplied by the existing API; no UI business logic, route, permission, component, theme or translation was added.

Three isolated contract-policy regression tests cover all registered operations roles and care states for closed appointments, the positive assignment-only restart case, and denied non-operations roles. The closed-appointment test failed before the fix and passes afterward. Worker and website TypeScript checks pass. The first website check encountered files excluded by the recovery's sparse checkout; restoring the existing localization/domain files resolved those missing-module errors.

The existing native database integration suite now asserts that cancelled source appointments omit reassignment and assignment-only cancellations keep it. Those assertions are committed for CI but have not run locally. No native PostgreSQL, role-login browser workflow, new video or full-role completion is certified by this increment. Governance metadata and workflow tags remain pending full acceptance. Remote CI and required reviews must pass before merge.

Reproduce the executed policy checks with `node --test scripts/test-care-closed-appointments.mjs`. CI runs them before migration and database/browser acceptance checks. Review the existing source appointment cancellation workflow in `scripts/test-care-delivery.mjs` for the added integration assertions.
