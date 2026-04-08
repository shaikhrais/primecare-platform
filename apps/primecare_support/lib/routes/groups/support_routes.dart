import 'package:go_router/go_router.dart';
import 'package:primecare_core/routes/app_routes.dart';
import 'package:primecare_ui/src/components/generic_feature_screen.dart';

import '../../offices/support/roles/customer_support/support_dashboard.dart'
    as customer_support_dash;
import '../../offices/support/roles/intake_coordinator/intake_dashboard.dart'
    as intake_coordinator_dash;
import '../../offices/support/roles/quality_assurance/qa_dashboard.dart'
    as quality_assurance_dash;
import '../../offices/support/roles/training_coordinator/training_modules.dart'
    as training_coordinator_dash;
import '../../offices/support/roles/customer_support/tickets.dart'
    as customer_support_tickets;
import '../../offices/support/roles/customer_support/escalations.dart'
    as customer_support_escalations;
import '../../offices/support/roles/customer_support/issue_categories.dart'
    as customer_support_issue_categories;
import '../../offices/support/roles/customer_support/templates.dart'
    as customer_support_templates;
import '../../offices/support/roles/customer_support/reports.dart'
    as customer_support_reports;
import '../../offices/support/roles/intake_coordinator/new_intakes.dart'
    as intake_coordinator_new_intakes;
import '../../offices/support/roles/intake_coordinator/intake_forms.dart'
    as intake_coordinator_intake_forms;
import '../../offices/support/roles/intake_coordinator/eligibility.dart'
    as intake_coordinator_eligibility;
import '../../offices/support/roles/intake_coordinator/scheduling.dart'
    as intake_coordinator_scheduling;
import '../../offices/support/roles/intake_coordinator/client_assignment.dart'
    as intake_coordinator_client_assignment;
import '../../offices/support/roles/intake_coordinator/reports.dart'
    as intake_coordinator_reports;
import '../../offices/support/roles/quality_assurance/audits.dart'
    as quality_assurance_audits;
import '../../offices/support/roles/quality_assurance/reviews.dart'
    as quality_assurance_reviews;
import '../../offices/support/roles/quality_assurance/complaints.dart'
    as quality_assurance_complaints;
import '../../offices/support/roles/quality_assurance/corrective_actions.dart'
    as quality_assurance_corrective_actions;
import '../../offices/support/roles/quality_assurance/scorecards.dart'
    as quality_assurance_scorecards;
import '../../offices/support/roles/quality_assurance/compliance_checks.dart'
    as quality_assurance_compliance_checks;
import '../../offices/support/roles/quality_assurance/reports.dart'
    as quality_assurance_reports;
import '../../offices/support/roles/training_coordinator/training_schedule.dart'
    as training_coordinator_training_schedule;
import '../../offices/support/roles/training_coordinator/courses.dart'
    as training_coordinator_courses;
import '../../offices/support/roles/training_coordinator/progress.dart'
    as training_coordinator_progress;
import '../../offices/support/roles/training_coordinator/workshops.dart'
    as training_coordinator_workshops;
import '../../offices/support/roles/training_coordinator/attendance.dart'
    as training_coordinator_attendance;
import '../../offices/support/roles/training_coordinator/materials.dart'
    as training_coordinator_materials;
import '../../offices/support/roles/training_coordinator/certifications.dart'
    as training_coordinator_certifications;
import '../../offices/support/roles/training_coordinator/reports.dart'
    as training_coordinator_reports;

