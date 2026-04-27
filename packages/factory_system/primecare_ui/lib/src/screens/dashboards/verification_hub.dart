// Layer: 05_UI_PRESENTATION
import 'package:primecare_ui/primecare_ui.dart';

class VerificationHub extends ConsumerWidget {
  const VerificationHub({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ds = PrimeCareDesignSystem.of(context);
    final layout = ref.watch(layoutProvider);
    final scale = layout.scaleFactor;

    final asyncVerification = ref.watch(systemVerificationMetricsProvider);

    return PageTemplate(
      title: LocaleKeys.dashboards_common_labels_verification_hub.tr(),
      subtitle: LocaleKeys
          .dashboards_common_labels_system_integrity_and_macro_reconciliation_telemetry_logs
          .tr(),
      body: asyncVerification.when(
        data: (metrics) {
          final statusColor = !metrics.isOfflineFallback
              ? ds.colors.success
              : ds.colors.warning;

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
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
                      !metrics.isOfflineFallback
                          ? Icons.check_circle
                          : Icons.warning_amber_rounded,
                      color: statusColor,
                      size: PrimeCareSpacing.scaled(24, scale),
                    ),
                    SizedBox(width: PrimeCareSpacing.scaled(16, scale)),
                    Text(
                      'Database Status: ${!metrics.isOfflineFallback ? 'CONNECTED' : 'OFFLINE'}',
                      style: Theme.of(
                        context,
                      ).textTheme.titleLarge?.copyWith(color: statusColor),
                    ),
                    if (metrics.isOfflineFallback) ...[
                      Spacer(),
                      Chip(
                        label: Text(
                          LocaleKeys.dashboards_common_labels_offline_fallback
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
                'Table Row Counts',
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              SizedBox(height: PrimeCareSpacing.scaled(16, scale)),
              PrimeResponsiveGrid(
                desktopMainAxisExtent: PrimeCareSpacing.scaled(160, scale),
                children: metrics.kpis.map((kpi) {
                  return Card(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.table_chart_outlined,
                            size: 32,
                            color: PrimeCareColors.slate400,
                          ),
                          const SizedBox(height: 8),
                          Text(
                            kpi.title,
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                          const SizedBox(height: 4),
                          Text(
                            kpi.value,
                            style: Theme.of(context).textTheme.titleLarge,
                          ),
                        ],
                      ),
                    ),
                  );
                }).toList(),
              ),
            ],
          );
        },
        loading: () =>
            Center(child: CircularProgressIndicator(color: ds.colors.primary)),
        error: (err, _) => Center(
          child: Text(
            'Error loading verification logs: $err',
            style: TextStyle(color: ds.colors.error),
          ),
        ),
      ),
    );
  }
}
