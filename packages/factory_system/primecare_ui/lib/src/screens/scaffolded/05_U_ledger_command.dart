// Layer: 05_UI_PRESENTATION
import 'package:primecare_ui/primecare_ui.dart';

class LedgerCommand extends ConsumerWidget {
  LedgerCommand({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return PageTemplate(
      title: 'navigation.items.ledger_command'.tr(),
      subtitle: 'navigation.items.ledger_command'.tr(),

      body: Center(
        child: Text(LocaleKeys.dashboards_common_labels_provisioning.tr()),
      ),
    );
  }
}
