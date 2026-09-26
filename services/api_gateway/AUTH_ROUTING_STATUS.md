# Authentication integration status

## Implemented in this branch
- The gateway sends `/v1/auth/<path>` and `/api/auth/<path>` to the auth service and preserves query strings.
- `POST /login` checks a bcrypt password hash and active user status. It issues a 32-byte random token, stores only its SHA-256 digest in `auth_sessions`, and expires the session after 12 hours.
- `GET /me` requires a valid, unexpired bearer token or session cookie. `POST /logout` removes that session.
- Flutter no longer grants demo access or infers a role from an email. Stored sessions must pass `/me`. The auth app no longer transfers tokens in callback URLs.

## Before running
1. Apply `packages/database/migrations/20260926_auth_sessions.sql` to a database whose `users` table follows the Prisma schema with `roles`, `status`, and `password_hash`. The older `infra/migrations/001_initial_schema.sql` instead uses a `role` column and is incompatible.
2. Provision a user with a unique bcrypt `password_hash` using `BCrypt.hashpw(password, BCrypt.gensalt())`. Existing seed hashes with 64 hexadecimal characters are SHA-256 and are deliberately rejected; reset those passwords. Never reuse the example seed password.
3. Set the Flutter `API_BASE_URL` to the reachable gateway origin and route `/v1/auth/*` to that gateway. The deployed web configuration currently defaults to `/api`, which yields `/api/v1/auth/*` and does not match the gateway route.
4. Set `AUTH_SERVICE_URL` to the auth service address when it is not running in the Docker network.

## Remaining blockers
- Root Compose references nonexistent service directories. The individual Dockerfiles cannot build workspace packages using their current contexts. The database client requires TLS even for the local plaintext Postgres Compose service.
- The Flutter client retains bearer tokens in SharedPreferences and the old cross-portal callback path is intentionally disabled. A production browser login should use a same-origin gateway, secure cookie sessions, and a server-side one-time authorization handoff for other portals.
- Other generated routes and gateway mock endpoints are not protected by this session implementation. No clinical or personal data should be exposed through them.
- No Dart or Flutter SDK is available in the current execution workspace, so this branch is untested at runtime and must remain a draft.
