// PRIMECARE CONSOLIDATED FILE
import 'package:primecare_ui/src/features/features_controller.dart';
import 'package:primecare_ui/src/shared/primecare_adapters.dart'
    hide isOnlineProvider, ProviderTTL;

class CtoDashboardView extends ConsumerWidget {
  const CtoDashboardView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncData = ref.watch(ctoDashboardAdapterProvider);

    return PageTemplate(
      title: LocaleKeys.dashboards_common_labels_cto_dashboard.tr(),
      subtitle: LocaleKeys
          .dashboards_common_labels_technical_operations_overview
          .tr(),
      actions: [
        IconButton(
          icon: const Icon(Icons.refresh),
          onPressed: () => ref.refresh(ctoDashboardAdapterProvider),
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
    if (t.contains('uptime') || t.contains('system')) return Icons.dns_outlined;
    if (t.contains('user')) return Icons.people_outline;
    if (t.contains('latency') || t.contains('api')) return Icons.speed_outlined;
    if (t.contains('security')) return Icons.security_outlined;
    return Icons.analytics_outlined;
  }
}

class CtoDashboardIntent extends PrimeCareScreen {
  CtoDashboardIntent() : super(title: 'CtoDashboard');

  @override
  Widget build(BuildContext context) => const CtoDashboardView();
}
