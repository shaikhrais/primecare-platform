$dashboards = Get-ChildItem "lib/features" -Recurse -Filter "*view_model.dart" | Where-Object { $_.Name -match "dashboard" }
foreach ($file in $dashboards) {
    if ($file.Name -eq "primecare_dashboard_view_model.dart") { continue }
    $content = Get-Content $file.FullName -Raw
    $content = $content -replace "import '../../common/domain/models/primecare_dashboard_view_model.dart';", "import '../../../common/domain/models/primecare_dashboard_view_model.dart';"
    Set-Content -Path $file.FullName -Value $content
}

$forms = Get-ChildItem "lib/features" -Recurse -Filter "*view_model.dart" | Where-Object { $_.Name -notmatch "dashboard" -and $_.Name -notmatch "primecare" }
foreach ($file in $forms) {
    if ($file.Name -eq "primecare_form_view_model.dart") { continue }
    $content = Get-Content $file.FullName -Raw
    $content = $content -replace "import '../../common/domain/models/primecare_form_view_model.dart';", "import '../../../common/domain/models/primecare_form_view_model.dart';"
    Set-Content -Path $file.FullName -Value $content
}

# Fix franchise_owner_view_model.dart which acts as a dashboard
$franchiseOwner = Get-Item "lib/features/franchise_owner_dashboard/domain/models/franchise_owner_view_model.dart"
$content = Get-Content $franchiseOwner.FullName -Raw
$content = $content -replace "import '../../common/domain/models/primecare_dashboard_view_model.dart';", "import '../../../common/domain/models/primecare_dashboard_view_model.dart';"
Set-Content -Path $franchiseOwner.FullName -Value $content
