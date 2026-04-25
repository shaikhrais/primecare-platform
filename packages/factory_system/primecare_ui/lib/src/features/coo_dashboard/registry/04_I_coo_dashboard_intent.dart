// Layer: 04_REGISTRY_INTENT
import 'package:flutter_core/00_B_flutter_core.dart';
import '../presentation/widgets/05_U_coo_dashboard_screen.dart';

class CooDashboardIntent extends AppScreenIntent {
  CooDashboardIntent();

  @override
  String get name => 'coo_dashboard';

  @override
  String get route => '/offices/corporate/roles/coo/dashboard';

  @override
  String get title => 'Coo Dashboard';

  @override
  PlatformRole get requiredRole => PlatformRole.coo;

  @override
  dynamic get provider => cooMetricsProvider;

  @override
  Widget build(BuildContext context) => const CooDashboardScreen();
}
