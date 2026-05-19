import 'package:primecare_ui/primecare_ui.dart';

class UnknownDashboardScreen extends GovernedStatelessWidget {
  const UnknownDashboardScreen({super.key});

  @override
  Widget buildScreen(BuildContext context) {
    return EmptyState(
      icon: LucideIcons.layoutTemplate,
      title: 'UnknownDashboardScreen',
      subtitle: 'Premium feature module pending hydration.',
      actionLabel: 'Refresh',
      onAction: () {},
    );
  }
}
