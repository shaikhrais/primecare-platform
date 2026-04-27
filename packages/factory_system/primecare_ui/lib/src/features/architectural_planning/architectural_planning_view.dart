import 'package:primecare_ui/primecare_ui.dart';

class ArchitecturalPlanningView extends ConsumerWidget {
  const ArchitecturalPlanningView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncData = ref.watch(architecturalPlanningAdapterProvider);

    return PageTemplate(
      title: LocaleKeys.dashboards_common_labels_architectural_planning_dashboard.tr(),
      subtitle: LocaleKeys
          .dashboards_common_labels_infrastructure_and_architectural_roadmap
          .tr(),
      actions: [
        IconButton(
          icon: const Icon(Icons.refresh),
          onPressed: () => ref.read(architecturalPlanningAdapterProvider.notifier).refresh(),
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
    if (t.contains('roadmap')) return Icons.map_outlined;
    if (t.contains('blueprint')) return Icons.architecture_outlined;
    if (t.contains('capacity')) return Icons.storage_outlined;
    return Icons.account_tree_outlined;
  }
}
class ArchitecturalPlanningIntent extends PrimeCareScreen {
  ArchitecturalPlanningIntent() : super(title: "ArchitecturalPlanning");

  @override
  Widget build(BuildContext context) => const ArchitecturalPlanningView();
}


