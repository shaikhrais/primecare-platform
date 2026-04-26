// Layer: 05_UI_PRESENTATION
import 'package:primecare_ui/primecare_ui.dart';

class BillingConsole extends ConsumerWidget {
  BillingConsole({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return PageTemplate(
      title: 'navigation.items.billing_console'.tr(),
      subtitle: 'navigation.items.billing_console'.tr(),

      body: Center(
        child: Text(LocaleKeys.dashboards_common_labels_provisioning.tr()),
      ),
    );
  }
}
