// Existing registered entry; domain actions remain subject to their own contracts.
import '../workspace/governed_workspace_screen.dart';

class DynamicScreenDashboardScreen extends GovernedWorkspaceEntry {
  const DynamicScreenDashboardScreen({super.key})
      : super(route: '/common/dynamic-dashboard');
}
