// Existing registered entry; domain actions remain subject to their own contracts.
import '../workspace/governed_workspace_screen.dart';

class SystemDashboardScreen extends GovernedWorkspaceEntry {
  const SystemDashboardScreen({super.key})
      : super(route: '/common/system-dashboard');
}
