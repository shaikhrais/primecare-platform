// Existing registered entry; domain actions remain subject to their own contracts.
import '../workspace/governed_workspace_screen.dart';

class HrManagerDashboardScreen extends GovernedWorkspaceEntry {
  const HrManagerDashboardScreen({super.key})
      : super(route: '/offices/corporate/roles/hr_manager/dashboard');
}
