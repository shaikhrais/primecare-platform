// PRIMECARE CONSOLIDATED FILE
import 'package:primecare_ui/src/shared/primecare_adapters.dart'
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
