import 'package:go_router/go_router.dart';
import 'package:flutter_core/flutter_core.dart';
import 'package:primecare_ui/primecare_ui.dart';

final List<RouteBase> clinicRoutes = [
  // --- Dashboards by Role ---
  GoRoute(
    path: CorporateRoutes.ceoDashboard,
    builder: (context, state) => const DemoDashboardScreen(),
  ),
  GoRoute(
    path: CorporateRoutes.headOfBusDevDashboard,
    builder: (context, state) => const DemoDashboardScreen(),
  ),
  GoRoute(
    path: FranchiseRoutes.franchiseOwnerDashboard,
    builder: (context, state) => const DemoDashboardScreen(),
  ),
  GoRoute(
    path: FranchiseRoutes.billingAdminDashboard,
    builder: (context, state) => const DemoDashboardScreen(),
  ),
  GoRoute(
    path: SupportRoutes.customerSupportDashboard,
    builder: (context, state) => const DemoDashboardScreen(),
  ),
  GoRoute(
    path: CommonRoutes.clinicDashboard,
    builder: (context, state) => const DemoDashboardScreen(),
  ),
  GoRoute(
    path: CorporateRoutes.complianceManagerDashboard,
    builder: (context, state) => const DemoDashboardScreen(),
  ),

  // --- Sub-Screens ---
  GoRoute(
    path: CommonRoutes.clinicClientProfile,
    builder: (context, state) => const DemoDashboardScreen(),
  ),
  GoRoute(
    path: CommonRoutes.clinicCarePlan,
    builder: (context, state) => const DemoDashboardScreen(),
  ),
  GoRoute(
    path: CommonRoutes.clinicHistoryLogs,
    builder: (context, state) => const DemoDashboardScreen(),
  ),
  GoRoute(
    path: CommonRoutes.clinicProfileSettings,
    builder: (context, state) => const DemoDashboardScreen(),
  ),
  GoRoute(
    path: CommonRoutes.clinicMessaging,
    builder: (context, state) => const DemoDashboardScreen(),
  ),
  GoRoute(
    path: CommonRoutes.clinicIncidentReport,
    builder: (context, state) => const DemoDashboardScreen(),
  ),
  GoRoute(
    path: CommonRoutes.clinicCheckInOut,
    builder: (context, state) => const DemoDashboardScreen(),
  ),
  GoRoute(
    path: CommonRoutes.clinicDailyNotes,
    builder: (context, state) => const DemoDashboardScreen(),
  ),
  GoRoute(
    path: CommonRoutes.clinicShiftDetails,
    builder: (context, state) => const DemoDashboardScreen(),
  ),
  GoRoute(
    path: CommonRoutes.clinicMyShifts,
    builder: (context, state) => const DemoDashboardScreen(),
  ),
];
