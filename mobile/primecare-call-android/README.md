# PrimeCare Calls — native Android test APK

Native Android UI, in-app sign-in/MFA and Twilio Voice Android SDK 6.10.5.
**No Chrome, browser, Custom Tab or WebView is required or launched.**
The earlier browser-powered test APK is superseded by this native build.

## Install and call

1. Install `PrimeCare-Calls-native-test.apk` on Android 8.0 or newer. Android may
   ask you to allow installation from the app used to open the download.
   Uninstall the earlier **PrimeCare Calls · Test** first if the debug signing
   certificate conflicts. This does not delete any server account or records.
2. Open **PrimeCare Calls Native · Test**. Sign in using your existing permitted
   staff email and password. Complete the in-app authenticator step if required;
   initial MFA enrollment displays the server-issued setup key inside the app.
3. Enter the full country-code phone number and tap **Call phone**. Allow the
   microphone and, when asked, call notifications. Tap **Call phone** again.
4. Use **Mute**, **Speaker** and **End call**. A foreground microphone service
   holds the active call when the screen is left; use the notification to return
   or end it. Permission denial, force-stop, battery policies or Android process
   termination can interrupt a call. A physical handset must verify this behavior.
5. **Sign out** stops local audio and requests server session revocation.
   Failed cleanup retains a retryable reservation; tap **End call** again.

Calls use internet data and the configured business caller ID, not the SIM
number. No call is automatic. No incoming-call push, Bluetooth route control,
internal-extension media, recording or Android Telecom integration is included.
This first native build covers staff-to-client outgoing telephone calls.

## Scope and lifecycle

`MainActivity` inherits `NativeCallActivityBase`; `NativeSessionClient` inherits
`BoundedJsonClient`. Shared `NativeCallController` owns session and call lifecycle;
`TwilioNativeVoice` implements the injectable `VoicePort`. The UI does not decide
role access. The app uses the existing registered auth/me/MFA/logout and external
prepare/state/end APIs. The server still verifies current tenant/staff/session,
permissions, one-use ticket, live provider identity and server-owned caller ID.
No API, governance contract, incoming routing or server deployment is changed.

The session token, password and MFA state are never persisted to disk. Sensitive
fields disable state/autofill saving; Android screenshots are blocked. Reopen
sign-in after process termination. HTTPS uses system trust, a fixed origin/path
allowlist, no redirects, bounded JSON and timeouts. No provider secret is embedded.
Tokens are used once to initiate a native call; only `Ticket` is forwarded as
SDK parameters. Current native calling permission is polled while media is
active; failure releases local audio. This is not a guarantee of instant
carrier-side revocation against a modified client. The server still limits calls
to one hour. The call service never restarts or redials automatically.

## Build and evidence

Java 17, Gradle 8.9, AGP 8.7.3, SDK 35. Run
`gradle :app:testDebugUnitTest :app:assembleDebug :app:lintDebug`.
CI tests replace the transport/media ports and place **zero real phone calls**.
They cover native auth/MFA, denied grants, microphone denial, foreground-service
ordering, ticket scope, mute/speaker/end, revocation, preparation cancellation,
cleanup retries, service-generation races and launch without a browser.
The workflow verifies the signature, package, native arm64 Twilio library,
required microphone permission and absence of the AndroidX browser dependency.
`SOURCE.txt`/`SHA256SUMS` identify exact download bytes.

This sideload test APK uses a disposable CI debug certificate, not a production
release key. A later test build can require uninstalling the old app. Build,
lint and simulated media tests do not prove real Android/PSTN two-way audio,
locked-screen behavior, Bluetooth support or concurrent-call capacity.

References:
- https://www.twilio.com/docs/voice/sdks/android
- https://www.twilio.com/docs/voice/sdks/mobile-best-practices
- https://media.twiliocdn.com/sdk/android/voice/latest/docs/com/twilio/voice/Call.Listener.html
- https://developer.android.com/develop/background-work/services/fgs/service-types
