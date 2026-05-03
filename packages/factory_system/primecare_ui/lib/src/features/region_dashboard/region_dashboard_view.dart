// PRIMECARE CONSOLIDATED FILE
import 'package:primecare_ui/src/features/features_controller.dart';
import 'package:primecare_ui/src/shared/primecare_adapters.dart'
// @governance: isRenderOk=true
// @governance: userApprovedLayout=true
// @governance: lifecycleStatus=completed

    hide isOnlineProvider, ProviderTTL;

class RegionDashboardView extends ConsumerWidget {
  const RegionDashboardView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncData = ref.watch(regionDashboardAdapterProvider);

    return PageTemplate(
      title: LocaleKeys.dashboards_common_labels_regional_dashboard.tr(),
      subtitle: LocaleKeys
          .dashboards_common_labels_regional_performance_overview
          .tr(),
      actions: [
        IconButton(
          icon: const Icon(Icons.refresh),
          onPressed: () => ref.refresh(regionDashboardAdapterProvider),
        ),
      ],
      body: asyncData.when(
        data: (result) => result.fold(
          (data) => SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                PrimeCareResponsiveKpiGrid(
                  children: data.kpis
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
    if (t.contains('growth')) return Icons.trending_up_outlined;
    if (t.contains('density')) return Icons.map_outlined;
    if (t.contains('resource')) return Icons.people_outline;
    if (t.contains('compliance')) return Icons.gavel_outlined;
    return Icons.analytics_outlined;
  }
}

class RegionDashboardIntent extends PrimeCareScreen {
  RegionDashboardIntent()
    : super(
        name: 'region',
        title: 'dashboards.common.labels.regional_dashboard',
        route: '/offices/corporate/roles/region/dashboard',
        requiredRole: PlatformRole.regionalManagerOntario,
        form: PrimeCareForm.regionDashboard,
        provider: regionDashboardAdapterProvider,
        componentLabels: const [
          'Aura HUD',
          'Regional Performance Comparison',
          'Site Health Overlays',
          'Local Management Controls',
        ],
      );

  @override
  Widget build(BuildContext context) => const RegionDashboardView();
}
