// Layer: 04_REGISTRY_INTENT
import 'package:flutter_core/00_B_flutter_core.dart';
import '../presentation/widgets/05_U_hr_hiring_dashboard_screen.dart';

class HrHiringDashboardIntent extends AppScreenIntent {
  HrHiringDashboardIntent();

  @override
  String get name => 'hr_hiring_dashboard';

  @override
  String get route => '/offices/corporate/roles/hr_hiring/dashboard';

  @override
  String get title => 'dashboards.hrhiring.title';

  @override
  PlatformRole get requiredRole => PlatformRole.hrHiring;

  @override
  dynamic get provider => hrMetricsProvider;

  @override
  List<String> get componentLabels => [
    'dashboards.hrhiring.labels.dashboards_hrhiring_labels_aura_hud',
    'dashboards.hrhiring.labels.dashboards_hrhiring_labels_candidate_pipeline',
    'dashboards.hrhiring.labels.dashboards_hrhiring_labels_interview_scheduler',
    'dashboards.hrhiring.labels.dashboards_hrhiring_labels_hiring_analytics',
  ];

  @override
  Widget build(BuildContext context) => const HrHiringDashboardScreen();
}
