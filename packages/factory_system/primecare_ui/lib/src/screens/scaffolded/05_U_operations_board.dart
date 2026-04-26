// Layer: 05_UI_PRESENTATION
import 'package:primecare_ui/primecare_ui.dart';

class OperationsBoard extends ConsumerWidget {
  const OperationsBoard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return PageTemplate(
      title: 'navigation.items.operations_board'.tr(),
      subtitle: 'navigation.items.operations_board'.tr(),
      
      body: Center(child: Text('Provisioning...')),
    );
  }
}
