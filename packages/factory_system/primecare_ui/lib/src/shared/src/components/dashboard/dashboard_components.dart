// Layer: 02_COMPONENTS_DASHBOARD
// Architecture: Class-Based Unified Dashboard Components

import 'package:primecare_ui/src/shared/primecare_adapters.dart';
import '../../integration/platform_governance_registry.dart';
import 'package:primecare_ui/src/theme/primecare_theme.dart';

/// [View Component] - A premium grid for high-precision KPI metrics.
class DashboardKpiGrid extends StatelessWidget {
  final List<KpiMetric> metrics;

  const DashboardKpiGrid({required this.metrics, super.key});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: 280,
        mainAxisSpacing: 16,
        crossAxisSpacing: 16,
        childAspectRatio: 1.6,
      ),
      itemCount: metrics.length,
      itemBuilder: (context, index) {
        final kpi = metrics[index];
        return PrimeCareKpiCard(
          title: kpi.title,
          value: kpi.value,
          subtitle: kpi.subtitle ?? '',
          icon: _mapStatusToIcon(kpi.status),
          color: _mapStatusToColor(context, kpi.status),
        );
      },
    );
  }

  IconData _mapStatusToIcon(String status) {
    switch (status.toLowerCase()) {
      case 'positive':
      case 'success':
        return Icons.trending_up;
      case 'negative':
      case 'critical':
        return Icons.trending_down;
      case 'warning':
        return Icons.warning_amber_rounded;
      default:
        return Icons.bar_chart;
    }
  }

  Color? _mapStatusToColor(BuildContext context, String status) {
    final theme = context.theme;
    switch (status.toLowerCase()) {
      case 'positive':
      case 'success':
        return theme.colors.success.withAlpha(20);
      case 'negative':
      case 'critical':
        return theme.colors.error.withAlpha(20);
      case 'warning':
        return Colors.orange.withAlpha(20);
      default:
        return null;
    }
  }
}

/// [View Component] - A premium card for Actionable Insights.
class ActionableInsightCard extends StatelessWidget {
  final DashboardInsight insight;

  const ActionableInsightCard({required this.insight, super.key});

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    
    return PrimeCareCard(
      margin: const EdgeInsets.only(bottom: 12),
      color: _mapImpactToColor(context, insight.impact),
      child: IntrinsicHeight(
        child: Row(
          children: [
            Container(
              width: 4,
              decoration: BoxDecoration(
                color: _mapImpactToIndicatorColor(context, insight.impact),
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    insight.title,
                    style: theme.typography.labelLarge.copyWith(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    insight.description,
                    style: theme.typography.bodySmall,
                  ),
                ],
              ),
            ),
            Icon(
              _mapImpactToIcon(insight.impact),
              color: _mapImpactToIndicatorColor(context, insight.impact),
              size: 20,
            ),
          ],
        ),
      ),
    );
  }

  Color _mapImpactToColor(BuildContext context, InsightImpact? impact) {
    final theme = context.theme;
    switch (impact) {
      case InsightImpact.growth:
      case InsightImpact.positive:
        return theme.colors.success.withAlpha(10);
      case InsightImpact.critical:
      case InsightImpact.warning:
        return theme.colors.error.withAlpha(10);
      case InsightImpact.caution:
        return Colors.orange.withAlpha(10);
      default:
        return theme.colors.surface;
    }
  }

  Color _mapImpactToIndicatorColor(BuildContext context, InsightImpact? impact) {
    final theme = context.theme;
    switch (impact) {
      case InsightImpact.growth:
      case InsightImpact.positive:
        return theme.colors.success;
      case InsightImpact.critical:
      case InsightImpact.warning:
        return theme.colors.error;
      case InsightImpact.caution:
        return Colors.orange;
      default:
        return theme.colors.primary;
    }
  }

  IconData _mapImpactToIcon(InsightImpact? impact) {
    switch (impact) {
      case InsightImpact.growth:
        return Icons.auto_graph;
      case InsightImpact.critical:
        return Icons.gpp_maybe;
      case InsightImpact.caution:
        return Icons.lightbulb_outline;
      default:
        return Icons.info_outline;
    }
  }
}

/// [View Component] - A standard header for dashboard sections.
class DashboardSectionHeader extends StatelessWidget {
  final String title;
  final Widget? trailing;

  const DashboardSectionHeader({required this.title, this.trailing, super.key});

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title, style: theme.typography.titleMedium.copyWith(fontWeight: FontWeight.bold)),
          if (trailing != null) trailing!,
        ],
      ),
    );
  }
}

/// [View Component] - A "Digital Audit Plate" for Lifetime Variables.
/// Displays immutable structural metadata from the Master Registry.
class SystemIntegrityManifest extends StatelessWidget {
  const SystemIntegrityManifest({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    final stats = PlatformGovernanceRegistry.getManifestSummary();

    return PrimeCareCard(
      color: theme.colors.slateGray.withAlpha(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.verified_user_outlined, color: theme.colors.primary, size: 20),
              const SizedBox(width: 12),
              Text('System Integrity Manifest', style: theme.typography.labelLarge),
              const Spacer(),
              const Badge(label: Text(PlatformGovernanceRegistry.buildVersion)),
            ],
          ),
          const Divider(height: 32),
          Wrap(
            spacing: 24,
            runSpacing: 16,
            children: stats.entries.map((e) => _ManifestItem(label: e.key, value: e.value)).toList(),
          ),
        ],
      ),
    );
  }
}

class _ManifestItem extends StatelessWidget {
  final String label;
  final String value;

  const _ManifestItem({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: theme.typography.labelSmall.copyWith(color: theme.colors.slateGray)),
        const SizedBox(height: 4),
        Text(value, style: theme.typography.bodyMedium.copyWith(fontWeight: FontWeight.bold)),
      ],
    );
  }
}

/// [View Component] - A grid for Analytics Charts.
class DashboardAnalyticsCharts extends StatelessWidget {
  final List<AnalyticsChart> charts;

  const DashboardAnalyticsCharts({required this.charts, super.key});

  @override
  Widget build(BuildContext context) {
    if (charts.isEmpty) return const SizedBox.shrink();
    
    return LayoutBuilder(
      builder: (context, constraints) {
        final isMobile = constraints.maxWidth < 600;
        final isTablet = constraints.maxWidth >= 600 && constraints.maxWidth < 1024;
        
        final crossAxisCount = isMobile ? 1 : (isTablet ? 2 : 2);
        
        return GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: crossAxisCount,
            mainAxisSpacing: 16,
            crossAxisSpacing: 16,
            mainAxisExtent: 350, // Fixed height for chart cards
          ),
          itemCount: charts.length,
          itemBuilder: (context, index) {
            final chart = charts[index];
            return PrimeCareChartCard(
              title: chart.title,
              chart: PrimeCareLineChart(chart: chart),
            );
          },
        );
      },
    );
  }
}
