import 'package:primecare_ui/primecare_ui.dart';
import 'package:go_router/go_router.dart';

class ScreenConfig {
  final String routePath;
  final String titleKey;
  final String subtitleKey;

  const ScreenConfig({
    required this.routePath,
    required this.titleKey,
    required this.subtitleKey,
  });
}

final List<ScreenConfig> clinicScreenRegistry = [
  const ScreenConfig(
    routePath: CommonRoutes.clinicDashboard,
    titleKey: 'Clinical Intelligence',
    subtitleKey: 'High-fidelity operations and risk surveillance.',
  ),
  const ScreenConfig(
    routePath: CommonRoutes.clinicClientProfile,
    titleKey: 'Clinic Client Profile',
    subtitleKey: 'View and manage client details.',
  ),
  const ScreenConfig(
    routePath: CommonRoutes.clinicCarePlan,
    titleKey: 'Clinic Care Plan',
    subtitleKey: 'Review and update client care plans.',
  ),
  const ScreenConfig(
    routePath: CommonRoutes.clinicHistoryLogs,
    titleKey: 'Clinic History Logs',
    subtitleKey: 'Audit logs and past interactions.',
  ),
  const ScreenConfig(
    routePath: CommonRoutes.clinicProfileSettings,
    titleKey: 'Clinic Profile Settings',
    subtitleKey: 'Manage user preferences.',
  ),
  const ScreenConfig(
    routePath: CommonRoutes.clinicMessaging,
    titleKey: 'Clinic Messaging',
    subtitleKey: 'Secure communications.',
  ),
  const ScreenConfig(
    routePath: CommonRoutes.clinicIncidentReport,
    titleKey: 'Clinic Incident Report',
    subtitleKey: 'File reports for any incidents.',
  ),
  const ScreenConfig(
    routePath: CommonRoutes.clinicCheckInOut,
    titleKey: 'Clinic Check In Out',
    subtitleKey: 'Log time and attendance.',
  ),
  const ScreenConfig(
    routePath: CommonRoutes.clinicDailyNotes,
    titleKey: 'Clinic Daily Notes',
    subtitleKey: 'Document daily observations.',
  ),
  const ScreenConfig(
    routePath: CommonRoutes.clinicShiftDetails,
    titleKey: 'Clinic Shift Details',
    subtitleKey: 'View upcoming and active shifts.',
  ),
  const ScreenConfig(
    routePath: CommonRoutes.clinicMyShifts,
    titleKey: 'Clinic My Shifts',
    subtitleKey: 'Manage your assigned shifts.',
  ),
];

final List<RouteBase> clinicRoutes = [
  ...clinicScreenRegistry.map(
    (config) => GoRoute(
      path: config.routePath,
      builder: (context, state) => Scaffold(
        body: Center(
          child: Text('Not Implemented: ${config.titleKey}'),
        ),
      ),
    ),
  ),
  GoRoute(
    path: CommonRoutes.institutionalScheduler,
    builder: (context, state) => const Scaffold(
      body: Center(
        child: Text('Not Implemented: Institutional Scheduler'),
      ),
    ),
  ),
  GoRoute(
    path: '/offices/system-verification',
    builder: (context, state) => const Scaffold(
      body: Center(
        child: Text('Not Implemented: System Verification'),
      ),
    ),
  ),
  GoRoute(
    path: ClinicalRoutes.pswDashboard,
    builder: (context, state) => const Scaffold(
      body: Center(
        child: Text('Not Implemented: PSW Dashboard'),
      ),
    ),
  ),
];
