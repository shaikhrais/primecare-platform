$apps = @(
    "primecare_business_development",
    "primecare_client",
    "primecare_clinic",
    "primecare_corporate",
    "primecare_franchise",
    "primecare_marketing",
    "primecare_support"
)

$rootDir = Get-Location

foreach ($app in $apps) {
    Write-Host "========================================"
    Write-Host "Running Integration Stress Test & Screenshots for $app"
    Write-Host "========================================"
    Set-Location "apps\$app"
    
    # Run with --fail-fast to stop immediately on the first error within the app
    flutter test "integration_test\screenshot_stress_test.dart" -d windows --fail-fast
    
    # Check if the test failed, and if so, stop the entire script
    if ($LASTEXITCODE -ne 0) {
        Write-Host "❌ ERROR DETECTED in $app! Stopping execution so it can be fixed." -ForegroundColor Red
        Set-Location $rootDir
        exit $LASTEXITCODE
    }
    
    Set-Location $rootDir
}

Write-Host "All apps tested! Screenshots saved to C:\primecare_screenshots\"
