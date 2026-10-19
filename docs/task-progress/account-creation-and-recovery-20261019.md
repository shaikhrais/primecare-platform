# Account creation and password recovery — 2026-10-19

Production PostgreSQL governance remains the only live tracking authority. This checkpoint covers two business processes, not new screen/action/API duties.

| Workflow ID | Issue found | Fix | Test result | Verification status | Evidence | Published execution source |
| --- | --- | --- | --- | --- | --- | --- |
| auth.create-tenant-account | General CEO/HR target-role creation UI absent; policy/spec/API metadata conflicts | Recorded exact dependencies; preserved existing grants and narrower maintenance flow | 2 real-credential/native API cases and 6 security groups passed; no general UI/browser execution possible | missing; test_status scoped_pass; attempt 325 | [Native receipt and replay](https://github.com/shaikhrais/primecare-platform/actions/runs/39337979328/artifacts/12228195607) | 353efbc29acdd9001ba2a0fcfc7d5a44e83eeb4e |
| auth.forgot-password | Deployed inbox delivery and formal API metadata/review acceptance remain unproven | Corrected isolated fixture preparation and an unsupported header assertion; application unchanged | 3 actual-main EN/FR/ES browser cases and 8 API/security groups passed | implemented-unverified; test_status scoped_pass, bound through protected recorder | [Receipt, videos and replay](https://github.com/shaikhrais/primecare-platform/actions/runs/39339396205/artifacts/12227837634) | 3c6da2798bd931de452c2c2fbdb16c114fa85a2e |

## Account creation

The live definition permits CEO and HR Director. Platform Admin remains the primary denied actor for this particular API; no accounts were elevated and no grants were added.

The 109 creation-policy rows (CEO 71, HR Director 38), all same_tenant, exactly match the current generated server policy. POST /v1/auth/register is API1. Its request enum omits growth_caller, growth_coordinator, growth_google, growth_meta, growth_offline, growth_seo and maintenance; response_schema is null. Legacy api_permissions rows use an unrelated RMT-list key. The virtual_draft definition has no resolved policy composite-key source links.

API1 has no screen_api_links. Inspected CEO/HR screens 705/903/935/39/314 contain generic/placeholder controls rather than an approved email/password/actor-specific role creation component. Both current maintenance forms hardcode maintenance; Platform Administration uses a separate tenant API/authority. Register the exact controls, resource/test-ID bindings and supported metadata writer before implementing the missing general UI.

Native execution demonstrated CEO/HR approved account creation, one same-tenant active user, safe response, bcrypt hash, one matching creation audit, new-account credential login and authoritative API reread. Platform Admin/PSW denial, HR escalation denial, tenant-header/field injection, invalid password, missing/expired sessions, normalized duplicate retry, suppressed-audit rollback/retry and concurrent duplicate submissions all passed. These are API proofs; the required UI remains absent.

## Password recovery

Actual main entry → real Platform Admin credential login → logout → registered recovery UI → gateway → inherited service dispatcher → native PostgreSQL → reload was exercised in EN/FR/ES at 320/1440/768 widths. Existing localized copy and stable data-cy selectors were used.

Demonstrated:
- Invalid browser email input prevents submission; offline errors are retryable.
- Missing native email binding and rejected provider acceptance produce localized unavailable states.
- A successful retry returns only the generic message; its code is confined to the isolated email fixture. The database stores SHA-256(email:code), owner ID and approximately 15-minute expiry.
- Passwords/accounts/sessions remain unchanged by recovery; revoked login credentials remain denied; page reload does not resend.
- Unknown, inactive and ambiguous case-insensitive emails return the same generic response without reset tokens or mail.
- Invalid email and user/tenant field injection are rejected without domain changes.
- Invalid provider acknowledgement deletes only the new unsent code, preserving earlier codes.
- A suppressed native reset insert rolls back and sends no email.
- The current three-request/900-second budget denies the fourth request. Concurrent accepted requests store distinct hashes, and competing requests near the limit admit only the remaining one-request budget.
- Forged user/tenant headers cannot redirect a foreign account's recovery code to the requester or expose it in HTTP.

The protected recorder compares the current production auth_recovery_web_policy/recovery-web-v1 with the producer-bound generated policy before saving a scoped pass. That table registers the shared public web presentation separately from native screen947 metadata.

Remaining exact dependencies: actual Cloudflare EMAIL binding/approved tenant sender/mailbox delivery; API395 auth_required=1 versus existing public recovery behavior; null request/response schemas, permission/rate-limit keys and legacy PRISMA service ownership; formal retry timing (observed 429 has no Retry-After, which the registry does not require); current specification/source/evidence binding, governed playback, full accessibility/PWA/performance and independent reviews. No verified promotion is justified.

## Diagnostic history and validation

Three unsuccessful diagnostic producers remain available:
- [39338559825](https://github.com/shaikhrais/primecare-platform/actions/runs/39338559825): missing existing tenant-mail migration in the synthetic schema.
- [39338859913](https://github.com/shaikhrais/primecare-platform/actions/runs/39338859913): three browser cases/four groups passed before isolated trigger dollar quoting failed.
- [39339102871](https://github.com/shaikhrais/primecare-platform/actions/runs/39339102871): three browser cases/five groups passed; an unsupported Retry-After assertion failed despite the correct 429.

The corrected producer passed. The protected recorder preserves the earlier receipts as blocked fixture/contract diagnostics, followed by the successful scoped attempt; they are not classified as confirmed application defects. No failing check was forced or bypassed.

## Inventory and handoff

Last production attempt totals: 147 = 11 missing + 131 implemented-unverified + 0 verified + 5 blocked. DONE=0, PENDING=147. The final production checkpoint recalculates both verification and separate test-status counts. Supporting catalogue entries overlap and are not additional business processes.

No application code, role grants or real production business data changed. Both random native schemas were dropped, and all recovery emails were captured by a synthetic binding. No deployment or feature PR was needed. No work branch was created.

This documentation commit removes create-account-inspection.yml, record-account-creation.yml, forgot-password-recovery.yml and record-auth-recovery.yml. The already-started protected recorder verifies removal, exact latest-main source hashes, successful main checks, one remote branch/main and zero open PRs before saving checkpoints for both attempted workflows and recovery-handoff-current. Its AUTH_RECOVERY_HANDOFF_COMMITTED marker provides final SHAs, actual attempt IDs, evidence, counts, cleanup/review state and the next live business process.

Next candidate: auth.inspect-account. Read the production checkpoint and fresh repository state before proceeding; do not repeat these attempts unless their source, specification or evidence becomes stale.
