import 'package:primecare_ui/primecare_ui.dart';

class GlobalSettings extends GovernedStatelessWidget {
  const GlobalSettings({super.key});

  @override
  Widget buildScreen(BuildContext context) {
    return EmptyState(
      icon: LucideIcons.layoutTemplate,
      title: 'GlobalSettings',
      subtitle: 'Premium feature module pending hydration.',
      actionLabel: 'Refresh',
      onAction: () {},
    );
  }
}
