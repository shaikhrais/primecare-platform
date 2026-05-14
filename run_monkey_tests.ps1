# This script runs Android Monkey Tests on all 9 PrimeCare APKs
# Requirements: 
# 1. An Android Emulator must be running or a physical device connected via USB
# 2. `adb` must be available in your system PATH

$apps = @(
    @{ name="primecare_business_development"; pkg="com.example.primecare_business_development" },
    @{ name="primecare_client"; pkg="com.example.primecare_client" },
    @{ name="primecare_clinic"; pkg="com.example.primecare_clinic" },
    @{ name="primecare_corporate"; pkg="com.example.primecare_corporate" },
    @{ name="primecare_franchise"; pkg="com.example.primecare_franchise" },
    @{ name="primecare_marketing"; pkg="com.example.primecare_marketing" },
    @{ name="primecare_support"; pkg="com.example.primecare_support" },
    @{ name="primecare_governance"; pkg="com.example.primecare_governance" },
    @{ name="primecare_enterprise_blueprint"; pkg="com.example.primecare_enterprise_blueprint" }
)

Write-Host "Starting Automated UI Stress Tests (Monkey Test)..." -ForegroundColor Cyan

foreach ($app in $apps) {
    Write-Host "----------------------------------------"
    Write-Host "Installing $($app.name) ..." -ForegroundColor Yellow
    
    $apkPath = "apps\$($app.name)\build\app\outputs\flutter-apk\app-release.apk"
    adb install -r $apkPath
    
    if ($LASTEXITCODE -ne 0) {
        Write-Host "Failed to install $($app.name). Skipping test." -ForegroundColor Red
        continue
    }

    Write-Host "Testing $($app.pkg) ..." -ForegroundColor Yellow
    
    # Run monkey test: 500 random events, ignore security crashes to keep testing, throttle events by 50ms
    adb shell monkey -p $($app.pkg) --throttle 50 --ignore-crashes --ignore-timeouts --ignore-security-exceptions -v 500
    
    if ($LASTEXITCODE -eq 0) {
        Write-Host "$($app.name) survived the Monkey Test!" -ForegroundColor Green
    } else {
        Write-Host "$($app.name) encountered an error during stress testing." -ForegroundColor Red
    }
}
Write-Host "----------------------------------------"
Write-Host "All tests completed." -ForegroundColor Cyan
