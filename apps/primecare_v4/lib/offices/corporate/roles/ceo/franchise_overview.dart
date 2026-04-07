import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:primecare_v4/design_system/clinical_glass.dart';
import 'package:primecare_v4/design_system/primecare_theme.dart';

class CeoFranchiseOverviewScreen extends ConsumerStatefulWidget {
  const CeoFranchiseOverviewScreen({super.key});

  @override
  ConsumerState<CeoFranchiseOverviewScreen> createState() =>
      _CeoFranchiseOverviewScreenState();
}

class _CeoFranchiseOverviewScreenState
    extends ConsumerState<CeoFranchiseOverviewScreen> {
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
              Expanded(flex: 3, child: _buildFranchisesTable()),
              const SizedBox(width: 32),
              Expanded(
                flex: 1,
                child: Column(
                  children: [
                    _buildTopGrowthWidget(),
                    const SizedBox(height: 24),
                    _buildStatusWidget(),
                  ],
                ),
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
                  LucideIcons.building,
                  color: PrimeCareTheme.colors.navyIndigo,
                  size: 28,
                ),
                const SizedBox(width: 12),
                Text(
                  'Franchise Network Overview',
                  style: PrimeCareTheme.typography.heroTitle.copyWith(
                    color: PrimeCareTheme.colors.navyIndigo,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              'High-level operational and financial status of all franchise branches.',
              style: PrimeCareTheme.typography.body.copyWith(
                color: PrimeCareTheme.colors.slateGray,
              ),
            ),
          ],
        ),
        ClinicalGlassButton(
          onPressed: () {},
          icon: LucideIcons.externalLink,
          label: 'Export Report',
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
            title: 'Total Franchises',
            value: '215',
            icon: LucideIcons.building,
            trend: '+8 this year',
            isPositive: true,
          ),
        ),
        const SizedBox(width: 24),
        Expanded(
          child: _buildMetricCard(
            title: 'Average Revenue / Branch',
            value: '\$662K',
            icon: LucideIcons.trendingUp,
            trend: '+4.2% YoY',
            isPositive: true,
          ),
        ),
        const SizedBox(width: 24),
        Expanded(
          child: _buildMetricCard(
            title: 'Regions Established',
            value: '14',
            icon: LucideIcons.mapPin,
            trend: 'Across 3 countries',
            isNeutral: true,
          ),
        ),
        const SizedBox(width: 24),
        Expanded(
          child: _buildMetricCard(
            title: 'Franchisees Onboarding',
            value: '5',
            icon: LucideIcons.users,
            trend: 'Expected launch in Q4',
            isNeutral: true,
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

  Widget _buildFranchisesTable() {
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
                  'Active Franchises',
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
                        'Search branches...',
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
                  flex: 2,
                  child: Text(
                    'BRANCH NAME',
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
                  width: 80,
                  child: Text(
                    'STATUS',
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
          ..._buildFranchiseRows(),
        ],
      ),
    );
  }

  List<Widget> _buildFranchiseRows() {
    final branches = [
      {
        'name': 'Toronto Downtown',
        'region': 'Ontario',
        'revenue': '\$1.2M',
        'margin': '24%',
        'status': 'Excellent',
      },
      {
        'name': 'Vancouver West',
        'region': 'British Columbia',
        'revenue': '\$950K',
        'margin': '21%',
        'status': 'Excellent',
      },
      {
        'name': 'Calgary Central',
        'region': 'Alberta',
        'revenue': '\$680K',
        'margin': '18%',
        'status': 'Good',
      },
      {
        'name': 'Seattle North',
        'region': 'Pacific NW',
        'revenue': '\$540K',
        'margin': '15%',
        'status': 'Good',
      },
      {
        'name': 'Austin Central',
        'region': 'Texas',
        'revenue': '\$420K',
        'margin': '11%',
        'status': 'At Risk',
      },
    ];

    return branches.asMap().entries.map((entry) {
      final branch = entry.value;
      final int index = entry.key;

      Color statusColor;
      switch (branch['status']) {
        case 'Excellent':
          statusColor = PrimeCareTheme.colors.emeraldTeal;
          break;
        case 'Good':
          statusColor = PrimeCareTheme.colors.navyIndigo;
          break;
        case 'At Risk':
          statusColor = Colors.amber.shade700;
          break;
        default:
          statusColor = PrimeCareTheme.colors.slateGray;
      }

      final String marginStr = branch['margin'] as String;
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
                  flex: 2,
                  child: Text(
                    branch['name']!,
                    style: PrimeCareTheme.typography.body.copyWith(
                      color: PrimeCareTheme.colors.navyIndigo,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Text(
                    branch['region']!,
                    style: PrimeCareTheme.typography.body.copyWith(
                      color: PrimeCareTheme.colors.slateGray,
                    ),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Text(
                    branch['revenue']!,
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
                        branch['margin']!,
                        style: PrimeCareTheme.typography.body.copyWith(
                          color: marginColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  width: 80,
                  child: Align(
                    alignment: Alignment.center,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: statusColor.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        branch['status']!,
                        style: PrimeCareTheme.typography.label.copyWith(
                          color: statusColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          if (index < branches.length - 1)
            Divider(
              height: 1,
              color: PrimeCareTheme.colors.surfaceContainerHighest,
            ),
        ],
      );
    }).toList();
  }

  Widget _buildTopGrowthWidget() {
    return ClinicalGlassPanel(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Top Growth Branches',
                style: PrimeCareTheme.typography.h3.copyWith(
                  color: PrimeCareTheme.colors.navyIndigo,
                ),
              ),
              Icon(
                LucideIcons.award,
                color: PrimeCareTheme.colors.emeraldTeal,
                size: 20,
              ),
            ],
          ),
          const SizedBox(height: 24),
          _buildGrowthItem(
            '1. Toronto Downtown',
            '+15.2%',
            PrimeCareTheme.colors.emeraldTeal,
          ),
          const SizedBox(height: 16),
          _buildGrowthItem(
            '2. Vancouver West',
            '+12.8%',
            PrimeCareTheme.colors.emeraldTeal,
          ),
          const SizedBox(height: 16),
          _buildGrowthItem(
            '3. Calgary Central',
            '+9.4%',
            PrimeCareTheme.colors.navyIndigo,
          ),
          const SizedBox(height: 16),
          _buildGrowthItem(
            '4. Seattle North',
            '+7.1%',
            PrimeCareTheme.colors.navyIndigo,
          ),
        ],
      ),
    );
  }

  Widget _buildGrowthItem(String branch, String growth, Color color) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          branch,
          style: PrimeCareTheme.typography.body.copyWith(
            color: PrimeCareTheme.colors.navyIndigo,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          growth,
          style: PrimeCareTheme.typography.label.copyWith(
            color: color,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  Widget _buildStatusWidget() {
    return ClinicalGlassPanel(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Network Status',
                style: PrimeCareTheme.typography.h3.copyWith(
                  color: PrimeCareTheme.colors.navyIndigo,
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          _buildStatusItem(
            'Excellent Performance',
            '125',
            PrimeCareTheme.colors.emeraldTeal,
          ),
          const SizedBox(height: 16),
          _buildStatusItem(
            'Good / Stable',
            '68',
            PrimeCareTheme.colors.navyIndigo,
          ),
          const SizedBox(height: 16),
          _buildStatusItem('Needs Improvement', '15', Colors.amber.shade600),
          const SizedBox(height: 16),
          _buildStatusItem('At Risk', '7', Colors.amber.shade700),
        ],
      ),
    );
  }

  Widget _buildStatusItem(String label, String count, Color color) {
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
          count,
          style: PrimeCareTheme.typography.body.copyWith(
            color: PrimeCareTheme.colors.navyIndigo,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
