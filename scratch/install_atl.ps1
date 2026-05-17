# PrimeCare Platform: C++ ATL Dependency Installer for Windows Desktop Target
# This script terminates any hanging installer locks and adds the C++ ATL component.

Write-Host "==========================================================" -ForegroundColor Cyan
Write-Host "PrimeCare C++ ATL Dependency Installer" -ForegroundColor Cyan
Write-Host "==========================================================" -ForegroundColor Cyan

# 1. Check for Administrative privileges
$isAdmin = ([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)
if (-not $isAdmin) {
    Write-Host "[!] This script must be run as Administrator to modify Visual Studio Build Tools." -ForegroundColor Yellow
    Write-Host "[*] Relaunching script with Administrator privileges..." -ForegroundColor Cyan
    Start-Process powershell -ArgumentList "-NoProfile -ExecutionPolicy Bypass -File `"$PSCommandPath`"" -Verb RunAs
    Exit
}

# 2. Terminate any hanging VS Installer / setup processes from prior runs to release locks
Write-Host "[*] Checking for hanging installer locks..." -ForegroundColor Cyan
$setupProc = Get-Process -Name "setup", "vs_installer", "vs_installershell" -ErrorAction SilentlyContinue
if ($setupProc) {
    Write-Host "[!] Found hanging installer processes from previous sessions. Terminating to release lock..." -ForegroundColor Yellow
    $setupProc | Stop-Process -Force -ErrorAction SilentlyContinue
    Start-Sleep -Seconds 2
    Write-Host "[√] Process locks released." -ForegroundColor Green
} else {
    Write-Host "[√] No active installer locks found." -ForegroundColor Green
}

# 3. Locate Visual Studio 2019 Build Tools installation path
$vsPath = "C:\Program Files (x86)\Microsoft Visual Studio\2019\BuildTools"
$installerPath = "C:\Program Files (x86)\Microsoft Visual Studio\Installer\vs_installer.exe"

if (-not (Test-Path $vsPath)) {
    Write-Host "[X] Visual Studio 2019 Build Tools not found at: $vsPath" -ForegroundColor Red
    Write-Host "[*] Please make sure Visual Studio Build Tools 2019 is installed." -ForegroundColor Yellow
    Exit
}

if (-not (Test-Path $installerPath)) {
    Write-Host "[X] Visual Studio Installer not found at: $installerPath" -ForegroundColor Red
    Exit
}

# 4. Invoke Visual Studio Installer in quiet/unattended mode to install the VC++ ATL component
Write-Host "[*] Modifying VS Build Tools to add C++ ATL (Microsoft.VisualStudio.Component.VC.ATLMFC)..." -ForegroundColor Cyan
Write-Host "[*] This process runs in quiet mode and typically takes 1-2 minutes. Please wait..." -ForegroundColor Cyan

$process = Start-Process -FilePath $installerPath -ArgumentList "modify --installPath `"$vsPath`" --add Microsoft.VisualStudio.Component.VC.ATLMFC --quiet --norestart" -PassThru -Wait

if ($process.ExitCode -eq 0) {
    Write-Host "[√] C++ ATL component installed successfully!" -ForegroundColor Green
    Write-Host "[*] You can now successfully build and run the Windows desktop application." -ForegroundColor Green
} else {
    Write-Host "[X] Installation exited with code: $($process.ExitCode)" -ForegroundColor Red
    Write-Host "[*] Please review the Visual Studio Installer logs or run vs_installer manually." -ForegroundColor Yellow
}

Write-Host "==========================================================" -ForegroundColor Cyan
