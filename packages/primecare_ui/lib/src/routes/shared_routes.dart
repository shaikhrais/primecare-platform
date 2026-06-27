// Governance - Category: middleware | Purpose: Routing definition mapping client endpoints, paths, layouts, and access guards.
import 'package:go_router/go_router.dart';
import 'package:primecare_ui/src/admin/screens/screenshot_inventory_page.dart';

final List<RouteBase> sharedCommonRoutes = [
  GoRoute(
    path: '/admin/screenshot-inventory',
    builder: (context, state) => const ScreenshotInventoryPage(),
  ),
];
