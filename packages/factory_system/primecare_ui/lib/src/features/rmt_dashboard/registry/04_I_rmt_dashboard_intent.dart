// Layer: 04_REGISTRY_INTENT
import 'package:flutter_core/00_B_flutter_core.dart';
import '../presentation/widgets/05_U_rmt_dashboard_screen.dart';

class RmtDashboardIntent extends AppScreenIntent {
  RmtDashboardIntent();

  @override
  String get name => 'rmt_dashboard';

  @override
  String get route => '/offices/corporate/roles/rmt/dashboard';

  @override
  String get title => 'dashboards.rmt.title';

  @override
  PlatformRole get requiredRole => PlatformRole.rmt;

  @override
  dynamic get provider => rmtDashboardAdapterProvider;

  @override
  Widget build(BuildContext context) => const RmtDashboardScreen();
}
