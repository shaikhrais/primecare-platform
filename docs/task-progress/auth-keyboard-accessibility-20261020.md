# Auth keyboard and form accessibility — 2026-10-20

The auth browser producer now verifies keyboard login and keyboard password submission, forward and reverse tab order, and automated WCAG2A/AA,2.1A/AA and2.2AA checks on the login and password forms. The existing recovery link uses the approved media control-height token as an explicit minimum clickable height. No endpoint, role, permission or business policy was added.

The first scans exposed undersized targets with the historical fixture's empty theme. The password button result was therefore not accepted as a production defect. The isolated fixture now uses the deployed clinic manifest's existing CSS tokens, validates required variables and preserves the source URL/hash. The initial strict import also exposed a non-CSS `null` key. The exporter now omits rows without a CSS variable name, validates exported names/values and rejects conflicting duplicate values. It preserves exact approved values and excludes inactive/other-theme rows. It does not write to the governance database or invent fallback tokens.

[Run39508510798](https://github.com/shaikhrais/primecare-platform/actions/runs/39508510798) passed all nine cases, Chromium/Firefox/WebKit × EN320/FR768/ES1440, with the actual UI, gateway, auth service and isolated native PostgreSQL. All18 automated form scans reported zero violations and zero incomplete results. Each engine also passed the seven theme-export regression tests and13 existing auth/account/sign-out client tests. Full source-bound JSON, screenshots and videos are retained in artifacts. Summaries are in evidence/auth-keyboard-accessibility-20261020.json.

All prior checks remain in the journey: malformed success, offline retry, localized denial, audit rollback, bcrypt hash, invalidation of old sessions/reset codes, foreign-tenant preservation, new login/reload and preservation of a replacement browser session. Keyboard submission now exercises the actual mutations throughout those cases.

The UUID/text backend matrix passed [39507958555](https://github.com/shaikhrais/primecare-platform/actions/runs/39507958555). The auth release passed [39508913029](https://github.com/shaikhrais/primecare-platform/actions/runs/39508913029). The recovery-link CSS deployed to all nine portals and passed smoke checks in [39507678596](https://github.com/shaikhrais/primecare-platform/actions/runs/39507678596).

Release gating previously chose an older failed browser run even after corrected proof passed. It now selects successful repaired proof and compares Worker, website source, shared data, auth localization and database migration inputs. Manual/retry releases use the latest successful backend run rather than an obsolete hardcoded run. Browser triggers cover those runtime inputs. The recorder requires all three engines, all nine journey cases, keyboard flags and18 passing form scans before tracking writes.

The earlier live producer39507071862 passed its deployed journey, but its older password receipts were rejected by the stricter recorder39508167917 before tracking writes. That rejection is superseded by the successful current-source producer and recorder below.

These checks cover two forms and desktop browser engines. They do not approve full-page accessibility, manual screen-reader behavior, native/mobile devices, PWA installation, remaining workflow alternatives, or independent reviews. The three protected bootstrap policies and role-switch policy remain blocked. Whole auth acceptance remains false.

## Fresh deployed acceptance result

The current source rebuilt and deployed all nine portals in [39509036427](https://github.com/shaikhrais/primecare-platform/actions/runs/39509036427), then passed255 live account/read/lifecycle checks across EN320/FR768/ES1440. Every locale received a real Cloudflare recovery email, completed reset/current-password change/logout, checked native password/session/reset/audit state, rejected denied access and replay, and confirmed exact synthetic cleanup and removal of only the correlated email.

The current-source session gate passed and [39510747332](https://github.com/shaikhrais/primecare-platform/actions/runs/39510747332) passed90 additional live checks,30 per locale: current-session projection, authoritative counts/timestamps, bearer and tenant denial, caller-selected user denial, reload, cancellation, confirmed revocation, old-token denial, foreign-tenant preservation, committed audit and signed-out reload. All three cases removed their exact synthetic users, tenants, sessions, audits and counters.

The production recorder passed [39510747399](https://github.com/shaikhrais/primecare-platform/actions/runs/39510747399), verified deployed JS/CSS and governed theme values against each of the nine actual build artifacts, validated all nine native browser cases and18 automated form scans, and recorded scoped attempts424–437 for14 existing auth processes. The latest complete browser proof [39508854499](https://github.com/shaikhrais/primecare-platform/actions/runs/39508854499) also passed all three engines. The auth release version is `60f731de-3d2d-474e-b265-1d6b46023165`.

The session verifier now recognizes newer all-nine deployments only when every deploy/build/gateway job succeeds and the website/shared/builder inputs match. This replaced its obsolete single-workflow deployment lookup. Production session evidence recording is running as39511078128; successful browser execution is already established by the producer above.

The live auth register has23 processes:19 implemented-unverified with scoped passing evidence, four policy-blocked, none missing and zero fully verified. These workflow counts overlap the platform catalogue and must not be added to147. No approval status was fabricated.
