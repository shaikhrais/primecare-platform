// Layer: 05_UI_PRESENTATION
import 'package:primecare_ui/primecare_ui.dart';

class Audits extends ConsumerWidget {
  Audits({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return PageTemplate(
      title: 'navigation.items.audits'.tr(),
      subtitle: 'navigation.items.audits'.tr(),

      body: Center(
        child: Text(LocaleKeys.dashboards_common_labels_provisioning.tr()),
      ),
    );
  }
}
