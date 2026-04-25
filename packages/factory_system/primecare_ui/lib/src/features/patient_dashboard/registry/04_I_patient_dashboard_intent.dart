// Layer: 04_REGISTRY_INTENT
import 'package:flutter_core/00_B_flutter_core.dart';
import '../presentation/widgets/05_U_patient_dashboard_screen.dart';

class PatientDashboardIntent extends AppScreenIntent {
  PatientDashboardIntent();

  @override
  String get name => 'patient_dashboard';

  @override
  String get route => '/offices/corporate/roles/patient/dashboard';

  @override
  String get title => 'Patient Dashboard';

  @override
  PlatformRole get requiredRole => PlatformRole.patient;

  @override
  dynamic get provider => patientDashboardAdapterProvider;

  @override
  Widget build(BuildContext context) => const PatientDashboardScreen();
}
