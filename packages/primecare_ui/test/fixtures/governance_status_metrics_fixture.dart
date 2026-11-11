// Exact generated Active/Clear/Latency card calls inside a minimal build context.
import 'package:primecare_ui/primecare_ui.dart';

class GovernanceStatusMetricsFixture extends StatelessWidget {
  const GovernanceStatusMetricsFixture({super.key});
  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    return Column(children: [
GovMetricCard(
                title: 'Operational Status',
                value: 'Active',
                trendLabel: 'Optimal',
                progress: 0.92,
                icon: LucideIcons.activity,
                brandColor: theme.colors.success,
              ),GovMetricCard(
                title: 'Security Sync',
                value: 'Clear',
                trendLabel: 'Secured',
                progress: 1.0,
                icon: LucideIcons.shieldCheck,
                brandColor: theme.colors.success,
              ),
      GovMetricCard(title: 'Latency Telemetry', value: '14ms',
        trendLabel: 'Optimal', progress: 0.97, icon: LucideIcons.zap,
        brandColor: theme.colors.warning),
    ]);
  }
}
