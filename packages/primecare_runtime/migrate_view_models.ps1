$dashboards = Get-ChildItem "lib/features" -Recurse -Filter "*view_model.dart" | Where-Object { $_.Name -match "dashboard" }
foreach ($file in $dashboards) {
    if ($file.Name -eq "primecare_dashboard_view_model.dart") { continue }
    
    $content = Get-Content $file.FullName -Raw
    if ($content -match "class\s+(\w+)\s+(?:implements|extends)") {
        $className = $matches[1]
        
        # Calculate relative path to primecare_dashboard_view_model.dart
        # All dashboard view models are in lib/features/FEATURE_NAME/domain/models/
        # which is 4 levels deep from lib (features/FEATURE/domain/models)
        # We need to go up to 'features' (../../), then into common/domain/models
        
        $newContent = "import '../../common/domain/models/primecare_dashboard_view_model.dart';`r`n"
        $newContent += "typedef $className = PrimeCareDashboardViewModel;`r`n"
        
        Set-Content -Path $file.FullName -Value $newContent
        Write-Host "Migrated Dashboard: $className in $($file.Name)"
    }
}

$forms = Get-ChildItem "lib/features" -Recurse -Filter "*view_model.dart" | Where-Object { $_.Name -notmatch "dashboard" -and $_.Name -notmatch "primecare" -and $_.Name -ne "developer_samples_view_model.dart" -and $_.Name -ne "common_feature_view_model.dart" -and $_.Name -ne "common_view_model.dart" -and $_.Name -ne "franchise_owner_view_model.dart" }
foreach ($file in $forms) {
    $content = Get-Content $file.FullName -Raw
    if ($content -match "class\s+(\w+)\s*\{*") {
        $className = $matches[1]
        
        $newContent = "import '../../common/domain/models/primecare_form_view_model.dart';`r`n"
        $newContent += "typedef $className = PrimeCareFormViewModel;`r`n"
        
        Set-Content -Path $file.FullName -Value $newContent
        Write-Host "Migrated Form: $className in $($file.Name)"
    }
}

# Fix franchise_owner_view_model.dart which acts as a dashboard
$franchiseOwner = Get-Item "lib/features/franchise_owner_dashboard/domain/models/franchise_owner_view_model.dart"
$newContent = "import '../../common/domain/models/primecare_dashboard_view_model.dart';`r`n"
$newContent += "typedef FranchiseOwnerViewModel = PrimeCareDashboardViewModel;`r`n"
Set-Content -Path $franchiseOwner.FullName -Value $newContent
Write-Host "Migrated FranchiseOwnerViewModel"

Write-Host "Migration complete!"
