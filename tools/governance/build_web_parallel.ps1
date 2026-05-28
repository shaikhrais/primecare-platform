$apps = @(
    "primecare_business_development",
    "primecare_client",
    "primecare_corporate",
    "primecare_franchise",
    "primecare_marketing",
    "primecare_support",
    "primecare_governance"
)

$rootDir = Get-Location
$jobs = @()

foreach ($app in $apps) {
    Write-Host "Starting parallel web build for $app..." -ForegroundColor Cyan
    $job = Start-Job -ScriptBlock {
        param($appName, $root)
        Set-Location -Path "$root\apps\$appName"
        & flutter build web --release --no-tree-shake-icons --dart-define=API_BASE_URL=https://primecare-api.itpro-mohammed.workers.dev/api
        if ($LASTEXITCODE -ne 0) {
            Write-Error "Failed building $appName"
            exit 1
        } else {
            Write-Output "Successfully built $appName!"
        }
    } -ArgumentList $app, $rootDir
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
    Write-Host "All sub-applications built successfully for web in parallel!" -ForegroundColor Green
    exit 0
}
