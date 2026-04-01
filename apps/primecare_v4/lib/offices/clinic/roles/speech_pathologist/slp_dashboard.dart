import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../office/components/glass_surface.dart';
import '../../../../office/components/kpi_stat_card.dart';
import '../../../../office/components/audit_log_tile.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../providers/api_providers.dart';

class SlpDashboard extends ConsumerWidget {
  const SlpDashboard({Key? key}) : super(key: key);

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
                    'Speech & Swallowing Clinic Hub',
                    style: theme.textTheme.headlineMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: AppTheme.primary,
                      fontFamily: 'Outfit',
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Restoring communication and swallowing function through evidence-based care.',
                    style: theme.textTheme.titleMedium?.copyWith(
                      color: Colors.blueGrey,
                      fontFamily: 'Inter',
                    ),
                  ),
                  const SizedBox(height: 32),

                  // SLP KPI ROW
                  LayoutBuilder(
                    builder: (context, constraints) {
                      final cardWidth = constraints.maxWidth > 1200 ? (constraints.maxWidth - 48) / 4 : (constraints.maxWidth > 600 ? (constraints.maxWidth - 16) / 2 : constraints.maxWidth);
                      return Wrap(
                        spacing: 16,
                        runSpacing: 16,
                        children: [
                          _buildKpi(cardWidth, 'Speech Sessions', '5', Icons.record_voice_over, AppTheme.primary, '3 Completed'),
                          _buildKpi(cardWidth, 'Swallowing Tests', '2', Icons.local_dining_outlined, Colors.indigo, 'High priority'),
                          _buildKpi(cardWidth, 'Progress Notes', '6', Icons.grading, Colors.orange, 'EOD deadline'),
                          _buildKpi(cardWidth, 'Vocal Clarity Score', '84%', Icons.multitrack_audio, Colors.teal, 'Network Average'),
                        ],
                      );
                    },
                  ),

                  const SizedBox(height: 32),

                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // LEFT: Active Clinical Queue
                      Expanded(
                        flex: 2,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Communication Recovery Queue', style: theme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold, fontFamily: 'Outfit')),
                            const SizedBox(height: 16),
                            GlassSurface(
                              padding: const EdgeInsets.all(24),
                              child: Column(
                                children: [
                                  _buildSessionRow('Linda Belcher', 'Aphasia Recovery', 'Vocal Exercises', '10:45 AM'),
                                  const Divider(color: Colors.blueGrey, height: 24, thickness: 0.1),
                                  _buildSessionRow('Gene Belcher', 'Swallowing Evaluation', 'Bedside Test', '11:45 AM', isHighRisk: true),
                                  const Divider(color: Colors.blueGrey, height: 24, thickness: 0.1),
                                  _buildSessionRow('Tina Belcher', 'Cognitive-Comm Therapy', 'Social Interaction', '1:30 PM'),
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
                            Text('Clinical Assessments', style: theme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold, fontFamily: 'Outfit')),
                            const SizedBox(height: 16),
                            GlassSurface(
                              padding: const EdgeInsets.all(16),
                              child: Column(
                                children: [
                                  AuditLogTile(title: 'Swallowing Plan', subtitle: 'Modified Diet - Ref: G. Belcher', timestamp: '22m ago', icon: Icons.restaurant, iconColor: Colors.teal),
                                  const Divider(color: Colors.blueGrey, height: 16, thickness: 0.1),
                                  AuditLogTile(title: 'Vocal Analysis', subtitle: 'L. Belcher - Improved', timestamp: '1h ago', icon: Icons.mic, iconColor: Colors.indigo),
                                  const Divider(color: Colors.blueGrey, height: 16, thickness: 0.1),
                                  AuditLogTile(title: 'Caregiver Training', subtitle: 'Session logged', timestamp: '5h ago', icon: Icons.groups, iconColor: Colors.blueGrey),
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

  Widget _buildSessionRow(String name, String type, String focus, String time, {bool isHighRisk = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          CircleAvatar(
            backgroundColor: isHighRisk ? Colors.red.withOpacity(0.1) : AppTheme.primary.withOpacity(0.1),
            child: Text(name[0], style: TextStyle(color: isHighRisk ? Colors.red : AppTheme.primary, fontWeight: FontWeight.bold)),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(name, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                Text('$type ($focus)', style: const TextStyle(color: Colors.blueGrey, fontSize: 12)),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(time, style: const TextStyle(fontWeight: FontWeight.bold, color: AppTheme.primary)),
              if (isHighRisk) const Text('HIGH RISK', style: TextStyle(color: Colors.red, fontSize: 9, fontWeight: FontWeight.bold, letterSpacing: 1.1)),
            ],
          ),
        ],
      ),
    );
  }
}
