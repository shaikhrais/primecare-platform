import 'package:primecare_ui/primecare_ui.dart';

class UnknownDashboardScreen extends StatelessWidget {
  const UnknownDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return EmptyState(
      icon: LucideIcons.layoutTemplate,
      title: 'UnknownDashboardScreen',
      subtitle: 'Premium feature module pending hydration.',
      actionLabel: 'Refresh',
      onAction: () {},
    );
  }
}