final List<RouteBase> supportRoutes = [
  GoRoute(
    path: AppRoutes.customerSupportTickets,
    builder: (context, state) => const customer_support_tickets.TicketsView(),
  ),
  GoRoute(
    path: AppRoutes.customerSupportEscalations,
    builder: (context, state) =>
        const customer_support_escalations.EscalationsScreen(),
  ),
  GoRoute(
    path: AppRoutes.customerSupportIssueCategories,
    builder: (context, state) =>
        const customer_support_issue_categories.IssueCategoriesScreen(),
  ),
  GoRoute(
    path: AppRoutes.customerSupportTemplates,
    builder: (context, state) =>
        const customer_support_templates.TemplatesScreen(),
  ),
  GoRoute(
    path: AppRoutes.customerSupportReports,
    builder: (context, state) =>
        const GenericFeatureScreen(featureId: 'pending'),
  ),
  GoRoute(
    path: AppRoutes.intakeCoordinatorNewIntakes,
    builder: (context, state) =>
        const intake_coordinator_new_intakes.NewIntakesScreen(),
  ),
  GoRoute(
    path: AppRoutes.intakeCoordinatorIntakeForms,
    builder: (context, state) =>
        const intake_coordinator_intake_forms.IntakeFormsScreen(),
  ),
  GoRoute(
    path: AppRoutes.intakeCoordinatorEligibility,
    builder: (context, state) =>
        const intake_coordinator_eligibility.EligibilityScreen(),
  ),
  GoRoute(
    path: AppRoutes.intakeCoordinatorScheduling,
    builder: (context, state) =>
        const intake_coordinator_scheduling.SchedulingScreen(),
  ),
  GoRoute(
    path: AppRoutes.intakeCoordinatorClientAssignment,
    builder: (context, state) =>
        const intake_coordinator_client_assignment.ClientAssignmentScreen(),
  ),
  GoRoute(
    path: AppRoutes.qualityAssuranceAudits,
    builder: (context, state) =>
        const GenericFeatureScreen(featureId: 'pending'),
  ),
  GoRoute(
    path: AppRoutes.qualityAssuranceReviews,
    builder: (context, state) =>
        const quality_assurance_reviews.ReviewsScreen(),
  ),
  GoRoute(
    path: AppRoutes.qualityAssuranceComplaints,
    builder: (context, state) =>
        const quality_assurance_complaints.ComplaintsScreen(),
  ),
  GoRoute(
    path: AppRoutes.qualityAssuranceCorrectiveActions,
    builder: (context, state) =>
        const GenericFeatureScreen(featureId: 'pending'),
  ),
  GoRoute(
    path: AppRoutes.qualityAssuranceScorecards,
    builder: (context, state) =>
        const quality_assurance_scorecards.ScorecardsScreen(),
  ),
  GoRoute(
    path: AppRoutes.qualityAssuranceComplianceChecks,
    builder: (context, state) =>
        const quality_assurance_compliance_checks.ComplianceChecksScreen(),
  ),
  GoRoute(
    path: AppRoutes.qualityAssuranceReports,
    builder: (context, state) =>
        const GenericFeatureScreen(featureId: 'pending'),
  ),
  GoRoute(
    path: AppRoutes.trainingCoordinatorTrainingSchedule,
    builder: (context, state) =>
        const training_coordinator_training_schedule.TrainingScheduleScreen(),
  ),
  GoRoute(
    path: AppRoutes.trainingCoordinatorCourses,
    builder: (context, state) =>
        const training_coordinator_courses.CoursesScreen(),
  ),
  GoRoute(
    path: AppRoutes.trainingCoordinatorProgress,
    builder: (context, state) =>
        const training_coordinator_progress.ProgressScreen(),
  ),
  GoRoute(
    path: AppRoutes.trainingCoordinatorWorkshops,
    builder: (context, state) =>
        const training_coordinator_workshops.WorkshopsScreen(),
  ),
  GoRoute(
    path: AppRoutes.trainingCoordinatorAttendance,
    builder: (context, state) =>
        const training_coordinator_attendance.AttendanceScreen(),
  ),
  GoRoute(
    path: AppRoutes.trainingCoordinatorMaterials,
    builder: (context, state) =>
        const training_coordinator_materials.MaterialsScreen(),
  ),
  GoRoute(
    path: AppRoutes.customerSupportDashboard,
    builder: (context, state) => const customer_support_dash.SupportDashboard(),
  ),
  GoRoute(
    path: AppRoutes.intakeCoordinatorDashboard,
    builder: (context, state) =>
        const intake_coordinator_dash.IntakeDashboard(),
  ),
  GoRoute(
    path: AppRoutes.qualityAssuranceDashboard,
    builder: (context, state) => const quality_assurance_dash.QaDashboard(),
  ),
  GoRoute(
    path: AppRoutes.trainingCoordinatorDashboard,
    builder: (context, state) =>
        const training_coordinator_dash.TrainingCoordinatorDashboard(),
  ),
];
