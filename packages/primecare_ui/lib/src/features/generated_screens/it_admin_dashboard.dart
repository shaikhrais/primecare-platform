// Existing registered entry; domain actions remain subject to their own contracts.
import '../workspace/governed_workspace_screen.dart';

class ItAdminDashboardScreen extends GovernedWorkspaceEntry {
  const ItAdminDashboardScreen({super.key})
      : super(route: '/offices/corporate/roles/it_admin/dashboard');
}
