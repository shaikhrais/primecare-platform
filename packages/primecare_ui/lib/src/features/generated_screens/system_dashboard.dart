import 'package:primecare_ui/primecare_ui.dart';

class SystemDashboard extends GovernedStatelessWidget {
  const SystemDashboard({super.key});

  @override
  Widget buildScreen(BuildContext context) {
    return EmptyState(
      icon: LucideIcons.layoutTemplate,
      title: 'SystemDashboard',
      subtitle: 'Premium feature module pending hydration.',
      actionLabel: 'Refresh',
      onAction: () {},
    );
  }
}
