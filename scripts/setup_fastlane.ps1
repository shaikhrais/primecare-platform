# Setup Fastlane for all PrimeCare applications

$apps = @(
    "primecare_business_development",
    "primecare_client",
    "primecare_clinic",
    "primecare_corporate",
    "primecare_franchise",
    "primecare_governance",
    "primecare_marketing",
    "primecare_support",
    "primecare_enterprise_blueprint"
)

foreach ($app in $apps) {
    Write-Host "Setting up Fastlane templates for $app..."

    $androidFastlanePath = "apps\$app\android\fastlane"
    $iosFastlanePath = "apps\$app\ios\fastlane"

    if (-not (Test-Path $androidFastlanePath)) { New-Item -ItemType Directory -Path $androidFastlanePath -Force | Out-Null }
    if (-not (Test-Path $iosFastlanePath)) { New-Item -ItemType Directory -Path $iosFastlanePath -Force | Out-Null }

    # Create Android Fastfile
    $androidFastfileContent = @"
default_platform(:android)

platform :android do
  desc "Deploy a new internal build to the Google Play Store"
  lane :internal do
    upload_to_play_store(
      track: 'internal',
      aab: '../build/app/outputs/bundle/release/app-release.aab',
      skip_upload_metadata: true,
      skip_upload_images: true,
      skip_upload_screenshots: true
    )
  end

  desc "Promote Internal to Production"
  lane :promote_to_production do
    upload_to_play_store(
      track: 'internal',
      track_promote_to: 'production',
      skip_upload_apk: true,
      skip_upload_aab: true
    )
  end
end
"@
    Set-Content -Path "$androidFastlanePath\Fastfile" -Value $androidFastfileContent

    # Create iOS Fastfile
    $iosFastfileContent = @"
default_platform(:ios)

platform :ios do
  desc "Push a new beta build to TestFlight"
  lane :beta do
    build_app(scheme: "Runner")
    upload_to_testflight
  end

  desc "Deploy a new version to the App Store"
  lane :release do
    build_app(scheme: "Runner")
    upload_to_app_store(
      force: true,
      submit_for_review: true,
      automatic_release: true
    )
  end
end
"@
    Set-Content -Path "$iosFastlanePath\Fastfile" -Value $iosFastfileContent

    Write-Host "✅ Fastlane generated for $app"
}

Write-Host "Fastlane scaffolding complete! The CI/CD pipelines can now be updated to invoke 'fastlane internal' for automated Store distribution."
