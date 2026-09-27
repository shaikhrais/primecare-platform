Get-ChildItem -Path "apps" -Filter "app_router.dart" -Recurse | Where-Object { $_.FullName -notmatch "primecare_corporate" } | ForEach-Object {
    $file = $_.FullName
    $text = Get-Content $file -Raw
    
    if ($text -notmatch "publicRoutes:") {
        $text = $text -replace 'initialLocation:.*?,', 'initialLocation: activeRole == PlatformRole.guest ? CommonRoutes.login : AuthNotifier.getDashboardRouteForRole(authState.role ?? ''''),'
        $text = $text -replace 'return null;\s*\},', "return null;
    },
    publicRoutes: [
      GoRoute(
        path: CommonRoutes.login,
        builder: (context, state) => const SignInView(),
      ),
    ],"
        
        Set-Content -Path $file -Value $text
        Write-Host "Updated $file"
    } else {
        Write-Host "Skipped $file (already has publicRoutes)"
    }
}
