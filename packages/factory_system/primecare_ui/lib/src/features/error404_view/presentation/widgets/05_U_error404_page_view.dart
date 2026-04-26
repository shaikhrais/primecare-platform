// Layer: 05_UI_PRESENTATION
import 'package:primecare_ui/primecare_ui.dart';

/// Hardened error404PageView
class Error404pageview extends StatelessWidget {
  Error404pageview({super.key});

  @override
  Widget build(BuildContext context) {
    return PrimeCareResponsiveKpiGrid(
      children: [
        PrimeCareCard(
          child: Text(
            LocaleKeys
                .dashboards_common_labels_operational_sector__error404pageview
                .tr(),
          ),
        ),
      ],
    );
  }
}
