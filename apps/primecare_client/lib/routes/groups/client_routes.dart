import 'package:go_router/go_router.dart';
import 'package:primecare_core/routes/app_routes.dart';
import 'package:primecare_ui/src/components/generic_feature_screen.dart';

import '../../offices/client/roles/client/client_dashboard.dart'
    as patient_dash;
import '../../offices/client/roles/client/book_appointment.dart'
    as client_book_appointment;
import '../../offices/client/roles/client/my_appointments.dart'
    as client_my_appointments;
import '../../offices/client/roles/client/care_team.dart' as client_care_team;
import '../../offices/client/roles/client/treatment_history.dart'
    as client_treatment_history;
import '../../offices/client/roles/client/payments.dart' as client_payments;
import '../../offices/client/roles/client/profile.dart' as client_profile;
import '../../offices/client/roles/family_member/loved_one_schedule.dart'
    as family_member_loved_one_schedule;
import '../../offices/client/roles/family_member/care_updates.dart'
    as family_member_care_updates;
import '../../offices/client/roles/family_member/billing.dart'
    as family_member_billing;
import '../../offices/client/roles/family_member/emergency_contacts.dart'
    as family_member_emergency_contacts;
import '../../offices/client/roles/family_member/profile.dart'
    as family_member_profile;
import '../../offices/client/roles/family_member/family_dashboard.dart'
    as family_member_dash;

final List<RouteBase> clientRoutes = [
  GoRoute(
    path: AppRoutes.clientBookAppointment,
    builder: (context, state) =>
        const client_book_appointment.BookAppointmentView(),
  ),
  GoRoute(
    path: AppRoutes.clientMyAppointments,
    builder: (context, state) =>
        const client_my_appointments.MyAppointmentsScreen(),
  ),
  GoRoute(
    path: AppRoutes.clientCareTeam,
    builder: (context, state) => const client_care_team.CareTeamView(),
  ),
  GoRoute(
    path: AppRoutes.clientTreatmentHistory,
    builder: (context, state) =>
        const client_treatment_history.TreatmentHistoryScreen(),
  ),
  GoRoute(
    path: AppRoutes.clientPayments,
    builder: (context, state) => const client_payments.ClientPaymentsScreen(),
  ),
  GoRoute(
    path: AppRoutes.clientProfile,
    builder: (context, state) => const client_profile.ProfileScreen(),
  ),
  GoRoute(
    path: AppRoutes.familyMemberLovedOneSchedule,
    builder: (context, state) =>
        const family_member_loved_one_schedule.LovedOneScheduleScreen(),
  ),
  GoRoute(
    path: AppRoutes.familyMemberCareUpdates,
    builder: (context, state) =>
        const family_member_care_updates.CareUpdatesView(),
  ),
  GoRoute(
    path: AppRoutes.familyMemberBilling,
    builder: (context, state) => const family_member_billing.BillingScreen(),
  ),
  GoRoute(
    path: AppRoutes.familyMemberEmergencyContacts,
    builder: (context, state) =>
        const family_member_emergency_contacts.EmergencyContactsScreen(),
  ),
  GoRoute(
    path: AppRoutes.familyMemberProfile,
    builder: (context, state) => const family_member_profile.ProfileScreen(),
  ),
  GoRoute(
    path: AppRoutes.patientDashboard,
    builder: (context, state) => const patient_dash.ClientDashboardScreen(),
  ),
  GoRoute(
    path: AppRoutes.familyMemberDashboard,
    builder: (context, state) =>
        const family_member_dash.FamilyDashboardScreen(),
  ),
];
