// Layer: 04_REGISTRY_INTENT
import 'package:flutter_core/00_B_flutter_core.dart';
import '../presentation/widgets/05_U_system_verification_dashboard_screen.dart';

class SystemVerificationDashboardIntent extends AppScreenIntent {
  SystemVerificationDashboardIntent();

  @override
  String get name => 'system_verification_dashboard';

  @override
  String get route => '/offices/corporate/roles/system_verification/dashboard';

  @override
  String get title => 'dashboards.systemverification.title';

  @override
  PlatformRole get requiredRole => PlatformRole.systemVerification;

  @override
  dynamic get provider => systemVerificationMetricsProvider;

  @override
  Widget build(BuildContext context) =>
      const SystemVerificationDashboardScreen();
}
