# PrimeCare Calls — Android test APK

Installable foreground calling launcher, Android 8.0 or newer. Requires current
Google Chrome. It opens the existing HTTPS clinic portal in a Chrome Custom Tab.
The shared deployed TypeScript calling UI and server authorization are unchanged.
This is a browser-powered calling launcher, not a native Twilio Android SDK app.

## Install and call

1. Download and open `PrimeCare-Calls-test.apk` on Android. Allow installation
   from the app used to open the download when Android asks.
2. Open **PrimeCare Calls · Test**, then **Open calling portal**.
3. Sign in with a permitted staff account. Open **Calls → Call a client’s phone**.
4. Enter the full country-code number, tap **Call phone**, and allow microphone
   access for the portal in Chrome. Allow Chrome microphone access in Android
   settings too if it was disabled.
5. Keep the portal visible while calling. Use **Mute** and **End phone call**.

Calling uses internet data and the configured Twilio caller ID; it does not use
the phone’s SIM dialer. No call starts automatically. The APK has no microphone,
phone, contact, storage or notification permissions; Chrome owns the web session
and requests the microphone permission for the website.

Background/screen-locked calling, Android Telecom integration and incoming-call
push notifications are not provided. A real Android handset and two-way PSTN
audio must still be tested. The existing browser automation is not a handset test.

## Build and trust

The `Build PrimeCare calling test APK` GitHub workflow builds and lints with
Java 17, Gradle 8.9, Android Gradle Plugin 8.7.3 and SDK 35, then verifies APK
signature, package and absence of launcher permissions. AndroidX Browser 1.8.0
is pinned for this minimal host. `SOURCE.txt` and `SHA256SUMS` identify the source
and exact APK. The APK is signed with the CI's disposable Android **debug** key.
It is for sideload testing, not Play Store distribution. A future CI build may
need the old test app uninstalled first because its signing key can differ;
the web account and server records are unaffected. Do not use this identity as
a production Android release certificate.

Build locally with the Android SDK installed: `gradle :app:assembleDebug :app:lintDebug`.
Do not embed provider secrets, session tokens or arbitrary URL/deep-link handlers.
`MainActivity` inherits shared `BrowserPortalActivity`; only the fixed HTTPS
portal is allowed. No WebView/JavaScript bridge or separate phone-call policy.

References:
- https://developer.chrome.com/docs/android/custom-tabs
- https://developer.android.com/build/releases/agp-8-7-0-release-notes
- https://developer.android.com/jetpack/androidx/releases/browser
- https://www.twilio.com/docs/voice/sdks/javascript
