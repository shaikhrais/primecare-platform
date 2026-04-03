import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../office/components/glass_surface.dart';
import '../../../../office/components/kpi_stat_card.dart';
import '../../../../office/components/audit_log_tile.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../providers/dashboard_providers.dart';

class HrDashboard extends ConsumerWidget {
  const HrDashboard({super.key});

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
                      'HR: Talent & Hiring Pipeline',
                      style: theme.textTheme.headlineMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: AppTheme.primary,
                        fontFamily: 'Outfit',
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Managing clinical recruitments, credentialing verification, and staff onboarding.',
                      style: theme.textTheme.titleMedium?.copyWith(
                        color: Colors.blueGrey,
                        fontFamily: 'Inter',
                      ),
                    ),
                    const SizedBox(height: 32),

                    // HR KPI ROW
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
                        // LEFT: Recruitment Pipeline
                        Expanded(
                          flex: 2,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Active Talent Acquisition', style: theme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold, fontFamily: 'Outfit')),
                              const SizedBox(height: 16),
                              GlassSurface(
                                padding: const EdgeInsets.all(24),
                                child: Column(
                                  children: [
                                    _buildRecruitItem('Sarah Blake', 'RN Specialist', 'INTERVIEW', 'Fri 10:30'),
                                    const Divider(color: Colors.blueGrey, height: 24, thickness: 0.1),
                                    _buildRecruitItem('Julian Smith', 'PSW Level 1', 'OFFER SENT', 'Awaiting Sign'),
                                    const Divider(color: Colors.blueGrey, height: 24, thickness: 0.1),
                                    _buildRecruitItem('Amanda Lee', 'Billing Admin', 'SCREENING', 'Score: 92/100'),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),

                        const SizedBox(width: 24),

                        // RIGHT: HR Logs
                        Expanded(
                          flex: 1,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Compliance & Verifications', style: theme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold, fontFamily: 'Outfit')),
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

  Widget _buildRecruitItem(String name, String role, String status, String nextAction) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
           CircleAvatar(
            backgroundColor: AppTheme.primary.withValues(alpha: 0.1),
            child: Text(name[0], style: const TextStyle(color: AppTheme.primary, fontWeight: FontWeight.bold)),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(name, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                Text(role, style: const TextStyle(color: Colors.blueGrey, fontSize: 12)),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(status, style: const TextStyle(fontWeight: FontWeight.bold, color: AppTheme.primary, fontSize: 11)),
              Text(nextAction, style: const TextStyle(color: Colors.blueGrey, fontSize: 10)),
            ],
          ),
        ],
      ),
    );
  }

  IconData _getIcon(String title) {
    if (title.contains('Reqs')) return Icons.work_outline;
    if (title.contains('Appls')) return Icons.people_outline;
    if (title.contains('Time')) return Icons.speed;
    if (title.contains('Onboarding')) return Icons.how_to_reg_outlined;
    return Icons.insights;
  }

  IconData _getActivityIcon(String icon) {
    switch (icon) {
      case 'verified': return Icons.verified_user_outlined;
      case 'warning': return Icons.warning_amber_outlined;
      case 'hail': return Icons.hail_outlined;
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
