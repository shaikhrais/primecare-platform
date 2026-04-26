// Layer: 05_UI_PRESENTATION
import 'package:primecare_ui/primecare_ui.dart';

class ApiMonitoring extends ConsumerWidget {
  const ApiMonitoring({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return PageTemplate(
      title: 'navigation.items.api_monitoring'.tr(),
      subtitle: 'navigation.items.api_monitoring'.tr(),
      
      body: Center(child: Text('Provisioning...')),
    );
  }
}
