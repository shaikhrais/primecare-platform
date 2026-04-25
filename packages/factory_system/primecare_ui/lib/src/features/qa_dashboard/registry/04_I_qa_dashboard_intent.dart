// Layer: 04_REGISTRY_INTENT
import 'package:flutter_core/00_B_flutter_core.dart';
import '../presentation/widgets/05_U_qa_dashboard_screen.dart';

class QaDashboardIntent extends AppScreenIntent {
  QaDashboardIntent();

  @override
  String get name => 'qa_dashboard';

  @override
  String get route => '/offices/corporate/roles/qa/dashboard';

  @override
  String get title => 'Qa Dashboard';

  @override
  PlatformRole get requiredRole => PlatformRole.qa;

  @override
  dynamic get provider => qaMetricsProvider;

  @override
  Widget build(BuildContext context) => const QaDashboardScreen();
}
