# Gateway auth routing status

The gateway exposes `/api/auth/<path>` and `/v1/auth/<path>` through the existing auth service. For example, a request to `/v1/auth/health` is forwarded to `AUTH_SERVICE_URL/health`. The gateway preserves query parameters, request bodies, response status, and response headers.

The default upstream hostname is `auth_api:8080` for the Docker service network. Set `AUTH_SERVICE_URL=http://localhost:8080` when running the auth service directly on the host; the hostname `auth_api` will not resolve outside Docker.

This change does **not** make login safe to use. `services/auth_api/bin/server.dart` currently accepts an email without checking a password and uses the user ID as a session token. The Flutter auth app also puts a token into a redirect URL. Do not enter real credentials or patient information until those flows are replaced and verified.

The root `docker-compose.yml` references several directories that do not exist, and the service Dockerfiles use build contexts that cannot resolve the monorepo's relative package dependencies. The full stack cannot be started through that Compose file yet.

Suggested next implementation: choose a single Flutter login screen, define a real password verification and session flow in the auth service, then connect that screen to `/v1/auth/login` through the gateway. Remove URL tokens and mock responses before deploying.
