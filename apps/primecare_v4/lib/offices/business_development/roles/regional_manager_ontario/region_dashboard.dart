import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../office/components/glass_surface.dart';
import '../../../../office/components/kpi_stat_card.dart';
import '../../../../office/components/audit_log_tile.dart';
import '../../../../office/components/region_performance_card.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../providers/api_providers.dart';

class RegionDashboard extends ConsumerWidget {
  final String regionName;
  const RegionDashboard({super.key, this.regionName = 'Ontario Cluster'});

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
                      const Icon(Icons.map_outlined, color: Colors.teal, size: 28),
                      const SizedBox(width: 12),
                      Text(
                        'Regional Hub: $regionName',
                        style: theme.textTheme.headlineMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: AppTheme.primary,
                          fontFamily: 'Outfit',
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Orchestrating facility clusters, staffing velocity, and regional revenue growth.',
                    style: TextStyle(color: Colors.blueGrey, fontFamily: 'Inter'),
                  ),
                  const SizedBox(height: 32),

                  // REGIONAL KPI ROW
                  LayoutBuilder(
                    builder: (context, constraints) {
                      final cardWidth = constraints.maxWidth > 1200 ? (constraints.maxWidth - 48) / 4 : (constraints.maxWidth > 600 ? (constraints.maxWidth - 16) / 2 : constraints.maxWidth);
                      return Wrap(
                        spacing: 16,
                        runSpacing: 16,
                        children: [
                          _buildKpi(cardWidth, 'Total Revenue', '\$1.8M', Icons.payments_outlined, AppTheme.primary, 'Region Target: \$2.0M'),
                          _buildKpi(cardWidth, 'Active Facilities', '42', Icons.business_outlined, Colors.indigo, '3 New in pipeline'),
                          _buildKpi(cardWidth, 'Care Compliance', '97%', Icons.verified_user_outlined, Colors.teal, 'Target: 98%'),
                          _buildKpi(cardWidth, 'Staffing Velocity', '+12%', Icons.person_add_alt_1_outlined, Colors.orange, 'Last 30 days'),
                        ],
                      );
                    },
                  ),

                  const SizedBox(height: 32),

                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // LEFT: Facility Performance
                      Expanded(
                        flex: 2,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Regional Performance Ladder', style: theme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold, fontFamily: 'Outfit')),
                            const SizedBox(height: 16),
                            GlassSurface(
                              padding: const EdgeInsets.all(24),
                              child: Column(
                                children: [
                                  RegionPerformanceCard(region: 'Toronto GTA', facilityCount: '18 Units', revenue: '\$820k', margin: '32% ACTIVE'),
                                  const Divider(color: Colors.blueGrey, height: 24, thickness: 0.1),
                                  RegionPerformanceCard(region: 'Hamilton Corridor', facilityCount: '12 Units', revenue: '\$440k', margin: '28% ACTIVE'),
                                  const Divider(color: Colors.blueGrey, height: 24, thickness: 0.1),
                                  RegionPerformanceCard(region: 'Ottawa East', facilityCount: '12 Units', revenue: '\$540k', margin: '22% STABLE', marginColor: Colors.blue),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(width: 24),

                      // RIGHT: Regional Logs
                      Expanded(
                        flex: 1,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Regional Audit Trail', style: theme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold, fontFamily: 'Outfit')),
                            const SizedBox(height: 16),
                            GlassSurface(
                              padding: const EdgeInsets.all(16),
                              child: Column(
                                children: [
                                  AuditLogTile(title: 'New License: Brampton', subtitle: 'Ref: #PC-882 - Approved', timestamp: '1h ago', icon: Icons.badge_outlined, iconColor: Colors.teal),
                                  const Divider(color: Colors.blueGrey, height: 16, thickness: 0.1),
                                  AuditLogTile(title: 'Compliance Alert', subtitle: 'Ottawa Facility: documentation', timestamp: '4h ago', icon: Icons.warning_amber, iconColor: Colors.orange),
                                  const Divider(color: Colors.blueGrey, height: 16, thickness: 0.1),
                                  AuditLogTile(title: 'Strategic Onboarding', subtitle: '3 New PSWs in London ON', timestamp: '1d ago', icon: Icons.group_add_outlined, iconColor: Colors.indigo),
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
}
