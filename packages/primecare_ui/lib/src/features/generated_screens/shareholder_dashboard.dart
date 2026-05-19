import 'package:primecare_ui/primecare_ui.dart';

class ShareholderDashboard extends GovernedStatelessWidget {
  const ShareholderDashboard({super.key});

  @override
  Widget buildScreen(BuildContext context) {
    return EmptyState(
      icon: LucideIcons.layoutTemplate,
      title: 'ShareholderDashboard',
      subtitle: 'Premium feature module pending hydration.',
      actionLabel: 'Refresh',
      onAction: () {},
    );
  }
}
