// Layer: 05_UI_PRESENTATION
import 'package:primecare_ui/primecare_ui.dart';

class FooterLayout3Screen extends ConsumerWidget {
  final dynamic data;

  FooterLayout3Screen({super.key, this.data});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return PrimeCareScaffold(
      title: LocaleKeys.dashboards_common_labels_footerlayout3.tr(),
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
              'footerLayout3 Implementation',
              style: context.textTheme.headlineMedium,
            ),
            SizedBox(height: 8),
            Text(
              LocaleKeys
                  .dashboards_common_labels_this_component_is_part_of_the_shared_layouts_module
                  .tr(),
            ),
          ],
        ),
      ),
    );
  }
}
