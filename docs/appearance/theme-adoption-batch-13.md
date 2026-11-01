# Batch 13: task-backed work module foundations

Original shared web and Flutter templates now cover task due-date calendar, authorized directory, workflow tasks, task instructions and task status board. This is a bounded integration with an existing governed workflow, not adoption of every reference application feature.

The metadata registration committed 23 optional controls and required-element records, 38 resources and 114 draft EN/FR/ES translations. Production registration run [41266361915](https://github.com/shaikhrais/primecare-platform/actions/runs/41266361915) independently verified existing API authority 16578/16579 before writing. No APIs, role grants, business records, schema changes, routes or runtime activation were introduced. Human review flags remain unset.

Source: [5a9deba6d51c54a2bfdac795c86c651b06827ab5](https://github.com/shaikhrais/primecare-platform/commit/5a9deba6d51c54a2bfdac795c86c651b06827ab5). Verification run: [41267690894](https://github.com/shaikhrais/primecare-platform/actions/runs/41267690894). Final job conclusions and log excerpts are recorded in `theme-adoption-batch-13-evidence.json`.

The adapter reuses the existing server-authorized task actions and shared transition rules. Every saved edit/transition needs a mutation acknowledgement followed by fresh item readback with the expected fields and next version. UI editors capture versions; rejected or uncertain operations never display success. The source tests exercise API validation, independent SQL, reload, stale writes, scope mismatch, read-only directory, uncertain retry and disposal. Browser tests exercise all five templates against the real existing handler in an isolated PostgreSQL fixture; no operational records are used.

Read `work-modules-usage.md` for exact feature mapping, imports, ownership, bounds and missing work. Standalone note/contact CRUD, appointment calendar features, manual board rank and new-template creation are explicitly unadopted. Flutter transport/host bindings, production deployment/device checks and human review remain open. Screen 2534 and full-app activation are not claimed.

B14 is next: mailbox, messenger, notifications and file manager, using existing communications authority. B13's remaining requirements remain tracked when moving to B14.
