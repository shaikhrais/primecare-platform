# Recovery feedback repair and full-story checks — 2026-10-20

A successful password reset cleared its localized success confirmation. The shared recovery renderer assigned the confirmation and then called `form.reset()`; because `output` is a resettable form element, it returned to its empty default value. The native browser suite reproduced blank feedback in [39516789261](https://github.com/shaikhrais/primecare-platform/actions/runs/39516789261). The renderer now resets the form first, then assigns the existing localized confirmation. No API, role, permission or business rule changed.

The initial new audit-fault fixture in39516566333 had an SQL dollar-quote error introduced during test editing. That was corrected before the feedback defect was evaluated. The fixture migration is included in source bindings. Both failed runs are preserved; neither is passing evidence.

[39516993763](https://github.com/shaikhrais/primecare-platform/actions/runs/39516993763) passed Chromium, Firefox and WebKit in EN320/FR768/ES1440. It preserves the nine existing current-password cases and adds nine recovery cases, for18 journeys and36 automated form scans across login, current-password, forgot-password and reset-password forms. All scans reported zero violations and zero incomplete checks.

Recovery checks use the real main UI, gateway, auth handler and disposable native PostgreSQL. They cover keyboard submission and navigation; provider failure leaving domain state unchanged; retry; identical visible response for an absent account without sending mail; storage of only the account-bound code hash; password mismatch without a request; offline retry; rejection of malformed success; invalid and expired codes; audit failure rolling back password, consumed code and session changes; the actual bcrypt hash; revocation of the old session; preservation of another tenant; replay denial; cleared secret fields; persistent localized success; and new-password login followed by authoritative reload.

The mail binding is explicitly isolated to inject a provider failure. It does not demonstrate Cloudflare sending or inbox delivery. Fresh deployed receiving-Worker evidence is established by the production runs below, separately from the isolated fault-test binding. Every browser job drops its isolated synthetic schema and records its exact source graph. No production fault triggers or synthetic native-test rows are installed.

The production recorder now requires three recovery cases and six recovery-form scans per engine, all mandatory flags, passing source hashes and the separate real deployed email receipts. It reports nine native recovery cases and36 total automated form scans. The full receipts, screenshots and source hashes remain in CI artifacts; machine summaries are in evidence/auth-recovery-feedback-20261020.json.

The current auth inventory remains23 processes:19 implemented with scoped evidence, four policy-blocked. Full acceptance remains false. These tests do not approve manual assistive-technology/device/PWA coverage or independent reviews, nor invent protected-bootstrap or role-switch policy.

## Deployment and current production evidence

All nine portals deployed successfully and passed smoke checks in [39516993847](https://github.com/shaikhrais/primecare-platform/actions/runs/39516993847). The complete auth backend UUID/text matrix passed [39516789197](https://github.com/shaikhrais/primecare-platform/actions/runs/39516789197); targeted auth release passed [39517575317](https://github.com/shaikhrais/primecare-platform/actions/runs/39517575317).

[39517539808](https://github.com/shaikhrais/primecare-platform/actions/runs/39517539808) passed255 live account/read/lifecycle checks in EN320/FR768/ES1440. Every locale received a real Cloudflare recovery email, reset its synthetic account, changed its password, signed out, checked native audit/session/reset state and reloaded. Exact synthetic records and only hash-matched correlated messages were removed. Existing accounts and inbox entries were preserved.

[39517671719](https://github.com/shaikhrais/primecare-platform/actions/runs/39517671719) passed90 additional own-session checks across the same locales: denial and tenant isolation, projection/count/timestamp comparison, cancellation, confirmed revocation, committed audit and signed-out reload. Exact synthetic cleanup passed.

The production recorder passed [39519287647](https://github.com/shaikhrais/primecare-platform/actions/runs/39519287647), attested all nine deployed JS/CSS/theme values against their actual build artifacts, checked nine native recovery cases, nine current-password cases and36 automated form scans, and wrote scoped attempts442–455 for14 existing auth processes. The own-session recorder passed [39518472036](https://github.com/shaikhrais/primecare-platform/actions/runs/39518472036), preserving attempts440–441 and the90-check producer.

The own-session recorder originally used the workflow queue timestamp, which can precede deployment even when its proof jobs run later. It now compares actual successful proof-job start timestamps with build/gateway/all-nine deployment completion, and retains the exact current/producer source and deployed asset checks. Earlier rejected attempts39517985829 and39518312095 made no tracking writes.

[39518263513](https://github.com/shaikhrais/primecare-platform/actions/runs/39518263513) cancelled only untouched automatic same-commit pending duplicate39517671735. The guard requires zero jobs, preserves manual/rerun requests and refuses cancellation when jobs have started. Existing active fixtures completed normally.

The current production auth snapshot still has23 business processes:19 implemented-unverified with scoped passing evidence, four blocked and zero fully verified. The blocked duties are the three first-operator bootstraps and role switching. Full actor/platform/manual accessibility/PWA coverage and independent review approvals remain incomplete. The345 live checks,18 browser journeys and36 automated form scans do not grant those approvals.
