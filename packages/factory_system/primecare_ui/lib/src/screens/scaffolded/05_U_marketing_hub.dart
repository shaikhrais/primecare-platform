// Layer: 05_UI_PRESENTATION
import 'package:primecare_ui/primecare_ui.dart';

class MarketingHub extends ConsumerWidget {
  MarketingHub({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return PageTemplate(
      title: 'navigation.items.marketing_hub'.tr(),
      subtitle: 'navigation.items.marketing_hub'.tr(),

      body: Center(
        child: Text(LocaleKeys.dashboards_common_labels_provisioning.tr()),
      ),
    );
  }
}
