// Existing registered entry; domain actions remain subject to their own contracts.
import '../workspace/governed_workspace_screen.dart';

class HswDashboardScreen extends GovernedWorkspaceEntry {
  const HswDashboardScreen({super.key})
      : super(route: '/clinical/hsw-dashboard');
}
