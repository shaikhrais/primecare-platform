import 'package:primecare_ui/primecare_ui.dart';
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

final List<ScreenConfig> supportScreenRegistry = [
  ScreenConfig(
    routePath: SupportRoutes.customerSupportTickets,
    titleKey: 'Customer Support Tickets',
    subtitleKey: 'Real-time overview fetched natively via API.',
    providerId: 'customerSupportTickets',
  ),
  ScreenConfig(
    routePath: SupportRoutes.customerSupportEscalations,
    titleKey: 'Customer Support Escalations',
    subtitleKey: 'Real-time overview fetched natively via API.',
    providerId: 'customerSupportEscalations',
  ),
  ScreenConfig(
    routePath: SupportRoutes.customerSupportIssueCategories,
    titleKey: 'Customer Support Issue Categories',
    subtitleKey: 'Real-time overview fetched natively via API.',
    providerId: 'customerSupportIssueCategories',
  ),
  ScreenConfig(
    routePath: SupportRoutes.customerSupportTemplates,
    titleKey: 'Customer Support Templates',
    subtitleKey: 'Real-time overview fetched natively via API.',
    providerId: 'customerSupportTemplates',
  ),
  ScreenConfig(
    routePath: SupportRoutes.customerSupportReports,
    titleKey: 'Customer Support Reports',
    subtitleKey: 'Real-time overview fetched natively via API.',
    providerId: 'customerSupportReports',
  ),
  ScreenConfig(
    routePath: SupportRoutes.intakeCoordinatorNewIntakes,
    titleKey: 'Intake Coordinator New Intakes',
    subtitleKey: 'Real-time overview fetched natively via API.',
    providerId: 'intakeCoordinatorNewIntakes',
  ),
  ScreenConfig(
    routePath: SupportRoutes.intakeCoordinatorIntakeForms,
    titleKey: 'Intake Coordinator Intake Forms',
    subtitleKey: 'Real-time overview fetched natively via API.',
    providerId: 'intakeCoordinatorIntakeForms',
  ),
  ScreenConfig(
    routePath: SupportRoutes.intakeCoordinatorEligibility,
    titleKey: 'Intake Coordinator Eligibility',
    subtitleKey: 'Real-time overview fetched natively via API.',
    providerId: 'intakeCoordinatorEligibility',
  ),
  ScreenConfig(
    routePath: SupportRoutes.intakeCoordinatorScheduling,
    titleKey: 'Intake Coordinator Scheduling',
    subtitleKey: 'Real-time overview fetched natively via API.',
    providerId: 'intakeCoordinatorScheduling',
  ),
  ScreenConfig(
    routePath: SupportRoutes.intakeCoordinatorClientAssignment,
    titleKey: 'Intake Coordinator Client Assignment',
    subtitleKey: 'Real-time overview fetched natively via API.',
    providerId: 'intakeCoordinatorClientAssignment',
  ),
  ScreenConfig(
    routePath: SupportRoutes.qualityAssuranceAudits,
    titleKey: 'Quality Assurance Audits',
    subtitleKey: 'Real-time overview fetched natively via API.',
    providerId: 'qualityAssuranceAudits',
  ),
  ScreenConfig(
    routePath: SupportRoutes.qualityAssuranceReviews,
    titleKey: 'Quality Assurance Reviews',
    subtitleKey: 'Real-time overview fetched natively via API.',
    providerId: 'qualityAssuranceReviews',
  ),
  ScreenConfig(
    routePath: SupportRoutes.qualityAssuranceComplaints,
    titleKey: 'Quality Assurance Complaints',
    subtitleKey: 'Real-time overview fetched natively via API.',
    providerId: 'qualityAssuranceComplaints',
  ),
  ScreenConfig(
    routePath: SupportRoutes.qualityAssuranceCorrectiveActions,
    titleKey: 'Quality Assurance Corrective Actions',
    subtitleKey: 'Real-time overview fetched natively via API.',
    providerId: 'qualityAssuranceCorrectiveActions',
  ),
  ScreenConfig(
    routePath: SupportRoutes.qualityAssuranceScorecards,
    titleKey: 'Quality Assurance Scorecards',
    subtitleKey: 'Real-time overview fetched natively via API.',
    providerId: 'qualityAssuranceScorecards',
  ),
  ScreenConfig(
    routePath: SupportRoutes.qualityAssuranceComplianceChecks,
    titleKey: 'Quality Assurance Compliance Checks',
    subtitleKey: 'Real-time overview fetched natively via API.',
    providerId: 'qualityAssuranceComplianceChecks',
  ),
  ScreenConfig(
    routePath: SupportRoutes.qualityAssuranceReports,
    titleKey: 'Quality Assurance Reports',
    subtitleKey: 'Real-time overview fetched natively via API.',
    providerId: 'qualityAssuranceReports',
  ),
  ScreenConfig(
    routePath: SupportRoutes.trainingCoordinatorTrainingSchedule,
    titleKey: 'Training Coordinator Training Schedule',
    subtitleKey: 'Real-time overview fetched natively via API.',
    providerId: 'trainingCoordinatorTrainingSchedule',
  ),
  ScreenConfig(
    routePath: SupportRoutes.trainingCoordinatorCourses,
    titleKey: 'Training Coordinator Courses',
    subtitleKey: 'Real-time overview fetched natively via API.',
    providerId: 'trainingCoordinatorCourses',
  ),
  ScreenConfig(
    routePath: SupportRoutes.trainingCoordinatorProgress,
    titleKey: 'Training Coordinator Progress',
    subtitleKey: 'Real-time overview fetched natively via API.',
    providerId: 'trainingCoordinatorProgress',
  ),
  ScreenConfig(
    routePath: SupportRoutes.trainingCoordinatorWorkshops,
    titleKey: 'Training Coordinator Workshops',
    subtitleKey: 'Real-time overview fetched natively via API.',
    providerId: 'trainingCoordinatorWorkshops',
  ),
  ScreenConfig(
    routePath: SupportRoutes.trainingCoordinatorAttendance,
    titleKey: 'Training Coordinator Attendance',
    subtitleKey: 'Real-time overview fetched natively via API.',
    providerId: 'trainingCoordinatorAttendance',
  ),
  ScreenConfig(
    routePath: SupportRoutes.trainingCoordinatorMaterials,
    titleKey: 'Training Coordinator Materials',
    subtitleKey: 'Real-time overview fetched natively via API.',
    providerId: 'trainingCoordinatorMaterials',
  ),
  ScreenConfig(
    routePath: SupportRoutes.customerSupportDashboard,
    titleKey: 'Customer Support Dashboard',
    subtitleKey: 'Real-time overview fetched natively via API.',
    providerId: 'customerSupportDashboard',
  ),
  ScreenConfig(
    routePath: SupportRoutes.intakeCoordinatorDashboard,
    titleKey: 'Intake Coordinator Dashboard',
    subtitleKey: 'Real-time overview fetched natively via API.',
    providerId: 'intakeCoordinatorDashboard',
  ),
  ScreenConfig(
    routePath: SupportRoutes.qualityAssuranceDashboard,
    titleKey: 'Quality Assurance Dashboard',
    subtitleKey: 'Real-time overview fetched natively via API.',
    providerId: 'qualityAssuranceDashboard',
  ),
  ScreenConfig(
    routePath: SupportRoutes.trainingCoordinatorDashboard,
    titleKey: 'Training Coordinator Dashboard',
    subtitleKey: 'Real-time overview fetched natively via API.',
    providerId: 'trainingCoordinatorDashboard',
  ),
];

final List<RouteBase> supportRoutes = supportScreenRegistry.map((config) {
  return GoRoute(
    path: config.routePath,
    builder: (context, state) => PageTemplate.orchestrate(
      title: config.titleKey,
      subtitle: config.subtitleKey,
      provider: genericDashboardProvider(config.providerId),
    ),
  );
}).toList();
