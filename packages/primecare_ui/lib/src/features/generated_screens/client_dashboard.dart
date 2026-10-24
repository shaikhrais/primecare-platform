// Existing registered entry; domain actions remain subject to their own contracts.
import '../workspace/governed_workspace_screen.dart';

class ClientDashboardScreen extends GovernedWorkspaceEntry {
  const ClientDashboardScreen({super.key})
      : super(route: '/generated/client-dashboard');
}
