import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../office/components/glass_surface.dart';
import '../../../../office/components/kpi_stat_card.dart';
import '../../../../office/components/audit_log_tile.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../providers/api_providers.dart';

class TrainingCoordinatorDashboard extends ConsumerWidget {
  const TrainingCoordinatorDashboard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    ref.watch(apiClientProvider);

    return CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                   Text(
                    'Clinical Training & Onboarding Coordination',
                    style: theme.textTheme.headlineMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: AppTheme.primary,
                      fontFamily: 'Outfit',
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Orchestrating staff certification cycles, classroom logistics, and clinical education records.',
                    style: theme.textTheme.titleMedium?.copyWith(
                      color: Colors.blueGrey,
                      fontFamily: 'Inter',
                    ),
                  ),
                  const SizedBox(height: 32),

                  // TRAINING KPI ROW
                  LayoutBuilder(
                    builder: (context, constraints) {
                      final cardWidth = constraints.maxWidth > 1200 ? (constraints.maxWidth - 48) / 4 : (constraints.maxWidth > 600 ? (constraints.maxWidth - 16) / 2 : constraints.maxWidth);
                      return Wrap(
                        spacing: 16,
                        runSpacing: 16,
                        children: [
                          _buildKpi(cardWidth, 'New Hires', '12', Icons.hail_outlined, AppTheme.primary, 'Orientation: Mon'),
                          _buildKpi(cardWidth, 'Module Rate', '84%', Icons.menu_book_outlined, Colors.indigo, 'Completion stats'),
                          _buildKpi(cardWidth, 'Class Capacity', '18/20', Icons.meeting_room_outlined, Colors.teal, 'Vaughan Center'),
                          _buildKpi(cardWidth, 'Lapsed Certs', '2', Icons.update_outlined, Colors.orange, 'Action required'),
                        ],
                      );
                    },
                  ),

                  const SizedBox(height: 32),

                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // LEFT: Training Sessions
                      Expanded(
                        flex: 2,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Active Educational Sessions', style: theme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold, fontFamily: 'Outfit')),
                            const SizedBox(height: 16),
                            GlassSurface(
                              padding: const EdgeInsets.all(24),
                              child: Column(
                                children: [
                                  _buildSessionRow('Core Vitals Training', 'Clinical Staff (RN/PSW)', '09:00 AM', 'Vaughan Room 102'),
                                  const Divider(color: Colors.blueGrey, height: 24, thickness: 0.1),
                                  _buildSessionRow('Patient Lifting Protocols', 'PSW New Hires', '11:30 AM', 'Sim Lab B', isUrgent: true),
                                  const Divider(color: Colors.blueGrey, height: 24, thickness: 0.1),
                                  _buildSessionRow('Privacy & AODA Hub', 'Global Admin', '02:00 PM', 'Zoom Hub ID: 42'),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(width: 24),

                      // RIGHT: Certification Stream
                      Expanded(
                        flex: 1,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Coordinator Audit Feed', style: theme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold, fontFamily: 'Outfit')),
                            const SizedBox(height: 16),
                            GlassSurface(
                              padding: const EdgeInsets.all(16),
                              child: Column(
                                children: [
                                  AuditLogTile(title: 'Onboarding Done', subtitle: 'Ref: Group #PC-82 - 6 Staff', timestamp: '12m ago', icon: Icons.verified, iconColor: Colors.teal),
                                  const Divider(color: Colors.blueGrey, height: 16, thickness: 0.1),
                                  AuditLogTile(title: 'Room Booked', subtitle: 'Kitchener Site - Sim Lab', timestamp: '1h ago', icon: Icons.room_preferences_outlined, iconColor: Colors.indigo),
                                  const Divider(color: Colors.blueGrey, height: 16, thickness: 0.1),
                                  AuditLogTile(title: 'Module Published', subtitle: 'Post-Op Care v2.4 (L1)', timestamp: '3h ago', icon: Icons.publish_outlined, iconColor: Colors.orange),
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
      );
  }

  Widget _buildKpi(double width, String title, String value, IconData icon, Color color, [String? subtitle]) {
    return SizedBox(
      width: width,
      child: KpiStatCard(title: title, value: value, subtitle: subtitle, icon: icon, iconColor: color),
    );
  }

  Widget _buildSessionRow(String title, String attendees, String time, String location, {bool isUrgent = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
           CircleAvatar(
            backgroundColor: isUrgent ? Colors.orange.withValues(alpha: 0.1) : AppTheme.primary.withValues(alpha: 0.1),
            child: Icon(Icons.school_outlined, color: isUrgent ? Colors.orange : AppTheme.primary, size: 20),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                Text('$attendees | $location', style: const TextStyle(color: Colors.blueGrey, fontSize: 12)),
              ],
            ),
          ),
          Text(time, style: TextStyle(fontWeight: FontWeight.bold, color: isUrgent ? Colors.orange : AppTheme.primary, fontSize: 14)),
        ],
      ),
    );
  }
}
