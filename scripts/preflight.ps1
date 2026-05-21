$ErrorActionPreference = "Stop"

Write-Host "Starting Pre-flight Verification..." -ForegroundColor Cyan

Write-Host "Running Platform-wide Dart analysis..." -ForegroundColor Yellow
dart analyze . --fatal-warnings
if ($LASTEXITCODE -ne 0) {
    Write-Host "Code analysis failed! Fix all errors and warnings before proceeding." -ForegroundColor Red
    exit 1
}

Write-Host "Running Localization Audit..." -ForegroundColor Yellow
dart run scripts/audit_localization.dart
if ($LASTEXITCODE -ne 0) {
    Write-Host "Localization audit failed! Check your i18n paths and asset registrations." -ForegroundColor Red
    exit 1
}

Write-Host "Running Backend Tests (Services)..." -ForegroundColor Yellow
$services = Get-ChildItem -Path "services" -Directory
foreach ($service in $services) {
    if ((Test-Path "$($service.FullName)\pubspec.yaml") -and (Test-Path "$($service.FullName)\test")) {
        Write-Host "Testing $($service.Name)..." -ForegroundColor Gray
        cd $service.FullName
        dart test
        if ($LASTEXITCODE -ne 0) {
            Write-Host "Tests failed in $($service.Name)!" -ForegroundColor Red
            exit 1
        }
        cd ..\..
    }
}

Write-Host "Running Frontend Tests (Apps)..." -ForegroundColor Yellow
$apps = Get-ChildItem -Path "apps" -Directory
foreach ($app in $apps) {
    if ((Test-Path "$($app.FullName)\pubspec.yaml") -and (Test-Path "$($app.FullName)\test")) {
        Write-Host "Testing $($app.Name)..." -ForegroundColor Gray
        cd $app.FullName
        flutter test
        if ($LASTEXITCODE -ne 0) {
            Write-Host "Tests failed in $($app.Name)!" -ForegroundColor Red
            exit 1
        }
        cd ..\..
    }
}

Write-Host "Pre-flight Code Verification Passed! Platform is clean and compliant." -ForegroundColor Green
exit 0
