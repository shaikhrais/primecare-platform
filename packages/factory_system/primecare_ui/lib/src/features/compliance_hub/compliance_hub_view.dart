// PRIMECARE CONSOLIDATED FILE
import 'package:primecare_ui/src/features/features_controller.dart';
import 'package:primecare_ui/src/shared/primecare_adapters.dart'
    hide isOnlineProvider, ProviderTTL;

class ComplianceHubView extends ConsumerWidget {
  const ComplianceHubView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncData = ref.watch(complianceHubAdapterProvider);

    return PageTemplate(
      title: LocaleKeys.dashboards_common_labels_compliance_hub.tr(),
      subtitle: LocaleKeys
          .dashboards_common_labels_regulatory_and_standard_compliance_status
          .tr(),
      actions: [
        IconButton(
          icon: const Icon(Icons.refresh),
          onPressed: () => ref.refresh(complianceHubAdapterProvider),
        ),
      ],
      body: asyncData.when(
        data: (result) => result.fold(
          (data) => SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const AuraDashboardHud(),
                const SizedBox(height: 24),
                PrimeCareResponsiveKpiGrid(
                  children: data.metrics.kpis
                      .map(
                        (kpi) => PrimeCareKpiCard(
                          title: kpi.title,
                          value: kpi.value,
                          subtitle: kpi.subtitle ?? '',
                          icon: _getIconForMetric(kpi.title),
                          onPinToggle: () {},
                        ),
                      )
                      .toList(),
                ),
              ],
            ),
          ),
          (error) => Center(child: Text(error.toString())),
        ),
        loading: () => const PrimeCareSkeleton(),
        error: (e, s) => Center(child: Text(e.toString())),
      ),
    );
  }

  IconData _getIconForMetric(String title) {
    final t = title.toLowerCase();
    if (t.contains('drift')) return Icons.warning_amber_outlined;
    if (t.contains('score')) return Icons.speed_outlined;
    if (t.contains('audit')) return Icons.fact_check_outlined;
    return Icons.security_outlined;
  }
}

class ComplianceHubIntent extends PrimeCareScreen {
  ComplianceHubIntent()
    : super(
        title: 'ComplianceHub',
        route: '/offices/corporate/roles/compliance_manager/dashboard',
      );

  @override
  Widget build(BuildContext context) => const ComplianceHubView();
}
