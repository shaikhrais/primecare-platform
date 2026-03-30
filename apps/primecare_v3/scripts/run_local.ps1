<#
.SYNOPSIS
Starts the PrimeCare V3 local development environment safely.

.DESCRIPTION
Runs the local Flutter interface explicitly bound to the standard localhost Worker API port (8787).
For offline work, make sure npm run dev is alive terminal-side in the apps/worker-api directory.
#>

$ErrorActionPreference = "Stop"

Write-Host "🚀 Spooling up PrimeCare Local UI Workspace..." -ForegroundColor Cyan
Write-Host "Target API Backend: http://127.0.0.1:8787" -ForegroundColor Gray

# Boot flutter specifying the native port parameter for absolute clarity
flutter run -d web-server --web-port 8080 --dart-define=API_URL=http://127.0.0.1:8787
