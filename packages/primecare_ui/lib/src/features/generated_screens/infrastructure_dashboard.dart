// Existing registered entry; domain actions remain subject to their own contracts.
import '../workspace/governed_workspace_screen.dart';

class InfrastructureDashboardScreen extends GovernedWorkspaceEntry {
  const InfrastructureDashboardScreen({super.key})
      : super(route: '/common/infrastructure-dashboard');
}
