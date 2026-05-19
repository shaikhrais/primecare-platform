import 'package:primecare_ui/primecare_ui.dart';

class Cases extends GovernedStatelessWidget {
  const Cases({super.key});

  @override
  Widget buildScreen(BuildContext context) {
    return EmptyState(
      icon: LucideIcons.layoutTemplate,
      title: 'Cases',
      subtitle: 'Premium feature module pending hydration.',
      actionLabel: 'Refresh',
      onAction: () {},
    );
  }
}
