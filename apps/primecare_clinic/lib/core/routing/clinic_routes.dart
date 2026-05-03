import 'package:primecare_ui/primecare_ui.dart';
import 'package:go_router/go_router.dart';
import '../../features/clinic_operations/clinic_operations_view.dart';

// InstitutionalSchedulerScreen and SystemVerificationDashboardScreen should also be moved to the MVC structure eventually.
// For now, I'll keep them as imports if they exist.
// import '../../features/institutional_scheduler/institutional_scheduler_view.dart'; 
// import '../../features/system_verification/system_verification_view.dart';

class ScreenConfig {
  final String routePath;
  final String titleKey;
  final String subtitleKey;
  final Widget view;

  const ScreenConfig({
    required this.routePath,
    required this.titleKey,
    required this.subtitleKey,
    required this.view,
  });
}

final List<ScreenConfig> clinicScreenRegistry = [
  const ScreenConfig(
    routePath: CommonRoutes.clinicDashboard,
    titleKey: 'Clinical Intelligence',
    subtitleKey: 'High-fidelity operations and risk surveillance.',
    view: ClinicOperationsView(),
  ),
  const ScreenConfig(
    routePath: CommonRoutes.clinicClientProfile,
    titleKey: 'Clinic Client Profile',
    subtitleKey: 'View and manage client details.',
    view: ClientProfileView(),
  ),
  const ScreenConfig(
    routePath: CommonRoutes.clinicCarePlan,
    titleKey: 'Clinic Care Plan',
    subtitleKey: 'Review and update client care plans.',
    view: CarePlanView(),
  ),
  const ScreenConfig(
    routePath: CommonRoutes.clinicHistoryLogs,
    titleKey: 'Clinic History Logs',
    subtitleKey: 'Audit logs and past interactions.',
    view: HistoryLogsView(),
  ),
  const ScreenConfig(
    routePath: CommonRoutes.clinicProfileSettings,
    titleKey: 'Clinic Profile Settings',
    subtitleKey: 'Manage user preferences.',
    view: ProfileSettingsView(),
  ),
  const ScreenConfig(
    routePath: CommonRoutes.clinicMessaging,
    titleKey: 'Clinic Messaging',
    subtitleKey: 'Secure communications.',
    view: MessagingView(),
  ),
  const ScreenConfig(
    routePath: CommonRoutes.clinicIncidentReport,
    titleKey: 'Clinic Incident Report',
    subtitleKey: 'File reports for any incidents.',
    view: IncidentReportView(),
  ),
  const ScreenConfig(
    routePath: CommonRoutes.clinicCheckInOut,
    titleKey: 'Clinic Check In Out',
    subtitleKey: 'Log time and attendance.',
    view: CheckInOutView(),
  ),
  const ScreenConfig(
    routePath: CommonRoutes.clinicDailyNotes,
    titleKey: 'Clinic Daily Notes',
    subtitleKey: 'Document daily observations.',
    view: DailyNotesView(),
  ),
  const ScreenConfig(
    routePath: CommonRoutes.clinicShiftDetails,
    titleKey: 'Clinic Shift Details',
    subtitleKey: 'View upcoming and active shifts.',
    view: ShiftDetailsView(),
  ),
  const ScreenConfig(
    routePath: CommonRoutes.clinicMyShifts,
    titleKey: 'Clinic My Shifts',
    subtitleKey: 'Manage your assigned shifts.',
    view: MyShiftsView(),
  ),
];

final List<RouteBase> clinicRoutes = [
  ...clinicScreenRegistry.map((config) => GoRoute(
        path: config.routePath,
        builder: (context, state) => config.view,
      )),
  // Note: These screens below still need consolidation into their own 3-file MVCs
  GoRoute(
    path: CommonRoutes.institutionalScheduler,
    builder: (context, state) => const Placeholder(),
  ),
  GoRoute(
    path: '/offices/system-verification',
    builder: (context, state) => const Placeholder(),
  ),
];

