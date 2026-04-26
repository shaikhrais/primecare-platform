// Layer: 05_UI_PRESENTATION
import 'package:primecare_ui/primecare_ui.dart';

class Profitability extends ConsumerWidget {
  Profitability({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return PageTemplate(
      title: 'navigation.items.profitability'.tr(),
      subtitle: 'navigation.items.profitability'.tr(),

      body: Center(
        child: Text(LocaleKeys.dashboards_common_labels_provisioning.tr()),
      ),
    );
  }
}
