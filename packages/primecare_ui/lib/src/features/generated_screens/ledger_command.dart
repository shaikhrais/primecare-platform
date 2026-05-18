import 'package:primecare_ui/primecare_ui.dart';

class LedgerCommand extends StatelessWidget {
  const LedgerCommand({super.key});

  @override
  Widget build(BuildContext context) {
    return EmptyState(
      icon: LucideIcons.layoutTemplate,
      title: 'LedgerCommand',
      subtitle: 'Premium feature module pending hydration.',
      actionLabel: 'Refresh',
      onAction: () {},
    );
  }
}
