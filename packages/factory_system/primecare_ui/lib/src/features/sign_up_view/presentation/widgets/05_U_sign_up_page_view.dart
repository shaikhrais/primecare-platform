// Layer: 05_UI_PRESENTATION
import 'package:primecare_ui/primecare_ui.dart';

/// Hardened sign_up_page_view
class SignUpPageView extends StatelessWidget {
  SignUpPageView({super.key});

  @override
  Widget build(BuildContext context) {
    return ClinicalGlassPanel(
      title: LocaleKeys.dashboards_common_labels_sign_up_page_view.tr(),
      child: PrimeCareCard(
        child: Text(
          LocaleKeys
              .dashboards_common_labels_operational_sector__sign_up_page_view
              .tr(),
        ),
      ),
    );
  }
}
