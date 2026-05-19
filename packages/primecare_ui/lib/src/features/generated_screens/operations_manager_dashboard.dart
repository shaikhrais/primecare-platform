import 'package:primecare_ui/primecare_ui.dart';

class OperationsManagerDashboard extends GovernedStatelessWidget {
  const OperationsManagerDashboard({super.key});

  @override
  Widget buildScreen(BuildContext context) {
    return EmptyState(
      icon: LucideIcons.layoutTemplate,
      title: 'OperationsManagerDashboard',
      subtitle: 'Premium feature module pending hydration.',
      actionLabel: 'Refresh',
      onAction: () {},
    );
  }
}
