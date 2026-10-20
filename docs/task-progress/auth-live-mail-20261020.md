# Live auth mail verification — 2026-10-20

The existing mail domain and deployed receiving Worker remain functional after PR218.

- Standalone provider send and exact owned inbox receipt passed: https://github.com/shaikhrais/primecare-platform/actions/runs/39431893721
- Deployed recovery passed: https://github.com/shaikhrais/primecare-platform/actions/runs/39432630862

The recovery producer used a temporary tenant/RMT account at the configured synthetic inbox. It proved credential login, generic recovery acknowledgement without code disclosure, actual code receipt and SHA-256 match to the database, successful reset, old-session revocation, old-password denial, new-password login, consumed-code replay denial, identity reread, logout, post-logout denial and removal of remaining reset codes. Exact synthetic account/tenant records were removed, and only the hash-matched received test message was deleted.

Two earlier producer failures are preserved. Python requests initially received a non-JSON edge rejection without the registered browser origin. The second producer failed to decode the receiver's rawBase64 MIME payload. Adding the registered origin and decoding the stored MIME fixed the producer. No application mail or recovery source was changed; these failures do not establish a merge regression.

Sender code: cloudflare/workers/src/email.ts. Recovery code: cloudflare/workers/src/password-recovery.ts. The deployed receiver is primecare-email-inbox; its stored record fields include from, to, subject, messageId, receivedAt, size and rawBase64.

These are real deployed API/email proofs. Full auth acceptance remains incomplete: registered account/session UI controls, recovery-policy cutover, core API metadata reconciliation, remaining UI/actor/platform acceptance and independent review gates remain outstanding. Do not mark all 23 auth business processes verified from this producer.

The user requests main-only work. AGENTS.md now requires direct main changes and preserves expected-head checks. PR219 is the final transition branch and must be merged and deleted after checks pass.
