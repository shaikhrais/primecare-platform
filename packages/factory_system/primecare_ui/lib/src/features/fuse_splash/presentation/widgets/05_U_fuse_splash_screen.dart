// Layer: 05_UI_PRESENTATION
import 'package:primecare_ui/primecare_ui.dart';

/// Hardened fuse_splash_screen
class FuseSplashScreen extends StatelessWidget {
  FuseSplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ClinicalGlassPanel(
      title: LocaleKeys.dashboards_common_labels_fuse_splash_screen.tr(),
      child: PrimeCareCard(
        child: Text(
          LocaleKeys
              .dashboards_common_labels_operational_sector__fuse_splash_screen
              .tr(),
        ),
      ),
    );
  }
}
