// Existing registered entry; domain actions remain subject to their own contracts.
import '../workspace/governed_workspace_screen.dart';

class DynamicDashboardScreen extends GovernedWorkspaceEntry {
  const DynamicDashboardScreen({super.key})
      : super(route: '/generated/dynamic-dashboard');
}
