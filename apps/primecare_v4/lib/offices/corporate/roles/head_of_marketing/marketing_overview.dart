import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../office/components/glass_surface.dart';
import '../../../../office/components/kpi_stat_card.dart';
import '../../../../office/components/audit_log_tile.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../providers/api_providers.dart';

class MarketingOverview extends ConsumerWidget {
  const MarketingOverview({Key? key}) : super(key: key);

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
                    'Global Brand & Growth Marketing',
                    style: theme.textTheme.headlineMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: AppTheme.primary,
                      fontFamily: 'Outfit',
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Orchestrating regional outreach, lead velocity, and institutional brand authority.',
                    style: theme.textTheme.titleMedium?.copyWith(
                      color: Colors.blueGrey,
                      fontFamily: 'Inter',
                    ),
                  ),
                  const SizedBox(height: 32),

                  // MARKETING KPI ROW
                  LayoutBuilder(
                    builder: (context, constraints) {
                      final cardWidth = constraints.maxWidth > 1200 ? (constraints.maxWidth - 48) / 4 : (constraints.maxWidth > 600 ? (constraints.maxWidth - 16) / 2 : constraints.maxWidth);
                      return Wrap(
                        spacing: 16,
                        runSpacing: 16,
                        children: [
                          _buildKpi(cardWidth, 'Total Reach', '2.4M', Icons.campaign_outlined, AppTheme.primary, '32% MoM Growth'),
                          _buildKpi(cardWidth, 'Avg Lead Cost', '$12.40', Icons.payments_outlined, Colors.indigo, 'Target: <$15'),
                          _buildKpi(cardWidth, 'Lead Velocity', '8.2k', Icons.speed, Colors.teal, 'Active inquiries'),
                          _buildKpi(cardWidth, 'Brand Equity', '92%', Icons.star_outline, Colors.orange, 'Surpassing Competitors'),
                        ],
                      );
                    },
                  ),

                  const SizedBox(height: 32),

                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // LEFT: Regional Campaigns
                      Expanded(
                        flex: 2,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Active Expansion Campaigns', style: theme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold, fontFamily: 'Outfit')),
                            const SizedBox(height: 16),
                            GlassSurface(
                              padding: const EdgeInsets.all(24),
                              child: Column(
                                children: [
                                  _buildCampaignRow('Healthy Aging: NY Cluster', 'Paid Search / Meta', 'ACTIVE', '4.2k Leads'),
                                  const Divider(color: Colors.blueGrey, height: 24, thickness: 0.1),
                                  _buildCampaignRow('PrimeCare Discovery: ON', 'Local Outreach', 'ACTIVE', '2.1k Leads'),
                                  const Divider(color: Colors.blueGrey, height: 24, thickness: 0.1),
                                  _buildCampaignRow('Post-Op Mobility: FLA', 'Affiliate / Clinic Hub', 'PAUSED', '0.4k Leads', isPaused: true),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(width: 24),

                      // RIGHT: Market Trends
                      Expanded(
                        flex: 1,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Marketing Audit Trail', style: theme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold, fontFamily: 'Outfit')),
                            const SizedBox(height: 16),
                            GlassSurface(
                              padding: const EdgeInsets.all(16),
                              child: Column(
                                children: [
                                  AuditLogTile(title: 'Asset Approved', subtitle: 'Regional TV Spot v2', timestamp: '5m ago', icon: Icons.video_library_outlined, iconColor: Colors.teal),
                                  const Divider(color: Colors.blueGrey, height: 16, thickness: 0.1),
                                  AuditLogTile(title: 'Budget Released', subtitle: 'Northeast Expansion Q3', timestamp: '2h ago', icon: Icons.savings_outlined, iconColor: Colors.teal),
                                  const Divider(color: Colors.blueGrey, height: 16, thickness: 0.1),
                                  AuditLogTile(title: 'Domain Risk', subtitle: 'Duplicate Lead Detection', timestamp: '1d ago', icon: Icons.warning_amber_outlined, iconColor: Colors.orange),
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

  Widget _buildCampaignRow(String title, String type, String status, String performance, {bool isPaused = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          CircleAvatar(
            backgroundColor: isPaused ? Colors.blueGrey.withOpacity(0.1) : AppTheme.primary.withOpacity(0.1),
            child: Icon(Icons.hub_outlined, color: isPaused ? Colors.blueGrey : AppTheme.primary, size: 20),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                Text(type, style: const TextStyle(color: Colors.blueGrey, fontSize: 12)),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(performance, style: TextStyle(fontWeight: FontWeight.bold, color: isPaused ? Colors.blueGrey : Colors.teal)),
              Text(status, style: const TextStyle(fontSize: 9, fontWeight: FontWeight.bold, letterSpacing: 1.1, color: Colors.blueGrey)),
            ],
          ),
        ],
      ),
    );
  }
}
