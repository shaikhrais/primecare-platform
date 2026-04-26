// Layer: 05_UI_PRESENTATION
import 'package:primecare_ui/primecare_ui.dart';

class UnderlineIconScreen extends ConsumerWidget {
  final dynamic data;

  UnderlineIconScreen({super.key, this.data});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return PrimeCareScaffold(
      title: LocaleKeys.dashboards_common_labels_underlineicon.tr(),
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
              'underlineIcon Implementation',
              style: context.textTheme.headlineMedium,
            ),
            SizedBox(height: 8),
            Text(
              LocaleKeys
                  .dashboards_common_labels_this_component_is_part_of_the_shared_icons_module
                  .tr(),
            ),
          ],
        ),
      ),
    );
  }
}
