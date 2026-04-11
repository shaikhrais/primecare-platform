import 'package:primecare_ui/primecare_ui.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_core/flutter_core.dart';

final List<RouteBase> supportRoutes = [
  GoRoute(
    path: SupportRoutes.customerSupportTickets,
    builder: (context, state) => const DemoDashboardScreen(),
  ),
  GoRoute(
    path: SupportRoutes.customerSupportEscalations,
    builder: (context, state) => const DemoDashboardScreen(),
  ),
  GoRoute(
    path: SupportRoutes.customerSupportIssueCategories,
    builder: (context, state) => const DemoDashboardScreen(),
  ),
  GoRoute(
    path: SupportRoutes.customerSupportTemplates,
    builder: (context, state) => const DemoDashboardScreen(),
  ),
  GoRoute(
    path: SupportRoutes.customerSupportReports,
    builder: (context, state) => const DemoDashboardScreen(),
  ),
  GoRoute(
    path: SupportRoutes.intakeCoordinatorNewIntakes,
    builder: (context, state) => const DemoDashboardScreen(),
  ),
  GoRoute(
    path: SupportRoutes.intakeCoordinatorIntakeForms,
    builder: (context, state) => const DemoDashboardScreen(),
  ),
  GoRoute(
    path: SupportRoutes.intakeCoordinatorEligibility,
    builder: (context, state) => const DemoDashboardScreen(),
  ),
  GoRoute(
    path: SupportRoutes.intakeCoordinatorScheduling,
    builder: (context, state) => const DemoDashboardScreen(),
  ),
  GoRoute(
    path: SupportRoutes.intakeCoordinatorClientAssignment,
    builder: (context, state) => const DemoDashboardScreen(),
  ),
  GoRoute(
    path: SupportRoutes.qualityAssuranceAudits,
    builder: (context, state) => const DemoDashboardScreen(),
  ),
  GoRoute(
    path: SupportRoutes.qualityAssuranceReviews,
    builder: (context, state) => const DemoDashboardScreen(),
  ),
  GoRoute(
    path: SupportRoutes.qualityAssuranceComplaints,
    builder: (context, state) => const DemoDashboardScreen(),
  ),
  GoRoute(
    path: SupportRoutes.qualityAssuranceCorrectiveActions,
    builder: (context, state) => const DemoDashboardScreen(),
  ),
  GoRoute(
    path: SupportRoutes.qualityAssuranceScorecards,
    builder: (context, state) => const DemoDashboardScreen(),
  ),
  GoRoute(
    path: SupportRoutes.qualityAssuranceComplianceChecks,
    builder: (context, state) => const DemoDashboardScreen(),
  ),
  GoRoute(
    path: SupportRoutes.qualityAssuranceReports,
    builder: (context, state) => const DemoDashboardScreen(),
  ),
  GoRoute(
    path: SupportRoutes.trainingCoordinatorTrainingSchedule,
    builder: (context, state) => const DemoDashboardScreen(),
  ),
  GoRoute(
    path: SupportRoutes.trainingCoordinatorCourses,
    builder: (context, state) => const DemoDashboardScreen(),
  ),
  GoRoute(
    path: SupportRoutes.trainingCoordinatorProgress,
    builder: (context, state) => const DemoDashboardScreen(),
  ),
  GoRoute(
    path: SupportRoutes.trainingCoordinatorWorkshops,
    builder: (context, state) => const DemoDashboardScreen(),
  ),
  GoRoute(
    path: SupportRoutes.trainingCoordinatorAttendance,
    builder: (context, state) => const DemoDashboardScreen(),
  ),
  GoRoute(
    path: SupportRoutes.trainingCoordinatorMaterials,
    builder: (context, state) => const DemoDashboardScreen(),
  ),
  GoRoute(
    path: SupportRoutes.customerSupportDashboard,
    builder: (context, state) => const DemoDashboardScreen(),
  ),
  GoRoute(
    path: SupportRoutes.intakeCoordinatorDashboard,
    builder: (context, state) => const DemoDashboardScreen(),
  ),
  GoRoute(
    path: SupportRoutes.qualityAssuranceDashboard,
    builder: (context, state) => const DemoDashboardScreen(),
  ),
  GoRoute(
    path: SupportRoutes.trainingCoordinatorDashboard,
    builder: (context, state) => const DemoDashboardScreen(),
  ),
];
