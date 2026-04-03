import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../office/components/glass_surface.dart';
import '../../../../office/components/kpi_stat_card.dart';
import '../../../../office/components/audit_log_tile.dart';
import '../../../../office/components/region_performance_card.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../providers/dashboard_providers.dart';

class CfoDashboard extends ConsumerWidget {
  const CfoDashboard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final metricsAsync = ref.watch(dashboardMetricsProvider);
    
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: metricsAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, stack) => Center(child: Text('Error loading metrics: $err')),
        data: (metrics) => CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                     Text(
                      'Fiscal Control & Audit Hub',
                      style: theme.textTheme.headlineMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: AppTheme.primary,
                        fontFamily: 'Outfit',
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'High-fidelity monitoring of the PrimeCare institutional ledger.',
                      style: theme.textTheme.titleMedium?.copyWith(
                        color: Colors.blueGrey,
                        fontFamily: 'Inter',
                      ),
                    ),
                    const SizedBox(height: 32),
                    
                    // FISCAL KPI ROW
                    LayoutBuilder(
                      builder: (context, constraints) {
                        final cardWidth = constraints.maxWidth > 1200 ? (constraints.maxWidth - 48) / 4 : (constraints.maxWidth > 600 ? (constraints.maxWidth - 16) / 2 : constraints.maxWidth);
                        return Wrap(
                          spacing: 16,
                          runSpacing: 16,
                          children: metrics.kpis.map((kpi) => _buildKpi(
                            cardWidth, 
                            kpi.title, 
                            kpi.value, 
                            _getIcon(kpi.title), 
                            _getStatusColor(kpi.status), 
                            kpi.subtitle
                          )).toList(),
                        );
                      },
                    ),
                    
                    const SizedBox(height: 32),

                    // FINANCIAL TABLES & LOGS
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // LEFT: Regional Performance
                        Expanded(
                          flex: 2,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Institutional Portfolio Performance', style: theme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold, fontFamily: 'Outfit')),
                              const SizedBox(height: 8),
                              Text('Region-specific revenue and margin breakdown.', style: theme.textTheme.bodyMedium?.copyWith(color: Colors.blueGrey)),
                              const SizedBox(height: 16),
                              GlassSurface(
                                padding: const EdgeInsets.all(24),
                                child: Column(
                                  children: [
                                    RegionPerformanceCard(region: 'Greater Toronto Area', facilityCount: '24 Units', revenue: '\$5.2M', margin: '34%'),
                                    const Divider(color: Colors.blueGrey, height: 24, thickness: 0.1),
                                    RegionPerformanceCard(region: 'Vancouver Metro', facilityCount: '16 Units', revenue: '\$3.1M', margin: '29%'),
                                    const Divider(color: Colors.blueGrey, height: 24, thickness: 0.1),
                                    RegionPerformanceCard(region: 'Montreal / East', facilityCount: '12 Units', revenue: '\$2.4M', margin: '22%'),
                                    const Divider(color: Colors.blueGrey, height: 24, thickness: 0.1),
                                    RegionPerformanceCard(region: 'US Expansion (TX)', facilityCount: '4 Units', revenue: '\$1.1M', margin: '18%', marginColor: Colors.orange),
                                  ],
                                ),
                              ),
                              
                              const SizedBox(height: 32),
                              
                              Text('Compliance Status: Financial Transparency', style: theme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold, fontFamily: 'Outfit')),
                              const SizedBox(height: 16),
                              GlassSurface(
                                padding: const EdgeInsets.all(24),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      'Institutional Audit Status: PRE-AUDIT VERIFIED',
                                      style: TextStyle(fontWeight: FontWeight.bold, color: Colors.teal),
                                    ),
                                    const SizedBox(height: 8),
                                    Text(
                                      'All ledger entries for Q3 have been reconciled against the PrimeCare core API. No discrepancies detected in regional payroll distributions.',
                                      style: theme.textTheme.bodyLarge?.copyWith(color: Colors.blueGrey.shade700, height: 1.5),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          )
                        ),
                        
                        const SizedBox(width: 24),
                        
                        // RIGHT: Ledger Audit Logs
                        Expanded(
                          flex: 1,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Ledger Discrepancies', style: theme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold, fontFamily: 'Outfit')),
                              const SizedBox(height: 16),
                              GlassSurface(
                                padding: const EdgeInsets.all(16),
                                child: Column(
                                  children: [
                                    _buildIssueTile('Payroll Anomaly - Hamilton', 'Verification Required', Icons.warning_amber_rounded, Colors.red),
                                    const Divider(color: Colors.blueGrey, height: 16, thickness: 0.1),
                                    _buildIssueTile('Tax Remittance - Q3', 'Pending Signature', Icons.assignment_late_outlined, Colors.orange),
                                  ],
                                ),
                              ),
                              
                              const SizedBox(height: 32),
                              
                              Text('Recent Fiscal Activity', style: theme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold, fontFamily: 'Outfit')),
                              const SizedBox(height: 16),
                              GlassSurface(
                                padding: const EdgeInsets.all(16),
                                child: Column(
                                  children: metrics.recentActivity.map((log) => Column(
                                    children: [
                                      AuditLogTile(
                                        title: log.title, 
                                        subtitle: log.subtitle, 
                                        timestamp: log.timestamp, 
                                        icon: _getActivityIcon(log.icon), 
                                        iconColor: _getStatusColor(log.color)
                                      ),
                                      const Divider(color: Colors.blueGrey, height: 16, thickness: 0.1),
                                    ],
                                  )).toList(),
                                ),
                              )
                            ],
                          )
                        )
                      ],
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildKpi(double width, String title, String value, IconData icon, Color color, [String? subtitle]) {
    return SizedBox(
      width: width,
      child: KpiStatCard(title: title, value: value, subtitle: subtitle, icon: icon, iconColor: color),
    );
  }

  Widget _buildIssueTile(String title, String subtitle, IconData icon, Color color) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(color: color.withValues(alpha: 0.1), borderRadius: BorderRadius.circular(8)),
            child: Icon(icon, color: color, size: 20),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                Text(subtitle, style: const TextStyle(color: Colors.blueGrey, fontSize: 12)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  IconData _getIcon(String title) {
    if (title.contains('Revenue')) return Icons.account_balance_wallet;
    if (title.contains('Margin')) return Icons.analytics;
    if (title.contains('Payroll')) return Icons.payments;
    if (title.contains('Cash')) return Icons.monetization_on;
    if (title.contains('Compliance')) return Icons.verified_user_outlined;
    return Icons.insights;
  }

  IconData _getActivityIcon(String icon) {
    switch (icon) {
      case 'verified': return Icons.verified;
      case 'person_add': return Icons.person_add;
      case 'security': return Icons.security;
      default: return Icons.history;
    }
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case 'success':
      case 'teal': return Colors.teal;
      case 'warning':
      case 'orange': return Colors.orange;
      case 'danger':
      case 'red': return Colors.red;
      case 'info':
      case 'indigo': return Colors.indigo;
      default: return Colors.blueGrey;
    }
  }
}

