# PrimeCare email library — IT maintenance

The shared catalog is `cloudflare/workers/src/email-templates.json`. All callers use
`sendEmail` from `email.ts`; the API key is never placed in a Flutter build.
The catalog includes password reset, welcome, invitation, appointment confirmation,
reminder, cancellation, receipt and security notice. Only password reset is wired
to a live event in this change; other callers must invoke the adapter explicitly.

IT edits subject/title/body/required fields, opens a PR, runs recovery tests and
deploys the auth Worker. Templates are plain text with `{{variable}}` placeholders;
the renderer creates escaped HTML and a plain-text alternative. Do not include
patient diagnoses, treatment details, passwords or payment-card information.

## Delivery setup

Verify your sending domain in Resend. Add GitHub Actions repository secrets
`RESEND_API_KEY` (send permission only) and `EMAIL_FROM` (a verified sender, e.g.
`PrimeCare <no-reply@your-verified-domain>`). Never paste the key into chat or commit it.
Run **Deploy password recovery** on main. The workflow validates both inputs,
applies only the additive recovery migration and deploys the auth Worker. Existing
authentication remains unchanged if configuration validation fails.

## API and app

`POST /v1/auth/forgot-password` takes `{"email":"user@example.com"}`.
200 gives a generic acknowledgment for eligible/absent accounts; 400 invalid input;
429 rate limit; 503 delivery or service unavailable. Provider acceptance does not
prove inbox delivery; inspect delivery/bounce events in Resend.

`POST /v1/auth/reset-password` takes email, 12-character code and newPassword.
The code expires in 15 minutes; only its email-bound SHA-256 hash is stored.
Successful reset consumes all codes and revokes all sessions. Invalid, expired or
used codes cannot update the password. Password minimum: 12 characters; maximum:
72 UTF-8 bytes. Recovery codes must never appear in logs or API responses.

Native builds use the HTTPS gateway and Android Internet permission. Users copy the
emailed code into **I have a reset code**, choose a new password and sign in again.

## Verify before rollout

Run `node --test scripts/test-auth-recovery.mjs` and Worker type checks.
Use a controlled test account to request a code, confirm actual delivery, reset,
verify old-password rejection/new-password success, and verify replay rejection.
Do not reset another person's account. Delete expired recovery rows during routine
database maintenance: `DELETE FROM auth_password_resets WHERE expires_at<=NOW();`.
