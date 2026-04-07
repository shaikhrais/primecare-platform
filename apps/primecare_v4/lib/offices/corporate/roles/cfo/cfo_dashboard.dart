import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:primecare_v4/design_system/clinical_glass.dart';
import 'package:primecare_v4/design_system/primecare_theme.dart';
import 'package:primecare_v4/shared/components/page_template.dart';
import '../../../../providers/dashboard_providers.dart';

class CfoDashboard extends ConsumerWidget {
  const CfoDashboard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final metricsAsync = ref.watch(dashboardMetricsProvider);

    return metricsAsync.when(
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (err, stack) => Center(child: Text('Error loading metrics: $err')),
      data: (metrics) => PageTemplate(
        title: 'Financial Command Center',
        subtitle: 'Enterprise Ledger & Margin Analysis',
        icon: LucideIcons.pieChart,
        actions: [
          _buildActionIconButton(context, LucideIcons.download, 'Export Audit Report'),
          const SizedBox(width: 12),
          _buildActionIconButton(context, LucideIcons.settings, 'Financial Settings'),
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
                      _buildRegionalMarginAnalysis(context),
                      const SizedBox(height: 24),
                      _buildComplianceStatus(context),
                    ],
                  ),
                ),
                const SizedBox(width: 24),
                Expanded(
                  flex: 1,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      _buildLedgerAuditLogs(context),
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

  Widget _buildRegionalMarginAnalysis(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Regional Margin Analysis',
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
              _buildRegionRow(context, 'Greater Toronto Area', '24 Units', '\$5.2M', '34% MARGIN', PrimeCareTheme.emeraldTeal),
              const Divider(color: PrimeCareTheme.surfaceDim, height: 32),
              _buildRegionRow(context, 'Vancouver Metro', '16 Units', '\$3.1M', '29% MARGIN', PrimeCareTheme.emeraldTeal),
              const Divider(color: PrimeCareTheme.surfaceDim, height: 32),
              _buildRegionRow(context, 'US Expansion (TX)', '4 Units', '\$1.1M', '18% MARGIN', PrimeCareTheme.amberWarning),
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

  Widget _buildComplianceStatus(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Compliance Status',
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.w600,
            fontFamily: 'Outfit',
            color: PrimeCareTheme.surfaceOn,
          ),
        ),
        const SizedBox(height: 16),
        ClinicalGlassPanel(
          padding: const EdgeInsets.all(24),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: PrimeCareTheme.emeraldTeal.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Icon(LucideIcons.shieldCheck, color: PrimeCareTheme.emeraldTeal),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'PRE-AUDIT VERIFIED',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w700,
                        fontFamily: 'Outfit',
                        color: PrimeCareTheme.emeraldTeal,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'All ledger entries for Q3 have been reconciled. No discrepancies detected in regional payroll distributions.',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        height: 1.5,
                        color: PrimeCareTheme.surfaceOnVariant,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildLedgerAuditLogs(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Ledger Audit Logs',
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
            children: [
              _buildAuditRow(context, 'Payroll Anomaly', 'Hamilton - Verification Required', LucideIcons.alertTriangle, PrimeCareTheme.amberWarning),
              const Divider(color: PrimeCareTheme.surfaceDim, height: 24),
              _buildAuditRow(context, 'Q3 Tax Remittance', 'Pending Signature', LucideIcons.fileSignature, PrimeCareTheme.navyIndigo),
              const Divider(color: PrimeCareTheme.surfaceDim, height: 24),
              _buildAuditRow(context, 'Funds Cleared', 'Inbound TX #9021', LucideIcons.checkCircle2, PrimeCareTheme.emeraldTeal),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildAuditRow(BuildContext context, String title, String subtitle, IconData icon, Color color) {
    return Row(
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
              Text(
                subtitle,
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: PrimeCareTheme.surfaceOnVariant,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  IconData _getLucideIcon(String title) {
    if (title.contains('Revenue')) return LucideIcons.dollarSign;
    if (title.contains('Margin')) return LucideIcons.pieChart;
    if (title.contains('Payroll')) return LucideIcons.users;
    if (title.contains('Cash')) return LucideIcons.banknote;
    if (title.contains('Compliance')) return LucideIcons.shieldCheck;
    return LucideIcons.activity;
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

