// Layer: 05_UI_PRESENTATION
import 'package:primecare_ui/primecare_ui.dart';

class IntakePipeline extends ConsumerWidget {
  const IntakePipeline({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const PageTemplate(
      title: 'IntakePipeline',
      subtitle: 'Auto-scaffolded module',
      
      body: Center(child: Text('Provisioning...')),
    );
  }
}
