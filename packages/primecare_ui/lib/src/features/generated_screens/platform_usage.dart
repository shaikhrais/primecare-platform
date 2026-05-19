import 'package:primecare_ui/primecare_ui.dart';

class PlatformUsage extends GovernedStatelessWidget {
  const PlatformUsage({super.key});

  @override
  Widget buildScreen(BuildContext context) {
    return EmptyState(
      icon: LucideIcons.layoutTemplate,
      title: 'PlatformUsage',
      subtitle: 'Premium feature module pending hydration.',
      actionLabel: 'Refresh',
      onAction: () {},
    );
  }
}
