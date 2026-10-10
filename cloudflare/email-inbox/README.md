# Private Cloudflare mailbox

The `primecare-email-inbox` Email Worker stores received MIME messages and envelope metadata in the private `primecare-email-inbox` KV namespace. It has no public HTTP endpoint. Read messages through the authenticated Cloudflare dashboard or KV API. Bodies, reset codes, and credentials must not be written to Actions logs or public artifacts.

| Address | Retention |
| --- | --- |
| temp@15minutes-email.com | Seven days |
| auth-test@15minutes-email.com | Permanent, until manually deleted |

Only these exact recipients are accepted. Maximum message size is 2 MiB. Raw MIME is preserved as base64, including attachments, alongside subject, sender, recipient, Message-ID, and receipt timestamp. Each delivery gets its own unique key. Storage errors propagate rather than accepting and losing mail.

## Deployment

The dedicated `.github/workflows/setup-email-inbox.yml` workflow tests the Worker, creates or reuses the KV namespace, and deploys it without a workers.dev or preview URL. Existing auth/email sending configuration is untouched.

## Routing prerequisite

On 2026-10-10 the production token could read the owned active zone, email sending setup, Worker settings, and KV, but Cloudflare returned HTTP 403 for DNS, Email Routing settings, and Email Routing rules. Deployment of storage alone does not create functioning email addresses.

The token needs Zone / Email Routing Rules / Edit and Zone / Email Routing Settings / Read for `15minutes-email.com` (plus existing Zone Read). If receiving is disabled, enabling it also requires Email Routing Settings Edit and DNS Edit; inspect DNS first to avoid replacing existing mail providers.

After receiving is enabled, run `node cloudflare/email-inbox/connect-routing.mjs` with the Cloudflare token/account environment variables. It creates two exact recipient rules pointing at this Worker, checks account ownership and all conflicts first, preserves catch-all and existing rules, and never changes DNS.

Then send a synthetic message to each address and inspect KV receipt before claiming delivery works. Password recovery and the eight application templates still require live receipt verification; successful provider acceptance alone is insufficient.

## Live verification: 2026-10-10

Updated production credentials connected both exact recipient rules successfully. Run 38073498464 sent all eight synthetic template messages using native Cloudflare sending and verified each receipt in private KV, including seven-day expiry for temp and no expiry for auth-test. This verifies sending, receiving, storage, and retention; application-triggered recovery/reset remains a separate test.
