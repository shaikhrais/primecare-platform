$ErrorActionPreference = "Continue"

Write-Host "Preparing to secure execution checkpoint..." -ForegroundColor Cyan

& .\scripts\preflight.ps1
if ($LASTEXITCODE -ne 0) {
    Write-Host "Pre-flight constraints violated. Cannot secure an unstable checkpoint." -ForegroundColor Red
    exit 1
}

$Timestamp = Get-Date -Format "yyyyMMdd-HHmmss"

$Status = git status --porcelain
if ([string]::IsNullOrWhiteSpace($Status)) {
    Write-Host "Working directory is pristine. No new checkpoint required." -ForegroundColor DarkGray
    exit 0
}

Write-Host "Securing checkpoint..." -ForegroundColor Yellow
git add .
git commit -m "[Checkpoint] Safe state secured at $Timestamp" --no-verify

if ($LASTEXITCODE -eq 0) {
    Write-Host "Checkpoint $Timestamp successfully logged to local history. Type 'git reset HEAD~1' to gracefully rollback anytime." -ForegroundColor Green
} else {
    Write-Host "Failed to secure local checkpoint." -ForegroundColor Red
    exit 1
}
exit 0
