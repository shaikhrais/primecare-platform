import 'package:primecare_ui/primecare_ui.dart';
import 'package:go_router/go_router.dart';
import '../../features/corporate_operations/corporate_operations_view.dart';

final List<RouteBase> corporateRoutes = [
  GoRoute(
    path: CorporateRoutes.ceoDashboard,
    builder: (context, state) => const CeoDashboardView(),
  ),
  GoRoute(
    path: CorporateRoutes.cooDashboard,
    builder: (context, state) => const CooDashboardView(),
  ),
  GoRoute(
    path: CorporateRoutes.cfoDashboard,
    builder: (context, state) => const CfoDashboardView(),
  ),
  GoRoute(
    path: CorporateRoutes.ctoDashboard,
    builder: (context, state) => const CtoDashboardView(),
  ),
  GoRoute(
    path: CorporateRoutes.ctoVerificationHub,
    builder: (context, state) => const VerificationHubView(),
  ),

  // Fallback for role-based dynamic routes
  GoRoute(
    path: '/offices/:officeId/roles/:role/dashboard',
    builder: (context, state) {
      final role = state.pathParameters['role'] ?? 'guest';
      switch (role.toLowerCase()) {
        case 'ceo': return const CeoDashboardView();
        case 'coo': return const CooDashboardView();
        case 'cfo': return const CfoDashboardView();
        case 'cto': return const CtoDashboardView();
        default: return ErrorState(message: 'Unknown role: $role');
      }
    },
  ),
];

