// Existing registered entry; domain actions remain subject to their own contracts.
import '../workspace/governed_workspace_screen.dart';

class ChiropractorDashboardScreen extends GovernedWorkspaceEntry {
  const ChiropractorDashboardScreen({super.key})
      : super(route: '/offices/clinical/roles/chiropractor/dashboard');
}
