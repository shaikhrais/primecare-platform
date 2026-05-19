import 'package:primecare_ui/primecare_ui.dart';

class FamilyHome extends GovernedStatelessWidget {
  const FamilyHome({super.key});

  @override
  Widget buildScreen(BuildContext context) {
    return EmptyState(
      icon: LucideIcons.layoutTemplate,
      title: 'FamilyHome',
      subtitle: 'Premium feature module pending hydration.',
      actionLabel: 'Refresh',
      onAction: () {},
    );
  }
}
