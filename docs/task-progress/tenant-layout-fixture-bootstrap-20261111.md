# Tenant layout acceptance bootstrap

Batch: repair two test preconditions confirmed in CI on main 6e5fedac. The shared component/browser and three native operating-system jobs passed; these failures are separate acceptance fixtures.

Both cross-batch browser and disposable PostgreSQL jobs timed out waiting for appearance-open in test-tenant-workspace-layout.mjs (jobs 130803878980 and 130803878665). The test invoked the tenant renderer without installing the Screen Manager required at its route boundary. The fixture now uses the same real installPortalPresentation and managed route registration as the existing tenant work-host fixture. These presentation registrations do not grant identity or data access. The original real tenant handler, actor tokens, denied-role assertions, API writes/readbacks, layout persistence and lifecycle assertions remain in place. A configuration error now fails explicitly before waiting for the appearance control.

Governance web build job 130803879258 rejected nullable PieChart section.titleStyle access. The test now explicitly asserts that the style and its color exist before calculating the unchanged 4.5 contrast threshold.

Local syntax, Screen Manager and platform presentation fixture checks are run. Browser process startup is denied by the local container's socket policy; no browser or native acceptance is claimed locally. GitHub Actions must rerun the full acceptance fixtures. Source violations remain separately tracked at zero and whole-feature acceptance remains 0/72.
