import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../office/components/glass_surface.dart';
import '../../../../office/components/kpi_stat_card.dart';
import '../../../../office/components/audit_log_tile.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../providers/dashboard_providers.dart';

class ChiroDashboard extends ConsumerWidget {
  const ChiroDashboard({super.key});

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
                      'Chiropractic Hub',
                      style: theme.textTheme.headlineMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: AppTheme.primary,
                        fontFamily: 'Outfit',
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Spinal health monitoring and treatment lifecycle.',
                      style: theme.textTheme.titleMedium?.copyWith(
                        color: Colors.blueGrey,
                        fontFamily: 'Inter',
                      ),
                    ),
                    const SizedBox(height: 32),

                    // CHIRO KPI ROW
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
                        // LEFT: Spinal Exam Queue
                        Expanded(
                          flex: 2,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Spinal Exam & Treatment Queue', style: theme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold, fontFamily: 'Outfit')),
                              const SizedBox(height: 16),
                              GlassSurface(
                                padding: const EdgeInsets.all(24),
                                child: Column(
                                  children: [
                                    _buildExamRow('James Miller', 'Spinal Adjustment - L4/L5', '11:45 AM', 'In Session'),
                                    const Divider(color: Colors.blueGrey, height: 24, thickness: 0.1),
                                    _buildExamRow('Amanda White', 'Initial Spinal Assessment', '12:30 PM', 'Ready'),
                                    const Divider(color: Colors.blueGrey, height: 24, thickness: 0.1),
                                    _buildExamRow('Robert Brown', 'Post-Treatment Review', '2:00 PM', 'Confirmed'),
                                  ],
                                ),
                              ),
                              
                              const SizedBox(height: 32),
                              
                              Text('Diagnostic Imaging Review', style: theme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold, fontFamily: 'Outfit')),
                              const SizedBox(height: 16),
                              GlassSurface(
                                padding: const EdgeInsets.all(16),
                                child: Column(
                                  children: [
                                    _buildImagingTile('H. Potter', 'Cervical X-Ray', '2 reports ready', Icons.folder_shared, Colors.indigo),
                                    const Divider(color: Colors.blueGrey, height: 16, thickness: 0.1),
                                    _buildImagingTile('L. Sky', 'Lumbar MRI', 'Pending lab release', Icons.pending, Colors.orange),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),

                        const SizedBox(width: 24),

                        // RIGHT: Clinical Logs
                        Expanded(
                          flex: 1,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Recent Adjustments', style: theme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold, fontFamily: 'Outfit')),
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

  Widget _buildExamRow(String name, String type, String time, String status) {
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
                Text(type, style: const TextStyle(color: Colors.blueGrey)),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(time, style: const TextStyle(fontWeight: FontWeight.bold)),
              Text(status, style: const TextStyle(color: Colors.teal, fontSize: 12)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildImagingTile(String patient, String type, String status, IconData icon, Color color) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0),
      child: Row(
        children: [
          Icon(icon, color: color, size: 20),
          const SizedBox(width: 16),
          Expanded(
            child: Row(
              children: [
                Expanded(child: Text(patient, style: const TextStyle(fontWeight: FontWeight.bold))),
                Text(type, style: const TextStyle(color: Colors.blueGrey, fontSize: 12)),
              ],
            ),
          ),
          const SizedBox(width: 12),
          Text(status, style: TextStyle(color: color, fontSize: 11, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }

  IconData _getIcon(String title) {
    if (title.contains('Exam')) return Icons.healing;
    if (title.contains('Flow')) return Icons.people;
    if (title.contains('Imaging')) return Icons.visibility;
    if (title.contains('Note')) return Icons.checklist;
    return Icons.insights;
  }

  IconData _getActivityIcon(String icon) {
    switch (icon) {
      case 'straighten': return Icons.straighten;
      case 'task': return Icons.task_alt;
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
