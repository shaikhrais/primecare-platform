// Existing registered entry; domain actions remain subject to their own contracts.
import '../workspace/governed_workspace_screen.dart';

class CnsDashboardScreen extends GovernedWorkspaceEntry {
  const CnsDashboardScreen({super.key})
      : super(route: '/clinical/cns-dashboard');
}
