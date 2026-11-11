# Shared skeleton lifecycle repairs

Batch: harden the existing shared countdown and asynchronous region used by original PrimeCare skeleton components. All consumers retain the same public factory API and governed metadata.

Reproduced two defects with public-API DOM tests before editing production code: calling tick after an individual countdown disposal still invoked onFinish (1 instead of 0); retrying a failed asynchronous region kept role=alert while loading. Both tests failed on main 6eb532a2.

Countdown disposal now blocks subsequent explicit/visibility ticks, removes its own visibility listener and releases its factory timer cleanup entry. Retry removes stale alert semantics before announcing the busy loading state. Error and recovered content behavior remain tested.

Validation: the two public-API regressions pass after repair; existing four component model tests and 21 shared fixtures are rerun. The browser suite adds equivalent scenarios and runs in the existing component catalogue workflow. Local Chromium download was truncated, so browser/native acceptance is pending GitHub Actions. No feature, registration, grant, route or production readiness credit is added. Full acceptance remains 0/72 verified and 72 pending; strict source findings are separately tracked.
