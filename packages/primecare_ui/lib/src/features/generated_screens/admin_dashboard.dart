// Existing registered entry; domain actions remain subject to their own contracts.
import '../workspace/governed_workspace_screen.dart';

class AdminDashboardScreen extends GovernedWorkspaceEntry {
  const AdminDashboardScreen({super.key})
      : super(route: '/offices/franchise/roles/admin/dashboard');
}
