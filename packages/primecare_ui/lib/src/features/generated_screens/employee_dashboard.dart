// Existing registered entry; domain actions remain subject to their own contracts.
import '../workspace/governed_workspace_screen.dart';

class EmployeeDashboardScreen extends GovernedWorkspaceEntry {
  const EmployeeDashboardScreen({super.key})
      : super(route: '/staff/employee-dashboard');
}
