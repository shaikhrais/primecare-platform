import 'package:primecare_ui/primecare_ui.dart';

class BusinessOverview extends GovernedStatelessWidget {
  const BusinessOverview({super.key});

  @override
  Widget buildScreen(BuildContext context) {
    return EmptyState(
      icon: LucideIcons.layoutTemplate,
      title: 'BusinessOverview',
      subtitle: 'Premium feature module pending hydration.',
      actionLabel: 'Refresh',
      onAction: () {},
    );
  }
}
