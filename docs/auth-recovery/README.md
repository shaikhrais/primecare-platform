# Recovery presentation compatibility

Public web password recovery uses the existing authentication APIs and the `auth_recovery_web_policy` governance record. Its two public routes, source file and registered component/control mappings are exported in `packages/shared/src/auth-recovery.json`.

The existing native screen routes and source bindings are preserved using the metadata recorded in `native-presentation-baseline.json`. The registrar reconciles only its former web-specific section and known route/file values; an unexpected presentation change stops registration. It does not activate APIs or promote native or web readiness.

Validation: `python3 scripts/test-auth-recovery-governance.py` checks reconciliation, preserved native sections, component bindings, idempotence, read-only checks and rollback on an unknown route. `scripts/test-auth-recovery-web.mjs` exercises public recovery in EN/FR/ES at 320 and 1440 pixels. The native source/POM audit remains an independent structural check; it does not certify business behavior or physical devices.
