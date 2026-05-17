$apps = @(
    "primecare_clinic",
    "primecare_corporate",
    "primecare_franchise",
    "primecare_marketing",
    "primecare_support",
    "primecare_governance",
    "primecare_enterprise_blueprint"
)

$rootDir = Get-Location
$jobs = @()

foreach ($app in $apps) {
    Write-Host "Starting parallel build for $app..." -ForegroundColor Cyan
    $job = Start-Job -ScriptBlock {
        param($appName, $root)
        Set-Location -Path "$root\apps\$appName"
        & flutter build apk --release
        if ($LASTEXITCODE -ne 0) {
            Write-Error "Failed building $appName"
        } else {
            Write-Output "Successfully built $appName!"
        }
    } -ArgumentList $app, $rootDir
    $jobs += $job
}

Write-Host "Waiting for all parallel builds to complete..." -ForegroundColor Yellow
Wait-Job -Job $jobs | Out-Null
$results = Receive-Job -Job $jobs
foreach ($res in $results) {
    Write-Host $res
}

$failed = $jobs | Where-Object { $_.State -eq 'Failed' }
if ($failed) {
    Write-Host "Some builds failed." -ForegroundColor Red
} else {
    Write-Host "All APKs built successfully in parallel!" -ForegroundColor Green
}
