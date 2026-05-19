import 'package:primecare_ui/primecare_ui.dart';

class ClinicalDashboard extends GovernedStatelessWidget {
  const ClinicalDashboard({super.key});

  @override
  Widget buildScreen(BuildContext context) {
    return EmptyState(
      icon: LucideIcons.layoutTemplate,
      title: 'ClinicalDashboard',
      subtitle: 'Premium feature module pending hydration.',
      actionLabel: 'Refresh',
      onAction: () {},
    );
  }
}
