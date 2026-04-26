// Layer: 04_REGISTRY_INTENT
import 'package:flutter_core/00_B_flutter_core.dart';
import '../presentation/widgets/05_U_intake_dashboard_screen.dart';

class IntakeDashboardIntent extends AppScreenIntent {
  IntakeDashboardIntent();

  @override
  String get name => 'intake_dashboard';

  @override
  String get route => '/offices/corporate/roles/intake/dashboard';

  @override
  String get title => 'dashboards.intake.title';

  @override
  PlatformRole get requiredRole => PlatformRole.intake;

  @override
  dynamic get provider => intakeMetricsProvider;

  @override
  Widget build(BuildContext context) => const IntakeDashboardScreen();
}
