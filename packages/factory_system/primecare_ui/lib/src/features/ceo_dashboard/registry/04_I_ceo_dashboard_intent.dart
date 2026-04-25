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
  String get title => 'Ceo Dashboard';

  @override
  PlatformRole get requiredRole => PlatformRole.ceo;

  @override
  dynamic get provider => ceoDashboardAdapterProvider;

  @override
  List<String> get componentLabels => [
    'Global KPI Metrics',
    'Region Comparison',
    'Strategic Initiatives',
  ];

  @override
  Widget build(BuildContext context) => const CeoDashboardScreen();
}
