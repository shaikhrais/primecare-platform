// @governance: componentLabels=['Aura HUD (Security Alert)', 'Access Request Form', 'Auth Redirect']
// PRIMECARE CONSOLIDATED FILE
import 'package:primecare_ui/src/shared/primecare_adapters.dart'
// @governance: isRenderOk=true
// @governance: userApprovedLayout=true
// @governance: lifecycleStatus=completed

    hide isOnlineProvider, ProviderTTL;

// Layer: 05_UI_PRESENTATION

/// Hardened error401PageView
class Error401pageview extends StatelessWidget {
  Error401pageview({super.key});

  @override
  Widget build(BuildContext context) {
    return PrimeCareResponsiveKpiGrid(
      children: [
        PrimeCareCard(
          child: Text(
            LocaleKeys
                .dashboards_common_labels_operational_sector__error401pageview
                .tr(),
          ),
        ),
      ],
    );
  }
}
