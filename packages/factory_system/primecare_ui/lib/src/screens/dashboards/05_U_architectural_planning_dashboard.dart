// Layer: 05_UI_PRESENTATION

import 'package:primecare_ui/primecare_ui.dart';

class ArchitecturalPlanningDashboard extends ConsumerWidget {
  ArchitecturalPlanningDashboard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final PrimeCareDesignSystem ds = PrimeCareDesignSystem.of(context);
    final layout = ref.watch(layoutProvider);
    final double scale = layout.scaleFactor;

    final asyncData = ref.watch(architecturePlanningMetricsProvider);

    return PageTemplate(
      title: LocaleKeys.dashboards_common_labels_architectural_governance.tr(),
      subtitle:
          'Real-time telemetry of the platform\'s strategic mapping across Layers.',
      body: asyncData.when(
        data: (metrics) {
          final int flaggedGaps =
              int.tryParse(
                metrics.kpis
                    .firstWhere(
                      (k) => k.title == 'Flagged Gaps',
                      orElse: () => KpiMetric(
                        title: '',
                        value: '0',
                        status: 'neutral',
                      ),
                    )
                    .value,
              ) ??
              0;
          final bool hasAnomalies = flaggedGaps > 0;
          final Color statusColor = hasAnomalies
              ? ds.colors.warning
              : ds.colors.success;

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Overall Status
              Container(
                padding: EdgeInsets.all(PrimeCareSpacing.scaled(16, scale)),
                decoration: BoxDecoration(
                  color: statusColor.withValues(alpha: 0.1),
                  border: Border.all(color: statusColor),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  children: [
                    Icon(
                      hasAnomalies
                          ? Icons.warning_amber_rounded
                          : Icons.check_circle,
                      color: statusColor,
                      size: PrimeCareSpacing.scaled(24, scale),
                    ),
                    SizedBox(width: PrimeCareSpacing.scaled(16, scale)),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          hasAnomalies
                              ? 'IMPLEMENTATION CONCERNS OBSERVED'
                              : 'STRUCTURAL PARITY MAINTAINED',
                          style: Theme.of(context).textTheme.titleMedium
                              ?.copyWith(
                                color: statusColor,
                                fontWeight: FontWeight.bold,
                              ),
                        ),
                        if (hasAnomalies)
                          Text(
                            '$flaggedGaps capabilities lack native API implementation',
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                      ],
                    ),
                    if (metrics.isOfflineFallback) ...[
                      Spacer(),
                      Chip(
                        label: Text(
                          LocaleKeys.dashboards_common_labels_offline_cache
                              .tr(),
                        ),
                        backgroundColor: PrimeCareColors.amber,
                        labelStyle: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ],
                ),
              ),
              SizedBox(height: PrimeCareSpacing.scaled(32, scale)),
              Text(
                'Architecture Metrics',
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              SizedBox(height: PrimeCareSpacing.scaled(16, scale)),
              Wrap(
                spacing: PrimeCareSpacing.scaled(16, scale),
                runSpacing: PrimeCareSpacing.scaled(16, scale),
                children: metrics.kpis.map((kpi) {
                  return Container(
                    width: PrimeCareSpacing.scaled(200, scale),
                    padding: EdgeInsets.all(PrimeCareSpacing.scaled(16, scale)),
                    decoration: BoxDecoration(
                      color: PrimeCareColors.slate800,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          kpi.title,
                          style: Theme.of(context).textTheme.titleSmall
                              ?.copyWith(color: PrimeCareColors.slate300),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          kpi.value,
                          style: Theme.of(context).textTheme.headlineSmall
                              ?.copyWith(
                                color: kpi.status == 'success'
                                    ? ds.colors.success
                                    : (kpi.status == 'warning'
                                          ? ds.colors.warning
                                          : PrimeCareColors.white),
                                fontWeight: FontWeight.bold,
                              ),
                        ),
                      ],
                    ),
                  );
                }).toList(),
              ),
              SizedBox(height: PrimeCareSpacing.scaled(32, scale)),
              Text(
                'Recent Activities & Insights',
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              SizedBox(height: PrimeCareSpacing.scaled(16, scale)),
              for (final activity in metrics.recentActivity)
                Card(
                  color: PrimeCareColors.slate800,
                  margin: EdgeInsets.only(
                    bottom: PrimeCareSpacing.scaled(12, scale),
                  ),
                  child: ListTile(
                    leading: Icon(
                      Icons.info_outline,
                      color: activity.color == 'green'
                          ? ds.colors.success
                          : ds.colors.warning,
                    ),
                    title: Text(
                      activity.title,
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        color: PrimeCareColors.white,
                      ),
                    ),
                    subtitle: Text(
                      activity.subtitle,
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: PrimeCareColors.slate300,
                      ),
                    ),
                    trailing: Text(
                      activity.timestamp,
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: PrimeCareColors.slate400,
                      ),
                    ),
                  ),
                ),
            ],
          );
        },
        loading: () =>
            Center(child: CircularProgressIndicator(color: ds.colors.primary)),
        error: (err, _) => Center(
          child: Text(
            'Error loading architecture planning data: $err',
            style: TextStyle(color: ds.colors.error),
          ),
        ),
      ),
    );
  }
}
