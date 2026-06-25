$apps = @(
    "primecare_auth",
    "primecare_governance",
    "primecare_client",
    "primecare_clinic",
    "primecare_corporate",
    "primecare_franchise",
    "primecare_marketing",
    "primecare_support",
    "primecare_business_development",
    "primecare_enterprise_blueprint"
)

$rootDir = Get-Location
$results = @()

Write-Host "=========================================================" -ForegroundColor Green
Write-Host "🚀 DEPLOYING PRE-BUILT APPLICATIONS TO CLOUDFLARE PAGES" -ForegroundColor Green
Write-Host "=========================================================" -ForegroundColor Green

foreach ($app in $apps) {
    $projectName = $app -replace '_', '-'
    $appPath = Join-Path $rootDir ("apps\" + $app)
    $buildPath = Join-Path $appPath "build\web"
    
    Write-Host ""
    Write-Host "---------------------------------------------------------" -ForegroundColor Cyan
    Write-Host "📦 Processing: $app -> $projectName" -ForegroundColor Cyan
    Write-Host "---------------------------------------------------------" -ForegroundColor Cyan
    
    if (-Not (Test-Path $buildPath)) {
        Write-Host "❌ Build directory not found: $buildPath" -ForegroundColor Red
        $results += [PSCustomObject]@{
            AppName     = $app
            ProjectName = $projectName
            Status      = "Failed"
            Details     = "Build dir not found"
            URL         = "N/A"
        }
        continue
    }

    # Step 1: Generate AssetManifest.json
    Write-Host "⚡ Step 1: Generating AssetManifest.json..." -ForegroundColor Yellow
    $assetsPath = Join-Path $buildPath "assets"
    if (Test-Path $assetsPath) {
        python "$rootDir\scripts\generate_asset_manifest.py" "$assetsPath"
    } else {
        Write-Host "⚠️ No assets directory found at $assetsPath" -ForegroundColor Yellow
    }
    
    # Step 2: Remove flutter_service_worker.js
    Write-Host "⚡ Step 2: Disabling service worker cache..." -ForegroundColor Yellow
    $swFile = Join-Path $buildPath "flutter_service_worker.js"
    if (Test-Path $swFile) {
        Remove-Item $swFile -Force
        Write-Host "Service worker deleted." -ForegroundColor Green
    } else {
        Write-Host "Service worker not found/already deleted." -ForegroundColor Green
    }
    
    # Step 3: Deploy to Cloudflare Pages
    Write-Host "⚡ Step 3: Deploying to Cloudflare Pages..." -ForegroundColor Yellow
    # Change location to run wrangler pages deploy
    Set-Location -Path $appPath
    $deployOutput = wrangler pages deploy build/web --project-name $projectName --commit-dirty=true 2>&1 | Out-String
    Set-Location -Path $rootDir
    
    $url = "N/A"
    if ($deployOutput -match 'https://[a-zA-Z0-9.-]+\.pages\.dev') {
        $url = $Matches[0].TrimEnd('/')
        if ($url -match "\.($projectName)\.pages\.dev$") {
            $url = "https://$projectName.pages.dev"
        }
    }
    
    if ($deployOutput -match "Success" -or $deployOutput -match "Deployment complete") {
        Write-Host "✨ Successfully deployed to $url" -ForegroundColor Green
        $results += [PSCustomObject]@{
            AppName     = $app
            ProjectName = $projectName
            Status      = "Deployed"
            Details     = "Success"
            URL         = $url
        }
    } else {
        Write-Host "❌ Deployment failed!" -ForegroundColor Red
        Write-Host $deployOutput -ForegroundColor Gray
        $results += [PSCustomObject]@{
            AppName     = $app
            ProjectName = $projectName
            Status      = "Failed"
            Details     = "wrangler deploy failed"
            URL         = "N/A"
        }
    }
}

Write-Host ""
Write-Host "=========================================================" -ForegroundColor Green
Write-Host "📊 DEPLOYMENT CYCLE SUMMARY" -ForegroundColor Green
Write-Host "=========================================================" -ForegroundColor Green

$results | Format-Table -AutoSize

# Save Markdown report
$reportPath = Join-Path $rootDir "artifacts\cloudflare_deployment_report.md"
$mdLines = @(
    "# PrimeCare Cloudflare Deployment Report",
    "",
    "This report summarizes the automated deployment of the pre-built PrimeCare Flutter Web applications.",
    "",
    "## Deployment Status Table",
    "",
    "| Application Name | Cloudflare Project | Status | Details | Live URL |",
    "|---|---|---|---|---|"
)

foreach ($res in $results) {
    $line = "| **" + $res.AppName + "** | `" + $res.ProjectName + "` | **" + $res.Status + "** | " + $res.Details + " | [" + $res.URL + "](" + $res.URL + ") |"
    $mdLines += $line
}

$mdLines += ""
$mdLines += ("*Report generated on " + (Get-Date -Format "yyyy-MM-dd HH:mm:ss") + "*")

$mdContent = $mdLines -join "`r`n"
Set-Content -Path $reportPath -Value $mdContent
Write-Host "Saved deployment report to artifacts\cloudflare_deployment_report.md" -ForegroundColor Green
