// Layer: 05_UI_PRESENTATION
import 'package:primecare_ui/primecare_ui.dart';

class FinancialOverview extends ConsumerWidget {
  const FinancialOverview({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const PageTemplate(
      title: 'FinancialOverview',
      subtitle: 'Auto-scaffolded module',
      
      body: Center(child: Text('Provisioning...')),
    );
  }
}
