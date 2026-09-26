# Authentication integration status

## Implemented in this branch
- The gateway sends `/v1/auth/<path>` and `/api/auth/<path>` to the auth service and preserves query strings.
- `POST /login` checks a bcrypt password hash and active user status. It issues a 32-byte random token, stores only its SHA-256 digest in `auth_sessions`, and expires the session after 12 hours.
- `GET /me` requires a valid, unexpired bearer token or session cookie. `POST /logout` removes that session.
- Flutter no longer grants demo access or infers a role from an email. Stored sessions must pass `/me`. The auth app no longer transfers tokens in callback URLs.

## Before running
1. For an isolated local setup, set `PRIMECARE_DB_PASSWORD` in your shell and run `docker compose -f compose.auth.yml up --build -d`. This uses a separate `auth_db` volume, creates a minimal development `users` table, and applies the session migration. For an existing database, apply only `packages/database/migrations/20260926_auth_sessions.sql` to a `users` table with `roles`, `status`, and `password_hash`. The older `infra/migrations/001_initial_schema.sql` uses `role` and is incompatible.
2. Generate a bcrypt hash interactively with `docker compose -f compose.auth.yml run --rm auth_api dart run bin/hash_password.dart`. Then run `docker compose -f compose.auth.yml exec db psql -U primecare -d primecare` and enter `INSERT INTO users (email, roles, password_hash) VALUES ('you@example.com', 'client', '<paste generated hash>');`. Use your own email and password. Existing 64-character SHA-256 seed hashes are deliberately rejected.
3. For local Flutter, use `--dart-define=API_BASE_URL=http://localhost:8700` with a gateway reachable by the device. For deployed web, the default uses same-origin `/v1/auth/*`, so configure a reverse proxy to the gateway before trying to log in.
4. Set `AUTH_SERVICE_URL` to the auth service address when it is not running in the Docker network.

## Remaining blockers
- Root Compose references nonexistent service directories. Use `compose.auth.yml` for this isolated auth flow. The standalone service Dockerfiles now use the repository root as build context, and local Compose explicitly disables database TLS.
- The Flutter client retains bearer tokens in SharedPreferences and the old cross-portal callback path is intentionally disabled. A production browser login should use a same-origin gateway, secure cookie sessions, and a server-side one-time authorization handoff for other portals.
- Other generated routes and gateway mock endpoints are not protected by this session implementation. No clinical or personal data should be exposed through them.
- No Dart or Flutter SDK is available in the current execution workspace, so this branch is untested at runtime and must remain a draft.
