import 'package:primecare_ui/primecare_ui.dart';

class TaxRemittance extends GovernedStatelessWidget {
  const TaxRemittance({super.key});

  @override
  Widget buildScreen(BuildContext context) {
    return EmptyState(
      icon: LucideIcons.layoutTemplate,
      title: 'TaxRemittance',
      subtitle: 'Premium feature module pending hydration.',
      actionLabel: 'Refresh',
      onAction: () {},
    );
  }
}
