// Layer: 05_UI_PRESENTATION
import 'package:primecare_ui/primecare_ui.dart';

class TaxRemittance extends ConsumerWidget {
  TaxRemittance({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return PageTemplate(
      title: 'navigation.items.tax_remittance'.tr(),
      subtitle: 'navigation.items.tax_remittance'.tr(),
      body: Center(
        child: Text(LocaleKeys.dashboards_common_labels_provisioning.tr()),
      ),
    );
  }
}
