import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:primecare_v4/design_system/clinical_glass.dart';
import 'package:primecare_v4/design_system/primecare_theme.dart';
import 'package:fl_chart/fl_chart.dart';

class CeoRegionPerformanceScreen extends ConsumerStatefulWidget {
  const CeoRegionPerformanceScreen({super.key});

  @override
  ConsumerState<CeoRegionPerformanceScreen> createState() =>
      _CeoRegionPerformanceScreenState();
}

class _CeoRegionPerformanceScreenState
    extends ConsumerState<CeoRegionPerformanceScreen> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(32.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildHeader(),
          const SizedBox(height: 32),
          _buildKPIs(),
          const SizedBox(height: 32),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(flex: 3, child: _buildRegionTable()),
              const SizedBox(width: 32),
              Expanded(
                flex: 1,
                child: Column(children: [_buildRevenueDistributionChart()]),
              ),
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
            Row(
              children: [
                Icon(
                  LucideIcons.map,
                  color: PrimeCareTheme.colors.navyIndigo,
                  size: 28,
                ),
                const SizedBox(width: 12),
                Text(
                  'Region Performance',
                  style: PrimeCareTheme.typography.heroTitle.copyWith(
                    color: PrimeCareTheme.colors.navyIndigo,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              'Analyze financial and operational performance aggregated by geographical region.',
              style: PrimeCareTheme.typography.body.copyWith(
                color: PrimeCareTheme.colors.slateGray,
              ),
            ),
          ],
        ),
        ClinicalGlassButton(
          onPressed: () {},
          icon: LucideIcons.externalLink,
          label: 'Export Data',
          isActive: false,
        ),
      ],
    );
  }

  Widget _buildKPIs() {
    return Row(
      children: [
        Expanded(
          child: _buildMetricCard(
            title: 'Active Regions',
            value: '14',
            icon: LucideIcons.globe,
            trend: 'Across 3 countries',
            isPositive: true,
          ),
        ),
        const SizedBox(width: 24),
        Expanded(
          child: _buildMetricCard(
            title: 'Top Region (Revenue)',
            value: 'Ontario',
            icon: LucideIcons.award,
            trend: '\$45.2M YTD',
            isPositive: true,
          ),
        ),
        const SizedBox(width: 24),
        Expanded(
          child: _buildMetricCard(
            title: 'Fastest Growing',
            value: 'Texas',
            icon: LucideIcons.rocket,
            trend: '+18.5% YoY',
            isPositive: true,
          ),
        ),
        const SizedBox(width: 24),
        Expanded(
          child: _buildMetricCard(
            title: 'Lowest Margin',
            value: 'Pacific NW',
            icon: LucideIcons.alertTriangle,
            trend: '12.4% Average',
            isWarning: true,
          ),
        ),
      ],
    );
  }

  Widget _buildMetricCard({
    required String title,
    required String value,
    required IconData icon,
    required String trend,
    bool isWarning = false,
    bool isPositive = false,
    bool isNeutral = false,
  }) {
    Color trendColor = PrimeCareTheme.colors.slateGray;
    Color iconColor = PrimeCareTheme.colors.navyIndigo;

    if (isWarning) {
      trendColor = Colors.amber.shade700;
      iconColor = Colors.amber.shade700;
    } else if (isPositive) {
      trendColor = PrimeCareTheme.colors.emeraldTeal;
      iconColor = PrimeCareTheme.colors.emeraldTeal;
    } else if (isNeutral) {
      trendColor = PrimeCareTheme.colors.navyIndigo;
    }

    return ClinicalGlassPanel(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: PrimeCareTheme.typography.label.copyWith(
                  color: PrimeCareTheme.colors.slateGray,
                ),
              ),
              Icon(icon, color: iconColor, size: 20),
            ],
          ),
          const SizedBox(height: 16),
          Text(
            value,
            style: PrimeCareTheme.typography.h1.copyWith(
              color: PrimeCareTheme.colors.navyIndigo,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            trend,
            style: PrimeCareTheme.typography.label.copyWith(
              color: trendColor,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRegionTable() {
    return ClinicalGlassPanel(
      padding: EdgeInsets.zero,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(24.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Regional Performance Data',
                  style: PrimeCareTheme.typography.h3.copyWith(
                    color: PrimeCareTheme.colors.navyIndigo,
                  ),
                ),
                Container(
                  width: 250,
                  decoration: BoxDecoration(
                    color: PrimeCareTheme.colors.surfaceContainerLow,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: PrimeCareTheme.colors.surfaceContainerHighest,
                    ),
                  ),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 12,
                  ),
                  child: Row(
                    children: [
                      Icon(
                        LucideIcons.search,
                        size: 18,
                        color: PrimeCareTheme.colors.slateGray,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        'Search region...',
                        style: PrimeCareTheme.typography.body.copyWith(
                          color: PrimeCareTheme.colors.slateGray,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
            color: PrimeCareTheme.colors.surfaceContainerLow,
            child: Row(
              children: [
                Expanded(
                  flex: 3,
                  child: Text(
                    'REGION',
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
                    'MANAGER',
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
                    'REVENUE (YTD)',
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
                    'MARGIN',
                    style: PrimeCareTheme.typography.label.copyWith(
                      fontSize: 11,
                      color: PrimeCareTheme.colors.slateGray,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(
                  width: 100,
                  child: Text(
                    'GROWTH',
                    textAlign: TextAlign.center,
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
          ..._buildRegionRows(),
        ],
      ),
    );
  }

  List<Widget> _buildRegionRows() {
    final regions = [
      {
        'name': 'Ontario',
        'manager': 'Sarah Jenkins',
        'revenue': '\$45.2M',
        'margin': '26%',
        'growth': '+12.4%',
      },
      {
        'name': 'British Columbia',
        'manager': 'Michael Chen',
        'revenue': '\$32.1M',
        'margin': '24%',
        'growth': '+10.2%',
      },
      {
        'name': 'Texas',
        'manager': 'David Smith',
        'revenue': '\$28.5M',
        'margin': '21%',
        'growth': '+18.5%',
      },
      {
        'name': 'Alberta',
        'manager': 'Emma Thompson',
        'revenue': '\$18.4M',
        'margin': '19%',
        'growth': '+8.1%',
      },
      {
        'name': 'Pacific NW',
        'manager': 'John Davies',
        'revenue': '\$15.2M',
        'margin': '12.4%',
        'growth': '+4.2%',
      },
    ];

    return regions.asMap().entries.map((entry) {
      final region = entry.value;
      final int index = entry.key;

      final String growthStr = region['growth'] as String;
      final double growthVal = double.parse(
        growthStr.replaceAll('%', '').replaceAll('+', ''),
      );
      Color growthColor = PrimeCareTheme.colors.emeraldTeal;
      if (growthVal < 5) growthColor = Colors.amber.shade700;
      if (growthVal >= 5 && growthVal < 10)
        growthColor = PrimeCareTheme.colors.navyIndigo;

      final String marginStr = region['margin'] as String;
      final double marginVal = double.parse(marginStr.replaceAll('%', ''));
      Color marginColor = PrimeCareTheme.colors.emeraldTeal;
      if (marginVal < 15) marginColor = Colors.amber.shade700;
      if (marginVal >= 15 && marginVal < 20)
        marginColor = PrimeCareTheme.colors.navyIndigo;

      return Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
            child: Row(
              children: [
                Expanded(
                  flex: 3,
                  child: Text(
                    region['name']!,
                    style: PrimeCareTheme.typography.body.copyWith(
                      color: PrimeCareTheme.colors.navyIndigo,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Text(
                    region['manager']!,
                    style: PrimeCareTheme.typography.body.copyWith(
                      color: PrimeCareTheme.colors.slateGray,
                    ),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Text(
                    region['revenue']!,
                    style: PrimeCareTheme.typography.body.copyWith(
                      color: PrimeCareTheme.colors.navyIndigo,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Row(
                    children: [
                      Icon(
                        marginVal >= 20
                            ? LucideIcons.trendingUp
                            : (marginVal < 15
                                  ? LucideIcons.trendingDown
                                  : LucideIcons.minus),
                        size: 14,
                        color: marginColor,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        region['margin']!,
                        style: PrimeCareTheme.typography.body.copyWith(
                          color: marginColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  width: 100,
                  child: Align(
                    alignment: Alignment.center,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: growthColor.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        region['growth']!,
                        style: PrimeCareTheme.typography.label.copyWith(
                          color: growthColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          if (index < regions.length - 1)
            Divider(
              height: 1,
              color: PrimeCareTheme.colors.surfaceContainerHighest,
            ),
        ],
      );
    }).toList();
  }

  Widget _buildRevenueDistributionChart() {
    return ClinicalGlassPanel(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                'Revenue Dist.',
                style: PrimeCareTheme.typography.h3.copyWith(
                  color: PrimeCareTheme.colors.navyIndigo,
                ),
              ),
              const Spacer(),
              Icon(
                LucideIcons.pieChart,
                color: PrimeCareTheme.colors.slateGray,
                size: 20,
              ),
            ],
          ),
          const SizedBox(height: 32),
          SizedBox(
            height: 200,
            child: PieChart(
              PieChartData(
                sectionsSpace: 2,
                centerSpaceRadius: 40,
                sections: [
                  PieChartSectionData(
                    color: PrimeCareTheme.colors.navyIndigo,
                    value: 32,
                    title: 'ON',
                    radius: 50,
                    titleStyle: PrimeCareTheme.typography.label.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  PieChartSectionData(
                    color: PrimeCareTheme.colors.emeraldTeal,
                    value: 22,
                    title: 'BC',
                    radius: 45,
                    titleStyle: PrimeCareTheme.typography.label.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  PieChartSectionData(
                    color: Colors.amber.shade600,
                    value: 20,
                    title: 'TX',
                    radius: 40,
                    titleStyle: PrimeCareTheme.typography.label.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  PieChartSectionData(
                    color: Colors.amber.shade400,
                    value: 13,
                    title: 'AB',
                    radius: 35,
                    titleStyle: PrimeCareTheme.typography.label.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  PieChartSectionData(
                    color: PrimeCareTheme.colors.slateGray,
                    value: 13,
                    title: 'Other',
                    radius: 30,
                    titleStyle: PrimeCareTheme.typography.label.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 32),
          Column(
            children: [
              _buildLegendItem(
                'Ontario',
                '32%',
                PrimeCareTheme.colors.navyIndigo,
              ),
              const SizedBox(height: 12),
              _buildLegendItem(
                'British Columbia',
                '22%',
                PrimeCareTheme.colors.emeraldTeal,
              ),
              const SizedBox(height: 12),
              _buildLegendItem('Texas', '20%', Colors.amber.shade600),
              const SizedBox(height: 12),
              _buildLegendItem('Alberta', '13%', Colors.amber.shade400),
              const SizedBox(height: 12),
              _buildLegendItem(
                'Other Regions',
                '13%',
                PrimeCareTheme.colors.slateGray,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildLegendItem(String label, String value, Color color) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Container(
              width: 12,
              height: 12,
              decoration: BoxDecoration(color: color, shape: BoxShape.circle),
            ),
            const SizedBox(width: 8),
            Text(
              label,
              style: PrimeCareTheme.typography.body.copyWith(
                color: PrimeCareTheme.colors.slateGray,
              ),
            ),
          ],
        ),
        Text(
          value,
          style: PrimeCareTheme.typography.body.copyWith(
            color: PrimeCareTheme.colors.navyIndigo,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
