$dirs = @(
    "packages/factory_system/primecare_ui",
    "packages/flutter_core",
    "packages/primecare_adapters",
    "apps/primecare_business_development",
    "apps/primecare_client",
    "apps/primecare_clinic",
    "apps/primecare_corporate",
    "apps/primecare_franchise",
    "apps/primecare_marketing",
    "apps/primecare_support"
)

foreach ($dir in $dirs) {
    Write-Host "Upgrading dependencies in $dir..."
    Push-Location $dir
    flutter pub upgrade
    Pop-Location
}
