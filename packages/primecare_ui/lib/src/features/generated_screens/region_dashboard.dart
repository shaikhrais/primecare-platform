import 'package:primecare_ui/primecare_ui.dart';

class RegionDashboard extends GovernedStatelessWidget {
  const RegionDashboard({super.key});

  @override
  Widget buildScreen(BuildContext context) {
    return EmptyState(
      icon: LucideIcons.layoutTemplate,
      title: 'RegionDashboard',
      subtitle: 'Premium feature module pending hydration.',
      actionLabel: 'Refresh',
      onAction: () {},
    );
  }
}
