import 'package:flutter_ui/flutter_ui.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_core/routes/app_routes.dart';
import 'package:flutter_ui/src/components/generic_feature_screen.dart';
































final List<RouteBase> supportRoutes = [
  GoRoute(
    path: AppRoutes.customerSupportTickets,
    builder: (context, state) => const CustomerSupportTicketsScreen(),
  ),
  GoRoute(
    path: AppRoutes.customerSupportEscalations,
    builder: (context, state) => const CustomerSupportEscalationsScreen(),
  ),
  GoRoute(
    path: AppRoutes.customerSupportIssueCategories,
    builder: (context, state) => const CustomerSupportIssueCategoriesScreen(),
  ),
  GoRoute(
    path: AppRoutes.customerSupportTemplates,
    builder: (context, state) => const CustomerSupportTemplatesScreen(),
  ),
  GoRoute(
    path: AppRoutes.customerSupportReports,
    builder: (context, state) => const CustomerSupportReportsScreen(),
  ),
  GoRoute(
    path: AppRoutes.intakeCoordinatorNewIntakes,
    builder: (context, state) => const IntakeCoordinatorNewIntakesScreen(),
  ),
  GoRoute(
    path: AppRoutes.intakeCoordinatorIntakeForms,
    builder: (context, state) => const IntakeCoordinatorIntakeFormsScreen(),
  ),
  GoRoute(
    path: AppRoutes.intakeCoordinatorEligibility,
    builder: (context, state) => const IntakeCoordinatorEligibilityScreen(),
  ),
  GoRoute(
    path: AppRoutes.intakeCoordinatorScheduling,
    builder: (context, state) => const IntakeCoordinatorSchedulingScreen(),
  ),
  GoRoute(
    path: AppRoutes.intakeCoordinatorClientAssignment,
    builder: (context, state) => const IntakeCoordinatorClientAssignmentScreen(),
  ),
  GoRoute(
    path: AppRoutes.qualityAssuranceAudits,
    builder: (context, state) => const QualityAssuranceAuditsScreen(),
  ),
  GoRoute(
    path: AppRoutes.qualityAssuranceReviews,
    builder: (context, state) => const QualityAssuranceReviewsScreen(),
  ),
  GoRoute(
    path: AppRoutes.qualityAssuranceComplaints,
    builder: (context, state) => const QualityAssuranceComplaintsScreen(),
  ),
  GoRoute(
    path: AppRoutes.qualityAssuranceCorrectiveActions,
    builder: (context, state) => const QualityAssuranceCorrectiveActionsScreen(),
  ),
  GoRoute(
    path: AppRoutes.qualityAssuranceScorecards,
    builder: (context, state) => const QualityAssuranceScorecardsScreen(),
  ),
  GoRoute(
    path: AppRoutes.qualityAssuranceComplianceChecks,
    builder: (context, state) => const QualityAssuranceComplianceChecksScreen(),
  ),
  GoRoute(
    path: AppRoutes.qualityAssuranceReports,
    builder: (context, state) => const QualityAssuranceReportsScreen(),
  ),
  GoRoute(
    path: AppRoutes.trainingCoordinatorTrainingSchedule,
    builder: (context, state) => const TrainingCoordinatorTrainingScheduleScreen(),
  ),
  GoRoute(
    path: AppRoutes.trainingCoordinatorCourses,
    builder: (context, state) => const TrainingCoordinatorCoursesScreen(),
  ),
  GoRoute(
    path: AppRoutes.trainingCoordinatorProgress,
    builder: (context, state) => const TrainingCoordinatorProgressScreen(),
  ),
  GoRoute(
    path: AppRoutes.trainingCoordinatorWorkshops,
    builder: (context, state) => const TrainingCoordinatorWorkshopsScreen(),
  ),
  GoRoute(
    path: AppRoutes.trainingCoordinatorAttendance,
    builder: (context, state) => const TrainingCoordinatorAttendanceScreen(),
  ),
  GoRoute(
    path: AppRoutes.trainingCoordinatorMaterials,
    builder: (context, state) => const TrainingCoordinatorMaterialsScreen(),
  ),
  GoRoute(
    path: AppRoutes.customerSupportDashboard,
    builder: (context, state) => const CustomerSupportDashboard(),
  ),
  GoRoute(
    path: AppRoutes.intakeCoordinatorDashboard,
    builder: (context, state) => const IntakeCoordinatorDashboard(),
  ),
  GoRoute(
    path: AppRoutes.qualityAssuranceDashboard,
    builder: (context, state) => const QualityAssuranceDashboard(),
  ),
  GoRoute(
    path: AppRoutes.trainingCoordinatorDashboard,
    builder: (context, state) => const TrainingCoordinatorDashboardScreenStitch(),
  ),
];
