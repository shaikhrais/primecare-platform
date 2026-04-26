// Layer: 04_REGISTRY_INTENT
import 'package:flutter_core/00_B_flutter_core.dart';
import '../presentation/widgets/05_U_scheduler_dashboard_screen.dart';

class SchedulerDashboardIntent extends AppScreenIntent {
  SchedulerDashboardIntent();

  @override
  String get name => 'scheduler_dashboard';

  @override
  String get route => '/offices/corporate/roles/scheduler/dashboard';

  @override
  String get title => 'dashboards.scheduler.title';

  @override
  PlatformRole get requiredRole => PlatformRole.scheduler;

  @override
  dynamic get provider => schedulerMetricsProvider;

  @override
  Widget build(BuildContext context) => const SchedulerDashboardScreen();
}
