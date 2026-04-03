import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../office/components/glass_surface.dart';
import '../../../../office/components/kpi_stat_card.dart';
import '../../../../office/components/audit_log_tile.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../providers/dashboard_providers.dart';

class FranchiseSalesDashboard extends ConsumerWidget {
  const FranchiseSalesDashboard({super.key});

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
                      'Franchise Growth: Expansion Pipeline',
                      style: theme.textTheme.headlineMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: AppTheme.primary,
                        fontFamily: 'Outfit',
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Monitor potential franchise partners, discovery day conversions, and regional territory sales.',
                      style: theme.textTheme.titleMedium?.copyWith(
                        color: Colors.blueGrey,
                        fontFamily: 'Inter',
                      ),
                    ),
                    const SizedBox(height: 32),

                    // FRANCHISE KPI ROW
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

                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // LEFT: Sales Funnel
                        Expanded(
                          flex: 2,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Active Prospect Pipeline', style: theme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold, fontFamily: 'Outfit')),
                              const SizedBox(height: 16),
                              GlassSurface(
                                padding: const EdgeInsets.all(24),
                                child: Column(
                                  children: [
                                    _buildProspectRow('Discovery Day: Toronto', '8 Qualified Leads', 'HIGH PRIORITY', Colors.teal),
                                    const Divider(color: Colors.blueGrey, height: 24, thickness: 0.1),
                                    _buildProspectRow('Territory Sale: Vancouver', 'Ref: #BC-202', 'PENDING SIG', Colors.indigo),
                                    const Divider(color: Colors.blueGrey, height: 24, thickness: 0.1),
                                    _buildProspectRow('Partner Inquiry: Florida', 'Web Lead v4', 'FOLLOW UP', Colors.orange),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),

                        const SizedBox(width: 24),

                        // RIGHT: Sales Audit Feed
                        Expanded(
                          flex: 1,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Lead Activity Feed', style: theme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold, fontFamily: 'Outfit')),
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
                              ),
                            ],
                          ),
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

  Widget _buildProspectRow(String title, String subtitle, String status, Color statusColor) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
           Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(color: statusColor.withValues(alpha: 0.1), borderRadius: BorderRadius.circular(10)),
            child: Icon(Icons.rocket_launch_outlined, color: statusColor, size: 20),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                Text(subtitle, style: const TextStyle(color: Colors.blueGrey, fontSize: 12)),
              ],
            ),
          ),
          Text(status, style: TextStyle(fontWeight: FontWeight.bold, color: statusColor, fontSize: 10, letterSpacing: 1.1)),
        ],
      ),
    );
  }

  IconData _getIcon(String title) {
    if (title.contains('Leads')) return Icons.filter_alt_outlined;
    if (title.contains('Conversion')) return Icons.track_changes_outlined;
    if (title.contains('Pipeline')) return Icons.account_tree_outlined;
    if (title.contains('Proposals')) return Icons.assignment_outlined;
    return Icons.insights;
  }

  IconData _getActivityIcon(String icon) {
    switch (icon) {
      case 'verified': return Icons.verified_user_outlined;
      case 'lock': return Icons.lock_outline;
      case 'cloud_done': return Icons.cloud_done_outlined;
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
      case 'indigo':
      case 'blue': return Colors.indigo;
      default: return Colors.blueGrey;
    }
  }
}
