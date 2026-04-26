// Layer: 04_REGISTRY_INTENT
import 'package:flutter_core/00_B_flutter_core.dart';
import '../presentation/widgets/05_U_finance_director_dashboard_screen.dart';

class FinanceDirectorDashboardIntent extends AppScreenIntent {
  FinanceDirectorDashboardIntent();

  @override
  String get name => 'finance_director_dashboard';

  @override
  String get route => '/offices/corporate/roles/finance_director/dashboard';

  @override
  String get title => 'dashboards.financedirector.title';

  @override
  PlatformRole get requiredRole => PlatformRole.financeDirector;

  @override
  dynamic get provider => financeDirectorMetricsProvider;

  @override
  List<String> get componentLabels => [
    'dashboards.financedirector.labels.dashboards_financedirector_labels_aura_hud',
    'dashboards.financedirector.labels.dashboards_financedirector_labels_financial_summary_grid',
    'dashboards.financedirector.labels.dashboards_financedirector_labels_cash_flow_forecast',
    'dashboards.financedirector.labels.dashboards_financedirector_labels_budget_distribution',
  ];

  @override
  Widget build(BuildContext context) => const FinanceDirectorDashboardScreen();
}
