# Auth and Admin shared layout and language verification

Auth retains `AuthScreen → BaseAuthScreen` for its stateful credential/form host and `AuthController → BaseAuthWorkflow` for transport-independent business behavior. Its presentation now uses `_AuthLayout → BasePrimecareScreen → BasePrimecareLayout`, sharing the same window classification, spacing, language header and typography as Admin. Resizing and language changes preserve the Auth host and its text controllers.

The shared layout policy owns Auth form sizing: at most 440 logical pixels normally and 560 at ultra-wide widths (2560+). Mobile uses 12-pixel page padding, tablet 20, desktop 24 and wide/ultra-wide 32. Short windows and keyboard insets scroll vertically; ultra-wide text increases by 20% while accessibility scaling remains enabled. Physical inches do not identify app window size: a 75-inch 4K display follows its logical viewport after OS scaling and browser zoom.

All Auth text continues to come from the existing EN/ES/FR catalog. Form validation can wrap errors onto three lines. Language selection uses the same central controller as Admin. Server messages do not replace localized recovery/reset/change confirmations. No new endpoint or permission is added.

| Auth task | Shared workflow behavior |
| --- | --- |
| Sign in | Validate and normalize email; validate the returned session and token. |
| Recovery | Request recovery instructions; render the localized non-disclosing confirmation. |
| Reset password | Validate email, reset code and new password; require a fresh sign-in after success. |
| Check session | Read the authorized account; clear local session state after a server 401. |
| Change password | Require an authenticated session and valid current/new credentials; require sign-in again after success. |
| Sign out | Revoke the session; keep credentials available for retry if revocation fails. |
| Language selection | Update EN/ES/FR labels without submitting credentials or resetting drafts. |
| Admin entry | Show the inherited workspace entry for an Admin session; the server still enforces authorization. |

Verification adds 18 Auth UI tests: 15 complete controlled-transport workflows across five viewport sizes and EN/ES/FR, plus three double-size-text/keyboard-inset tests using actual language menus and phone/landscape/4K resizing. These are shared UI integration tests, not new live production or native-platform certification. CI results are pending. Existing Admin responsive and browser checks run in the same gate.
