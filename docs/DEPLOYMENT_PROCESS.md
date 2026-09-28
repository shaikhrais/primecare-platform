# PrimeCare production deployment process

This is the required production order. Do not deploy websites against an unverified gateway.

## 1. TypeScript APIs

1. Type-check `cloudflare/workers/src/service.ts`.
2. Generate one Wrangler configuration per API.
3. Deploy the 12 independent Workers.
4. Attach `DB_URL` as an encrypted Worker secret.
5. Verify every public `/health` endpoint.

## 2. TypeScript API gateway

1. Type-check `cloudflare/workers/src/gateway.ts`.
2. Deploy the gateway with internal service bindings to all 12 APIs.
3. Wait for Cloudflare edge propagation.
4. Verify `/health` and every `/v1/{service}/health` route.
5. Record the verified gateway URL.

## 3. TypeScript websites

1. Export approved applications, roles, screens, sections, elements, localization and theme tokens from `.agents/governance/governance.db`.
2. Compile the shared TypeScript runtime.
3. Produce 10 independent static website directories.
4. Inject only the verified gateway URL into each manifest.
5. Deploy each directory to its matching Cloudflare Pages project.
6. Verify the production HTML, manifest, JavaScript and API connection for all 10 sites.

## Required GitHub secrets

- `CLOUDFLARE_ACCOUNT_ID`
- `CLOUDFLARE_API_TOKEN` with Edit Cloudflare Workers and Cloudflare Pages edit access
- `PRODUCTION_DATABASE_URL`

## Production gateway

`https://primecare-api-gateway.itpro-mohammed.workers.dev`

## Recovery

Worker and Pages deployments are versioned by Cloudflare. If website verification fails, the workflow stops without changing the already verified API and gateway order. Correct the website build or token permission, then rerun the website workflow.
