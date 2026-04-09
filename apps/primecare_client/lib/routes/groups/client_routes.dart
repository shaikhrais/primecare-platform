import 'package:flutter_ui/primecare_ui.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_core/routes/app_routes.dart';
import 'package:flutter_ui/src/components/generic_feature_screen.dart';















final List<RouteBase> clientRoutes = [
  GoRoute(
    path: AppRoutes.clientBookAppointment,
    builder: (context, state) => const ClientBookAppointmentScreen(),
  ),
  GoRoute(
    path: AppRoutes.clientMyAppointments,
    builder: (context, state) => const ClientMyAppointmentsScreen(),
  ),
  GoRoute(
    path: AppRoutes.clientCareTeam,
    builder: (context, state) => const ClientCareTeamScreen(),
  ),
  GoRoute(
    path: AppRoutes.clientTreatmentHistory,
    builder: (context, state) => const ClientTreatmentHistoryScreen(),
  ),
  GoRoute(
    path: AppRoutes.clientPayments,
    builder: (context, state) => const ClientPaymentsScreenStitch(),
  ),
  GoRoute(
    path: AppRoutes.clientProfile,
    builder: (context, state) => const ClientProfileScreenStitch(),
  ),
  GoRoute(
    path: AppRoutes.familyMemberLovedOneSchedule,
    builder: (context, state) => const FamilyMemberLovedOneScheduleScreen(),
  ),
  GoRoute(
    path: AppRoutes.familyMemberCareUpdates,
    builder: (context, state) => const FamilyMemberCareUpdatesScreen(),
  ),
  GoRoute(
    path: AppRoutes.familyMemberBilling,
    builder: (context, state) => const FamilyMemberBillingScreen(),
  ),
  GoRoute(
    path: AppRoutes.familyMemberEmergencyContacts,
    builder: (context, state) => const FamilyMemberEmergencyContactsScreen(),
  ),
  GoRoute(
    path: AppRoutes.familyMemberProfile,
    builder: (context, state) => const FamilyMemberProfileScreen(),
  ),
  GoRoute(
    path: AppRoutes.patientDashboard,
    builder: (context, state) => const PatientDashboard(),
  ),
  GoRoute(
    path: AppRoutes.familyMemberDashboard,
    builder: (context, state) => const FamilyMemberDashboard(),
  ),
];
