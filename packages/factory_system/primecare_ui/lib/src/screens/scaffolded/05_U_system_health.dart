// Layer: 05_UI_PRESENTATION
import 'package:primecare_ui/primecare_ui.dart';

class SystemHealth extends ConsumerWidget {
  SystemHealth({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return PageTemplate(
      title: 'navigation.items.system_health'.tr(),
      subtitle: 'navigation.items.system_health'.tr(),
      body: Center(
        child: Text(LocaleKeys.dashboards_common_labels_provisioning.tr()),
      ),
    );
  }
}
