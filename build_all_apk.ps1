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

foreach ($app in $apps) {
    Write-Host "=========================================" -ForegroundColor Cyan
    Write-Host "Building $app APK..." -ForegroundColor Cyan
    Write-Host "=========================================" -ForegroundColor Cyan
    
    Set-Location -Path "apps\$app"
    flutter build apk --release
    
    if ($LASTEXITCODE -ne 0) {
        Write-Host "Error building APK for $app!" -ForegroundColor Red
        Set-Location -Path $rootDir
        exit $LASTEXITCODE
    }
    
    Set-Location -Path $rootDir
}

Write-Host "=========================================" -ForegroundColor Green
Write-Host "All APKs built successfully!" -ForegroundColor Green
Write-Host "=========================================" -ForegroundColor Green
