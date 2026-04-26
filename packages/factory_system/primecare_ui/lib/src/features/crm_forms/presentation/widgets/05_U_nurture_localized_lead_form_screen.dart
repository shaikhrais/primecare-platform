// Layer: 05_UI_PRESENTATION
import 'package:primecare_ui/primecare_ui.dart';

class NurtureLocalizedLeadFormScreen extends ConsumerWidget {
  final dynamic data;

  NurtureLocalizedLeadFormScreen({super.key, this.data});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return PrimeCareScaffold(
      title: LocaleKeys.dashboards_common_labels_nurturelocalizedleadform.tr(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              LucideIcons.component,
              size: 64,
              color: context.theme.colors.primary,
            ),
            SizedBox(height: 16),
            Text(
              'nurtureLocalizedLeadForm Implementation',
              style: context.textTheme.headlineMedium,
            ),
            SizedBox(height: 8),
            Text(
              LocaleKeys
                  .dashboards_common_labels_this_component_is_part_of_the_crm_forms_module
                  .tr(),
            ),
          ],
        ),
      ),
    );
  }
}
