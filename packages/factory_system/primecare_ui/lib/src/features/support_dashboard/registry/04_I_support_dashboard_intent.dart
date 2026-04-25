// Layer: 04_REGISTRY_INTENT
import 'package:flutter_core/00_B_flutter_core.dart';
import '../presentation/widgets/05_U_support_dashboard_screen.dart';

class SupportDashboardIntent extends AppScreenIntent {
  SupportDashboardIntent();

  @override
  String get name => 'support_dashboard';

  @override
  String get route => '/offices/corporate/roles/support/dashboard';

  @override
  String get title => 'Support Dashboard';

  @override
  PlatformRole get requiredRole => PlatformRole.support;

  @override
  dynamic get provider => supportMetricsProvider;

  @override
  Widget build(BuildContext context) => const SupportDashboardScreen();
}
