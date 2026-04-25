// Layer: 04_REGISTRY_INTENT
import 'package:flutter_core/00_B_flutter_core.dart';
import '../presentation/widgets/05_U_clinic_dashboard_screen.dart';

class ClinicDashboardIntent extends AppScreenIntent {
  ClinicDashboardIntent();

  @override
  String get name => 'clinic_dashboard';

  @override
  String get route => '/offices/corporate/roles/clinic/dashboard';

  @override
  String get title => 'Clinic Dashboard';

  @override
  PlatformRole get requiredRole => PlatformRole.clinic;

  @override
  dynamic get provider => clinicDashboardAdapterProvider;

  @override
  Widget build(BuildContext context) => const ClinicDashboardScreen();
}
