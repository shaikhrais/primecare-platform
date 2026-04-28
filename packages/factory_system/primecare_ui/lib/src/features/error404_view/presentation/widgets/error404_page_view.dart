// PRIMECARE CONSOLIDATED FILE
import 'package:primecare_ui/src/shared/primecare_adapters.dart'
    hide isOnlineProvider, ProviderTTL;

// Layer: 05_UI_PRESENTATION

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
