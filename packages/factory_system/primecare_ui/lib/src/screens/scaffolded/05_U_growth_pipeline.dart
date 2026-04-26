// Layer: 05_UI_PRESENTATION
import 'package:primecare_ui/primecare_ui.dart';

class GrowthPipeline extends ConsumerWidget {
  GrowthPipeline({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return PageTemplate(
      title: 'navigation.items.growth_pipeline'.tr(),
      subtitle: 'navigation.items.growth_pipeline'.tr(),

      body: Center(
        child: Text(LocaleKeys.dashboards_common_labels_provisioning.tr()),
      ),
    );
  }
}
