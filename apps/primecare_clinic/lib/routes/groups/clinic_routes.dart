import 'package:go_router/go_router.dart';
import 'package:primecare_core/routes/app_routes.dart';

import '../../screens/client_profile.dart';
import '../../screens/care_plan.dart';
import '../../screens/history_logs.dart';
import '../../screens/profile_settings.dart';
import '../../screens/messaging.dart';
import '../../screens/incident_report.dart';
import '../../screens/check_in_out.dart';
import '../../screens/master_app_shell.dart';
import '../../screens/daily_notes.dart';
import '../../screens/shift_details.dart';
import '../../screens/dashboard.dart';
import '../../screens/my_shifts.dart';

final List<RouteBase> clinicRoutes = [
  GoRoute(
    path: AppRoutes.clinicMasterShell,
    builder: (context, state) => const MasterAppShellScreen(),
  ),
  GoRoute(
    path: AppRoutes.clinicDashboard,
    builder: (context, state) => const DashboardScreen(),
  ),
  GoRoute(
    path: AppRoutes.clinicClientProfile,
    builder: (context, state) => const ClientProfileScreen(),
  ),
  GoRoute(
    path: AppRoutes.clinicCarePlan,
    builder: (context, state) => const CarePlanScreen(),
  ),
  GoRoute(
    path: AppRoutes.clinicHistoryLogs,
    builder: (context, state) => const HistoryLogsScreen(),
  ),
  GoRoute(
    path: AppRoutes.clinicProfileSettings,
    builder: (context, state) => const ProfileSettingsScreen(),
  ),
  GoRoute(
    path: AppRoutes.clinicMessaging,
    builder: (context, state) => const MessagingScreen(),
  ),
  GoRoute(
    path: AppRoutes.clinicIncidentReport,
    builder: (context, state) => const IncidentReportScreen(),
  ),
  GoRoute(
    path: AppRoutes.clinicCheckInOut,
    builder: (context, state) => const CheckInOutScreen(),
  ),
  GoRoute(
    path: AppRoutes.clinicDailyNotes,
    builder: (context, state) => const DailyNotesScreen(),
  ),
  GoRoute(
    path: AppRoutes.clinicShiftDetails,
    builder: (context, state) => const ShiftDetailsScreen(),
  ),
  GoRoute(
    path: AppRoutes.clinicMyShifts,
    builder: (context, state) => const MyShiftsScreen(),
  )
];
