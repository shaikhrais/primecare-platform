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

- Cloudflare sender email: `noreply@15minutes-email.com` for this deployment.
- Subject, title and plain-text body for eight shared templates. Required
  placeholders are validated; HTML is escaped by the shared renderer.
- Runtime binding status, pending work and the latest twenty maintenance actions.
- A test message to the signed-in IT account; arbitrary recipients are rejected.
  Cloudflare acceptance is reported separately from inbox delivery.

Native delivery uses the auth Worker's `EMAIL` binding. No Resend account, API
key or external email provider is used. Saved legacy encrypted provider credentials
are preserved for rollback but are never read or decrypted for native sending.
Sender and template changes take effect immediately without rebuilding the app.
The backend enforces live session, organization and role checks on every operation.

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

## Pending go-live tasks

1. In Cloudflare: Compute > Email Service > Email Sending > Onboard Domain,
   choose `15minutes-email.com`, and complete the domain checks. Cloudflare adds
   the required SPF, DKIM and bounce DNS records. Existing mail records should
   be reviewed before changing them.
2. General recipient delivery requires Workers Paid. Verified destination
   addresses can receive free test emails. Never upgrade billing automatically.
3. Run **Deploy native Cloudflare email and recovery** on the tested main release.
   The generated auth config sets the `EMAIL` send binding, restricts it to
   `noreply@15minutes-email.com`, and supplies the sender as a non-secret variable.
   Deployment does not by itself verify the sending domain or inbox delivery.
4. Send a maintenance test email and check inbox/spam.
5. Test Forgot Password: receive code, reset, reject the old password, sign in
   with the new password, and reject a replayed code.
6. Connect remaining welcome/invitation/appointment/payment events to the shared
   renderer. Only password recovery and the maintenance test are integrated.

No public arbitrary-recipient email endpoint is exposed. Password recovery keeps
its existing account and rate-limit checks. Failed sends delete the unused reset
hash. Native sending does not retry ambiguous responses or claim provider-level
idempotency; the adapter returns Cloudflare's message ID only after acceptance.

Official documentation:
- https://developers.cloudflare.com/email-service/get-started/send-emails/
- https://developers.cloudflare.com/email-service/api/send-emails/workers-api/
- https://developers.cloudflare.com/email-service/platform/pricing/
