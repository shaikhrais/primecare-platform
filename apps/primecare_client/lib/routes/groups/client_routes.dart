import 'package:flutter_ui/flutter_ui.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_core/flutter_core.dart';

final List<RouteBase> clientRoutes = [
  GoRoute(
    path: ClientRoutes.clientBookAppointment,
    builder: (context, state) => const ClientBookAppointmentScreen(),
  ),
  GoRoute(
    path: ClientRoutes.clientMyAppointments,
    builder: (context, state) => const ClientMyAppointmentsScreen(),
  ),
  GoRoute(
    path: ClientRoutes.clientCareTeam,
    builder: (context, state) => const ClientCareTeamScreen(),
  ),
  GoRoute(
    path: ClientRoutes.clientTreatmentHistory,
    builder: (context, state) => const ClientTreatmentHistoryScreen(),
  ),
  GoRoute(
    path: ClientRoutes.clientPayments,
    builder: (context, state) => const ClientPaymentsScreenStitch(),
  ),
  GoRoute(
    path: ClientRoutes.clientProfile,
    builder: (context, state) => const ClientProfileScreenStitch(),
  ),
  GoRoute(
    path: ClientRoutes.familyMemberLovedOneSchedule,
    builder: (context, state) => const FamilyMemberLovedOneScheduleScreen(),
  ),
  GoRoute(
    path: ClientRoutes.familyMemberCareUpdates,
    builder: (context, state) => const FamilyMemberCareUpdatesScreen(),
  ),
  GoRoute(
    path: ClientRoutes.familyMemberBilling,
    builder: (context, state) => const FamilyMemberBillingScreen(),
  ),
  GoRoute(
    path: ClientRoutes.familyMemberEmergencyContacts,
    builder: (context, state) => const FamilyMemberEmergencyContactsScreen(),
  ),
  GoRoute(
    path: ClientRoutes.familyMemberProfile,
    builder: (context, state) => const FamilyMemberProfileScreen(),
  ),
  GoRoute(
    path: ClientRoutes.patientDashboard,
    builder: (context, state) => const PatientDashboard(),
  ),
  GoRoute(
    path: ClientRoutes.familyMemberDashboard,
    builder: (context, state) => const FamilyMemberDashboard(),
  ),
];
