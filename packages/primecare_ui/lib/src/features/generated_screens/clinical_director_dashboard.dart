import 'package:primecare_ui/primecare_ui.dart';

class ClinicalDirectorDashboard extends GovernedStatelessWidget {
  const ClinicalDirectorDashboard({super.key});

  @override
  Widget buildScreen(BuildContext context) {
    return EmptyState(
      icon: LucideIcons.layoutTemplate,
      title: 'ClinicalDirectorDashboard',
      subtitle: 'Premium feature module pending hydration.',
      actionLabel: 'Refresh',
      onAction: () {},
    );
  }
}
