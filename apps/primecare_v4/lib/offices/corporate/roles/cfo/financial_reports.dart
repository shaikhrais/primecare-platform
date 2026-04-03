import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../office/components/glass_surface.dart';
import '../../../../office/components/kpi_stat_card.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../providers/dashboard_providers.dart';

class FinancialReportsView extends ConsumerWidget {
  const FinancialReportsView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final metricsAsync = ref.watch(dashboardMetricsProvider);

    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          'Strategic Financial HUD',
          style: theme.textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.bold,
            fontFamily: 'Outfit',
            color: AppTheme.primary,
          ),
        ),
      ),
      body: metricsAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, stack) => Center(child: Text('Error: $err')),
        data: (metrics) => SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // FINANCE HUD
              Row(
                children: [
                  Expanded(child: KpiStatCard(title: 'Total Revenue', value: r'$14.2M', icon: Icons.payments, iconColor: Colors.teal, subtitle: '+12% vs last month')),
                  const SizedBox(width: 16),
                  Expanded(child: KpiStatCard(title: 'Net Profit', value: r'$840K', icon: Icons.trending_up, iconColor: Colors.indigo, subtitle: 'Q3 Aggregated')),
                  const SizedBox(width: 16),
                  Expanded(child: KpiStatCard(title: 'Awaiting Pay', value: r'$2.4M', icon: Icons.timer_outlined, iconColor: Colors.orange, subtitle: 'Due in 2 days')),
                ],
              ),

              const SizedBox(height: 32),

              // PERFORMANCE TRENDS
              Text('Quarterly Revenue Dynamics', style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold, fontFamily: 'Outfit')),
              const SizedBox(height: 16),
              GlassSurface(
                padding: const EdgeInsets.all(24),
                child: Column(
                  children: [
                    _buildTrendRow('Clinic Service Revenue', r'$8.4M', '+4.2%', Colors.teal),
                    const Divider(height: 32, thickness: 0.1),
                    _buildTrendRow('Franchise Royalty Fees', r'$2.1M', '+2.1%', Colors.indigo),
                    const Divider(height: 32, thickness: 0.1),
                    _buildTrendRow('Institutional Partnerships', r'$3.7M', '-0.5%', Colors.orange),
                  ],
                ),
              ),

              const SizedBox(height: 32),

              // ACCESS REPOSITORY
              Text('Consolidated Financial Reports', style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold, fontFamily: 'Outfit')),
              const SizedBox(height: 16),
              _buildReportItem('Q3 Consolidated Profit & Loss', 'READY', Colors.teal),
              _buildReportItem('Annual Tax Compliance Hub', 'AUDITING', Colors.orange),
              _buildReportItem('Quarterly Cash Flow Forecast', 'READY', Colors.indigo),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTrendRow(String label, String value, String change, Color color) {
    return Row(
      children: [
        CircleAvatar(radius: 4, backgroundColor: color),
        const SizedBox(width: 16),
        Text(label, style: const TextStyle(fontWeight: FontWeight.w600)),
        const Spacer(),
        Text(value, style: const TextStyle(fontWeight: FontWeight.bold)),
        const SizedBox(width: 12),
        Text(change, style: TextStyle(color: color, fontWeight: FontWeight.bold, fontSize: 12)),
      ],
    );
  }

  Widget _buildReportItem(String label, String status, Color color) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: GlassSurface(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
        child: Row(
          children: [
            const Icon(Icons.description_outlined, color: AppTheme.primary, size: 20),
            const SizedBox(width: 20),
            Expanded(child: Text(label, style: const TextStyle(fontWeight: FontWeight.bold))),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              decoration: BoxDecoration(color: color.withValues(alpha: 0.1), borderRadius: BorderRadius.circular(4)),
              child: Text(status, style: TextStyle(color: color, fontWeight: FontWeight.bold, fontSize: 10)),
            ),
          ],
        ),
      ),
    );
  }
}
