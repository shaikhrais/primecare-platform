// Existing registered entry; domain actions remain subject to their own contracts.
import '../workspace/governed_workspace_screen.dart';

class UnknownDashboardScreen extends GovernedWorkspaceEntry {
  const UnknownDashboardScreen({super.key})
      : super(route: '/generated/unknown-dashboard');
}
