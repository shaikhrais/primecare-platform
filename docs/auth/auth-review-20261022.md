# Auth engineering review and owned-inbox verification

Reviewed business logic: deployed runtime `116d1eb30108f4590493a3cf1a209d7d5312ac63`. Subsequent changes in this review affect verification and documentation; the auth API/UI behavior is unchanged. Final verified runner/release source: `4ada3b8729a626d10560a7c2980035bf172b3640`.

## Review findings and repair

The implementing assistant reviewed recovery-code generation/hashing, lifecycle proof and session checks, temporary elevation/support authorization, notification leasing, native email transport and semantics/navigation. Codes have 128 random bits and context-bound hashes. Management requires current owned sessions and fresh password/factor proof. Support uses a fixed aggregate-only scope, current tenant approval and bounded session-linked authority. This technical review does not confer independent approval.

The review reproduced browser interaction failures before notification observation. Source `34f68661` failed during initial logout, then after completing English replacement/recovery and reloading the recovered account. The parallel ordinary lifecycle producer also failed during logout. Failed receipts received no acceptance credit and guarded synthetic account/tenant cleanup passed.

Targeted diagnostics at `a6485b6f` identified `initial signout control settling`, category `control-settle`: the mobile account page was signed in, its Sign out button was visible, and one valid server session existed. The helper treated a replaced semantics node as a settling failure. It now re-resolves a detached node only before its single click, at most three times. Detachment after field focus fails without entering or retrying proof. Five isolated browser regressions passed, including the two new replacement cases. Diagnostic screenshots are limited to the account success page without setup-key/saved-code semantics and mask all editable fields; raw exceptions and proof screens are never emitted.

## Final browser acceptance passed

[Deployed Flutter lifecycle/support 39774933735](https://github.com/shaikhrais/primecare-platform/actions/runs/39774933735) passed at source `4ada3b87`: English at 320px, French at 768px and Spanish at 1440px, each with 103 successful checks and exact cleanup. This includes enrollment, replay rejection, logout, replacement/recovery, reload, temporary elevation, explicit tenant approval, aggregate-only support and revocation. All selected-v2 storage assertions passed.

[Scoped production evidence recorder 39777265212](https://github.com/shaikhrais/primecare-platform/actions/runs/39777265212) succeeded. Native PostgreSQL/Flutter/release [39773884490](https://github.com/shaikhrais/primecare-platform/actions/runs/39773884490), workflow contracts [39773884435](https://github.com/shaikhrais/primecare-platform/actions/runs/39773884435) and deployed focus diagnostic [39773884620](https://github.com/shaikhrais/primecare-platform/actions/runs/39773884620) passed. Diagnostic runs earn no independent acceptance credit.

## Actual inbox acceptance passed

The existing owned inbox `auth-test@15minutes-email.com` is sufficient; no new addresses were needed. [Security-notice inbox acceptance 39772742647](https://github.com/shaikhrais/primecare-platform/actions/runs/39772742647), runner source `a6485b6f`, passed the real deployed API → native PostgreSQL → scheduled sender → receiving Worker journey. Each locale observed five expected localized notices and five transport acknowledgements: 15 received notices total. All synthetic account/tenant and hash-guarded new-message cleanups passed; prior mail was preserved. Tests refuse any existing account using the QA address.

Only new MIME messages matching the exact sole sender, QA recipient, localized subject and plain-text body count. Complete unchanged batches are cleaned; incomplete/ambiguous batches are preserved. No passwords, seeds, codes, tokens or raw MIME are written to evidence. Five new MIME/cleanup tests and three existing inbox tests passed.

The transport does not persist provider message IDs against outbox IDs. Receipts explicitly identify isolated-inbox batch observation and leave `perEventMessageIdVerified=false`. They do not claim a one-to-one event/message mapping, external mailbox-provider receipt, browser credit or physical-device proof.

## Semantics documentation cross-check

[Flutter web accessibility](https://docs.flutter.dev/ui/accessibility/web-accessibility), checked 2026-10-22, describes `SemanticsBinding.instance.ensureSemantics()` and the accessible HTML DOM generated from widgets. PrimeCare already enables semantics in its shared web runner. Test navigation uses `enable-semantics=true` as the final query parameter. Shared auth navigation and password-recovery navigation preserve the flag; existing auth-design tests cover public routes, validated return URLs and redirects. The deployed Forgot password navigation was also observed retaining the flag. A missing URL flag was not the reproduced failure.

## Separate acceptance gates

Independent architecture/database/security/accessibility/localization reviews and physical-device acceptance remain pending. The previous owner's Android login is not formal device acceptance. V1 key retirement remains subject to retirement/rollback review; both bindings are retained. No independent review flags, account roles or whole-platform readiness credit were changed by this review or its evidence.
