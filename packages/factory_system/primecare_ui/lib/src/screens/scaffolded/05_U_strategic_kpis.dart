// Layer: 05_UI_PRESENTATION
import 'package:primecare_ui/primecare_ui.dart';

class StrategicKpis extends ConsumerWidget {
  const StrategicKpis({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return PageTemplate(
      title: 'navigation.items.strategic_kpis'.tr(),
      subtitle: 'navigation.items.strategic_kpis'.tr(),
      body: Center(child: Text('Provisioning...')),
    );
  }
}
