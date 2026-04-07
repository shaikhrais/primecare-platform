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
  const RegionDashboard({super.key, this.regionName = 'USA Northeast'});

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
                Row(
                  children: [
                    const Icon(
                      Icons.public_outlined,
                      color: Colors.blueAccent,
                      size: 28,
                    ),
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
                  'Managing US-based facility expansion, CMS compliance, and multi-state operational velocity.',
                  style: TextStyle(color: Colors.blueGrey, fontFamily: 'Inter'),
                ),
                const SizedBox(height: 32),

                // USA REGIONAL KPI ROW
                LayoutBuilder(
                  builder: (context, constraints) {
                    final cardWidth = constraints.maxWidth > 1200
                        ? (constraints.maxWidth - 48) / 4
                        : (constraints.maxWidth > 600
                              ? (constraints.maxWidth - 16) / 2
                              : constraints.maxWidth);
                    return Wrap(
                      spacing: 16,
                      runSpacing: 16,
                      children: [
                        _buildKpi(
                          cardWidth,
                          'Total Revenue',
                          r'$2.4M',
                          Icons.payments_outlined,
                          AppTheme.primary,
                          r'Region Target: $2.8M',
                        ),
                        _buildKpi(
                          cardWidth,
                          'State Clusters',
                          '8 States',
                          Icons.map_outlined,
                          Colors.indigo,
                          '3 New states pending',
                        ),
                        _buildKpi(
                          cardWidth,
                          'CMS Rating',
                          '4.8/5.0',
                          Icons.stars_outlined,
                          Colors.teal,
                          'Network Average',
                        ),
                        _buildKpi(
                          cardWidth,
                          'Net Growth',
                          '+18%',
                          Icons.trending_up,
                          Colors.orange,
                          'Last 30 days',
                        ),
                      ],
                    );
                  },
                ),

                const SizedBox(height: 32),

                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // LEFT: State Performance
                    Expanded(
                      flex: 2,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'State Performance Ledger',
                            style: theme.textTheme.titleLarge?.copyWith(
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Outfit',
                            ),
                          ),
                          const SizedBox(height: 16),
                          GlassSurface(
                            padding: const EdgeInsets.all(24),
                            child: Column(
                              children: [
                                RegionPerformanceCard(
                                  region: 'New York Metro',
                                  facilityCount: '36 Units',
                                  revenue: r'$1.1M',
                                  margin: '32.1% ACTIVE',
                                ),
                                const Divider(
                                  color: Colors.blueGrey,
                                  height: 24,
                                  thickness: 0.1,
                                ),
                                RegionPerformanceCard(
                                  region: 'New Jersey Satellite',
                                  facilityCount: '18 Units',
                                  revenue: r'$640k',
                                  margin: '24.5% STABLE',
                                  marginColor: Colors.blue,
                                ),
                                const Divider(
                                  color: Colors.blueGrey,
                                  height: 24,
                                  thickness: 0.1,
                                ),
                                RegionPerformanceCard(
                                  region: 'Florida Cluster',
                                  facilityCount: '42 Units',
                                  revenue: r'$1.2M',
                                  margin: '28.2% ACTIVE',
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(width: 24),

                    // RIGHT: USA Logs
                    Expanded(
                      flex: 1,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'CMS & Regulatory Trail',
                            style: theme.textTheme.titleLarge?.copyWith(
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Outfit',
                            ),
                          ),
                          const SizedBox(height: 16),
                          GlassSurface(
                            padding: const EdgeInsets.all(16),
                            child: Column(
                              children: [
                                AuditLogTile(
                                  title: 'CMS Audit Success',
                                  subtitle: 'Ref: #NY-0042 - Passed',
                                  timestamp: '1h ago',
                                  icon: Icons.playlist_add_check_circle,
                                  iconColor: Colors.teal,
                                ),
                                const Divider(
                                  color: Colors.blueGrey,
                                  height: 16,
                                  thickness: 0.1,
                                ),
                                AuditLogTile(
                                  title: 'State Variance',
                                  subtitle: 'Florida: licensing lag',
                                  timestamp: '4h ago',
                                  icon: Icons.warning_amber,
                                  iconColor: Colors.orange,
                                ),
                                const Divider(
                                  color: Colors.blueGrey,
                                  height: 16,
                                  thickness: 0.1,
                                ),
                                AuditLogTile(
                                  title: 'Onboarding: Texas',
                                  subtitle: 'Lead: Region Manager East',
                                  timestamp: '1d ago',
                                  icon: Icons.person_add_alt_1_outlined,
                                  iconColor: Colors.indigo,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildKpi(
    double width,
    String title,
    String value,
    IconData icon,
    Color color, [
    String? subtitle,
  ]) {
    return SizedBox(
      width: width,
      child: KpiStatCard(
        title: title,
        value: value,
        subtitle: subtitle,
        icon: icon,
        iconColor: color,
      ),
    );
  }
}
