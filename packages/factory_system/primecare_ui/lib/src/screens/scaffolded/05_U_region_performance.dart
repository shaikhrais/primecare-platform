// Layer: 05_UI_PRESENTATION
import 'package:primecare_ui/primecare_ui.dart';

class RegionPerformance extends ConsumerWidget {
  const RegionPerformance({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return PageTemplate(
      title: 'navigation.items.region_performance'.tr(),
      subtitle: 'navigation.items.region_performance'.tr(),
      
      body: Center(child: Text('Provisioning...')),
    );
  }
}
