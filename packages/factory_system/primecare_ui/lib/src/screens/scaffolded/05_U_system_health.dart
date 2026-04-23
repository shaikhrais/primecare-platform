// Layer: 05_UI_PRESENTATION
import 'package:primecare_ui/primecare_ui.dart';

class SystemHealth extends ConsumerWidget {
  const SystemHealth({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const PageTemplate(
      title: 'SystemHealth',
      subtitle: 'Auto-scaffolded health monitor',
      body: Center(child: Text('Provisioning...')),
    );
  }
}
