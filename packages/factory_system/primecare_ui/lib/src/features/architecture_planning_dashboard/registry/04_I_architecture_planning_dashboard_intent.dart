// Layer: 04_REGISTRY_INTENT
import 'package:flutter_core/00_B_flutter_core.dart';
import '../presentation/widgets/05_U_architecture_planning_dashboard_screen.dart';

class ArchitecturePlanningDashboardIntent extends AppScreenIntent {
  const ArchitecturePlanningDashboardIntent();

  @override
  String get name => 'architecture_planning_dashboard';

  @override
  String get route => '/offices/corporate/roles/architecture_planning/dashboard';

  @override
  String get title => 'Architecture Planning Dashboard';

  @override
  PlatformRole get requiredRole => PlatformRole.architecturePlanning;

  @override
  dynamic get provider => architecturePlanningAdapterProvider;

  @override
  List<String> get componentLabels => ['Aura HUD', 'Architecture Roadmap', 'System Health Grid', 'Project Timeline'];

  @override
  Widget build(BuildContext context) => const ArchitecturePlanningDashboardScreen();
}

