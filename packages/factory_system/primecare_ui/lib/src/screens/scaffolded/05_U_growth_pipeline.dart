// Layer: 05_UI_PRESENTATION
import 'package:primecare_ui/primecare_ui.dart';

class GrowthPipeline extends ConsumerWidget {
  const GrowthPipeline({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return PageTemplate(
      title: 'navigation.items.growth_pipeline'.tr(),
      subtitle: 'navigation.items.growth_pipeline'.tr(),
      
      body: Center(child: Text('Provisioning...')),
    );
  }
}
