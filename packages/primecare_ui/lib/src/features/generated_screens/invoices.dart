import 'package:primecare_ui/primecare_ui.dart';

class Invoices extends GovernedStatelessWidget {
  const Invoices({super.key});

  @override
  Widget buildScreen(BuildContext context) {
    return EmptyState(
      icon: LucideIcons.layoutTemplate,
      title: 'Invoices',
      subtitle: 'Premium feature module pending hydration.',
      actionLabel: 'Refresh',
      onAction: () {},
    );
  }
}
