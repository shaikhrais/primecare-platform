import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../office/components/glass_surface.dart';
import '../../../../office/components/kpi_stat_card.dart';
import '../../../../office/components/audit_log_tile.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../providers/dashboard_providers.dart';

class CustomerSatisfactionView extends ConsumerWidget {
  const CustomerSatisfactionView({super.key});

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
                    'Customer Satisfaction (CSAT) & NPS HUD',
                    style: theme.textTheme.headlineMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: AppTheme.primary,
                      fontFamily: 'Outfit',
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Real-time clinic sentiment, Net Promoter Score, and qualitative patient feedback loop.',
                    style: theme.textTheme.titleMedium?.copyWith(
                      color: Colors.blueGrey,
                      fontFamily: 'Inter',
                    ),
                  ),
                  const SizedBox(height: 32),

                  // CSAT KPI ROW
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
                            'Net Promoter Score',
                            '+72',
                            Icons.trending_up,
                            Colors.teal,
                            'Top 10% Regional',
                          ),
                          _buildKpi(
                            cardWidth,
                            'CSAT Average',
                            '4.8/5.0',
                            Icons.star,
                            Colors.orange,
                            'Based on 452 Surveys',
                          ),
                          _buildKpi(
                            cardWidth,
                            'Negative Sentiment',
                            '2.1%',
                            Icons.feedback_outlined,
                            Colors.red,
                            'Down 1.4% MoM',
                          ),
                          _buildKpi(
                            cardWidth,
                            'Response Rate',
                            '64%',
                            Icons.mark_email_read,
                            Colors.indigo,
                            'Automated SMS Loop',
                          ),
                        ],
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
                            Text(
                              'Clinic Specific CSAT Breakdown',
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
                                  _buildClinicRow(
                                    'Downtown Core Clinic',
                                    '92% Satisfaction',
                                    'EXCEPTIONAL',
                                    Colors.teal,
                                  ),
                                  const Divider(
                                    color: Colors.blueGrey,
                                    height: 24,
                                    thickness: 0.1,
                                  ),
                                  _buildClinicRow(
                                    'West End Physiotherapy',
                                    '88% Satisfaction',
                                    'AT TARGET',
                                    Colors.indigo,
                                  ),
                                  const Divider(
                                    color: Colors.blueGrey,
                                    height: 24,
                                    thickness: 0.1,
                                  ),
                                  _buildClinicRow(
                                    'North York Multidisciplinary',
                                    '74% Satisfaction',
                                    'REVIEW WAIT TIMES',
                                    Colors.orange,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(width: 24),

                      // RIGHT: Sentiment Alerts
                      Expanded(
                        flex: 1,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Real-Time Qualitative Feedback',
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
                                    title: '5 Star Review',
                                    subtitle:
                                        '"The Physio resolved my back pain in 3 sessions!"',
                                    timestamp: '10 Mins Ago',
                                    icon: Icons.star,
                                    iconColor: Colors.teal,
                                  ),
                                  const Divider(
                                    color: Colors.blueGrey,
                                    height: 16,
                                    thickness: 0.1,
                                  ),
                                  AuditLogTile(
                                    title: '2 Star Review',
                                    subtitle:
                                        '"Waiting room was too crowded today."',
                                    timestamp: '1 Hr Ago',
                                    icon: Icons.warning_amber,
                                    iconColor: Colors.orange,
                                  ),
                                  const Divider(
                                    color: Colors.blueGrey,
                                    height: 16,
                                    thickness: 0.1,
                                  ),
                                  AuditLogTile(
                                    title: '5 Star Review',
                                    subtitle:
                                        '"Front desk staff is incredibly polite and fast."',
                                    timestamp: '4 Hrs Ago',
                                    icon: Icons.star,
                                    iconColor: Colors.teal,
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

  Widget _buildClinicRow(
    String name,
    String stat,
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
            child: Icon(
              Icons.maps_home_work_outlined,
              color: statusColor,
              size: 20,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                Text(
                  stat,
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
              letterSpacing: 1.1,
            ),
          ),
        ],
      ),
    );
  }
}
