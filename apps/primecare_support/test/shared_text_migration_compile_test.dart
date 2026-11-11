// Compile smoke coverage for constructor-only shared text migration.
// This does not claim individual screen runtime acceptance.
import 'package:flutter_test/flutter_test.dart';
import 'package:primecare_support/features/generated_screens/customer_support_escalations_screen.dart' as migrated0;
import 'package:primecare_support/features/generated_screens/customer_support_issue_categories_screen.dart' as migrated1;
import 'package:primecare_support/features/generated_screens/customer_support_reports_screen.dart' as migrated2;
import 'package:primecare_support/features/generated_screens/customer_support_templates_screen.dart' as migrated3;
import 'package:primecare_support/features/generated_screens/customer_support_tickets_screen.dart' as migrated4;
import 'package:primecare_support/features/generated_screens/intake_coordinator_client_assignment_screen.dart' as migrated5;
import 'package:primecare_support/features/generated_screens/intake_coordinator_eligibility_screen.dart' as migrated6;
import 'package:primecare_support/features/generated_screens/intake_coordinator_intake_forms_screen.dart' as migrated7;
import 'package:primecare_support/features/generated_screens/intake_coordinator_new_intakes_screen.dart' as migrated8;
import 'package:primecare_support/features/generated_screens/intake_coordinator_reports_screen.dart' as migrated9;
import 'package:primecare_support/features/generated_screens/intake_coordinator_scheduling_screen.dart' as migrated10;
import 'package:primecare_support/features/generated_screens/quality_assurance_audits_screen.dart' as migrated11;
import 'package:primecare_support/features/generated_screens/quality_assurance_complaints_screen.dart' as migrated12;
import 'package:primecare_support/features/generated_screens/quality_assurance_compliance_checks_screen.dart' as migrated13;
import 'package:primecare_support/features/generated_screens/quality_assurance_corrective_actions_screen.dart' as migrated14;
import 'package:primecare_support/features/generated_screens/quality_assurance_reports_screen.dart' as migrated15;
import 'package:primecare_support/features/generated_screens/quality_assurance_reviews_screen.dart' as migrated16;
import 'package:primecare_support/features/generated_screens/quality_assurance_scorecards_screen.dart' as migrated17;
import 'package:primecare_support/features/generated_screens/training_coordinator_attendance_screen.dart' as migrated18;
import 'package:primecare_support/features/generated_screens/training_coordinator_certifications_screen.dart' as migrated19;
import 'package:primecare_support/features/generated_screens/training_coordinator_courses_screen.dart' as migrated20;
import 'package:primecare_support/features/generated_screens/training_coordinator_materials_screen.dart' as migrated21;
import 'package:primecare_support/features/generated_screens/training_coordinator_progress_screen.dart' as migrated22;
import 'package:primecare_support/features/generated_screens/training_coordinator_reports_screen.dart' as migrated23;
import 'package:primecare_support/features/generated_screens/training_coordinator_training_schedule_screen.dart' as migrated24;
import 'package:primecare_support/features/generated_screens/training_coordinator_workshops_screen.dart' as migrated25;
import 'package:primecare_support/features/support/screens/escalation_dashboard_screen.dart' as migrated26;
import 'package:primecare_support/features/support/screens/help_desk_dashboard_screen.dart' as migrated27;
import 'package:primecare_support/features/support/screens/it_administrator_dashboard_screen.dart' as migrated28;

void main() {
  test('migrated consumer libraries compile', () {
    const migratedTypes = <Type>[
    migrated0.CustomerSupportEscalationsScreenState,
    migrated1.CustomerSupportIssueCategoriesScreenState,
    migrated2.CustomerSupportReportsScreenState,
    migrated3.CustomerSupportTemplatesScreenState,
    migrated4.CustomerSupportTicketsScreenState,
    migrated5.IntakeCoordinatorClientAssignmentScreenState,
    migrated6.IntakeCoordinatorEligibilityScreenState,
    migrated7.IntakeCoordinatorIntakeFormsScreenState,
    migrated8.IntakeCoordinatorNewIntakesScreenState,
    migrated9.IntakeCoordinatorReportsScreenState,
    migrated10.IntakeCoordinatorSchedulingScreenState,
    migrated11.QualityAssuranceAuditsScreenState,
    migrated12.QualityAssuranceComplaintsScreenState,
    migrated13.QualityAssuranceComplianceChecksScreenState,
    migrated14.QualityAssuranceCorrectiveActionsScreenState,
    migrated15.QualityAssuranceReportsScreenState,
    migrated16.QualityAssuranceReviewsScreenState,
    migrated17.QualityAssuranceScorecardsScreenState,
    migrated18.TrainingCoordinatorAttendanceScreenState,
    migrated19.TrainingCoordinatorCertificationsScreenState,
    migrated20.TrainingCoordinatorCoursesScreenState,
    migrated21.TrainingCoordinatorMaterialsScreenState,
    migrated22.TrainingCoordinatorProgressScreenState,
    migrated23.TrainingCoordinatorReportsScreenState,
    migrated24.TrainingCoordinatorTrainingScheduleScreenState,
    migrated25.TrainingCoordinatorWorkshopsScreenState,
    migrated26.EscalationDashboardScreenState,
    migrated27.HelpDeskDashboardScreenState,
    migrated28.ItAdministratorDashboardScreenState,
    ];
    expect(migratedTypes, hasLength(29));
  });
}
