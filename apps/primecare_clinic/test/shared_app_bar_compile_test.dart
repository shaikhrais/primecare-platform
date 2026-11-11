import 'package:flutter_test/flutter_test.dart';
import 'package:primecare_clinic/features/generated_screens/caregiver_dashboard_screen.dart';
import 'package:primecare_clinic/features/generated_screens/intake_coordinator_referrals_screen.dart';
import 'package:primecare_clinic/features/generated_screens/psw_incident_report_screen.dart';
import 'package:primecare_clinic/features/generated_screens/rpn_dashboard_screen.dart';
import 'package:primecare_clinic/features/physician/screens/physician_dashboard_screen.dart';
void main(){test('all migrated clinic app-bar consumers compile',(){expect(<Type>[CaregiverDashboardScreen,IntakeCoordinatorReferralsScreen,PswIncidentReportScreen,RpnDashboardScreen,PhysicianDashboardScreen],hasLength(5));});}
