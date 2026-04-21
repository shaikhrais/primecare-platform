import 'package:go_router/go_router.dart';
import 'package:primecare_ui/00_B_primecare_ui.dart';
import 'routes/groups/01_I_client_routes.dart';

final appRouterProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    initialLocation: '/',
    routes: [
      ShellRoute(
        builder: (context, state, child) => MasterLayout(
          shellType: AppShellType.client, // client uses client shell
          child: child,
        ),
        routes: clientRoutes,
      ),
    ],
  );
});
