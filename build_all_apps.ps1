$apps = @(
    "primecare_business_development",
    "primecare_client",
    "primecare_clinic",
    "primecare_corporate",
    "primecare_franchise",
    "primecare_marketing",
    "primecare_support",
    "primecare_governance"
)

$rootDir = Get-Location

foreach ($app in $apps) {
    Write-Host "=========================================" -ForegroundColor Cyan
    Write-Host "Building $app for Web..." -ForegroundColor Cyan
    Write-Host "=========================================" -ForegroundColor Cyan
    
    Set-Location -Path "apps\$app"
    flutter build web --release --no-tree-shake-icons
    
    if ($LASTEXITCODE -ne 0) {
        Write-Host "Error building $app!" -ForegroundColor Red
        Set-Location -Path $rootDir
        exit $LASTEXITCODE
    }
    
    Set-Location -Path $rootDir
}

Write-Host "=========================================" -ForegroundColor Green
Write-Host "All apps built successfully!" -ForegroundColor Green
Write-Host "=========================================" -ForegroundColor Green
