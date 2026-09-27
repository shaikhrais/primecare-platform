$apps = Get-ChildItem -Directory apps/
foreach ($app in $apps) {
    Write-Host "Fixing lints in $($app.Name)..."
    cd "apps/$($app.Name)"
    dart fix --apply
    cd ../..
}
