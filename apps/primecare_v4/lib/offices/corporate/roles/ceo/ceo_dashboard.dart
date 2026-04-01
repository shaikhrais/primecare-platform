import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../office/components/glass_surface.dart';
import '../../../../office/components/kpi_stat_card.dart';
import '../../../../office/components/audit_log_tile.dart';
import '../../../../office/components/region_performance_card.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../providers/dashboard_providers.dart';
import '../../../../services/dashboard_service.dart';

class CeoDashboard extends ConsumerWidget {
  const CeoDashboard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final metricsAsync = ref.watch(dashboardMetricsProvider);
    
    return Scaffold(
      backgroundColor: Colors.transparent, // Inherit shell background
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
                      'CEO Enterprise Overview',
                      style: theme.textTheme.headlineMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: AppTheme.primary,
                        fontFamily: 'Outfit',
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Strategic real-time monitoring across the clinical network.',
                      style: theme.textTheme.titleMedium?.copyWith(
                        color: Colors.blueGrey,
                        fontFamily: 'Inter',
                      ),
                    ),
                    const SizedBox(height: 32),
                    
                    // TOP KPI ROW (Responsive)
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

                    // REGIONAL PERFORMANCE & GROWTH
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // LEFT COLUMN: Regional Performance
                        Expanded(
                          flex: 2,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Regional Performance: Northeast Cluster', style: theme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold, fontFamily: 'Outfit')),
                              const SizedBox(height: 16),
                              GlassSurface(
                                padding: const EdgeInsets.all(24),
                                child: Column(
                                  children: [
                                    RegionPerformanceCard(region: 'Ontario Corridor', facilityCount: '42 Facilities', revenue: '$1.4M', margin: '32.4% ACTIVE'),
                                    const Divider(color: Colors.blueGrey, height: 24, thickness: 0.1),
                                    RegionPerformanceCard(region: 'New York Metro', facilityCount: '36 Facilities', revenue: '$1.1M', margin: '28.1% ACTIVE'),
                                    const Divider(color: Colors.blueGrey, height: 24, thickness: 0.1),
                                    RegionPerformanceCard(region: 'New Jersey Satellite', facilityCount: '18 Facilities', revenue: '$640k', margin: '24.5% STABLE', marginColor: Colors.blue),
                                  ],
                                ),
                              ),
                              
                              const SizedBox(height: 32),
                              
                              Text('Growth Pipeline & Insights', style: theme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold, fontFamily: 'Outfit')),
                              const SizedBox(height: 16),
                              GlassSurface(
                                padding: const EdgeInsets.all(24),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        const CircleAvatar(backgroundColor: Color(0x1A006565), child: Icon(Icons.psychology, color: AppTheme.primary)),
                                        const SizedBox(width: 16),
                                        Text('CEO Strategic Insight', style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold, fontFamily: 'Outfit')),
                                      ],
                                    ),
                                    const SizedBox(height: 16),
                                    const Text(
                                      'Expansion in the Hamilton cluster is outpacing projections. Recommend accelerating the Q4 site visits to finalize the three new clinic locations in NY currently under review.',
                                      style: TextStyle(fontSize: 16, height: 1.5, color: Color(0xFF4A5555), fontFamily: 'Inter'),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          )
                        ),
                        
                        const SizedBox(width: 24),
                        
                        // RIGHT COLUMN: Actions & Activity
                        Expanded(
                          flex: 1,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Executive Actions', style: theme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold, fontFamily: 'Outfit')),
                              const SizedBox(height: 16),
                              _buildActionCard('Approve Expansion', 'Review 3 clinic locations in NY', Icons.add_business),
                              _buildActionCard('Review Q3 Report', 'Financial audit for Northeast', Icons.assignment),
                              _buildActionCard('Board Messages', '2 priority updates from investors', Icons.forum),
                              
                              const SizedBox(height: 32),
                              
                              Text('Critical Activity Feed', style: theme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold, fontFamily: 'Outfit')),
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
                              )
                            ],
                          )
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

  Widget _buildActionCard(String title, String subtitle, IconData icon) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: GlassSurface(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Icon(icon, color: AppTheme.primary, size: 24),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
                  Text(subtitle, style: const TextStyle(color: Colors.blueGrey, fontSize: 13)),
                ],
              ),
            ),
            const Icon(Icons.chevron_right, color: Colors.blueGrey),
          ],
        ),
      ),
    );
  }

  IconData _getIcon(String title) {
    if (title.contains('Revenue')) return Icons.attach_money;
    if (title.contains('Locations')) return Icons.location_on;
    if (title.contains('Hours')) return Icons.schedule;
    if (title.contains('Compliance')) return Icons.verified_user;
    if (title.contains('Staff')) return Icons.people;
    return Icons.insights;
  }

  IconData _getActivityIcon(String icon) {
    switch (icon) {
      case 'verified': return Icons.verified;
      case 'person_add': return Icons.person_add;
      case 'security': return Icons.security;
      case 'trending_up': return Icons.trending_up;
      case 'warning': return Icons.warning_amber;
      default: return Icons.history;
    }
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case 'success':
      case 'green':
      case 'teal': return Colors.teal;
      case 'warning':
      case 'orange': return Colors.orange;
      case 'danger':
      case 'red': return Colors.red;
      case 'info':
      case 'blue':
      case 'indigo': return Colors.indigo;
      default: return Colors.blueGrey;
    }
  }
}
