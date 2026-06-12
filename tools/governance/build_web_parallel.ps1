$apps = @(
    "primecare_auth",
    "primecare_governance",
    "primecare_client",
    "primecare_clinic",
    "primecare_corporate",
    "primecare_franchise",
    "primecare_marketing",
    "primecare_support",
    "primecare_business_development",
    "primecare_enterprise_blueprint"
)

$appUrls = @{
    "primecare_auth" = "https://primecare-auth.pages.dev"
    "primecare_governance" = "https://primecare-governance.pages.dev"
    "primecare_client" = "https://primecare-client.pages.dev"
    "primecare_clinic" = "https://primecare-clinic.pages.dev"
    "primecare_corporate" = "https://primecare-corporate.pages.dev"
    "primecare_marketing" = "https://primecare-marketing.pages.dev"
    "primecare_support" = "https://primecare-support.pages.dev"
    "primecare_franchise" = "https://primecare-franchise.pages.dev"
    "primecare_business_development" = "https://primecare-business-development.pages.dev"
    "primecare_enterprise_blueprint" = "https://primecare-enterprise-blueprint.pages.dev"
}

$ssoUrl = "https://primecare-auth.pages.dev"
$rootDir = Get-Location
$jobs = @()

foreach ($app in $apps) {
    $appUrl = $appUrls[$app]
    Write-Host "Starting parallel web build for $app targeting $appUrl..." -ForegroundColor Cyan
    $job = Start-Job -ScriptBlock {
        param($appName, $root, $appUrl, $ssoUrl)
        Set-Location -Path "$root\apps\$appName"
        & flutter build web --release --no-tree-shake-icons --dart-define=API_BASE_URL=https://primecare-worker-api-gateway.itpro-mohammed.workers.dev/api --dart-define=SSO_PORTAL_URL=$ssoUrl --dart-define=APP_BASE_URL=$appUrl
        if ($LASTEXITCODE -ne 0) {
            Write-Error "Failed building $appName"
            exit 1
        } else {
            Write-Output "Successfully built $appName!"
        }
    } -ArgumentList $app, $rootDir, $appUrl, $ssoUrl
    $jobs += $job
}

Write-Host "Waiting for all parallel web builds to complete..." -ForegroundColor Yellow
Wait-Job -Job $jobs | Out-Null
$results = Receive-Job -Job $jobs
foreach ($res in $results) {
    Write-Host $res
}

$failed = $jobs | Where-Object { $_.State -eq 'Failed' }
if ($failed) {
    Write-Host "Some parallel web builds failed." -ForegroundColor Red
    exit 1
} else {
    Write-Host "All 10 sub-applications built successfully for web in parallel!" -ForegroundColor Green
    exit 0
}
