import 'package:flutter_test/flutter_test.dart';
import 'package:primecare_ui/src/features/admin/device_fleet_manager.dart' as view0;
import 'package:primecare_ui/src/features/auth/shared_account/consent/sections/consent_consent_content_section.dart' as view1;
import 'package:primecare_ui/src/features/auth/shared_account/consent/sections/consent_header_section.dart' as view2;
import 'package:primecare_ui/src/screens/allied/rmt_dashboard/sections/rmt_dashboard_header_section.dart' as view3;
import 'package:primecare_ui/src/screens/allied/treatment_notes_screen.dart' as view4;
import 'package:primecare_ui/src/screens/clinical/assessment_screen.dart' as view5;
import 'package:primecare_ui/src/screens/clinical/cns_dashboard/sections/cns_dashboard_header_section.dart' as view6;
import 'package:primecare_ui/src/screens/clinical/hsw_dashboard/sections/hsw_dashboard_header_section.dart' as view7;
import 'package:primecare_ui/src/screens/clinical/lpn_dashboard/sections/lpn_dashboard_header_section.dart' as view8;
import 'package:primecare_ui/src/screens/clinical/np_dashboard/sections/np_dashboard_header_section.dart' as view9;
import 'package:primecare_ui/src/screens/clinical/pediatric_dashboard/sections/pediatric_dashboard_header_section.dart' as view10;
import 'package:primecare_ui/src/screens/clinical/physician_dashboard/sections/physician_dashboard_header_section.dart' as view11;
import 'package:primecare_ui/src/screens/common/architecture_planning_dashboard/sections/architecture_planning_dashboard_header_section.dart' as view12;
import 'package:primecare_ui/src/screens/psw/incident_report_screen.dart' as view13;
import 'package:primecare_ui/src/screens/psw/psw_dashboard/sections/psw_dashboard_actions_section.dart' as view14;
import 'package:primecare_ui/src/screens/rn/patient_charting_screen.dart' as view15;

void main() { test('all reviewed remaining theme consumers compile', () {
 expect(<Type>[view0.DeviceFleetManager, view1.ConsentConsentContentSection, view2.ConsentHeaderSection, view3.RmtDashboardHeaderSection, view4.TreatmentNotesController, view5.AssessmentController, view6.CnsDashboardHeaderSection, view7.HswDashboardHeaderSection, view8.LpnDashboardHeaderSection, view9.NpDashboardHeaderSection, view10.PediatricDashboardHeaderSection, view11.PhysicianDashboardHeaderSection, view12.ArchitecturePlanningDashboardHeaderSection, view13.IncidentReportController, view14.PswDashboardActionsSection, view15.PatientChartingController],hasLength(16));
 }); }
