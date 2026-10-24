// Existing registered entry; domain actions remain subject to their own contracts.
import '../workspace/governed_workspace_screen.dart';

class PhysicianDashboardScreen extends GovernedWorkspaceEntry {
  const PhysicianDashboardScreen({super.key})
      : super(route: '/clinical/physician-dashboard');
}
