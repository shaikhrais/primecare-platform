<#
.SYNOPSIS
Deploys the PrimeCare V3 Flutter Web frontend to Cloudflare Pages.

.DESCRIPTION
This script automatically compiles the Dart application, injecting the precise production
Worker API URL at compile-time to prevent local routing issues on the live site.
It then triggers the wrangler deployment via npx.
#>

$ErrorActionPreference = "Stop"

$PROD_API_URL = "https://primecare-api.primecare-platform.workers.dev"

Write-Host "🚀 Compiling PrimeCare V3 for Production..." -ForegroundColor Cyan
Write-Host "Injection Target: $PROD_API_URL" -ForegroundColor Gray

# Compile Flutter forcing the Dart Environment Variable
flutter build web --dart-define=API_URL=$PROD_API_URL

Write-Host "✅ Compilation Complete. Pushing to Cloudflare Pages..." -ForegroundColor Green

# Deploy to Wrangler
npx wrangler pages deploy build/web --project-name=primecare-v3

Write-Host "✅ Deployment Pipeline Complete!" -ForegroundColor Green
