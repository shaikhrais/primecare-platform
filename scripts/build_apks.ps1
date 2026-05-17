$apps = @(
    "primecare_business_development",
    "primecare_client",
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
    Write-Host "Building APK for $app..." -ForegroundColor Cyan
    Write-Host "=========================================" -ForegroundColor Cyan
    
    Set-Location -Path "apps\$app"

    # Ensure Android project files are up to date and supported
    flutter create . --platforms android
    
    # Run pub get first to ensure dependencies are resolved
    flutter pub get
    
    # Build APK. Using --debug for now to avoid signing issues, 
    # but the user can change it to --release if they have signing configured.
    flutter build apk --debug
    
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
