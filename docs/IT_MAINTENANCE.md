# IT maintenance workspace

Open `/maintenance/configuration` inside any PrimeCare app after signing in.
The CEO also has an **IT maintenance** entry in the account menu and on `/success`.
The `maintenance` role lands directly on this page.

The CEO creates named IT maintenance accounts from this page using email and a
strong initial password. No shared maintenance password is created. For an
existing user, the existing CEO account-management API can assign `maintenance`
within the CEO's organization; it revokes sessions so the user must sign in again.
HR cannot create this role. CTO/admin roles are not implicitly granted access.
A maintenance account cannot assign roles or access clinical data through this API.

## Values managed on this page

- Verified sender email (a sending domain verified in Resend).
- Sending-only Resend API key: write-only, AES-GCM encrypted on the server, bound
  to the organization. Blank input preserves the current key. Keys are never
  returned in configuration responses or stored in the app's preferences.
- Subject, title and plain-text body for all eight shared email templates.
  Required placeholders are validated and HTML is escaped by the shared renderer.
- Runtime setup status, pending work and the latest twenty maintenance actions.
- A test message to the signed-in IT member's account; arbitrary recipients are
  rejected. Provider acceptance is reported separately from inbox delivery.

Changes are saved per organization and consumed by password recovery immediately;
no APK rebuild is needed for sender/key/template changes. Version checks reject
stale edits. The backend checks the current live session, role, organization and
active status on every read/write. Only explicit bearer tokens are accepted.

## Deployment administrator responsibilities

Run **Deploy recovery and IT maintenance** on the tested main release. It applies
additive configuration tables and provisions `CONFIG_ENCRYPTION_KEY` only if the
Worker has no such secret. It never overwrites an existing encryption key.
Back up the key securely through authorized infrastructure administration.
Rotating it requires re-encrypting stored credentials before switching keys.
`PRODUCTION_DATABASE_URL`/`DB_URL`, Cloudflare credentials and the encryption key
remain server/deployment secrets. The app shows their purpose and instructions,
never their values. Changing the Android gateway URL requires a workflow change
and rebuilt APK. These privileged infrastructure values are not editable by a
maintenance user.

## Pending go-live tasks shown in the app

1. IT verifies its domain with Resend, gets a sending-only provider key and saves
   sender/key in the maintenance page.
2. IT sends the test message and checks inbox/spam. Saving configuration alone
   does not mark delivery verified.
3. IT tests the complete Forgot Password flow on Android: receive code, reset,
   reject old password, sign in with new password, reject replay.
4. Developers wire welcome/invitation/appointment/payment events to the shared
   mail adapter. Only password recovery is currently integrated.
5. Review access periodically; CEO deactivates departing IT accounts through
   account management. Audit rows contain action/actor/time, never credentials.

The original Worker-level RESEND_API_KEY and EMAIL_FROM remain a fallback for
organizations without saved settings. Organizations with a saved sender use
their own encrypted key, or the existing server key if no organization key was
saved. Maintenance UI does not prove provider domain verification or inbox delivery.
