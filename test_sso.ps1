$ErrorActionPreference = "Stop"

Write-Host "=========================================" -ForegroundColor Cyan
Write-Host "    PrimeCare SSO Integration Test       " -ForegroundColor Cyan
Write-Host "=========================================" -ForegroundColor Cyan

$WorkspacePath = (Get-Item .).FullName

# 1. Start the Auth API
Write-Host "[1/3] Starting Auth API (Port 8700)..." -ForegroundColor Yellow
$ApiProcess = Start-Process -FilePath "dart" -ArgumentList "run", "bin/server.dart" -WorkingDirectory "$WorkspacePath\services\auth_api" -PassThru -NoNewWindow
Start-Sleep -Seconds 3

# 2. Start the Auth Portal
Write-Host "[2/3] Starting Auth Portal (Port 3000)..." -ForegroundColor Yellow
$AuthPortalProcess = Start-Process -FilePath "flutter" -ArgumentList "run", "-d", "web-server", "--web-port", "3000" -WorkingDirectory "$WorkspacePath\apps\primecare_auth" -PassThru -NoNewWindow
Start-Sleep -Seconds 5

# 3. Start the Clinic Portal
Write-Host "[3/3] Starting Clinic Portal (Port 3001)..." -ForegroundColor Yellow
$ClinicProcess = Start-Process -FilePath "flutter" -ArgumentList "run", "-d", "web-server", "--web-port", "3001" -WorkingDirectory "$WorkspacePath\apps\primecare_clinic" -PassThru -NoNewWindow
Start-Sleep -Seconds 5

Write-Host ""
Write-Host "All services have been started!" -ForegroundColor Green
Write-Host "-----------------------------------------"
Write-Host "Endpoints:"
Write-Host "Auth API:     http://localhost:8700"
Write-Host "Auth Portal:  http://localhost:3000"
Write-Host "Clinic App:   http://localhost:3001"
Write-Host "-----------------------------------------"
Write-Host ""
Write-Host "Testing Instructions:" -ForegroundColor Cyan
Write-Host "1. Open your browser to http://localhost:3001 (Clinic App)."
Write-Host "2. You should be automatically redirected to http://localhost:3000 (Auth Portal)."
Write-Host "3. Log in using a test credential (e.g., psw@primecare.test)."
Write-Host "4. You will be redirected back to the Clinic app and automatically logged in!"
Write-Host ""
Write-Host "Press any key to terminate all services..." -ForegroundColor Yellow
$null = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")

Write-Host "Stopping services..." -ForegroundColor Cyan
Stop-Process -Id $ApiProcess.Id -Force -ErrorAction SilentlyContinue
Stop-Process -Id $AuthPortalProcess.Id -Force -ErrorAction SilentlyContinue
Stop-Process -Id $ClinicProcess.Id -Force -ErrorAction SilentlyContinue
Write-Host "Done!" -ForegroundColor Green
