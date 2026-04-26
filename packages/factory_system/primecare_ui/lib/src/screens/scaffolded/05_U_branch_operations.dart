// Layer: 05_UI_PRESENTATION
import 'package:primecare_ui/primecare_ui.dart';

class BranchOperations extends ConsumerWidget {
  BranchOperations({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return PageTemplate(
      title: 'navigation.items.branch_operations'.tr(),
      subtitle: 'navigation.items.branch_operations'.tr(),

      body: Center(
        child: Text(LocaleKeys.dashboards_common_labels_provisioning.tr()),
      ),
    );
  }
}
