// Layer: 05_UI_PRESENTATION
import 'package:primecare_ui/primecare_ui.dart';

class IntakePipeline extends ConsumerWidget {
  const IntakePipeline({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return PageTemplate(
      title: 'navigation.items.intake_pipeline'.tr(),
      subtitle: 'navigation.items.intake_pipeline'.tr(),
      
      body: Center(child: Text('Provisioning...')),
    );
  }
}
