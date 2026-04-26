// Layer: 04_REGISTRY_INTENT
import 'package:flutter_core/00_B_flutter_core.dart';
import '../presentation/widgets/05_U_general_manager_dashboard_screen.dart';

class GeneralManagerDashboardIntent extends AppScreenIntent {
  GeneralManagerDashboardIntent();

  @override
  String get name => 'general_manager_dashboard';

  @override
  String get route => '/offices/corporate/roles/general_manager/dashboard';

  @override
  String get title => 'dashboards.generalmanager.title';

  @override
  PlatformRole get requiredRole => PlatformRole.generalManager;

  @override
  dynamic get provider => generalManagerMetricsProvider;

  @override
  Widget build(BuildContext context) => const GeneralManagerDashboardScreen();
}
