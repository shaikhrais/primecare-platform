import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../office/components/glass_surface.dart';
import '../../../../office/components/kpi_stat_card.dart';
import '../../../../office/components/audit_log_tile.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../providers/dashboard_providers.dart';

class PswDashboard extends ConsumerWidget {
  const PswDashboard({super.key});

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
                      'PSW Daily Care Portal',
                      style: theme.textTheme.headlineMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: AppTheme.primary,
                        fontFamily: 'Outfit',
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Coordinating daily living support and specialized home care cycles.',
                      style: theme.textTheme.titleMedium?.copyWith(
                        color: Colors.blueGrey,
                        fontFamily: 'Inter',
                      ),
                    ),
                    const SizedBox(height: 32),

                    // PSW KPI ROW
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

                    LayoutBuilder(
                      builder: (context, constraints) {
                        final isDesktop = constraints.maxWidth > 800;

                        final leftPane = Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Active Care Schedule', style: theme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold, fontFamily: 'Outfit')),
                            const SizedBox(height: 16),
                            GlassSurface(
                              padding: const EdgeInsets.all(24),
                              child: Column(
                                children: [
                                  _buildCareRow('Eleanor Rigby', 'Bathing & Grooming', 'READY', '14:30', isNext: true),
                                  const Divider(color: Colors.blueGrey, height: 24, thickness: 0.1),
                                  _buildCareRow('John Smith', 'Meal Prep (Low Sodium)', 'UPCOMING', '16:00'),
                                  const Divider(color: Colors.blueGrey, height: 24, thickness: 0.1),
                                  _buildCareRow('Martha Wayne', 'Ambulation / Walking Support', 'UPCOMING', '18:00'),
                                ],
                              ),
                            ),
                          ],
                        );

                        final rightPane = Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Incident Reports (Recent)', style: theme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold, fontFamily: 'Outfit')),
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
                        );

                        if (isDesktop) {
                          return Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(flex: 2, child: leftPane),
                              const SizedBox(width: 24),
                              Expanded(flex: 1, child: rightPane),
                            ],
                          );
                        } else {
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              leftPane,
                              const SizedBox(height: 32),
                              rightPane,
                            ],
                          );
                        }
                      },
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

  Widget _buildCareRow(String name, String type, String status, String time, {bool isNext = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          CircleAvatar(
            backgroundColor: isNext ? Colors.orange.withValues(alpha: 0.1) : AppTheme.primary.withValues(alpha: 0.1),
            child: Text(name[0], style: TextStyle(color: isNext ? Colors.orange : AppTheme.primary, fontWeight: FontWeight.bold)),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(name, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                Text(type, style: const TextStyle(color: Colors.blueGrey, fontSize: 13)),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(time, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
              Text(status, style: TextStyle(color: isNext ? Colors.orange : Colors.teal, fontSize: 11, fontWeight: FontWeight.bold)),
            ],
          ),
        ],
      ),
    );
  }

  IconData _getIcon(String title) {
    if (title.contains('ADL')) return Icons.task_alt;
    if (title.contains('Shift')) return Icons.schedule;
    if (title.contains('Alert')) return Icons.notification_important_outlined;
    if (title.contains('Hours')) return Icons.history;
    return Icons.insights;
  }

  IconData _getActivityIcon(String icon) {
    switch (icon) {
      case 'warning': return Icons.warning;
      case 'healing': return Icons.healing;
      case 'verified': return Icons.verified;
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
