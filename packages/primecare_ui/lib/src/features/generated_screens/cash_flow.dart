import 'package:primecare_ui/primecare_ui.dart';

class CashFlow extends GovernedStatelessWidget {
  const CashFlow({super.key});

  @override
  Widget buildScreen(BuildContext context) {
    return EmptyState(
      icon: LucideIcons.layoutTemplate,
      title: 'CashFlow',
      subtitle: 'Premium feature module pending hydration.',
      actionLabel: 'Refresh',
      onAction: () {},
    );
  }
}
