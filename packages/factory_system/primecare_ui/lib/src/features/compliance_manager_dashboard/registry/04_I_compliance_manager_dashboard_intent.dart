// Layer: 04_REGISTRY_INTENT
import 'package:flutter_core/00_B_flutter_core.dart';
import '../presentation/widgets/05_U_compliance_manager_dashboard_screen.dart';

class ComplianceManagerDashboardIntent extends AppScreenIntent {
  const ComplianceManagerDashboardIntent();

  @override
  String get name => 'compliance_manager_dashboard';

  @override
  String get route => '/offices/corporate/roles/compliance_manager/dashboard';

  @override
  String get title => 'Compliance Manager Dashboard';

  @override
  PlatformRole get requiredRole => PlatformRole.complianceManager;

  @override
  dynamic get provider => complianceManagerDashboardAdapterProvider;

  @override
  List<String> get componentLabels => ['Registry Integrity Score', 'Anomaly Heatmap', 'Execution Gate Logs'];

  @override
  Widget build(BuildContext context) => const ComplianceManagerDashboardScreen();
}

