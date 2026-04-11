import 'package:flutter_ui/flutter_ui.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_core/flutter_core.dart';

final List<RouteBase> supportRoutes = [
  GoRoute(
    path: SupportRoutes.customerSupportTickets,
    builder: (context, state) => const CustomerSupportTicketsScreen(),
  ),
  GoRoute(
    path: SupportRoutes.customerSupportEscalations,
    builder: (context, state) => const CustomerSupportEscalationsScreen(),
  ),
  GoRoute(
    path: SupportRoutes.customerSupportIssueCategories,
    builder: (context, state) => const CustomerSupportIssueCategoriesScreen(),
  ),
  GoRoute(
    path: SupportRoutes.customerSupportTemplates,
    builder: (context, state) => const CustomerSupportTemplatesScreen(),
  ),
  GoRoute(
    path: SupportRoutes.customerSupportReports,
    builder: (context, state) => const CustomerSupportReportsScreen(),
  ),
  GoRoute(
    path: SupportRoutes.intakeCoordinatorNewIntakes,
    builder: (context, state) => const IntakeCoordinatorNewIntakesScreen(),
  ),
  GoRoute(
    path: SupportRoutes.intakeCoordinatorIntakeForms,
    builder: (context, state) => const IntakeCoordinatorIntakeFormsScreen(),
  ),
  GoRoute(
    path: SupportRoutes.intakeCoordinatorEligibility,
    builder: (context, state) => const IntakeCoordinatorEligibilityScreen(),
  ),
  GoRoute(
    path: SupportRoutes.intakeCoordinatorScheduling,
    builder: (context, state) => const IntakeCoordinatorSchedulingScreen(),
  ),
  GoRoute(
    path: SupportRoutes.intakeCoordinatorClientAssignment,
    builder: (context, state) =>
        const IntakeCoordinatorClientAssignmentScreen(),
  ),
  GoRoute(
    path: SupportRoutes.qualityAssuranceAudits,
    builder: (context, state) => const QualityAssuranceAuditsScreen(),
  ),
  GoRoute(
    path: SupportRoutes.qualityAssuranceReviews,
    builder: (context, state) => const QualityAssuranceReviewsScreen(),
  ),
  GoRoute(
    path: SupportRoutes.qualityAssuranceComplaints,
    builder: (context, state) => const QualityAssuranceComplaintsScreen(),
  ),
  GoRoute(
    path: SupportRoutes.qualityAssuranceCorrectiveActions,
    builder: (context, state) =>
        const QualityAssuranceCorrectiveActionsScreen(),
  ),
  GoRoute(
    path: SupportRoutes.qualityAssuranceScorecards,
    builder: (context, state) => const QualityAssuranceScorecardsScreen(),
  ),
  GoRoute(
    path: SupportRoutes.qualityAssuranceComplianceChecks,
    builder: (context, state) => const QualityAssuranceComplianceChecksScreen(),
  ),
  GoRoute(
    path: SupportRoutes.qualityAssuranceReports,
    builder: (context, state) => const QualityAssuranceReportsScreen(),
  ),
  GoRoute(
    path: SupportRoutes.trainingCoordinatorTrainingSchedule,
    builder: (context, state) =>
        const TrainingCoordinatorTrainingScheduleScreen(),
  ),
  GoRoute(
    path: SupportRoutes.trainingCoordinatorCourses,
    builder: (context, state) => const TrainingCoordinatorCoursesScreen(),
  ),
  GoRoute(
    path: SupportRoutes.trainingCoordinatorProgress,
    builder: (context, state) => const TrainingCoordinatorProgressScreen(),
  ),
  GoRoute(
    path: SupportRoutes.trainingCoordinatorWorkshops,
    builder: (context, state) => const TrainingCoordinatorWorkshopsScreen(),
  ),
  GoRoute(
    path: SupportRoutes.trainingCoordinatorAttendance,
    builder: (context, state) => const TrainingCoordinatorAttendanceScreen(),
  ),
  GoRoute(
    path: SupportRoutes.trainingCoordinatorMaterials,
    builder: (context, state) => const TrainingCoordinatorMaterialsScreen(),
  ),
  GoRoute(
    path: SupportRoutes.customerSupportDashboard,
    builder: (context, state) => const CustomerSupportDashboard(),
  ),
  GoRoute(
    path: SupportRoutes.intakeCoordinatorDashboard,
    builder: (context, state) => const IntakeCoordinatorDashboard(),
  ),
  GoRoute(
    path: SupportRoutes.qualityAssuranceDashboard,
    builder: (context, state) => const QualityAssuranceDashboard(),
  ),
  GoRoute(
    path: SupportRoutes.trainingCoordinatorDashboard,
    builder: (context, state) =>
        const TrainingCoordinatorDashboardScreenStitch(),
  ),
];
