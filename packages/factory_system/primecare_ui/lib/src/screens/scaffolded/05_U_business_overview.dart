// Layer: 05_UI_PRESENTATION
import 'package:primecare_ui/primecare_ui.dart';

class BusinessOverview extends ConsumerWidget {
  BusinessOverview({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return PageTemplate(
      title: 'navigation.items.business_overview'.tr(),
      subtitle: 'navigation.items.business_overview'.tr(),

      body: Center(
        child: Text(LocaleKeys.dashboards_common_labels_provisioning.tr()),
      ),
    );
  }
}
