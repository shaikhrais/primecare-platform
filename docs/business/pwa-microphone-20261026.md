# Install PrimeCare and enable microphone access

Source `ef0174699a0086c12482d20d97f7ab7f32cae6bd` is deployed to all nine
portals. [Workflow 40340998282](https://github.com/shaikhrais/primecare-platform/actions/runs/40340998282)
passed all 15 scoped calling/deployment jobs. Native production staff and Code
Admin/MFA sign-in verified the install control, public manifest, active service
worker, microphone control and calling API access. Synthetic records were removed.

## On Android Chrome

1. Reload the existing portal tab. **Install PrimeCare** appears at the top.
2. Tap it and follow Chrome's installation dialog. If Chrome has not offered its
   native prompt yet, the page shows **⋮ → Add to Home screen → Install**.
   Chrome controls eligibility and may require a tap and about 30 seconds on the
   page. An already-installed app may offer Open instead. The control is hidden
   when opened as an installed standalone app.
3. In **Calls**, tap **Enable microphone**, then **Allow** when asked.
   Already-allowed access may simply report **Microphone ready** without another
   prompt. Blocked access shows Chrome site-permission and Android-app settings
   instructions; the website cannot override a previous denial.
4. Enter the country-code phone number and tap **Call phone**. Allow access if
   requested. Keep the app or page open during the call.

Installing opens the portal's login page; sign in normally in the installed
window. Installation does not create an account, change MFA setup, grant phone
calling to clients or enable offline/background calls. Calling still requires a
current permitted staff session and internet access. This does not fix or depend
on the earlier sideload Android APK.

## Implementation

The build supplies each portal's standalone manifest, root scope and login
start URL, theme metadata, 192/512 px PNG icons and a maskable-safe app mark.
Icons are deterministic code-owned assets generated without an extra binary or
image dependency. The shared install control handles `beforeinstallprompt`,
accepted/dismissed results, fallback guidance and installed display state.

The service worker uses fresh, no-store same-origin navigation fetches. On
network failure it shows only a reconnect message. It does not cache app pages,
authenticated data, sessions or API responses and has no Cache Storage, push,
notification or background call implementation. It does not force a reload of
an active call.

`MicrophoneAccess` inherits `CommunicationResourceBase`. Only Enable microphone
or an explicit Call action invokes `getUserMedia({audio:true,video:false})`.
Probe tracks stop immediately, including if the panel closes while permission
is pending. The call SDK separately owns call audio. Denial occurs before any
reservation or provider creation and displays actionable guidance. Existing
native routes, session permissions, one-use tickets and caller identity remain
unchanged.

## Evidence and limits

Twenty unit/gateway/PWA cases and five metadata cases passed, along with strict
TypeScript, native PostgreSQL, Worker runtime and real-Chromium checks. Browser
fixtures use virtual audio hardware and controlled permission outcomes. They
verify no automatic microphone use, stopped probe tracks, no prepare/dial after
denial, current call cleanup and mobile layout. PWA checks parse the manifest in
Chrome, decode both PNG sizes, verify service-worker control, exercise a simulated
install event and verify no private-page replay under forced network failure.
Production browser checks also verify actual deployed assets and native login.

[Exact receipts](../../reports/communications/pwa-microphone-20261026.json) record
source/job IDs and test boundaries. The Android OS install dialog, physical
microphone permission dialog and real carrier audio have not been verified.
Automation places zero real telephone calls.

References:
- https://web.dev/articles/install-criteria
- https://developer.mozilla.org/en-US/docs/Web/API/MediaDevices/getUserMedia
