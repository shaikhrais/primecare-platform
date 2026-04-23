// Layer: 04_REGISTRY_INTENT
import 'package:flutter_core/00_B_flutter_core.dart';
import '../presentation/widgets/05_U_scrum_master_dashboard_screen.dart';

class ScrumMasterDashboardIntent extends AppScreenIntent {
  const ScrumMasterDashboardIntent();

  @override
  String get name => 'scrum_master_dashboard';

  @override
  String get route => '/offices/corporate/roles/scrum_master/dashboard';

  @override
  String get title => 'Scrum Master Dashboard';

  @override
  PlatformRole get requiredRole => PlatformRole.scrumMaster;

  @override
  dynamic get provider => scrumMasterDashboardAdapterProvider;

  @override
  Widget build(BuildContext context) => const ScrumMasterDashboardScreen();
}

