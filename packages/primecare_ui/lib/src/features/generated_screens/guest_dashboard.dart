// Existing registered entry; domain actions remain subject to their own contracts.
import '../workspace/governed_workspace_screen.dart';

class GuestDashboardScreen extends GovernedWorkspaceEntry {
  const GuestDashboardScreen({super.key})
      : super(route: '/common/guest-dashboard');
}
