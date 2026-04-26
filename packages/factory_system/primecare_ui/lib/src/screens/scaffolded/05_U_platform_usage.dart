// Layer: 05_UI_PRESENTATION
import 'package:primecare_ui/primecare_ui.dart';

class PlatformUsage extends ConsumerWidget {
  const PlatformUsage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return PageTemplate(
      title: 'navigation.items.platform_usage'.tr(),
      subtitle: 'navigation.items.platform_usage'.tr(),
      
      body: Center(child: Text('Provisioning...')),
    );
  }
}
