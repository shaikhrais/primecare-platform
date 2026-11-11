// Compile smoke coverage for constructor-only shared text migration.
// This does not claim individual screen runtime acceptance.
import 'package:flutter_test/flutter_test.dart';
import 'package:primecare_clinic/features/generated_screens/clinical_director_quality_metrics_screen.dart' as migrated0;
import 'package:primecare_clinic/features/generated_screens/clinical_director_staffing_screen.dart' as migrated1;
import 'package:primecare_clinic/features/generated_screens/infection_control_dashboard_screen.dart' as migrated2;
import 'package:primecare_clinic/features/generated_screens/intake_coordinator_assessments_screen.dart' as migrated3;
import 'package:primecare_clinic/features/generated_screens/nurse_dashboard_screen.dart' as migrated4;
import 'package:primecare_clinic/features/generated_screens/psw_observation_vitals_log_screen.dart' as migrated5;
import 'package:primecare_clinic/features/generated_screens/psw_patient_profile_screen.dart' as migrated6;
import 'package:primecare_clinic/features/generated_screens/psw_schedule_screen.dart' as migrated7;
import 'package:primecare_clinic/features/generated_screens/psw_visit_checklist_screen.dart' as migrated8;
import 'package:primecare_clinic/features/psw/screens/psw_care_dashboard_screen.dart' as migrated9;
import 'package:primecare_clinic/features/psw/screens/psw_check_in_screen.dart' as migrated10;
import 'package:primecare_clinic/features/psw/screens/psw_daily_notes_screen.dart' as migrated11;
import 'package:primecare_clinic/features/psw/screens/psw_help_support_screen.dart' as migrated12;
import 'package:primecare_clinic/features/psw/screens/psw_messaging_screen.dart' as migrated13;
import 'package:primecare_clinic/features/psw/screens/psw_my_clients_screen.dart' as migrated14;
import 'package:primecare_clinic/features/psw/screens/psw_notifications_screen.dart' as migrated15;
import 'package:primecare_clinic/features/psw/screens/psw_profile_screen.dart' as migrated16;
import 'package:primecare_clinic/features/psw/screens/psw_reports_screen.dart' as migrated17;
import 'package:primecare_clinic/features/psw/screens/psw_system_logs_screen.dart' as migrated18;
import 'package:primecare_clinic/features/psw/screens/psw_task_list_screen.dart' as migrated19;
import 'package:primecare_clinic/features/rn/screens/rn_charting_screen.dart' as migrated20;
import 'package:primecare_clinic/features/rn/screens/rn_messaging_screen.dart' as migrated21;
import 'package:primecare_clinic/features/shared/screens/clinic_history_logs_screen.dart' as migrated22;
import 'package:primecare_clinic/features/shared/screens/clinic_incident_report_screen.dart' as migrated23;

void main() {
  test('migrated consumer libraries compile', () {
    const migratedTypes = <Type>[
    migrated0.ClinicalDirectorQualityMetricsScreenState,
    migrated1.ClinicalDirectorStaffingScreenState,
    migrated2.InfectionControlDashboardScreenState,
    migrated3.IntakeCoordinatorAssessmentsScreenState,
    migrated4.NurseDashboardScreenState,
    migrated5.PswObservationVitalsLogScreenState,
    migrated6.PswPatientProfileScreenState,
    migrated7.PswScheduleScreenState,
    migrated8.PswVisitChecklistScreenState,
    migrated9.PswCareDashboardScreenState,
    migrated10.PswCheckInScreenState,
    migrated11.PswDailyNotesScreenState,
    migrated12.PswHelpSupportScreenState,
    migrated13.PswMessagingScreenState,
    migrated14.PswMyClientsScreenState,
    migrated15.PswNotificationsScreenState,
    migrated16.PswProfileScreenState,
    migrated17.PswReportsScreenState,
    migrated18.PswSystemLogsScreenState,
    migrated19.PswTaskListScreenState,
    migrated20.RnChartingScreenState,
    migrated21.RnMessagingScreenState,
    migrated22.ClinicHistoryLogsScreenState,
    migrated23.ClinicIncidentReportScreenState,
    ];
    expect(migratedTypes, hasLength(24));
  });
}
