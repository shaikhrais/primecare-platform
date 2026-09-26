# PrimeCare production deployment

The canonical production workflow is `.github/workflows/production-deploy.yml`.

## Release order

1. Verify required credentials.
2. Analyze and test the Auth API and API gateway against PostgreSQL 15.
3. Build both production containers.
4. Apply append-only database migrations.
5. Publish commit-addressed containers to Artifact Registry.
6. Deploy the Auth API, then the API gateway, to Cloud Run.
7. Require gateway and routed-auth health checks.
8. Build all Flutter websites with the deployed gateway URL.
9. Deploy the websites to Cloudflare Pages.

`primecare_ui` and `flutter_core` are source dependencies. They are compiled into every Flutter application and are never deployed independently.

## Required GitHub Actions secrets

- `GCP_PROJECT_ID`
- `GCP_WORKLOAD_IDENTITY_PROVIDER`
- `GCP_SERVICE_ACCOUNT`
- `PRODUCTION_DATABASE_URL`
- `CLOUDFLARE_API_TOKEN`
- `CLOUDFLARE_ACCOUNT_ID`

Use GitHub's `production` environment for approval rules and secret scoping when available.

The Google deployment identity needs permission to manage Cloud Run, Artifact Registry, and Secret Manager. The Cloudflare token needs Pages edit access for the configured account.

## Database requirements

The production PostgreSQL database must already contain the compatible PrimeCare `users` table with `id`, `email`, `roles`, `password_hash`, and `status`. The workflow adds the `auth_sessions` table idempotently. It never drops, wipes, or seeds production data.

`PRODUCTION_DATABASE_URL` must be reachable from both GitHub-hosted runners (for migrations) and Cloud Run (for application traffic), and it must use TLS.

## Release and rollback

Every backend image is tagged with the Git commit SHA. Cloud Run retains revisions, so rollback is performed by shifting traffic to the prior healthy revision. Cloudflare Pages also retains previous deployments.

A release stops before website deployment if migration, backend deployment, gateway database health, or routed Auth API health fails.

## Current setup blocker

The Cloudflare API currently rejects the stored credentials with error 9106. Replace `CLOUDFLARE_API_TOKEN` and verify `CLOUDFLARE_ACCOUNT_ID` before triggering production.
