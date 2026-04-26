// Layer: 05_UI_PRESENTATION
import 'package:primecare_ui/primecare_ui.dart';

/// Hardened full_screen_toggle
class FullScreenToggle extends StatelessWidget {
  FullScreenToggle({super.key});

  @override
  Widget build(BuildContext context) {
    return ClinicalGlassPanel(
      title: LocaleKeys.dashboards_common_labels_full_screen_toggle.tr(),
      child: PrimeCareCard(
        child: Text(
          LocaleKeys
              .dashboards_common_labels_operational_sector__full_screen_toggle
              .tr(),
        ),
      ),
    );
  }
}
