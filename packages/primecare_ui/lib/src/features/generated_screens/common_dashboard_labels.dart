import 'package:primecare_ui/primecare_ui.dart';

class CommonDashboardLabels extends StatelessWidget {
  const CommonDashboardLabels({super.key});

  @override
  Widget build(BuildContext context) {
    return EmptyState(
      icon: LucideIcons.layoutTemplate,
      title: 'CommonDashboardLabels',
      subtitle: 'Premium feature module pending hydration.',
      actionLabel: 'Refresh',
      onAction: () {},
    );
  }
}
