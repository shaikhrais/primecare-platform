$ErrorActionPreference = "Continue"

param (
    [string]$Target = "dev:api"
)

Write-Host "Initiating Safe Run Protocol for Target: $Target" -ForegroundColor Cyan

& .\scripts\checkpoint.ps1
if ($LASTEXITCODE -ne 0) {
    Write-Host "Checkpoint protocol aborted. Run halted to protect state." -ForegroundColor Red
    exit 1
}

Write-Host "Booting $Target Environment..." -ForegroundColor Green
npm run $Target
