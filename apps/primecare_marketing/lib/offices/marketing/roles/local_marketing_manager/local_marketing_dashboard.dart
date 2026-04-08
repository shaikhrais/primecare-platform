import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../office/components/glass_surface.dart';
import '../../../../office/components/kpi_stat_card.dart';
import 'package:primecare_core/theme/app_theme.dart';
import 'package:primecare_core/providers/dashboard_providers.dart';

class LocalMarketingDashboard extends ConsumerWidget {
  const LocalMarketingDashboard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final metricsAsync = ref.watch(dashboardMetricsProvider);

    return metricsAsync.when(
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
                    'Neighborhood Engagement: Hyper-Local Strategy',
                    style: theme.textTheme.headlineMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: AppTheme.primary,
                      fontFamily: 'Outfit',
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Managing neighborhood-specific campaigns and tracking hyper-local referral sources.',
                    style: theme.textTheme.titleMedium?.copyWith(
                      color: Colors.blueGrey,
                      fontFamily: 'Inter',
                    ),
                  ),
                  const SizedBox(height: 32),

                  // LOCAL MARKETING KPI ROW
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
                        children: metrics.kpis
                            .map(
                              (kpi) => _buildKpi(
                                cardWidth,
                                kpi.title,
                                kpi.value,
                                _getIcon(kpi.title),
                                _getStatusColor(kpi.status),
                                kpi.subtitle,
                              ),
                            )
                            .toList(),
                      );
                    },
                  ),

                  const SizedBox(height: 32),

                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // LEFT: Campaign Roadmap
                      Expanded(
                        flex: 2,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Hyper-Local Campaign Roadmap',
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
                                  _buildCampaignRow(
                                    'North End GP Referral Drive',
                                    'GP-204 Targeted',
                                    'ACTIVE',
                                    Colors.red,
                                  ),
                                  const Divider(
                                    color: Colors.blueGrey,
                                    height: 24,
                                    thickness: 0.1,
                                  ),
                                  _buildCampaignRow(
                                    'Riverside Community Booth',
                                    'Event: Local Square',
                                    'UPCOMING',
                                    Colors.indigo,
                                  ),
                                  const Divider(
                                    color: Colors.blueGrey,
                                    height: 24,
                                    thickness: 0.1,
                                  ),
                                  _buildCampaignRow(
                                    'Westside Digital Door-knocking',
                                    'Facebook Ads (Local)',
                                    'PLANNING',
                                    Colors.teal,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(width: 24),

                      // RIGHT: Referral Analysis
                      Expanded(
                        flex: 1,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Local Referral Sources',
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
                                  _buildReferralSource(
                                    'Local GP Referrals',
                                    '45%',
                                    Colors.red,
                                  ),
                                  const Divider(
                                    color: Colors.blueGrey,
                                    height: 16,
                                    thickness: 0.1,
                                  ),
                                  _buildReferralSource(
                                    'Community Events',
                                    '30%',
                                    Colors.indigo,
                                  ),
                                  const Divider(
                                    color: Colors.blueGrey,
                                    height: 16,
                                    thickness: 0.1,
                                  ),
                                  _buildReferralSource(
                                    'Digital/Social',
                                    '25%',
                                    Colors.teal,
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
      ),
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

  Widget _buildCampaignRow(
    String title,
    String target,
    String status,
    Color statusColor,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: statusColor.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(Icons.campaign_outlined, color: statusColor, size: 20),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                Text(
                  target,
                  style: const TextStyle(color: Colors.blueGrey, fontSize: 12),
                ),
              ],
            ),
          ),
          Text(
            status,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: statusColor,
              fontSize: 10,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildReferralSource(String name, String percentage, Color color) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              CircleAvatar(radius: 4, backgroundColor: color),
              const SizedBox(width: 8),
              Text(name, style: const TextStyle(fontSize: 14)),
            ],
          ),
          Text(
            percentage,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
          ),
        ],
      ),
    );
  }

  IconData _getIcon(String title) {
    if (title.contains('Campaigns')) return Icons.layers_outlined;
    if (title.contains('Leads')) return Icons.stars_outlined;
    if (title.contains('Variance')) return Icons.pie_chart_outline;
    if (title.contains('Spend')) return Icons.payments_outlined;
    return Icons.insights;
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case 'success':
      case 'teal':
        return Colors.teal;
      case 'warning':
      case 'orange':
        return Colors.orange;
      case 'danger':
      case 'red':
        return Colors.red;
      case 'info':
      case 'indigo':
      case 'blue':
        return Colors.indigo;
      default:
        return Colors.blueGrey;
    }
  }
}
