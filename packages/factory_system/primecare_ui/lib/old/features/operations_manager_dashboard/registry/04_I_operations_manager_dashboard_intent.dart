// Layer: 04_REGISTRY_INTENT
import 'package:flutter_core/00_B_flutter_core.dart';
import '../presentation/widgets/05_U_operations_manager_dashboard_screen.dart';

class OperationsManagerDashboardIntent extends AppScreenIntent {
  OperationsManagerDashboardIntent();

  @override
  String get name => 'operations_manager_dashboard';

  @override
  String get route => '/offices/corporate/roles/operations_manager/dashboard';

  @override
  String get title => 'dashboards.operationsmanager.title';

  @override
  PlatformRole get requiredRole => PlatformRole.operationsManager;

  @override
  dynamic get provider => operationsMetricsProvider;

  @override
  Widget build(BuildContext context) =>
      const OperationsManagerDashboardScreen();
}
