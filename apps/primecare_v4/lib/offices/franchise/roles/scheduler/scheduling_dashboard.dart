import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../office/components/glass_surface.dart';
import '../../../../office/components/kpi_stat_card.dart';
import '../../../../office/components/audit_log_tile.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../providers/api_providers.dart';

class SchedulingDashboard extends ConsumerWidget {
  const SchedulingDashboard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    ref.watch(dioProvider);

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                   Text(
                    'Care Coordination & Scheduling',
                    style: theme.textTheme.headlineMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: AppTheme.primary,
                      fontFamily: 'Outfit',
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Optimizing caregiver-patient alignment and ensuring 100% shift coverage.',
                    style: theme.textTheme.titleMedium?.copyWith(
                      color: Colors.blueGrey,
                      fontFamily: 'Inter',
                    ),
                  ),
                  const SizedBox(height: 32),

                  // SCHEDULER KPI ROW
                  LayoutBuilder(
                    builder: (context, constraints) {
                      final cardWidth = constraints.maxWidth > 1200 ? (constraints.maxWidth - 48) / 4 : (constraints.maxWidth > 600 ? (constraints.maxWidth - 16) / 2 : constraints.maxWidth);
                      return Wrap(
                        spacing: 16,
                        runSpacing: 16,
                        children: [
                          _buildKpi(cardWidth, 'Total Shifts', '428', Icons.event_note_outlined, AppTheme.primary, 'Scheduled today'),
                          _buildKpi(cardWidth, 'Unfilled Gaps', '4', Icons.error_outline, Colors.orange, 'Action required'),
                          _buildKpi(cardWidth, 'Match Accuracy', '98%', Icons.verified_user_outlined, Colors.teal, 'Target: 95%'),
                          _buildKpi(cardWidth, 'Active Caregivers', '82 / 90', Icons.people_outline, Colors.indigo, 'In-field'),
                        ],
                      );
                    },
                  ),

                  const SizedBox(height: 32),

                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // LEFT: Shift Matching Queue
                      Expanded(
                        flex: 2,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('High-Priority Scheduling Gaps', style: theme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold, fontFamily: 'Outfit')),
                            const SizedBox(height: 16),
                            GlassSurface(
                              padding: const EdgeInsets.all(24),
                              child: Column(
                                children: [
                                  _buildGapRow('Brampton Cluster', 'PSW Night Shift', 'URGENT', '2h LEFT', isUrgent: true),
                                  const Divider(color: Colors.blueGrey, height: 24, thickness: 0.1),
                                  _buildGapRow('Vaughan South', 'RN Weekend Cover', 'MATCHING', '1d LEFT'),
                                  const Divider(color: Colors.blueGrey, height: 24, thickness: 0.1),
                                  _buildGapRow('Toronto East', 'Physio Replacement', 'PENDING', '4h LEFT'),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(width: 24),

                      // RIGHT: Activity Feed
                      Expanded(
                        flex: 1,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Coordination Audit Trail', style: theme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold, fontFamily: 'Outfit')),
                            const SizedBox(height: 16),
                            GlassSurface(
                              padding: const EdgeInsets.all(16),
                              child: Column(
                                children: [
                                  AuditLogTile(title: 'Shift Confirmed', subtitle: 'Ref: #SH-401 - J. Blake', timestamp: '5m ago', icon: Icons.check_circle_outline, iconColor: Colors.teal),
                                  const Divider(color: Colors.blueGrey, height: 16, thickness: 0.1),
                                  AuditLogTile(title: 'Late Clock-in', subtitle: 'Staff: PC-042 - Room 201', timestamp: '45m ago', icon: Icons.timer_outlined, iconColor: Colors.orange),
                                  const Divider(color: Colors.blueGrey, height: 16, thickness: 0.1),
                                  AuditLogTile(title: 'Schedule Published', subtitle: 'Next Week (Cluster A)', timestamp: '3h ago', icon: Icons.publish_outlined, iconColor: Colors.indigo),
                                ],
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
    );
  }

  Widget _buildKpi(double width, String title, String value, IconData icon, Color color, [String? subtitle]) {
    return SizedBox(
      width: width,
      child: KpiStatCard(title: title, value: value, subtitle: subtitle, icon: icon, iconColor: color),
    );
  }

  Widget _buildGapRow(String region, String role, String status, String countdown, {bool isUrgent = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(color: isUrgent ? Colors.red.withOpacity(0.1) : AppTheme.primary.withOpacity(0.1), borderRadius: BorderRadius.circular(10)),
            child: Icon(isUrgent ? Icons.priority_high : Icons.calendar_month_outlined, color: isUrgent ? Colors.red : AppTheme.primary, size: 20),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(region, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                Text(role, style: const TextStyle(color: Colors.blueGrey, fontSize: 12)),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(countdown, style: TextStyle(fontWeight: FontWeight.bold, color: isUrgent ? Colors.red : AppTheme.primary, fontSize: 12)),
              Text(status, style: const TextStyle(fontSize: 9, fontWeight: FontWeight.bold, letterSpacing: 1.1, color: Colors.blueGrey)),
            ],
          ),
        ],
      ),
    );
  }
}
