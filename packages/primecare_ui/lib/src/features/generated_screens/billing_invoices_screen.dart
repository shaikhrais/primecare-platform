import 'package:primecare_ui/primecare_ui.dart';

class BillingInvoicesScreen extends GovernedStatelessWidget {
  const BillingInvoicesScreen({super.key});

  @override
  Widget buildScreen(BuildContext context) {
    return EmptyState(
      icon: LucideIcons.layoutTemplate,
      title: 'BillingInvoicesScreen',
      subtitle: 'Premium feature module pending hydration.',
      actionLabel: 'Refresh',
      onAction: () {},
    );
  }
}
