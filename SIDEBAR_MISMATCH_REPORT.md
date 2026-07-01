# Sidebar Navigation Mismatch Report

Total entries: 2

| ID | Screen Name | Screen Code | Role | App | Route Path | File Path | Problem Found | Exact Missing Item | Suggested Fix |
|---|---|---|---|---|---|---|---|---|---|
| 1262 | ScreenProgressDashboardScreen | `screen_progress_dashboard` | Guest | Primecare Client | `/management/screen-progress-dashboard` | `packages/primecare_ui/lib/src/screens/management/screen_progress_dashboard.dart` | Route not found in sidebar menu for role 'Guest' | `Sidebar menu link for route /management/screen-progress-dashboard` | Add PrimeCareNavigationItem mapping for route /management/screen-progress-dashboard in NavigationRegistry._roleMenus['Guest'] |
| 1263 | AdminScreenHealthScreen | `admin_screen_health` | Guest | PrimeCare UI Client | `/admin/screen-health` | `packages/primecare_ui/lib/src/screens/admin/admin_screen_health_screen.dart` | Route not found in sidebar menu for role 'Guest' | `Sidebar menu link for route /admin/screen-health` | Add PrimeCareNavigationItem mapping for route /admin/screen-health in NavigationRegistry._roleMenus['Guest'] |
