// Layer: 04_REGISTRY_INTENT
import 'package:flutter_core/00_B_flutter_core.dart';
import '../presentation/widgets/05_U_compliance_manager_dashboard_screen.dart';

class ComplianceManagerDashboardIntent extends AppScreenIntent {
  ComplianceManagerDashboardIntent();

  @override
  String get name => 'compliance_manager_dashboard';

  @override
  String get route => '/offices/corporate/roles/compliance_manager/dashboard';

  @override
  String get title => 'dashboards.compliancemanager.title';

  @override
  PlatformRole get requiredRole => PlatformRole.complianceManager;

  @override
  dynamic get provider => complianceManagerDashboardAdapterProvider;

  @override
  List<String> get componentLabels => [
    'dashboards.compliancemanager.labels.registry_integrity_score',
    'dashboards.compliancemanager.labels.anomaly_heatmap',
    'dashboards.compliancemanager.labels.execution_gate_logs',
  ];

  @override
  Widget build(BuildContext context) =>
      const ComplianceManagerDashboardScreen();
}
