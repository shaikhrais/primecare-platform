param (
    [string]$Target = "appbundle" # Options: appbundle, apk, web, windows, linux
)

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
    Write-Host "Building $app for $Target..." -ForegroundColor Cyan
    Write-Host "=========================================" -ForegroundColor Cyan
    
    Set-Location -Path "apps\$app"
    
    if ($Target -eq "web") {
        flutter build web --release --no-tree-shake-icons
    } elseif ($Target -eq "appbundle") {
        flutter build appbundle --release
    } elseif ($Target -eq "apk") {
        flutter build apk --release
    } elseif ($Target -eq "windows") {
        flutter build windows --release
    } elseif ($Target -eq "linux") {
        flutter build linux --release
    } else {
        Write-Host "Unknown target: $Target" -ForegroundColor Red
        exit 1
    }
    
    if ($LASTEXITCODE -ne 0) {
        Write-Host "Error building $app!" -ForegroundColor Red
        Set-Location -Path $rootDir
        exit $LASTEXITCODE
    }
    
    Set-Location -Path $rootDir
}

Write-Host "=========================================" -ForegroundColor Green
Write-Host "All apps built successfully for $Target!" -ForegroundColor Green
Write-Host "=========================================" -ForegroundColor Green
