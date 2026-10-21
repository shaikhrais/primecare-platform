# Saved auth checkpoint — 2026-10-21

User requested: save everything first, then rebuild and deploy all changes; resume authenticator setup later.

All implementation changes were already committed on main at a787300aecc8fac1a93db21446eb176bd2c6c848. No new branch is required. The web MFA implementation, production schema, dedicated server secret, owner bootstrap and verification evidence are preserved in GitHub and the pinned production database.

Completed evidence: release39625187820 deployed the auth Worker and all nine web portals and passed live English/French/Spanish browser→gateway→PostgreSQL enrollment, code rejection, replay denial, reload/logout and exact synthetic cleanup. Security checks passed 88 tests, seven native MFA scenarios each for text and UUID identities, and the browser journeys. Evidence39626585014 records scoped tested status without independent review or whole-platform acceptance credit.

Resume point: the real owner reported that the authenticator code did not match. Do not assume personal enrollment succeeded. Last confirmed diagnostic39626666887 showed pendingEnrollment=true, activated=false, mfaEnabled=false and zero active sessions; this is historical, not a fresh status check. Use the read-only approved-owner enrollment diagnostic before resuming. Each fresh sign-in replaces an unconfirmed setup key. Investigate the current account state, matching key, challenge expiry and device clock if needed. Never reproduce keys or codes from screenshots or chat, and never bypass MFA.

Personal enrollment is paused. Preserve existing accounts, enrollment state, credentials, server encryption key and production data. Rebuild/deploy the committed current Cloudflare runtime (12 service Workers, gateway and nine TypeScript web portals). Do not overwrite these portals with legacy Flutter builds.

Remaining broader acceptance: native Flutter MFA, physical-device acceptance and independent reviews. Whole-platform auth sign-off remains false. No credentials, setup keys, one-time codes or secret values are stored in this checkpoint.
