import 'package:primecare_ui/primecare_ui.dart';

class Referrals extends GovernedStatelessWidget {
  const Referrals({super.key});

  @override
  Widget buildScreen(BuildContext context) {
    return EmptyState(
      icon: LucideIcons.layoutTemplate,
      title: 'Referrals',
      subtitle: 'Premium feature module pending hydration.',
      actionLabel: 'Refresh',
      onAction: () {},
    );
  }
}
