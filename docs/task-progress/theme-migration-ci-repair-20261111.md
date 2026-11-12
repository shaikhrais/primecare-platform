# Theme migration and website CI repair

Batch summary: repair two confirmed verification blockers while preserving mandatory Screen Manager/theme/shared-library enforcement.

- Workspace run43143503319 job130935849394: tenant layout passed, but theme migration fixture timed out at line52 waiting for appearance-open. The fixture called the real tenant renderer without installing presentation or registering its entry. Reuse existing tenantPresentationTheme, installPortalPresentation and resolveManagedRoute registration, matching the passing layout fixture. Assert page errors are empty and configuration error state absent before interacting.
- Account verification run43143503501 job130936866989: workspace route test bundling failed to resolve bcryptjs from five real worker imports. Pin bcryptjs3.0.2 in root devDependencies and lockfile; preserve every existing lock entry. No mock, externalization or authentication changes.

Local verification: 29 workspace route/publisher tests and117tenant manager/presentation tests passed. Browser fixture syntax passed. Existing missing-manager/theme denial tests still pass. These are local model/source checks, not browser/PostgreSQL or production proof. Fresh GitHub Actions must verify those gates and clean locked install.

Source mapping counts remain50/72,22unreconciled; full feature acceptance0/72. No screen/workflow readiness, runtime, deployment or migration-removal credit. No branch, PR or production data writes.
