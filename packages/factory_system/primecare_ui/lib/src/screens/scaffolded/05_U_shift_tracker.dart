// Layer: 05_UI_PRESENTATION
import 'package:primecare_ui/primecare_ui.dart';

class ShiftTracker extends ConsumerWidget {
  const ShiftTracker({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return PageTemplate(
      title: 'navigation.items.shift_tracker'.tr(),
      subtitle: 'navigation.items.shift_tracker'.tr(),
      
      body: Center(child: Text('Provisioning...')),
    );
  }
}
