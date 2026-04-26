// Layer: 04_REGISTRY_INTENT
import 'package:flutter_core/00_B_flutter_core.dart';
import '../presentation/widgets/05_U_cfo_dashboard_screen.dart';

class CfoDashboardIntent extends AppScreenIntent {
  CfoDashboardIntent();

  @override
  String get name => 'cfo_dashboard';

  @override
  String get route => '/offices/corporate/roles/cfo/dashboard';

  @override
  String get title => 'dashboards.cfo.title';

  @override
  PlatformRole get requiredRole => PlatformRole.cfo;

  @override
  dynamic get provider => cfoDashboardAdapterProvider;

  @override
  List<String> get componentLabels => [
    'dashboards.cfo.labels.liquidity_index',
    'dashboards.cfo.labels.burn_rate_analysis',
    'dashboards.cfo.labels.capital_allocation',
  ];

  @override
  Widget build(BuildContext context) => const CfoDashboardScreen();
}
