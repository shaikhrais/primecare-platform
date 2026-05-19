import 'package:primecare_ui/primecare_ui.dart';

class MarketingHub extends GovernedStatelessWidget {
  const MarketingHub({super.key});

  @override
  Widget buildScreen(BuildContext context) {
    return EmptyState(
      icon: LucideIcons.layoutTemplate,
      title: 'MarketingHub',
      subtitle: 'Premium feature module pending hydration.',
      actionLabel: 'Refresh',
      onAction: () {},
    );
  }
}
