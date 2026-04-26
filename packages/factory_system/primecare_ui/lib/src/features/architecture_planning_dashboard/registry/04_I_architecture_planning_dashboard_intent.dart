// Layer: 04_REGISTRY_INTENT
import 'package:flutter_core/00_B_flutter_core.dart';
import '../presentation/widgets/05_U_architecture_planning_dashboard_screen.dart';

class ArchitecturePlanningDashboardIntent extends AppScreenIntent {
  ArchitecturePlanningDashboardIntent();

  @override
  String get name => 'architecture_planning_dashboard';

  @override
  String get route =>
      '/offices/corporate/roles/architecture_planning/dashboard';

  @override
  String get title => 'dashboards.architectureplanning.title';

  @override
  PlatformRole get requiredRole => PlatformRole.architecturePlanning;

  @override
  dynamic get provider => architecturePlanningDashboardAdapterProvider;

  @override
  List<String> get componentLabels => [
    'dashboards.architectureplanning.labels.aura_hud',
    'dashboards.architectureplanning.labels.architecture_roadmap',
    'dashboards.architectureplanning.labels.system_health_grid',
    'dashboards.architectureplanning.labels.project_timeline',
  ];

  @override
  Widget build(BuildContext context) =>
      const ArchitecturePlanningDashboardScreen();
}
