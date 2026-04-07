import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:primecare_v4/design_system/clinical_glass.dart';
import 'package:primecare_v4/design_system/primecare_theme.dart';
import 'package:primecare_v4/shared/components/page_template.dart';
import '../../../../providers/dashboard_providers.dart';

class CeoDashboard extends ConsumerWidget {
  const CeoDashboard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final metricsAsync = ref.watch(dashboardMetricsProvider);

    return metricsAsync.when(
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (err, stack) => Center(child: Text('Error loading metrics: $err')),
      data: (metrics) => PageTemplate(
        header: PageHeader(
          title: 'CEO Enterprise Overview',
          subtitle: 'Strategic real-time monitoring across the clinical network.',
          actions: [
            _buildActionIconButton(context, LucideIcons.download, 'Export Report'),
            const SizedBox(width: 12),
            _buildActionIconButton(context, LucideIcons.settings, 'Settings'),
          ],
        ),
        content: [
          _buildKPIs(context, metrics),
          const SizedBox(height: 24),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 2,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    _buildRegionalPerformance(context),
                    const SizedBox(height: 24),
                    _buildGrowthInsights(context),
                  ],
                ),
              ),
              const SizedBox(width: 24),
              Expanded(
                flex: 1,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    _buildExecutiveActions(context),
                    const SizedBox(height: 24),
                    _buildCriticalActivityFeed(context, metrics),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildActionIconButton(BuildContext context, IconData icon, String tooltip) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.white.withValues(alpha: 0.2)),
      ),
      child: IconButton(
        icon: Icon(icon, color: Colors.white),
        onPressed: () {},
        tooltip: tooltip,
      ),
    );
  }

  Widget _buildKPIs(BuildContext context, dynamic metrics) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final cardWidth = constraints.maxWidth > 1200
            ? (constraints.maxWidth - 48) / 4
            : (constraints.maxWidth > 600
                  ? (constraints.maxWidth - 16) / 2
                  : constraints.maxWidth);
                  
        return Wrap(
          spacing: 16,
          runSpacing: 16,
          children: metrics.kpis
              .map<Widget>(
                (kpi) => SizedBox(
                  width: cardWidth,
                  child: _buildKPIUnit(
                    context,
                    kpi.title,
                    kpi.value,
                    _getLucideIcon(kpi.title),
                    kpi.subtitle ?? '',
                    _getLucideStatusColor(kpi.status),
                  ),
                ),
              )
              .toList(),
        );
      },
    );
  }

  Widget _buildKPIUnit(BuildContext context, String title, String value, IconData icon, String trend, Color trendColor) {
    return ClinicalGlassPanel(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, size: 20, color: PrimeCareTheme.surfaceOnVariant),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  title,
                  style: Theme.of(context).textTheme.labelMedium?.copyWith(
                        color: PrimeCareTheme.surfaceOnVariant,
                        fontWeight: FontWeight.w500,
                      ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Text(
            value,
            style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  color: PrimeCareTheme.surfaceOn,
                  fontWeight: FontWeight.w700,
                  fontFamily: 'Outfit',
                ),
          ),
          if (trend.isNotEmpty) ...[
            const SizedBox(height: 8),
            Text(
              trend,
              style: Theme.of(context).textTheme.labelSmall?.copyWith(
                    color: trendColor,
                    fontWeight: FontWeight.w600,
                  ),
            ),
          ]
        ],
      ),
    );
  }

  Widget _buildRegionalPerformance(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Regional Performance: Northeast Cluster',
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.w600,
            fontFamily: 'Outfit',
            color: PrimeCareTheme.surfaceOn,
          ),
        ),
        const SizedBox(height: 16),
        ClinicalGlassPanel(
          padding: const EdgeInsets.all(24),
          child: Column(
            children: [
              _buildRegionRow(context, 'Ontario Corridor', '42 Facilities', r'$1.4M', '32.4% ACTIVE', PrimeCareTheme.emeraldTeal),
              const Divider(color: PrimeCareTheme.surfaceDim, height: 32),
              _buildRegionRow(context, 'New York Metro', '36 Facilities', r'$1.1M', '28.1% ACTIVE', PrimeCareTheme.emeraldTeal),
              const Divider(color: PrimeCareTheme.surfaceDim, height: 32),
              _buildRegionRow(context, 'New Jersey Satellite', '18 Facilities', r'$640k', '24.5% STABLE', PrimeCareTheme.navyIndigo),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildRegionRow(BuildContext context, String region, String facilities, String revenue, String margin, Color statusColor) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          flex: 2,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                region,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                  color: PrimeCareTheme.surfaceOn,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                facilities,
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: PrimeCareTheme.surfaceOnVariant,
                ),
              ),
            ],
          ),
        ),
        Expanded(
          flex: 1,
          child: Text(
            revenue,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.w700,
              fontFamily: 'Outfit',
              color: PrimeCareTheme.surfaceOn,
            ),
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          decoration: BoxDecoration(
            color: statusColor.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Text(
            margin,
            style: Theme.of(context).textTheme.labelSmall?.copyWith(
              color: statusColor,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildGrowthInsights(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Growth Pipeline & Insights',
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.w600,
            fontFamily: 'Outfit',
            color: PrimeCareTheme.surfaceOn,
          ),
        ),
        const SizedBox(height: 16),
        ClinicalGlassPanel(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: PrimeCareTheme.emeraldTeal.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Icon(LucideIcons.lightbulb, color: PrimeCareTheme.emeraldTeal),
                  ),
                  const SizedBox(width: 16),
                  Text(
                    'CEO Strategic Insight',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                      fontFamily: 'Outfit',
                      color: PrimeCareTheme.surfaceOn,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Text(
                'Expansion in the Hamilton cluster is outpacing projections. Recommend accelerating the Q4 site visits to finalize the three new clinic locations in NY currently under review.',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  height: 1.5,
                  color: PrimeCareTheme.surfaceOnVariant,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildExecutiveActions(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Executive Actions',
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.w600,
            fontFamily: 'Outfit',
            color: PrimeCareTheme.surfaceOn,
          ),
        ),
        const SizedBox(height: 16),
        _buildActionRow(context, 'Approve Expansion', 'Review 3 clinic locations in NY', LucideIcons.building2),
        const SizedBox(height: 12),
        _buildActionRow(context, 'Review Q3 Report', 'Financial audit for Northeast', LucideIcons.fileText),
        const SizedBox(height: 12),
        _buildActionRow(context, 'Board Messages', '2 priority updates from investors', LucideIcons.messageSquare),
      ],
    );
  }

  Widget _buildActionRow(BuildContext context, String title, String subtitle, IconData icon) {
    return ClinicalGlassPanel(
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          Icon(icon, color: PrimeCareTheme.emeraldTeal, size: 24),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: Theme.of(context).textTheme.titleSmall?.copyWith(
                    fontWeight: FontWeight.w600,
                    color: PrimeCareTheme.surfaceOn,
                  ),
                ),
                Text(
                  subtitle,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: PrimeCareTheme.surfaceOnVariant,
                  ),
                ),
              ],
            ),
          ),
          const Icon(LucideIcons.chevronRight, color: PrimeCareTheme.surfaceOnVariant, size: 20),
        ],
      ),
    );
  }

  Widget _buildCriticalActivityFeed(BuildContext context, dynamic metrics) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Critical Activity Feed',
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.w600,
            fontFamily: 'Outfit',
            color: PrimeCareTheme.surfaceOn,
          ),
        ),
        const SizedBox(height: 16),
        ClinicalGlassPanel(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: metrics.recentActivity.map<Widget>((log) {
              final isLast = log == metrics.recentActivity.last;
              return Column(
                children: [
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: _getLucideStatusColor(log.color).withValues(alpha: 0.1),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          _getLucideActivityIcon(log.icon),
                          size: 16,
                          color: _getLucideStatusColor(log.color),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              log.title,
                              style: Theme.of(context).textTheme.labelLarge?.copyWith(
                                fontWeight: FontWeight.w600,
                                color: PrimeCareTheme.surfaceOn,
                              ),
                            ),
                            Text(
                              log.subtitle,
                              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                color: PrimeCareTheme.surfaceOnVariant,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Text(
                        log.timestamp,
                        style: Theme.of(context).textTheme.labelSmall?.copyWith(
                          color: PrimeCareTheme.surfaceOnVariant,
                        ),
                      ),
                    ],
                  ),
                  if (!isLast)
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 12.0),
                      child: Divider(color: PrimeCareTheme.surfaceDim, height: 1),
                    ),
                ],
              );
            }).toList(),
          ),
        ),
      ],
    );
  }

  IconData _getLucideIcon(String title) {
    if (title.contains('Revenue')) return LucideIcons.dollarSign;
    if (title.contains('Locations')) return LucideIcons.mapPin;
    if (title.contains('Hours')) return LucideIcons.clock;
    if (title.contains('Compliance')) return LucideIcons.shieldCheck;
    if (title.contains('Staff')) return LucideIcons.users;
    return LucideIcons.activity;
  }

  IconData _getLucideActivityIcon(String icon) {
    switch (icon) {
      case 'verified':
        return LucideIcons.checkCircle;
      case 'person_add':
        return LucideIcons.userPlus;
      case 'security':
        return LucideIcons.shield;
      case 'trending_up':
        return LucideIcons.trendingUp;
      case 'warning':
        return LucideIcons.alertTriangle;
      default:
        return LucideIcons.clock;
    }
  }

  Color _getLucideStatusColor(String status) {
    switch (status) {
      case 'success':
      case 'green':
      case 'teal':
        return PrimeCareTheme.emeraldTeal;
      case 'warning':
      case 'orange':
        return PrimeCareTheme.amberWarning;
      case 'danger':
      case 'red':
        return Colors.red;
      case 'info':
      case 'blue':
      case 'indigo':
        return PrimeCareTheme.navyIndigo;
      default:
        return PrimeCareTheme.surfaceOnVariant;
    }
  }
}
