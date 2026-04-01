import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../office/components/glass_surface.dart';
import '../../../../office/components/kpi_stat_card.dart';
import '../../../../office/components/audit_log_tile.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../providers/api_providers.dart';

class ComplianceDashboard extends ConsumerWidget {
  const ComplianceDashboard({Key? key}) : super(key: key);

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
                   Row(
                    children: [
                      const Icon(Icons.gavel_outlined, color: Colors.blueGrey, size: 28),
                      const SizedBox(width: 12),
                      Text(
                        'Compliance & Risk Governance',
                        style: theme.textTheme.headlineMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: AppTheme.primary,
                          fontFamily: 'Outfit',
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Ensuring institutional integrity through automated audit and risk oversight.',
                    style: theme.textTheme.titleMedium?.copyWith(
                      color: Colors.blueGrey,
                      fontFamily: 'Inter',
                    ),
                  ),
                  const SizedBox(height: 32),

                  // COMPLIANCE KPI ROW
                  LayoutBuilder(
                    builder: (context, constraints) {
                      final cardWidth = constraints.maxWidth > 1200 ? (constraints.maxWidth - 48) / 4 : (constraints.maxWidth > 600 ? (constraints.maxWidth - 16) / 2 : constraints.maxWidth);
                      return Wrap(
                        spacing: 16,
                        runSpacing: 16,
                        children: [
                          _buildKpi(cardWidth, 'Audit Health', '98.4%', Icons.verified_user_outlined, AppTheme.primary, 'Goal: 100%'),
                          _buildKpi(cardWidth, 'Risk Alerts', '3', Icons.warning_amber_outlined, Colors.redAccent, 'Action required'),
                          _buildKpi(cardWidth, 'Policy Updates', '12', Icons.auto_stories_outlined, Colors.indigo, 'Q4 Revision cycle'),
                          _buildKpi(cardWidth, 'License Renewals', '4', Icons.badge_outlined, Colors.teal, 'Expiring <30d'),
                        ],
                      );
                    },
                  ),

                  const SizedBox(height: 32),

                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // LEFT: Audit Queue
                      Expanded(
                        flex: 2,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Institutional Audit Queue', style: theme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold, fontFamily: 'Outfit')),
                            const SizedBox(height: 16),
                            GlassSurface(
                              padding: const EdgeInsets.all(24),
                              child: Column(
                                children: [
                                  _buildAuditItem('Hamilton Clinic', 'Annual Safety Review', 'IN PROGRESS', '88%'),
                                  const Divider(color: Colors.blueGrey, height: 24, thickness: 0.1),
                                  _buildAuditItem('Toronto West', 'Medication Storage Audit', 'URGENT', '42%', isUrgent: true),
                                  const Divider(color: Colors.blueGrey, height: 24, thickness: 0.1),
                                  _buildAuditItem('Ottawa Region', 'Credentialing Verification', 'COMPLETED', '100%'),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(width: 24),

                      // RIGHT: Risk Feed
                      Expanded(
                        flex: 1,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Incident Mitigation Feed', style: theme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold, fontFamily: 'Outfit')),
                            const SizedBox(height: 16),
                            GlassSurface(
                              padding: const EdgeInsets.all(16),
                              child: Column(
                                children: [
                                  AuditLogTile(title: 'Policy Exception', subtitle: 'Ref: Dr. Spencer - Approved', timestamp: '12m ago', icon: Icons.playlist_add_check, iconColor: Colors.teal),
                                  const Divider(color: Colors.blueGrey, height: 16, thickness: 0.1),
                                  AuditLogTile(title: 'Breach Attempt', subtitle: 'Blocked: IP 192.168.1.1', timestamp: '1h ago', icon: Icons.shield_outlined, iconColor: Colors.redAccent),
                                  const Divider(color: Colors.blueGrey, height: 16, thickness: 0.1),
                                  AuditLogTile(title: 'Staff Meeting', subtitle: 'Compliance Refresher - Mon', timestamp: '5h ago', icon: Icons.event, iconColor: Colors.blueGrey),
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

  Widget _buildAuditItem(String facility, String title, String status, String progress, {bool isUrgent = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(color: isUrgent ? Colors.red.withOpacity(0.1) : AppTheme.primary.withOpacity(0.1), borderRadius: BorderRadius.circular(10)),
            child: Icon(isUrgent ? Icons.priority_high : Icons.fact_check, color: isUrgent ? Colors.red : AppTheme.primary, size: 20),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(facility, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                Text(title, style: const TextStyle(color: Colors.blueGrey, fontSize: 12)),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(progress, style: TextStyle(fontWeight: FontWeight.bold, color: isUrgent ? Colors.red : Colors.teal)),
              Text(status, style: const TextStyle(fontSize: 9, fontWeight: FontWeight.bold, letterSpacing: 1.1, color: Colors.blueGrey)),
            ],
          ),
        ],
      ),
    );
  }
}
