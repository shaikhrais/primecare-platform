// Existing registered entry; domain actions remain subject to their own contracts.
import '../workspace/governed_workspace_screen.dart';

class PediatricDashboardScreen extends GovernedWorkspaceEntry {
  const PediatricDashboardScreen({super.key})
      : super(route: '/clinical/pediatric-dashboard');
}
