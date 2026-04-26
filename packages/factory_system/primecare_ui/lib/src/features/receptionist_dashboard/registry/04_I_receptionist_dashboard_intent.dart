// Layer: 04_REGISTRY_INTENT
import 'package:flutter_core/00_B_flutter_core.dart';
import '../presentation/widgets/05_U_receptionist_dashboard_screen.dart';

class ReceptionistDashboardIntent extends AppScreenIntent {
  ReceptionistDashboardIntent();

  @override
  String get name => 'receptionist_dashboard';

  @override
  String get route => '/offices/corporate/roles/receptionist/dashboard';

  @override
  String get title => 'dashboards.receptionist.title';

  @override
  PlatformRole get requiredRole => PlatformRole.receptionist;

  @override
  dynamic get provider => receptionistDashboardAdapterProvider;

  @override
  Widget build(BuildContext context) => const ReceptionistDashboardScreen();
}
