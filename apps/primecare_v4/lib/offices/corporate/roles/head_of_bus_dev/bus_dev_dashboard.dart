import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../office/components/glass_surface.dart';
import '../../../../office/components/kpi_stat_card.dart';
import '../../../../office/components/audit_log_tile.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../providers/api_providers.dart';

class BusDevDashboard extends ConsumerWidget {
  const BusDevDashboard({Key? key}) : super(key: key);

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
                    'Business Development Leadership',
                    style: theme.textTheme.headlineMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: AppTheme.primary,
                      fontFamily: 'Outfit',
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Strategic orchestration of franchise expansion and clinical partnership growth.',
                    style: theme.textTheme.titleMedium?.copyWith(
                      color: Colors.blueGrey,
                      fontFamily: 'Inter',
                    ),
                  ),
                  const SizedBox(height: 32),

                  // BUSDEV KPI ROW
                  LayoutBuilder(
                    builder: (context, constraints) {
                      final cardWidth = constraints.maxWidth > 1200 ? (constraints.maxWidth - 48) / 4 : (constraints.maxWidth > 600 ? (constraints.maxWidth - 16) / 2 : constraints.maxWidth);
                      return Wrap(
                        spacing: 16,
                        runSpacing: 16,
                        children: [
                          _buildKpi(cardWidth, 'Lead Pipeline', '142', Icons.account_tree_outlined, AppTheme.primary, '32 High intent'),
                          _buildKpi(cardWidth, 'Franchise Target', '8 / 12', Icons.add_home_work_outlined, Colors.indigo, 'Q2 Completion: 66%'),
                          _buildKpi(cardWidth, 'Avg Deal Size', '$120k', Icons.payments_outlined, Colors.teal, 'Network Entry Fee'),
                          _buildKpi(cardWidth, 'Expansion Score', '92/100', Icons.trending_up, Colors.orange, 'Ontario Cluster'),
                        ],
                      );
                    },
                  ),

                  const SizedBox(height: 32),

                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // LEFT: Partner Pipeline
                      Expanded(
                        flex: 2,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Franchise Acquisition Pipeline', style: theme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold, fontFamily: 'Outfit')),
                            const SizedBox(height: 16),
                            GlassSurface(
                              padding: const EdgeInsets.all(24),
                              child: Column(
                                children: [
                                  _buildPipelineItem('Brampton South', 'Negotiation Phase', '$450k Peak', '60% PROBABILITY'),
                                  const Divider(color: Colors.blueGrey, height: 24, thickness: 0.1),
                                  _buildPipelineItem('Mississauga East', 'Discovery Call', 'N/A', 'HOT LEAD', isHot: true),
                                  const Divider(color: Colors.blueGrey, height: 24, thickness: 0.1),
                                  _buildPipelineItem('Oakville Central', 'Agreement Signed', '$720k Peak', 'CLOSED WON', isWon: true),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(width: 24),

                      // RIGHT: Market Logs
                      Expanded(
                        flex: 1,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Growth Audit Trail', style: theme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold, fontFamily: 'Outfit')),
                            const SizedBox(height: 16),
                            GlassSurface(
                              padding: const EdgeInsets.all(16),
                              child: Column(
                                children: [
                                  AuditLogTile(title: 'New Lead: Hamilton', subtitle: 'Ref: Dr. Sarah Blake', timestamp: '5m ago', icon: Icons.person_add_alt_1_outlined, iconColor: Colors.teal),
                                  const Divider(color: Colors.blueGrey, height: 16, thickness: 0.1),
                                  AuditLogTile(title: 'Market Analysis', subtitle: 'Region: Kitchener-Waterloo', timestamp: '2h ago', icon: Icons.analytics_outlined, iconColor: Colors.indigo),
                                  const Divider(color: Colors.blueGrey, height: 16, thickness: 0.1),
                                  AuditLogTile(title: 'Partner Meeting', subtitle: 'Institutional Investors', timestamp: '1d ago', icon: Icons.groups_outlined, iconColor: Colors.blueGrey),
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

  Widget _buildPipelineItem(String location, String stage, String value, String status, {bool isHot = false, bool isWon = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          CircleAvatar(
            backgroundColor: isWon ? Colors.teal.withOpacity(0.1) : (isHot ? Colors.orange.withOpacity(0.1) : AppTheme.primary.withOpacity(0.1)),
            child: Icon(isWon ? Icons.check_circle_outline : (isHot ? Icons.whatshot_outlined : Icons.corporate_fare_outlined), color: isWon ? Colors.teal : (isHot ? Colors.orange : AppTheme.primary), size: 20),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(location, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                Text(stage, style: const TextStyle(color: Colors.blueGrey, fontSize: 12)),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(status, style: TextStyle(fontWeight: FontWeight.bold, color: isWon ? Colors.teal : (isHot ? Colors.orange : AppTheme.primary), fontSize: 11)),
              if (value != 'N/A') Text(value, style: const TextStyle(color: Colors.blueGrey, fontSize: 10)),
            ],
          ),
        ],
      ),
    );
  }
}
