import 'package:primecare_ui/primecare_ui.dart';

class BillingClaimsScreen extends GovernedStatelessWidget {
  const BillingClaimsScreen({super.key});

  @override
  Widget buildScreen(BuildContext context) {
    return EmptyState(
      icon: LucideIcons.layoutTemplate,
      title: 'BillingClaimsScreen',
      subtitle: 'Premium feature module pending hydration.',
      actionLabel: 'Refresh',
      onAction: () {},
    );
  }
}
