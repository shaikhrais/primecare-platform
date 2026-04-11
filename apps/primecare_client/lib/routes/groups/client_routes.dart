import 'package:primecare_ui/primecare_ui.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_core/flutter_core.dart';

final List<RouteBase> clientRoutes = [
  GoRoute(
    path: ClientRoutes.clientBookAppointment,
    builder: (context, state) => const DemoDashboardScreen(),
  ),
  GoRoute(
    path: ClientRoutes.clientMyAppointments,
    builder: (context, state) => const DemoDashboardScreen(),
  ),
  GoRoute(
    path: ClientRoutes.clientCareTeam,
    builder: (context, state) => const DemoDashboardScreen(),
  ),
  GoRoute(
    path: ClientRoutes.clientTreatmentHistory,
    builder: (context, state) => const DemoDashboardScreen(),
  ),
  GoRoute(
    path: ClientRoutes.clientPayments,
    builder: (context, state) => const DemoDashboardScreen(),
  ),
  GoRoute(
    path: ClientRoutes.clientProfile,
    builder: (context, state) => const DemoDashboardScreen(),
  ),
  GoRoute(
    path: ClientRoutes.familyMemberLovedOneSchedule,
    builder: (context, state) => const DemoDashboardScreen(),
  ),
  GoRoute(
    path: ClientRoutes.familyMemberCareUpdates,
    builder: (context, state) => const DemoDashboardScreen(),
  ),
  GoRoute(
    path: ClientRoutes.familyMemberBilling,
    builder: (context, state) => const DemoDashboardScreen(),
  ),
  GoRoute(
    path: ClientRoutes.familyMemberEmergencyContacts,
    builder: (context, state) => const DemoDashboardScreen(),
  ),
  GoRoute(
    path: ClientRoutes.familyMemberProfile,
    builder: (context, state) => const DemoDashboardScreen(),
  ),
  GoRoute(
    path: ClientRoutes.patientDashboard,
    builder: (context, state) => const DemoDashboardScreen(),
  ),
  GoRoute(
    path: ClientRoutes.familyMemberDashboard,
    builder: (context, state) => const DemoDashboardScreen(),
  ),
];
