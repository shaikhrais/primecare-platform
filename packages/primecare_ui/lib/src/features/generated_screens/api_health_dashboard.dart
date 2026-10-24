// Existing registered entry; domain actions remain subject to their own contracts.
import '../workspace/governed_workspace_screen.dart';

class ApiHealthDashboardScreen extends GovernedWorkspaceEntry {
  const ApiHealthDashboardScreen({super.key})
      : super(route: '/common/api-health-dashboard');
}
