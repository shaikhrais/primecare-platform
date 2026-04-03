import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../office/components/glass_surface.dart';
import '../../../../office/components/kpi_stat_card.dart';
import '../../../../office/components/audit_log_tile.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../providers/dashboard_providers.dart';

class MarketingOversightView extends ConsumerWidget {
  const MarketingOversightView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final metricsAsync = ref.watch(dashboardMetricsProvider);

    return Scaffold(
      backgroundColor: Colors.transparent,
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
                      'Marketing ROI & Growth Pipeline',
                      style: theme.textTheme.headlineMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: AppTheme.primary,
                        fontFamily: 'Outfit',
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Monitoring local advertising spend, Lead Velocity Rates, and Customer Acquisition Cost (CAC).',
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
                            _buildKpi(cardWidth, 'Total Ad Spend', '\$12,450', Icons.attach_money, Colors.orange, 'Current Month'),
                            _buildKpi(cardWidth, 'Blended CAC', '\$142.50', Icons.trending_down, Colors.teal, 'Decreased by 12%'),
                            _buildKpi(cardWidth, 'New Patient LTV', '\$2,100', Icons.auto_graph, Colors.indigo, 'Average Lifetime Value'),
                            _buildKpi(cardWidth, 'Lead Velocity Rate', '+18%', Icons.speed, Colors.teal, 'MoM Growth'),
                          ]
                        );
                      },
                    ),

                    const SizedBox(height: 32),

                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                         Expanded(
                          flex: 2,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Active Local Campaigns', style: theme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold, fontFamily: 'Outfit')),
                              const SizedBox(height: 16),
                              GlassSurface(
                                padding: const EdgeInsets.all(24),
                                child: Column(
                                  children: [
                                    _buildCampaignRow('Google Ads: "Physiotherapy Near Me"', '\$4,200', 'HIGH CONVERSION', Colors.teal),
                                    const Divider(color: Colors.blueGrey, height: 24, thickness: 0.1),
                                    _buildCampaignRow('Facebook: Post-Op Rehab Retargeting', '\$2,100', 'STABLE ROI', Colors.indigo),
                                    const Divider(color: Colors.blueGrey, height: 24, thickness: 0.1),
                                    _buildCampaignRow('Local Radio: Orthotics Promotion', '\$1,500', 'AWAITING DATA', Colors.orange),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),

                        const SizedBox(width: 24),

                        Expanded(
                          flex: 1,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Funnel Alerts', style: theme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold, fontFamily: 'Outfit')),
                              const SizedBox(height: 16),
                              GlassSurface(
                                padding: const EdgeInsets.all(16),
                                child: Column(
                                  children: [
                                    AuditLogTile(title: 'High Bounce Rate', subtitle: 'Landing page /sports-massage showing 72% bounce.', timestamp: '2 Hrs Ago', icon: Icons.warning_amber, iconColor: Colors.orange),
                                    const Divider(color: Colors.blueGrey, height: 16, thickness: 0.1),
                                    AuditLogTile(title: 'Record Conversion', subtitle: 'Google Ads CPC dropped below \$2.00.', timestamp: '4 Hrs Ago', icon: Icons.insights, iconColor: Colors.teal),
                                    const Divider(color: Colors.blueGrey, height: 16, thickness: 0.1),
                                    AuditLogTile(title: 'Ad Budget Depleted', subtitle: 'Facebook Monthly Budget reached at 90%.', timestamp: 'Yesterday', icon: Icons.account_balance_wallet, iconColor: Colors.red),
                                  ]
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
      ),
    );
  }

  Widget _buildKpi(double width, String title, String value, IconData icon, Color color, [String? subtitle]) {
    return SizedBox(
      width: width,
      child: KpiStatCard(title: title, value: value, subtitle: subtitle, icon: icon, iconColor: color),
    );
  }

  Widget _buildCampaignRow(String name, String spend, String status, Color statusColor) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
           Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(color: statusColor.withValues(alpha: 0.1), borderRadius: BorderRadius.circular(10)),
            child: Icon(Icons.campaign_outlined, color: statusColor, size: 20),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(name, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                Text('Spend: $spend', style: const TextStyle(color: Colors.blueGrey, fontSize: 12)),
              ],
            ),
          ),
          Text(status, style: TextStyle(fontWeight: FontWeight.bold, color: statusColor, fontSize: 10, letterSpacing: 1.1)),
        ],
      ),
    );
  }
}
