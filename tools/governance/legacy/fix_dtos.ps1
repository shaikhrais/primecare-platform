$files = Get-ChildItem -Path "packages/flutter_core/lib/features" -Filter "*_adapter_dto.dart" -Recurse
foreach ($file in $files) {
    Write-Host "Fixing $($file.FullName)"
    (Get-Content $file.FullName) -replace "id: json\['id'\] \?\? '',", "id: json['id']?.toString() ?? ''," | Set-Content $file.FullName
}
