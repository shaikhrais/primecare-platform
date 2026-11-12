# Native renderer assertion repairs

Batch summary: repair three confirmed fixture assumptions after the shared-control/theme migration. Preserve the production renderer, 4.5 contrast requirement, Screen Manager registration, access/error behavior and SDK controls.

Exact main ea2a9e2f Theme Center passed website and eight consumer packages. Native job 130860202248 passed 107 tests and failed the semantic bridge assertion: Color.lerp returns a Color with the same channels, while the expected MaterialColor is a swatch subclass. Compare the exact ARGB value and add a distinct-endpoint interpolation assertion; material ThemeData identity is still checked separately.

Governance job 130860202135 failed a 4.5 score-label contrast assertion (2.0479). Its fixture changed MaterialApp themes, pumped only the first animation frame, then compared the displayed foreground to the future target background. The actual score renderer already computes a readable foreground from its current Theme.of(context) surface. The fixture now settles theme changes, reads the actual painted circular surface and checks both target convergence and the unchanged contrast requirement. Additional coverage checks the actual foreground/background pair at initial, intermediate and settled light/dark transition frames. Thresholds, score calculation and status tones are untouched.

Unified job 130860200282 also found a stale `as Scaffold` cast in the actual health-route fixture. The registered shell now returns PrimeScaffold. Its public body is inspected without changing the shell, AppShellBoundary, ManagedScreenBoundary or lookup assertions. The same fixture continues exercising loading, successful sync, offline errors, denied responses and out-of-order requests.

Native tests are authored for GitHub Actions; no local Flutter runtime or new-head acceptance is claimed. Source violations remain 0, with zero new control/color removals. Feature acceptance remains 0/72 complete and 72 pending. This batch implements no new business capability and grants no readiness credit.
