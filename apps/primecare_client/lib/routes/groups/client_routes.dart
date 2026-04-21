import 'package:primecare_ui/00_B_primecare_ui.dart';
import 'package:go_router/go_router.dart';

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

final List<ScreenConfig> clientScreenRegistry = [
  ScreenConfig(
    routePath: ClientRoutes.clientBookAppointment,
    titleKey: 'Client Book Appointment',
    subtitleKey: 'Real-time overview fetched natively via API.',
    providerId: 'clientBookAppointment',
  ),
  ScreenConfig(
    routePath: ClientRoutes.clientMyAppointments,
    titleKey: 'Client My Appointments',
    subtitleKey: 'Real-time overview fetched natively via API.',
    providerId: 'clientMyAppointments',
  ),
  ScreenConfig(
    routePath: ClientRoutes.clientCareTeam,
    titleKey: 'Client Care Team',
    subtitleKey: 'Real-time overview fetched natively via API.',
    providerId: 'clientCareTeam',
  ),
  ScreenConfig(
    routePath: ClientRoutes.clientTreatmentHistory,
    titleKey: 'Client Treatment History',
    subtitleKey: 'Real-time overview fetched natively via API.',
    providerId: 'clientTreatmentHistory',
  ),
  ScreenConfig(
    routePath: ClientRoutes.clientPayments,
    titleKey: 'Client Payments',
    subtitleKey: 'Real-time overview fetched natively via API.',
    providerId: 'clientPayments',
  ),
  ScreenConfig(
    routePath: ClientRoutes.clientProfile,
    titleKey: 'Client Profile',
    subtitleKey: 'Real-time overview fetched natively via API.',
    providerId: 'clientProfile',
  ),
  ScreenConfig(
    routePath: ClientRoutes.familyMemberLovedOneSchedule,
    titleKey: 'Family Member Loved One Schedule',
    subtitleKey: 'Real-time overview fetched natively via API.',
    providerId: 'familyMemberLovedOneSchedule',
  ),
  ScreenConfig(
    routePath: ClientRoutes.familyMemberCareUpdates,
    titleKey: 'Family Member Care Updates',
    subtitleKey: 'Real-time overview fetched natively via API.',
    providerId: 'familyMemberCareUpdates',
  ),
  ScreenConfig(
    routePath: ClientRoutes.familyMemberBilling,
    titleKey: 'Family Member Billing',
    subtitleKey: 'Real-time overview fetched natively via API.',
    providerId: 'familyMemberBilling',
  ),
  ScreenConfig(
    routePath: ClientRoutes.familyMemberEmergencyContacts,
    titleKey: 'Family Member Emergency Contacts',
    subtitleKey: 'Real-time overview fetched natively via API.',
    providerId: 'familyMemberEmergencyContacts',
  ),
  ScreenConfig(
    routePath: ClientRoutes.familyMemberProfile,
    titleKey: 'Family Member Profile',
    subtitleKey: 'Real-time overview fetched natively via API.',
    providerId: 'familyMemberProfile',
  ),
  ScreenConfig(
    routePath: ClientRoutes.patientDashboard,
    titleKey: 'Patient Dashboard',
    subtitleKey: 'Real-time overview fetched natively via API.',
    providerId: 'patientDashboard',
  ),
  ScreenConfig(
    routePath: ClientRoutes.familyMemberDashboard,
    titleKey: 'Family Member Dashboard',
    subtitleKey: 'Real-time overview fetched natively via API.',
    providerId: 'familyMemberDashboard',
  ),
];

final List<RouteBase> clientRoutes = clientScreenRegistry.map((config) {
  return GoRoute(
    path: config.routePath,
    builder: (context, state) => PageTemplate.orchestrate(
      title: config.titleKey,
      subtitle: config.subtitleKey,
      provider: genericDashboardProvider(config.providerId),
    ),
  );
}).toList();
