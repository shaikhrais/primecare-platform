// Layer: 05_UI_PRESENTATION
import 'package:primecare_ui/primecare_ui.dart';

class LedgerCommand extends ConsumerWidget {
  const LedgerCommand({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return PageTemplate(
      title: 'navigation.items.ledger_command'.tr(),
      subtitle: 'navigation.items.ledger_command'.tr(),
      
      body: Center(child: Text('Provisioning...')),
    );
  }
}
