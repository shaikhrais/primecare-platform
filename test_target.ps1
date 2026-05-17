param (
    [Parameter(Mandatory=$true)]
    [string]$App,

    [Parameter(Mandatory=$false)]
    [string]$Role = ""
)

$rootDir = Get-Location

Write-Host "========================================"
if ($Role -eq "") {
    Write-Host "🔬 Micro-Testing App: $App [All Authorized Roles]"
} else {
    Write-Host "🔬 Micro-Testing App: $App | Specific Role: $Role"
}
Write-Host "========================================"

# Validate app exists
if (-not (Test-Path "apps\$App")) {
    Write-Host "❌ ERROR: Application 'apps\$App' does not exist." -ForegroundColor Red
    exit 1
}

Set-Location "apps\$App"

# Build the command dynamically
$cmd = "flutter test integration_test\screenshot_stress_test.dart -d windows"
if ($Role -ne "") {
    $cmd += " --dart-define=TEST_ROLE=$Role"
}

# Execute
Invoke-Expression $cmd

if ($LASTEXITCODE -ne 0) {
    Write-Host "`n❌ ERROR DETECTED in $App" -ForegroundColor Red
    if ($Role -ne "") {
        Write-Host "Role '$Role' failed the test. Fix the issue and run:" -ForegroundColor Yellow
        Write-Host ".\test_target.ps1 -App $App -Role $Role" -ForegroundColor Cyan
    } else {
        Write-Host "Fix the issue and run:" -ForegroundColor Yellow
        Write-Host ".\test_target.ps1 -App $App" -ForegroundColor Cyan
    }
} else {
    Write-Host "`n✅ $App passed all targeted tests!" -ForegroundColor Green
}

Set-Location $rootDir
