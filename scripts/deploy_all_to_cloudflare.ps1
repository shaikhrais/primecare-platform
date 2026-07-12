param(
    [Parameter(Position=0)]
    [string]$Target = "all"
)

$ErrorActionPreference = "Continue"

# Load .env file if present
if (Test-Path ".env") {
    Get-Content ".env" | ForEach-Object {
        if ($_ -match '^\s*([^#=]+)\s*=\s*(.*)$') {
            $key = $Matches[1].Trim()
            $val = $Matches[2].Trim()
            if ($val.StartsWith('"') -and $val.EndsWith('"')) { $val = $val.Substring(1, $val.Length - 2) }
            if ($val.StartsWith("'") -and $val.EndsWith("'")) { $val = $val.Substring(1, $val.Length - 2) }
            [System.Environment]::SetEnvironmentVariable($key, $val, "Process")
        }
    }
}

$allApps = @(
    "primecare_auth",                # 1
    "primecare_governance",          # 2
    "primecare_corporate",           # 3
    "primecare_franchise",           # 4
    "primecare_clinic",              # 5
    "primecare_client",              # 6
    "primecare_business_development",# 7
    "primecare_marketing",           # 8
    "primecare_support",             # 9
    "primecare_enterprise_blueprint" # 10
)

$apps = @()

if ($Target -eq "all" -or $Target -eq "*") {
    $apps = $allApps
} elseif ($Target -match "^\d+-\d+$") {
    # It's a range like "1-5"
    $parts = $Target -split "-"
    $start = [int]$parts[0]
    $end = [int]$parts[1]
    
    # Bound checks
    if ($start -lt 1) { $start = 1 }
    if ($end -gt $allApps.Count) { $end = $allApps.Count }
    
    for ($i = $start - 1; $i -le $end - 1; $i++) {
        $apps += $allApps[$i]
    }
} elseif ($Target -match "^[\d,]+$") {
    # Comma-separated list like "1,5" or single number "5"
    $parts = $Target -split ","
    foreach ($part in $parts) {
        $idx = [int]$part
        if ($idx -ge 1 -and $idx -le $allApps.Count) {
            $apps += $allApps[$idx - 1]
        }
    }
} else {
    # Name wildcard matching (e.g. "auth" or "*clinic*")
    $pattern = $Target
    if (-not $pattern.Contains("*")) {
        $pattern = "*" + $pattern + "*"
    }
    
    foreach ($app in $allApps) {
        if ($app -like $pattern) {
            $apps += $app
        }
    }
}

if ($apps.Count -eq 0) {
    Write-Host "⚠️ No matching applications found for target '$Target'!" -ForegroundColor Yellow
    Write-Host "Available applications and their 1-based indices:" -ForegroundColor Yellow
    for ($i = 0; $i -lt $allApps.Count; $i++) {
        Write-Host ("  " + ($i + 1) + ". " + $allApps[$i]) -ForegroundColor Yellow
    }
    exit 1
}

$rootDir = Get-Location
$results = @()

Write-Host '=========================================================' -ForegroundColor Green
Write-Host '🚀 PRIMECARE CLOUDFLARE PAGES ORCHESTRATED DEPLOYMENT' -ForegroundColor Green
Write-Host '=========================================================' -ForegroundColor Green

