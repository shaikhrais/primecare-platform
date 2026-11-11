import 'package:flutter_test/flutter_test.dart';
import 'package:primecare_clinic/features/generated_screens/caregiver_dashboard_screen.dart' as view0;
import 'package:primecare_clinic/features/generated_screens/rpn_dashboard_screen.dart' as view1;
import 'package:primecare_clinic/features/physician/screens/physician_dashboard_screen.dart' as view2;

void main() { test('all reviewed remaining theme consumers compile', () {
 expect(<Type>[view0.CaregiverDashboardScreen, view1.RpnDashboardScreen, view2.PhysicianDashboardScreen],hasLength(3));
 }); }
