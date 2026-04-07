import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:primecare_v4/design_system/clinical_glass.dart';
import 'package:primecare_v4/design_system/primecare_theme.dart';
import 'package:primecare_v4/shared/components/page_template.dart';
import '../../../../providers/dashboard_providers.dart';

class CtoDashboard extends ConsumerWidget {
  const CtoDashboard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final metricsAsync = ref.watch(dashboardMetricsProvider);

    return metricsAsync.when(
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (err, stack) => Center(child: Text('Error loading metrics: $err')),
      data: (metrics) => PageTemplate(
        title: 'CTO Command Center',
        subtitle: 'Infrastructure & Orchestration',
        icon: LucideIcons.terminal,
        actions: [
          _buildActionIconButton(context, LucideIcons.refreshCcw, 'Refresh Cache'),
          const SizedBox(width: 12),
          _buildActionIconButton(context, LucideIcons.settings, 'System Settings'),
        ],
        body: ListView(
          padding: const EdgeInsets.only(bottom: 32),
          children: [
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
                      _buildMicroserviceHealth(context),
                    ],
                  ),
                ),
                const SizedBox(width: 24),
                Expanded(
                  flex: 1,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      _buildDeploymentFeed(context, metrics),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildActionIconButton(BuildContext context, IconData icon, String tooltip) {
    return Container(
      decoration: BoxDecoration(
        color: PrimeCareTheme.surface.withValues(alpha: 0.8),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: PrimeCareTheme.outlineVariant.withValues(alpha: 0.5)),
      ),
      child: IconButton(
        icon: Icon(icon, color: PrimeCareTheme.surfaceOn),
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

  Widget _buildMicroserviceHealth(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Microservice Health Matrix',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.w600,
                fontFamily: 'Outfit',
                color: PrimeCareTheme.surfaceOn,
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
              decoration: BoxDecoration(
                color: PrimeCareTheme.emeraldTeal.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Text(
                'v4.2.1-stable',
                style: Theme.of(context).textTheme.labelSmall?.copyWith(
                  color: PrimeCareTheme.emeraldTeal,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        ClinicalGlassPanel(
          padding: const EdgeInsets.all(24),
          child: Column(
            children: [
              _buildServiceRow(context, 'Core Worker-API', 'Active', '99.99% Uptime in trailing 24h', PrimeCareTheme.emeraldTeal),
              const Divider(color: PrimeCareTheme.surfaceDim, height: 32),
              _buildServiceRow(context, 'Auth-Vault v2', 'Active', 'Latencies < 40ms', PrimeCareTheme.emeraldTeal),
              const Divider(color: PrimeCareTheme.surfaceDim, height: 32),
              _buildServiceRow(context, 'Prisma-Pulse Proxy', 'Degraded', 'Replication lag detected', PrimeCareTheme.amberWarning),
              const Divider(color: PrimeCareTheme.surfaceDim, height: 32),
              _buildServiceRow(context, 'Media Transmuxing', 'Active', 'Queue depth normal', PrimeCareTheme.emeraldTeal),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildServiceRow(BuildContext context, String name, String status, String note, Color statusColor) {
    return Row(
      children: [
        Container(
          width: 8,
          height: 8,
          decoration: BoxDecoration(
            color: statusColor,
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: statusColor.withValues(alpha: 0.4),
                blurRadius: 6,
                spreadRadius: 2,
              )
            ],
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                name,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                  color: PrimeCareTheme.surfaceOn,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                note,
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: PrimeCareTheme.surfaceOnVariant,
                ),
              ),
            ],
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
          decoration: BoxDecoration(
            color: statusColor.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(6),
          ),
          child: Text(
            status.toUpperCase(),
            style: Theme.of(context).textTheme.labelSmall?.copyWith(
              color: statusColor,
              fontWeight: FontWeight.w700,
              letterSpacing: 0.5,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildDeploymentFeed(BuildContext context, dynamic metrics) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Direct Deployment Feed',
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
            children: metrics.recentActivity
                .take(4)
                .map<Widget>(
                  (log) => Column(
                    children: [
                      _buildAuditRow(
                        context,
                        log.title,
                        log.subtitle,
                        _getLucideActivityIcon(log.icon),
                        _getLucideStatusColor(log.color),
                        log.timestamp,
                      ),
                      if (log != metrics.recentActivity.take(4).last)
                        const Divider(color: PrimeCareTheme.surfaceDim, height: 24),
                    ],
                  ),
                )
                .toList(),
          ),
        ),
      ],
    );
  }

  Widget _buildAuditRow(BuildContext context, String title, String subtitle, IconData icon, Color color, String time) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.1),
            shape: BoxShape.circle,
          ),
          child: Icon(icon, size: 16, color: color),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: Theme.of(context).textTheme.labelLarge?.copyWith(
                  fontWeight: FontWeight.w600,
                  color: PrimeCareTheme.surfaceOn,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                subtitle,
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: PrimeCareTheme.surfaceOnVariant,
                ),
              ),
            ],
          ),
        ),
        Text(
          time,
          style: Theme.of(context).textTheme.labelSmall?.copyWith(
            color: PrimeCareTheme.surfaceOnVariant,
          ),
        ),
      ],
    );
  }

  IconData _getLucideIcon(String title) {
    if (title.contains('Uptime')) return LucideIcons.cloud;
    if (title.contains('Throughput')) return LucideIcons.zap;
    if (title.contains('Connections')) return LucideIcons.server;
    if (title.contains('Latency')) return LucideIcons.activity;
    if (title.contains('Staff')) return LucideIcons.users;
    return LucideIcons.barChart2;
  }

  IconData _getLucideActivityIcon(String icon) {
    switch (icon) {
      case 'verified':
        return LucideIcons.checkCircle;
      case 'person_add':
        return LucideIcons.userPlus;
      case 'security':
        return LucideIcons.shieldCheck;
      case 'rocket':
        return LucideIcons.rocket;
      case 'schema':
        return LucideIcons.database;
      case 'cleaning':
        return LucideIcons.wrench;
      default:
        return LucideIcons.history;
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
