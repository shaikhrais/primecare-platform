import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:primecare_v4/design_system/clinical_glass.dart';
import 'package:primecare_v4/design_system/primecare_theme.dart';
import 'package:primecare_v4/shared/components/page_template.dart';
import '../../../../providers/dashboard_providers.dart';

class FinancialReportsView extends ConsumerWidget {
  const FinancialReportsView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final metricsAsync = ref.watch(dashboardMetricsProvider);

    return metricsAsync.when(
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (err, stack) => Center(child: Text('Error loading reports: $err')),
      data: (metrics) => PageTemplate(
        title: 'Consolidated Financial Reports',
        subtitle: 'Enterprise Ledger, Trial Balance & Tax Compliance',
        icon: LucideIcons.fileSpreadsheet,
        actions: [
          _buildActionIconButton(context, LucideIcons.filePlus, 'New Report Request'),
          const SizedBox(width: 12),
          _buildActionIconButton(context, LucideIcons.download, 'Export All'),
        ],
        body: ListView(
          padding: const EdgeInsets.only(bottom: 32),
          children: [
            _buildFinanceHud(context),
            const SizedBox(height: 24),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 3,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      _buildPerformanceTrends(context),
                      const SizedBox(height: 24),
                      _buildAccessRepository(context),
                    ],
                  ),
                ),
                const SizedBox(width: 24),
                Expanded(
                  flex: 2,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      _buildTaxCompliance(context),
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

  Widget _buildFinanceHud(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Row(
          children: [
            Expanded(
              child: _buildKPIUnit(context, 'Total Revenue', r'$14.2M', LucideIcons.wallet, '+12% vs last month', PrimeCareTheme.emeraldTeal),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: _buildKPIUnit(context, 'Net Profit', r'$840K', LucideIcons.trendingUp, 'Q3 Aggregated', PrimeCareTheme.navyIndigo),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: _buildKPIUnit(context, 'Awaiting Pay', r'$2.4M', LucideIcons.timer, 'Due in 2 days', PrimeCareTheme.amberWarning),
            ),
          ],
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
          const SizedBox(height: 8),
          Text(
            trend,
            style: Theme.of(context).textTheme.labelSmall?.copyWith(
                  color: trendColor,
                  fontWeight: FontWeight.w600,
                ),
          ),
        ],
      ),
    );
  }

  Widget _buildPerformanceTrends(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Quarterly Revenue Dynamics',
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
              _buildTrendRow(context, 'Clinic Service Revenue', r'$8.4M', '+4.2%', PrimeCareTheme.emeraldTeal),
              const Divider(color: PrimeCareTheme.surfaceDim, height: 32),
              _buildTrendRow(context, 'Franchise Royalty Fees', r'$2.1M', '+2.1%', PrimeCareTheme.navyIndigo),
              const Divider(color: PrimeCareTheme.surfaceDim, height: 32),
              _buildTrendRow(context, 'Institutional Partnerships', r'$3.7M', '-0.5%', PrimeCareTheme.amberWarning),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildTrendRow(BuildContext context, String label, String value, String change, Color color) {
    return Row(
      children: [
        CircleAvatar(radius: 4, backgroundColor: color),
        const SizedBox(width: 16),
        Expanded(
          child: Text(
            label,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.w600,
              color: PrimeCareTheme.surfaceOn,
            ),
          ),
        ),
        Text(
          value,
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.w700,
            fontFamily: 'Outfit',
            color: PrimeCareTheme.surfaceOn,
          ),
        ),
        const SizedBox(width: 16),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Text(
            change,
            style: Theme.of(context).textTheme.labelSmall?.copyWith(
              color: color,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildAccessRepository(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Consolidated Financial Reports',
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.w600,
            fontFamily: 'Outfit',
            color: PrimeCareTheme.surfaceOn,
          ),
        ),
        const SizedBox(height: 16),
        _buildReportItem(context, 'Q3 Consolidated Profit & Loss', 'READY', PrimeCareTheme.emeraldTeal),
        _buildReportItem(context, 'Annual Balance Sheet', 'AUDITING', PrimeCareTheme.amberWarning),
        _buildReportItem(context, 'Quarterly Cash Flow Forecast', 'READY', PrimeCareTheme.navyIndigo),
      ],
    );
  }

  Widget _buildReportItem(BuildContext context, String label, String status, Color color) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: ClinicalGlassPanel(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: PrimeCareTheme.surfaceContainerLow,
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Icon(LucideIcons.fileText, color: PrimeCareTheme.surfaceOnVariant, size: 20),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Text(
                label,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                  color: PrimeCareTheme.surfaceOn,
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(4),
              ),
              child: Text(
                status,
                style: Theme.of(context).textTheme.labelSmall?.copyWith(
                  color: color,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTaxCompliance(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Tax & Remittance Hub',
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
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: PrimeCareTheme.emeraldTeal.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Icon(LucideIcons.landmark, color: PrimeCareTheme.emeraldTeal),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'HST / GST COMPLIANT',
                          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.w700,
                            fontFamily: 'Outfit',
                            color: PrimeCareTheme.emeraldTeal,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'All regional tax remittances for Q3 have been processed and cleared via direct ledger entry.',
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
              const SizedBox(height: 24),
              ElevatedButton.icon(
                onPressed: () {},
                icon: const Icon(LucideIcons.fileSearch),
                label: const Text('View Tax Ledgers'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: PrimeCareTheme.emeraldTeal,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}
