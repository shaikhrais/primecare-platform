// Existing registered entry; domain actions remain subject to their own contracts.
import '../workspace/governed_workspace_screen.dart';

class CisoDashboardScreen extends GovernedWorkspaceEntry {
  const CisoDashboardScreen({super.key})
      : super(route: '/offices/corporate/roles/ciso/dashboard');
}
