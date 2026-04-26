// Layer: 05_UI_PRESENTATION
import 'package:primecare_ui/primecare_ui.dart';

class BranchComparison extends ConsumerWidget {
  const BranchComparison({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return PageTemplate(
      title: 'navigation.items.branch_comparison'.tr(),
      subtitle: 'navigation.items.branch_comparison'.tr(),
      
      body: Center(child: Text('Provisioning...')),
    );
  }
}
