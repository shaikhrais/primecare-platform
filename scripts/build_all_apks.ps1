param (
    [string]$TargetApp = $null
)

$allApps = @(
    "primecare_governance",
    "primecare_corporate",
    "primecare_client",
    "primecare_clinic",
    "primecare_business_development",
    "primecare_franchise",
    "primecare_marketing",
    "primecare_support"
)

$apps = if ($TargetApp) { @($TargetApp) } else { $allApps }

$root = Get-Location
$buildResults = @()

foreach ($app in $apps) {
    Write-Host "--- Building APK for $app ---" -ForegroundColor Cyan
    $appPath = Join-Path $root "apps\$app"
    
    if (Test-Path $appPath) {
        Push-Location $appPath
        try {
            # Check for android directory, create if missing
            $androidPath = Join-Path $appPath "android"
            if (!(Test-Path $androidPath)) {
                Write-Host "Android platform missing for $app. Initializing..." -ForegroundColor Yellow
                flutter create --platforms=android .
            }

            # Ensure dependencies are up to date
            flutter pub get
            
            # Build the APK with live API data source
            $startTime = Get-Date
            flutter build apk --debug --dart-define=API_BASE_URL=https://primecare-worker-api-gateway.itpro-mohammed.workers.dev/api
            $endTime = Get-Date
            
            $duration = $endTime - $startTime
            $apkPath = Join-Path $appPath "build\app\outputs\flutter-apk\app-debug.apk"
            
            if (Test-Path $apkPath) {
                $targetName = "${app}-debug.apk"
                $destPath = Join-Path $root "artifacts\builds\$targetName"
                
                if (!(Test-Path (Split-Path $destPath))) {
                    New-Item -ItemType Directory -Path (Split-Path $destPath) -Force
                }
                
                Copy-Item $apkPath $destPath -Force
                Write-Host "Successfully built and copied $targetName" -ForegroundColor Green
                $buildResults += [PSCustomObject]@{
                    App = $app
                    Status = "Success"
                    Duration = "$($duration.TotalMinutes.ToString('F2')) min"
                    Path = $destPath
                }
            } else {
                Write-Host "Failed to find APK output for $app" -ForegroundColor Red
                $buildResults += [PSCustomObject]@{
                    App = $app
                    Status = "Failed (Missing Output)"
                    Duration = "-"
                    Path = "-"
                }
            }
        } catch {
            $err = $_.Exception.Message
            Write-Host "Error building $app - $err" -ForegroundColor Red
            $buildResults += [PSCustomObject]@{
                App = $app
                Status = "Error: $err"
                Duration = "-"
                Path = "-"
            }
        } finally {
            Pop-Location
        }
    } else {
        Write-Host "App directory not found - $appPath" -ForegroundColor Yellow
    }
}

$buildResults | Format-Table -AutoSize
