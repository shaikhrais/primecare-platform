import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:primecare_v4/design_system/clinical_glass.dart';
import 'package:primecare_v4/design_system/primecare_theme.dart';

class StrategicKpisScreen extends ConsumerWidget {
  const StrategicKpisScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Strategic KPIs',
              style: PrimeCareTheme.typography.heroTitle.copyWith(
                color: PrimeCareTheme.colors.navyIndigo,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Balanced Scorecard & Organizational Health Metrics.',
              style: PrimeCareTheme.typography.body.copyWith(
                color: PrimeCareTheme.colors.slateGray,
              ),
            ),
            const SizedBox(height: 32),
            GridView.count(
              crossAxisCount: 2,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              mainAxisSpacing: 24,
              crossAxisSpacing: 24,
              childAspectRatio: 1.5,
              children: [
                _buildScorecardQuadrant(
                  'Financial',
                  LucideIcons.dollarSign,
                  [
                    _buildSubMetric('ROI', '22.5%', isPositive: true),
                    _buildSubMetric('Operating Margin', '18.2%', isPositive: true),
                    _buildSubMetric('Cost/Acquisition', '\$2.4k', isPositive: false),
                  ],
                ),
                _buildScorecardQuadrant(
                  'Customer/Patient',
                  LucideIcons.heart,
                  [
                    _buildSubMetric('NPS Score', '74', isPositive: true),
                    _buildSubMetric('Retention Rate', '94%', isPositive: true),
                    _buildSubMetric('Wait Times', '-15%', isPositive: true),
                  ],
                ),
                _buildScorecardQuadrant(
                  'Internal Processes',
                  LucideIcons.settings,
                  [
                    _buildSubMetric('Audit Pass Rate', '99.8%', isPositive: true),
                    _buildSubMetric('Incident Resolution', '4.2 hrs', isPositive: true),
                    _buildSubMetric('System Uptime', '99.99%', isPositive: true),
                  ],
                ),
                _buildScorecardQuadrant(
                  'Learning & Growth',
                  LucideIcons.trendingUp,
                  [
                    _buildSubMetric('Employee Turnover', '8.2%', isPositive: true), // lower is better, standard HR metric interpretation depends
                    _buildSubMetric('Training Hours', '+45%', isPositive: true),
                    _buildSubMetric('Internal Promotions', '32%', isPositive: true),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildScorecardQuadrant(String title, IconData icon, List<Widget> metrics) {
    return ClinicalGlassPanel(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: PrimeCareTheme.colors.navyIndigo),
              const SizedBox(width: 8),
              Text(title, style: PrimeCareTheme.typography.h2),
            ],
          ),
          const SizedBox(height: 24),
          Expanded(
            child: ListView.separated(
              itemCount: metrics.length,
              physics: const NeverScrollableScrollPhysics(),
              separatorBuilder: (context, index) => Divider(color: PrimeCareTheme.colors.surfaceContainerHighest),
              itemBuilder: (context, index) => metrics[index],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSubMetric(String label, String value, {required bool isPositive}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: PrimeCareTheme.typography.body),
          Row(
            children: [
              Text(value, style: PrimeCareTheme.typography.h3.copyWith(color: isPositive ? PrimeCareTheme.colors.emeraldTeal : PrimeCareTheme.colors.coralRed)),
              const SizedBox(width: 8),
              Icon(
                isPositive ? LucideIcons.arrowUpRight : LucideIcons.arrowDownRight,
                color: isPositive ? PrimeCareTheme.colors.emeraldTeal : PrimeCareTheme.colors.coralRed,
                size: 16,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
