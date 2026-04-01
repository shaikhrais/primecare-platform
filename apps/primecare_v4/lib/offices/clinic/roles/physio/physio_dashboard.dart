import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../office/components/glass_surface.dart';
import '../../../../office/components/kpi_stat_card.dart';
import '../../../../office/components/audit_log_tile.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../providers/api_providers.dart';

class PhysioDashboard extends ConsumerWidget {
  const PhysioDashboard({Key? key}) : super(key: key);

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
                    'Physiotherapy Clinical Hub',
                    style: theme.textTheme.headlineMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: AppTheme.primary,
                      fontFamily: 'Outfit',
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Managing rehabilitation programs and assessment outcomes.',
                    style: theme.textTheme.titleMedium?.copyWith(
                      color: Colors.blueGrey,
                      fontFamily: 'Inter',
                    ),
                  ),
                  const SizedBox(height: 32),

                  // CLINICAL KPI ROW
                  LayoutBuilder(
                    builder: (context, constraints) {
                      final cardWidth = constraints.maxWidth > 1200 ? (constraints.maxWidth - 48) / 4 : (constraints.maxWidth > 600 ? (constraints.maxWidth - 16) / 2 : constraints.maxWidth);
                      return Wrap(
                        spacing: 16,
                        runSpacing: 16,
                        children: [
                          _buildKpi(cardWidth, 'Today\'s Assessments', '6', Icons.assignment_turned_in, AppTheme.primary, '3 Completed'),
                          _buildKpi(cardWidth, 'Exercise Plans', '42', Icons.fitness_center, Colors.indigo, '12 New variations'),
                          _buildKpi(cardWidth, 'Notes Pending', '4', Icons.edit_note, Colors.orange, 'Due by EOD'),
                          _buildKpi(cardWidth, 'Client Progress', '92%', Icons.trending_up, Colors.teal, 'Avg. Recovery Rate'),
                        ],
                      );
                    },
                  ),

                  const SizedBox(height: 32),

                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // LEFT: Active Rehab Sessions
                      Expanded(
                        flex: 2,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Rehabilitation Session Queue', style: theme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold, fontFamily: 'Outfit')),
                            const SizedBox(height: 16),
                            GlassSurface(
                              padding: const EdgeInsets.all(24),
                              child: Column(
                                children: [
                                  _buildSessionRow('Sarah Jenkins', 'Post-Op Knee Rehab', '10:30 AM', 'Ready'),
                                  const Divider(color: Colors.blueGrey, height: 24, thickness: 0.1),
                                  _buildSessionRow('Michael Chen', 'Chronic Back Pain', '11:15 AM', 'Delayed', color: Colors.orange),
                                  const Divider(color: Colors.blueGrey, height: 24, thickness: 0.1),
                                  _buildSessionRow('Elena Rodriguez', 'Shoulder Mobility', '1:00 PM', 'Upcoming'),
                                ],
                              ),
                            ),
                            
                            const SizedBox(height: 32),
                            
                            Text('Clinical Alert: Critical Reassessments', style: theme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold, fontFamily: 'Outfit')),
                            const SizedBox(height: 16),
                            GlassSurface(
                              padding: const EdgeInsets.all(20),
                              child: Container(
                                decoration: BoxDecoration(
                                  border: Border.all(color: Colors.red.withOpacity(0.3)),
                                  borderRadius: BorderRadius.circular(12),
                                  color: Colors.red.withOpacity(0.05),
                                ),
                                padding: const EdgeInsets.all(16),
                                child: Row(
                                  children: [
                                    const Icon(Icons.error_outline, color: Colors.red),
                                    const SizedBox(width: 16),
                                    const Expanded(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text('3 Clients require immediate reassessment', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.red)),
                                          Text('Reassessment threshold (30 days) exceeded for specific recovery tracks.', style: TextStyle(color: Colors.redAccent)),
                                        ],
                                      ),
                                    ),
                                    ElevatedButton(
                                      onPressed: () {}, 
                                      style: ElevatedButton.styleFrom(backgroundColor: Colors.red, foregroundColor: Colors.white),
                                      child: const Text('View All'),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(width: 24),

                      // RIGHT: Activity & Progress
                      Expanded(
                        flex: 1,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Assessment History', style: theme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold, fontFamily: 'Outfit')),
                            const SizedBox(height: 16),
                            GlassSurface(
                              padding: const EdgeInsets.all(16),
                              child: Column(
                                children: [
                                  AuditLogTile(title: 'Range of Motion Test', subtitle: 'J. Doe - Completed', timestamp: '1h ago', icon: Icons.straighten, iconColor: Colors.teal),
                                  const Divider(color: Colors.blueGrey, height: 16, thickness: 0.1),
                                  AuditLogTile(title: 'Gait Analysis', subtitle: 'P. Smith - Uploaded', timestamp: '3h ago', icon: Icons.directions_walk, iconColor: Colors.indigo),
                                  const Divider(color: Colors.blueGrey, height: 16, thickness: 0.1),
                                  AuditLogTile(title: 'Initial Intake', subtitle: 'R. Roe - Pending', timestamp: '5h ago', icon: Icons.person_add_alt_1, iconColor: Colors.orange),
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

  Widget _buildSessionRow(String name, String type, String time, String status, {Color color = Colors.teal}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          CircleAvatar(
            backgroundColor: color.withOpacity(0.1),
            child: Text(name[0], style: TextStyle(color: color, fontWeight: FontWeight.bold)),
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
              Text(status, style: TextStyle(color: color, fontSize: 12)),
            ],
          ),
        ],
      ),
    );
  }
}
