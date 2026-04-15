import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'routes/groups/support_routes.dart';

final appRouterProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    initialLocation: '/',
    routes: [
      ShellRoute(
        builder: (context, state, child) => MasterLayout(
          shellType: AppShellType.admin, // support uses admin shell
          child: child,
        ),
        routes: supportRoutes,
      ),
    ],
  );
});
