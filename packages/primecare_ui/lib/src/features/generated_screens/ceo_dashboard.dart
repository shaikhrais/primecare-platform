import '../workspace/governed_workspace_screen.dart';
import 'package:flutter/widgets.dart';

class CeoDashboardScreen extends StatelessWidget {
  const CeoDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) => const GovernedWorkspaceScreen(route: '/offices/corporate/roles/ceo/dashboard');
}
