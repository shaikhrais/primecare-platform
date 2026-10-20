# Auth browser coverage repair — 2026-10-20

The password acceptance workflow previously ran only Chromium. Changes to its test producer and account UI did not trigger acceptance on main, leaving a verification gap. The push and pull-request filters now cover the Worker, shared website source, test producer, client tests, isolated specification fixture and workflow. No runtime endpoint, permission, role or business policy changed.

The producer accepts an explicitly named Chromium, Firefox or WebKit engine and records its name and version. CI runs independent PostgreSQL service fixtures with fail-fast disabled, so a failed engine cannot hide the others. Artifact names are unique; the existing Chromium name remains compatible with consumers. The deployed lifecycle recorder now requires three receipts, checks all nine locale/width cases and their mandatory flags, compares source hashes against current and producer source, and preserves every receipt.

[Run39506076194](https://github.com/shaikhrais/primecare-platform/actions/runs/39506076194), source `0202362b7035c1f17bab2dcb6cc4be3fa0add72e`, passed:

| Engine | Version | Cases |
| --- | --- | --- |
| Chromium | 148.0.7778.96 | EN320, FR768, ES1440 |
| Firefox | 150.0.2 | EN320, FR768, ES1440 |
| WebKit | 26.4 | EN320, FR768, ES1440 |

All nine cases used the real main UI, gateway and auth service against isolated native PostgreSQL. They passed malformed-success rejection, offline retry, localized invalid-credential denial, audit-failure rollback, bcrypt hash confirmation, denial of the old password and prior sessions, reset-code removal, preservation of the foreign tenant, new login and reload, and preservation of a replacement browser session while an older request completes. The13 auth/account/sign-out client tests passed in each job. All jobs completed successfully after dropping their isolated synthetic schema.

This is desktop-engine scoped evidence using an explicitly isolated metadata fixture. It does not establish physical-device, PWA, full accessibility or independent review acceptance. It does not repeat email delivery; prior real Cloudflare receiving evidence remains in auth-invalidation-20261020.md. Four protected-bootstrap/role-switch policy decisions remain blocked. Full auth acceptance is still false. New production tracking must only be claimed after the live producer and updated recorder succeed.

Machine summaries: evidence/auth-browser-engines-20261020.json. Full source-bound receipts, screenshots and videos are retained in the CI artifacts.
