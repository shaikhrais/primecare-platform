import 'package:primecare_ui/primecare_ui.dart';

class ComplianceHub extends GovernedStatelessWidget {
  const ComplianceHub({super.key});

  @override
  Widget buildScreen(BuildContext context) {
    return EmptyState(
      icon: LucideIcons.layoutTemplate,
      title: 'ComplianceHub',
      subtitle: 'Premium feature module pending hydration.',
      actionLabel: 'Refresh',
      onAction: () {},
    );
  }
}
