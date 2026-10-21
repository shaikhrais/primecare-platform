# Flutter recovery acknowledgement repair — 2026-10-20

The live Flutter recovery form previously treated every HTTP 200 as success, including empty or malformed responses. It now requires the existing API acknowledgement: the generic recovery message, or password_reset plus Boolean reauthenticationRequired=true. Failed acknowledgements retain drafts and cannot clear reset secrets or display success. No route, permission, role or server policy changed.

Six locale/mode widget scenarios cover malformed payloads, the other operation's acknowledgement, wrong/missing Boolean values, unavailable transport, HTTP failure despite a valid payload, retry, normalized requests, confirmed secret clearing and persistent success. Auth Gateway CI now executes these scenarios and the existing live-screen-text tests. YAML/parity/whitespace checks passed locally; Flutter SDK is unavailable locally, so widget execution is pending CI and is not claimed passed.

Gateway run 39524170230 passed all eleven jobs before this repair. Maintenance native safety run 39524173446 passed. Prior live TypeScript/email proofs remain historical scoped evidence; deployed Flutter email/browser acceptance still needs its own source-bound receipt. The deployment overlap recorded in auth-current-deployment-boundary-20261020.md remains unresolved. No full verified status, physical-device/manual accessibility acceptance or independent review approval is asserted.

## Follow-up and execution checkpoint

Commit 18832b0fc97bfcea29481bf29205d20cf9657046 centralizes the acknowledgement check in ApiResponse.confirmsPasswordRecovery. Both the form and existing AuthNotifier.forgotPassword use it. Core transport regressions cover malformed/cross-operation responses and non-200 responses with otherwise valid bodies.

Run 39524857619 failed before application execution: job118976996450 could not pull public.ecr.aws/docker/library/postgres:15-alpine because the mirror returned "toomanyrequests: Data limit exceeded" on all three attempts. Commit5e9dcaee3e1a428daea96ad2b3280fcdac69d61f keeps PostgreSQL15 and switches to its official postgres:15-alpine image. Replacement [39525040395](https://github.com/shaikhrais/primecare-platform/actions/runs/39525040395) was queued at the checkpoint. Superseded run39524857619's remaining jobs were cancelled by the existing per-ref concurrency mechanism; they did not establish passing widget results.

Read-only live browser inspection confirmed the Flutter login controls and Forgot password navigation rendered. Observed recovery URL carried enable-semantics inside returnUrl instead of as a top-level query parameter; semantics/navigation preservation requires a focused regression check. No credentials or recovery codes were submitted. The browser/exec server then disconnected; the attempted empty-submit validation did not return a result and is not counted as passed. GitHub access remained available, and all fixes/checkpoint evidence were preserved on main.

Full auth verification is still incomplete. Next execution must obtain the replacement CI result, resolve any regression, bind deployed Flutter recovery to real receiving-Worker/native database receipts, and reconcile the competing production deployment workflows. Do not promote historical TypeScript UI receipts into proof for the current Flutter runtime.
