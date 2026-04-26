// Layer: 04_REGISTRY_INTENT
import 'package:flutter_core/00_B_flutter_core.dart';
import '../presentation/widgets/05_U_ceo_dashboard_screen.dart';

class CeoDashboardIntent extends AppScreenIntent {
  CeoDashboardIntent();

  @override
  String get name => 'ceo_dashboard';

  @override
  String get route => '/offices/corporate/roles/ceo/dashboard';

  @override
  String get title => 'dashboards.ceo.title';

  @override
  PlatformRole get requiredRole => PlatformRole.ceo;

  @override
  dynamic get provider => ceoDashboardAdapterProvider;

  @override
  List<String> get componentLabels => [
    'dashboards.ceo.labels.dashboards_ceo_labels_global_kpi_metrics',
    'dashboards.ceo.labels.dashboards_ceo_labels_region_comparison',
    'dashboards.ceo.labels.dashboards_ceo_labels_strategic_initiatives',
  ];

  @override
  Widget build(BuildContext context) => const CeoDashboardScreen();
}
