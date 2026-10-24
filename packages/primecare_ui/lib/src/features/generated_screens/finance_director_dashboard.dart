// Existing registered entry; domain actions remain subject to their own contracts.
import '../workspace/governed_workspace_screen.dart';

class FinanceDirectorDashboardScreen extends GovernedWorkspaceEntry {
  const FinanceDirectorDashboardScreen({super.key})
      : super(route: '/offices/corporate/roles/finance_director/dashboard');
}
