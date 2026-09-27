# check_ui_build.ps1
# Verify that the Flutter web build exists
$uiDir = "C:/Users/Admin2/Documents/GitHub/primecare-platform/apps/primecare_corporate"
$buildDir = Join-Path $uiDir "build"
if (Test-Path $buildDir) {
    Write-Host "UI build directory exists at $buildDir" -ForegroundColor Green
    exit 0
} else {
    Write-Host "UI build directory not found. Flutter build may still be running or failed." -ForegroundColor Yellow
    exit 1
}
