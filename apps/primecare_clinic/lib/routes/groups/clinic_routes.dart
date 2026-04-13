import 'package:primecare_ui/primecare_ui.dart';
import 'package:go_router/go_router.dart';
import 'package:primecare_core/flutter_core.dart';

class ScreenConfig {
  final String routePath;
  final String titleKey;
  final String subtitleKey;
  final String providerId;

  const ScreenConfig({
    required this.routePath,
    required this.titleKey,
    required this.subtitleKey,
    required this.providerId,
  });
}

final List<ScreenConfig> clinicScreenRegistry = [
  ScreenConfig(
    routePath: CorporateRoutes.ceoDashboard,
    titleKey: 'Ceo Dashboard',
    subtitleKey: 'Real-time overview fetched natively via API.',
    providerId: 'ceoDashboard',
  ),
  ScreenConfig(
    routePath: CorporateRoutes.headOfBusDevDashboard,
    titleKey: 'Head Of Bus Dev Dashboard',
    subtitleKey: 'Real-time overview fetched natively via API.',
    providerId: 'headOfBusDevDashboard',
  ),
  ScreenConfig(
    routePath: FranchiseRoutes.franchiseOwnerDashboard,
    titleKey: 'Franchise Owner Dashboard',
    subtitleKey: 'Real-time overview fetched natively via API.',
    providerId: 'franchiseOwnerDashboard',
  ),
  ScreenConfig(
    routePath: FranchiseRoutes.billingAdminDashboard,
    titleKey: 'Billing Admin Dashboard',
    subtitleKey: 'Real-time overview fetched natively via API.',
    providerId: 'billingAdminDashboard',
  ),
  ScreenConfig(
    routePath: SupportRoutes.customerSupportDashboard,
    titleKey: 'Customer Support Dashboard',
    subtitleKey: 'Real-time overview fetched natively via API.',
    providerId: 'customerSupportDashboard',
  ),
  ScreenConfig(
    routePath: CommonRoutes.clinicDashboard,
    titleKey: 'Clinic Dashboard',
    subtitleKey: 'Real-time overview fetched natively via API.',
    providerId: 'clinicDashboard',
  ),
  ScreenConfig(
    routePath: CorporateRoutes.complianceManagerDashboard,
    titleKey: 'Compliance Manager Dashboard',
    subtitleKey: 'Real-time overview fetched natively via API.',
    providerId: 'complianceManagerDashboard',
  ),
  ScreenConfig(
    routePath: CommonRoutes.clinicClientProfile,
    titleKey: 'Clinic Client Profile',
    subtitleKey: 'Real-time overview fetched natively via API.',
    providerId: 'clinicClientProfile',
  ),
  ScreenConfig(
    routePath: CommonRoutes.clinicCarePlan,
    titleKey: 'Clinic Care Plan',
    subtitleKey: 'Real-time overview fetched natively via API.',
    providerId: 'clinicCarePlan',
  ),
  ScreenConfig(
    routePath: CommonRoutes.clinicHistoryLogs,
    titleKey: 'Clinic History Logs',
    subtitleKey: 'Real-time overview fetched natively via API.',
    providerId: 'clinicHistoryLogs',
  ),
  ScreenConfig(
    routePath: CommonRoutes.clinicProfileSettings,
    titleKey: 'Clinic Profile Settings',
    subtitleKey: 'Real-time overview fetched natively via API.',
    providerId: 'clinicProfileSettings',
  ),
  ScreenConfig(
    routePath: CommonRoutes.clinicMessaging,
    titleKey: 'Clinic Messaging',
    subtitleKey: 'Real-time overview fetched natively via API.',
    providerId: 'clinicMessaging',
  ),
  ScreenConfig(
    routePath: CommonRoutes.clinicIncidentReport,
    titleKey: 'Clinic Incident Report',
    subtitleKey: 'Real-time overview fetched natively via API.',
    providerId: 'clinicIncidentReport',
  ),
  ScreenConfig(
    routePath: CommonRoutes.clinicCheckInOut,
    titleKey: 'Clinic Check In Out',
    subtitleKey: 'Real-time overview fetched natively via API.',
    providerId: 'clinicCheckInOut',
  ),
  ScreenConfig(
    routePath: CommonRoutes.clinicDailyNotes,
    titleKey: 'Clinic Daily Notes',
    subtitleKey: 'Real-time overview fetched natively via API.',
    providerId: 'clinicDailyNotes',
  ),
  ScreenConfig(
    routePath: CommonRoutes.clinicShiftDetails,
    titleKey: 'Clinic Shift Details',
    subtitleKey: 'Real-time overview fetched natively via API.',
    providerId: 'clinicShiftDetails',
  ),
  ScreenConfig(
    routePath: CommonRoutes.clinicMyShifts,
    titleKey: 'Clinic My Shifts',
    subtitleKey: 'Real-time overview fetched natively via API.',
    providerId: 'clinicMyShifts',
  ),
];

final List<RouteBase> clinicRoutes = clinicScreenRegistry.map((config) {
  return GoRoute(
    path: config.routePath,
    builder: (context, state) => PageTemplate.orchestrate(
      title: config.titleKey,
      subtitle: config.subtitleKey,
      provider: genericDashboardProvider(config.providerId),
    ),
  );
}).toList();