foreach ($app in $apps) {
    $projectName = $app -replace '_', '-'
    $appPath = Join-Path $rootDir ('apps\' + $app)
    
    Write-Host ''
    Write-Host '---------------------------------------------------------' -ForegroundColor Cyan
    Write-Host ('📦 Processing: ' + $app + ' -> ' + $projectName) -ForegroundColor Cyan
    Write-Host '---------------------------------------------------------' -ForegroundColor Cyan
    
    if (-Not (Test-Path $appPath)) {
        Write-Host ('❌ Directory not found: ' + $appPath) -ForegroundColor Red
        $results += [PSCustomObject]@{
            AppName     = $app
            ProjectName = $projectName
            Status      = 'Failed'
            Details     = 'Directory not found'
            URL         = 'N/A'
        }
        continue
    }

    Set-Location -Path $appPath
    
    Write-Host '⚡ Step 0: Cleaning build cache...' -ForegroundColor Yellow
    flutter clean
    
    Write-Host '⚡ Step 1: Resolving dependencies...' -ForegroundColor Yellow
    flutter pub get
    if ($LASTEXITCODE -ne 0) {
        Write-Host '❌ Dependencies resolution failed!' -ForegroundColor Red
        $results += [PSCustomObject]@{
            AppName     = $app
            ProjectName = $projectName
            Status      = 'Failed'
            Details     = 'pub get failed'
            URL         = 'N/A'
        }
        Set-Location -Path $rootDir
        continue
    }

    $appUrls = @{
        "primecare_auth" = "https://primecare-auth.pages.dev"
        "primecare_governance" = "https://primecare-governance.pages.dev"
        "primecare_corporate" = "https://primecare-corporate.pages.dev"
        "primecare_franchise" = "https://primecare-franchise.pages.dev"
        "primecare_clinic" = "https://primecare-clinic.pages.dev"
        "primecare_client" = "https://primecare-client.pages.dev"
        "primecare_business_development" = "https://primecare-business-development.pages.dev"
        "primecare_marketing" = "https://primecare-marketing.pages.dev"
        "primecare_support" = "https://primecare-support.pages.dev"
        "primecare_enterprise_blueprint" = "https://primecare-enterprise-blueprint.pages.dev"
    }
    $ssoUrl = $appUrls[$app]
    if ($app -eq "primecare_auth") {
        $ssoUrl = $appUrls["primecare_auth"]
    } else {
        $ssoUrl = $appUrls["primecare_auth"]
    }
    $appUrl = $appUrls[$app]

    Write-Host '⚡ Step 2: Compiling to Web (Release)...' -ForegroundColor Yellow
    flutter build web --release --no-wasm-dry-run --dart-define=API_BASE_URL=https://primecare-worker-api-gateway.itpro-mohammed.workers.dev/api --dart-define=SSO_PORTAL_URL=$ssoUrl --dart-define=APP_BASE_URL=$appUrl
    if ($LASTEXITCODE -ne 0) {
        Write-Host '❌ Compilation failed!' -ForegroundColor Red
        $results += [PSCustomObject]@{
            AppName     = $app
            ProjectName = $projectName
            Status      = 'Failed'
            Details     = 'flutter build web failed'
            URL         = 'N/A'
        }
        Set-Location -Path $rootDir
        continue
    }

    Write-Host '⚡ Step 2.5: Generating AssetManifest.json for legacy web compatibility...' -ForegroundColor Yellow
    python "$rootDir\scripts\generate_asset_manifest.py" "build\web\assets"

    Write-Host '⚡ Step 2.6: Disabling service worker cache to prevent stale deployments...' -ForegroundColor Yellow
    if (Test-Path "build\web\flutter_service_worker.js") {
        Remove-Item "build\web\flutter_service_worker.js" -Force
    }

    Write-Host '⚡ Step 2.7: Creating Cloudflare Pages _redirects file for SPA client-side routing...' -ForegroundColor Yellow
    Set-Content -Path "build\web\_redirects" -Value "/* /index.html 200" -Encoding Ascii



    Write-Host '⚡ Step 3: Deploying to Cloudflare Pages...' -ForegroundColor Yellow
    $oldToken = $env:CLOUDFLARE_API_TOKEN
    $env:CLOUDFLARE_API_TOKEN = $null
    
    $deployOutput = npx wrangler pages deploy build/web --project-name $projectName --commit-dirty=true 2>&1 | Out-String
    
    $env:CLOUDFLARE_API_TOKEN = $oldToken
    
    $url = 'N/A'
    if ($deployOutput -match 'https://[a-zA-Z0-9.-]+\.pages\.dev') {
        $url = $Matches[0].TrimEnd('/')
        # Normalize URL to strip dynamic deployment preview subdomains (e.g., hash.primecare-xxx.pages.dev)
        # and consistently return the clean public project alias (https://primecare-xxx.pages.dev)
        if ($url -match "\.($projectName)\.pages\.dev$") {
            $url = "https://$projectName.pages.dev"
        }
    }
    
    if ($deployOutput -match 'Success' -or $deployOutput -match 'Deployment complete') {
        Write-Host ('✨ Successfully deployed to ' + $url) -ForegroundColor Green
        $results += [PSCustomObject]@{
            AppName     = $app
            ProjectName = $projectName
            Status      = 'Deployed'
            Details     = 'Success'
            URL         = $url
        }
    } else {
        Write-Host '❌ Deployment failed!' -ForegroundColor Red
        Write-Host $deployOutput -ForegroundColor Gray
        $results += [PSCustomObject]@{
            AppName     = $app
            ProjectName = $projectName
            Status      = 'Failed'
            Details     = 'wrangler deploy failed'
            URL         = 'N/A'
        }
    }

    Set-Location -Path $rootDir
}

Write-Host ''
Write-Host '🤖 Triggering Automated Post-Deployment Verification & Screen Details Audit Scan...' -ForegroundColor Cyan
npx tsx scripts/post_deploy_tester.ts

Write-Host ''
Write-Host '=========================================================' -ForegroundColor Green
Write-Host '📊 DEPLOYMENT CYCLE SUMMARY' -ForegroundColor Green
Write-Host '=========================================================' -ForegroundColor Green


$results | Format-Table -AutoSize

# Generate a markdown report in artifacts using safe concatenation and single quotes
$reportPath = Join-Path $rootDir 'artifacts\cloudflare_deployment_report.md'
$mdLines = @(
    '# PrimeCare Cloudflare Deployment Report',
    '',
    'This report summarizes the automated deployment cycle of the PrimeCare Flutter Web applications to Cloudflare Pages.',
    '',
    '## Deployment Status Table',
    '',
    '| Application Name | Cloudflare Project | Status | Details | Live URL |',
    '|---|---|---|---|---|'
)

foreach ($res in $results) {
    $line = '| **' + $res.AppName + '** | `' + $res.ProjectName + '` | **' + $res.Status + '** | ' + $res.Details + ' | [' + $res.URL + '](' + $res.URL + ') |'
    $mdLines += $line
}

$mdLines += ''
$mdLines += ('*Report generated on ' + (Get-Date -Format 'yyyy-MM-dd HH:mm:ss') + '*')

$mdContent = $mdLines -join "`r`n"
Set-Content -Path $reportPath -Value $mdContent
Write-Host 'Saved deployment report to artifacts\cloudflare_deployment_report.md' -ForegroundColor Green
