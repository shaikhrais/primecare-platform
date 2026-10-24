// Existing registered entry; domain actions remain subject to their own contracts.
import '../workspace/governed_workspace_screen.dart';

class ClinicalDirectorDashboardScreen extends GovernedWorkspaceEntry {
  const ClinicalDirectorDashboardScreen({super.key})
      : super(route: '/offices/clinical/roles/clinical_director/dashboard');
}
