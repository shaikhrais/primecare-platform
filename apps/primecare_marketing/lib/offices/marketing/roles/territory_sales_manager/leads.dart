import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:primecare_v4/design_system/clinical_glass.dart';
import 'package:primecare_v4/design_system/primecare_theme.dart';

class TerritoryLeadsScreen extends ConsumerStatefulWidget {
  const TerritoryLeadsScreen({super.key});

  @override
  ConsumerState<TerritoryLeadsScreen> createState() =>
      _TerritoryLeadsScreenState();
}

class _TerritoryLeadsScreenState extends ConsumerState<TerritoryLeadsScreen> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(32.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildHeader(),
          const SizedBox(height: 32),
          _buildMetricsOverview(),
          const SizedBox(height: 32),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 5,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildLeadVolumeTrend(),
                    const SizedBox(height: 32),
                    _buildLeadQualityMatrix(),
                  ],
                ),
              ),
              const SizedBox(width: 32),
              Expanded(flex: 3, child: _buildTopSources()),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Territory Lead Acquisition',
              style: PrimeCareTheme.typography.heroTitle.copyWith(
                color: PrimeCareTheme.colors.navyIndigo,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Analyze lead volume, top acquisition channels, and lead quality across your territory.',
              style: PrimeCareTheme.typography.body.copyWith(
                color: PrimeCareTheme.colors.slateGray,
              ),
            ),
          ],
        ),
        Row(
          children: [
            ClinicalGlassButton(
              onPressed: () {},
              icon: LucideIcons.calendar,
              label: 'Q3 2026',
            ),
            const SizedBox(width: 16),
            ClinicalGlassButton(
              onPressed: () {},
              icon: LucideIcons.download,
              label: 'Export Data',
              isActive: true,
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildMetricsOverview() {
    return Row(
      children: [
        Expanded(
          child: _buildMetricCard(
            title: 'Total Leads Generated',
            value: '4,285',
            trend: '+12.4%',
            positiveTrend: true,
          ),
        ),
        const SizedBox(width: 24),
        Expanded(
          child: _buildMetricCard(
            title: 'Avg. Cost Per Lead (CPL)',
            value: '\$45.20',
            trend: '-5.1%',
            positiveTrend: true, // Lower cost is better
          ),
        ),
        const SizedBox(width: 24),
        Expanded(
          child: _buildMetricCard(
            title: 'MQL to SQL Rate',
            value: '38.5%',
            trend: '+2.1%',
            positiveTrend: true,
          ),
        ),
        const SizedBox(width: 24),
        Expanded(
          child: _buildMetricCard(
            title: 'Avg. Days to Contact',
            value: '1.2 days',
            trend: '-0.3 days',
            positiveTrend: true, // Faster contact is better
          ),
        ),
      ],
    );
  }

  Widget _buildMetricCard({
    required String title,
    required String value,
    required String trend,
    required bool positiveTrend,
  }) {
    Color trendColor = positiveTrend
        ? PrimeCareTheme.colors.emeraldTeal
        : PrimeCareTheme.colors.coralRed;
    IconData trendIcon = positiveTrend
        ? LucideIcons.trendingUp
        : LucideIcons.trendingDown;

    return ClinicalGlassPanel(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: PrimeCareTheme.typography.label.copyWith(
              color: PrimeCareTheme.colors.slateGray,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            value,
            style: PrimeCareTheme.typography.h1.copyWith(
              color: PrimeCareTheme.colors.navyIndigo,
            ),
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Icon(trendIcon, size: 16, color: trendColor),
              const SizedBox(width: 4),
              Text(
                '$trend vs. Prior Qtr',
                style: PrimeCareTheme.typography.label.copyWith(
                  color: trendColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildLeadVolumeTrend() {
    return ClinicalGlassPanel(
      padding: const EdgeInsets.all(32),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Lead Volume Trend',
                style: PrimeCareTheme.typography.h3.copyWith(
                  color: PrimeCareTheme.colors.navyIndigo,
                ),
              ),
              // Legend
              Row(
                children: [
                  Container(
                    width: 12,
                    height: 12,
                    decoration: BoxDecoration(
                      color: PrimeCareTheme.colors.navyIndigo,
                      shape: BoxShape.circle,
                    ),
                  ),
                  const SizedBox(width: 4),
                  Text(
                    'Total Leads',
                    style: PrimeCareTheme.typography.label.copyWith(
                      color: PrimeCareTheme.colors.slateGray,
                      fontSize: 11,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Container(
                    width: 12,
                    height: 12,
                    decoration: BoxDecoration(
                      color: PrimeCareTheme.colors.emeraldTeal,
                      shape: BoxShape.circle,
                    ),
                  ),
                  const SizedBox(width: 4),
                  Text(
                    'Qualified Leads',
                    style: PrimeCareTheme.typography.label.copyWith(
                      color: PrimeCareTheme.colors.slateGray,
                      fontSize: 11,
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 32),
          // Bar Chart Placeholder using stacked containers
          SizedBox(
            height: 250,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                _buildStackedBar(total: 0.5, qualified: 0.3, label: 'Jan'),
                _buildStackedBar(total: 0.6, qualified: 0.35, label: 'Feb'),
                _buildStackedBar(total: 0.8, qualified: 0.45, label: 'Mar'),
                _buildStackedBar(total: 0.7, qualified: 0.4, label: 'Apr'),
                _buildStackedBar(total: 0.9, qualified: 0.55, label: 'May'),
                _buildStackedBar(total: 1.0, qualified: 0.6, label: 'Jun'),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStackedBar({
    required double total,
    required double qualified,
    required String label,
  }) {
    // total and qualified are percentages 0.0 to 1.0 for height relative to 200px max
    final double maxHeight = 200.0;
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Stack(
          alignment: Alignment.bottomCenter,
          children: [
            // Total Leads Bar (Background)
            Container(
              width: 30,
              height: maxHeight * total,
              decoration: BoxDecoration(
                color: PrimeCareTheme.colors.navyIndigo.withValues(alpha: 0.8),
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(4),
                ),
              ),
            ),
            // Qualified Leads Bar (Foreground)
            Container(
              width: 30,
              height: maxHeight * qualified,
              decoration: BoxDecoration(
                color: PrimeCareTheme.colors.emeraldTeal,
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(4),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Text(
          label,
          style: PrimeCareTheme.typography.label.copyWith(
            color: PrimeCareTheme.colors.slateGray,
          ),
        ),
      ],
    );
  }

  Widget _buildTopSources() {
    return ClinicalGlassPanel(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Top Lead Sources',
                style: PrimeCareTheme.typography.h3.copyWith(
                  color: PrimeCareTheme.colors.navyIndigo,
                ),
              ),
              Icon(
                LucideIcons.listFilter,
                size: 20,
                color: PrimeCareTheme.colors.slateGray,
              ),
            ],
          ),
          const SizedBox(height: 24),
          _buildSourceRow(
            name: 'Provider Referrals',
            count: 1250,
            percentage: 0.8,
          ),
          const SizedBox(height: 20),
          _buildSourceRow(
            name: 'Local Health Fairs',
            count: 980,
            percentage: 0.65,
          ),
          const SizedBox(height: 20),
          _buildSourceRow(
            name: 'Digital Search Ads',
            count: 850,
            percentage: 0.55,
          ),
          const SizedBox(height: 20),
          _buildSourceRow(
            name: 'Community Sponsorships',
            count: 620,
            percentage: 0.4,
          ),
          const SizedBox(height: 20),
          _buildSourceRow(
            name: 'Walk-ins / Direct',
            count: 585,
            percentage: 0.35,
          ),
        ],
      ),
    );
  }

  Widget _buildSourceRow({
    required String name,
    required int count,
    required double percentage,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              name,
              style: PrimeCareTheme.typography.h4.copyWith(
                color: PrimeCareTheme.colors.navyIndigo,
              ),
            ),
            Text(
              count.toString(),
              style: PrimeCareTheme.typography.label.copyWith(
                color: PrimeCareTheme.colors.navyIndigo,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        LinearProgressIndicator(
          value: percentage,
          backgroundColor: PrimeCareTheme.colors.surfaceContainerLow,
          valueColor: AlwaysStoppedAnimation<Color>(
            PrimeCareTheme.colors.navyIndigo,
          ),
          minHeight: 6,
          borderRadius: BorderRadius.circular(3),
        ),
      ],
    );
  }

  Widget _buildLeadQualityMatrix() {
    return ClinicalGlassPanel(
      padding: EdgeInsets.zero,
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
            decoration: BoxDecoration(
              color: PrimeCareTheme.colors.surfaceContainerLow,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(24),
                topRight: Radius.circular(24),
              ),
            ),
            child: Row(
              children: [
                Expanded(
                  flex: 3,
                  child: Text(
                    'LEAD SOURCE',
                    style: PrimeCareTheme.typography.label.copyWith(
                      fontSize: 11,
                      color: PrimeCareTheme.colors.slateGray,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Text(
                    'AVG SCORE (1-100)',
                    style: PrimeCareTheme.typography.label.copyWith(
                      fontSize: 11,
                      color: PrimeCareTheme.colors.slateGray,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Text(
                    'CONVERSION RATE',
                    style: PrimeCareTheme.typography.label.copyWith(
                      fontSize: 11,
                      color: PrimeCareTheme.colors.slateGray,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Text(
                    'LIFETIME VALUE (Est)',
                    style: PrimeCareTheme.typography.label.copyWith(
                      fontSize: 11,
                      color: PrimeCareTheme.colors.slateGray,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
          _buildQualityRow(
            source: 'Provider Referrals',
            score: '88',
            conv: '65.2%',
            ltv: '\$14,500',
          ),
          Divider(
            height: 1,
            color: PrimeCareTheme.colors.surfaceContainerHighest,
          ),
          _buildQualityRow(
            source: 'Local Health Fairs',
            score: '62',
            conv: '22.4%',
            ltv: '\$5,200',
          ),
          Divider(
            height: 1,
            color: PrimeCareTheme.colors.surfaceContainerHighest,
          ),
          _buildQualityRow(
            source: 'Digital Search Ads',
            score: '71',
            conv: '38.1%',
            ltv: '\$8,900',
          ),
        ],
      ),
    );
  }

  Widget _buildQualityRow({
    required String source,
    required String score,
    required String conv,
    required String ltv,
  }) {
    int scoreVal = int.tryParse(score) ?? 0;
    Color scoreColor = scoreVal > 80
        ? PrimeCareTheme.colors.emeraldTeal
        : (scoreVal > 60
              ? Colors.amber.shade700
              : PrimeCareTheme.colors.coralRed);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
      child: Row(
        children: [
          Expanded(
            flex: 3,
            child: Text(
              source,
              style: PrimeCareTheme.typography.h4.copyWith(
                color: PrimeCareTheme.colors.navyIndigo,
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Row(
              children: [
                Container(
                  width: 8,
                  height: 8,
                  decoration: BoxDecoration(
                    color: scoreColor,
                    shape: BoxShape.circle,
                  ),
                ),
                const SizedBox(width: 8),
                Text(
                  score,
                  style: PrimeCareTheme.typography.body.copyWith(
                    color: PrimeCareTheme.colors.navyIndigo,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            flex: 2,
            child: Text(
              conv,
              style: PrimeCareTheme.typography.body.copyWith(
                color: PrimeCareTheme.colors.slateGray,
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Text(
              ltv,
              style: PrimeCareTheme.typography.body.copyWith(
                color: PrimeCareTheme.colors.slateGray,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
