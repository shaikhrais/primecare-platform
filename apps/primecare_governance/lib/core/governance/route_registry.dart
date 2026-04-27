import 'package:go_router/go_router.dart';
import '../../features/governance_operations/governance_operations_view.dart';

class RouteRegistry {
  static final GoRouter router = GoRouter(
    initialLocation: '/',
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) => const GovernanceDashboardView(),
      ),
      GoRoute(
        path: '/users',
        builder: (context, state) => const UserManagementView(),
      ),
      GoRoute(
        path: '/governance',
        builder: (context, state) => const GovernanceDashboardView(),
      ),
      GoRoute(
        path: '/intake',
        builder: (context, state) => const FeatureIntakeView(),
      ),
      GoRoute(
        path: '/health',
        builder: (context, state) => const SystemHealthView(),
      ),
    ],
  );
}

