import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:primecare_v4/design_system/clinical_glass.dart';
import 'package:primecare_v4/design_system/primecare_theme.dart';
import 'package:fl_chart/fl_chart.dart';

class CommunityProgramsScreen extends ConsumerStatefulWidget {
  const CommunityProgramsScreen({super.key});

  @override
  ConsumerState<CommunityProgramsScreen> createState() =>
      _CommunityProgramsScreenState();
}

class _CommunityProgramsScreenState
    extends ConsumerState<CommunityProgramsScreen> {
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
              Expanded(flex: 3, child: _buildProgramsTable()),
              const SizedBox(width: 32),
              Expanded(
                flex: 1,
                child: Column(children: [_buildDemographicsChart()]),
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
                  LucideIcons.globe,
                  color: PrimeCareTheme.colors.navyIndigo,
                  size: 28,
                ),
                const SizedBox(width: 12),
                Text(
                  'Community Programs',
                  style: PrimeCareTheme.typography.heroTitle.copyWith(
                    color: PrimeCareTheme.colors.navyIndigo,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              'Manage and track ongoing community outreach initiatives.',
              style: PrimeCareTheme.typography.body.copyWith(
                color: PrimeCareTheme.colors.slateGray,
              ),
            ),
          ],
        ),
        ClinicalGlassButton(
          onPressed: () {},
          icon: LucideIcons.plus,
          label: 'New Program',
          isActive: true,
        ),
      ],
    );
  }

  Widget _buildKPIs() {
    return Row(
      children: [
        Expanded(
          child: _buildMetricCard(
            title: 'Overall Program Reach',
            value: '5,420',
            icon: LucideIcons.users,
            trend: '+12% vs last month',
            isPositive: true,
          ),
        ),
        const SizedBox(width: 24),
        Expanded(
          child: _buildMetricCard(
            title: 'Budget Utilized',
            value: '\$45K',
            icon: LucideIcons.pieChart,
            trend: '65% of \$69K Allocation',
            isNeutral: true,
          ),
        ),
        const SizedBox(width: 24),
        Expanded(
          child: _buildMetricCard(
            title: 'Volunteers Engaged',
            value: '142',
            icon: LucideIcons.heartHandshake,
            trend: '+15 this week',
            isPositive: true,
          ),
        ),
        const SizedBox(width: 24),
        Expanded(
          child: _buildMetricCard(
            title: 'At-Risk Programs',
            value: '1',
            icon: LucideIcons.alertTriangle,
            trend: 'Behind schedule',
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

  Widget _buildProgramsTable() {
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
                  'Active Programs',
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
                        'Search programs...',
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
                    'PROGRAM NAME',
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
                    'LEAD',
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
                    'REACH',
                    style: PrimeCareTheme.typography.label.copyWith(
                      fontSize: 11,
                      color: PrimeCareTheme.colors.slateGray,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: Text(
                    'PROGRESS',
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
          ..._buildProgramRows(),
        ],
      ),
    );
  }

  List<Widget> _buildProgramRows() {
    final programs = [
      {
        'name': 'Senior Tech Literacy',
        'lead': 'Sarah Jenkins',
        'reach': '450',
        'progress': 0.75,
        'status': 'On Track',
      },
      {
        'name': 'Youth Heart Health',
        'lead': 'Marcus Chen',
        'reach': '1,200',
        'progress': 0.40,
        'status': 'On Track',
      },
      {
        'name': 'Mobile Vitals Clinic',
        'lead': 'Dr. A. Patel',
        'reach': '3,500',
        'progress': 0.90,
        'status': 'Completing',
      },
      {
        'name': 'Nutrition Workshops',
        'lead': 'Emma Thompson',
        'reach': '150',
        'progress': 0.15,
        'status': 'At Risk',
      },
      {
        'name': 'Caregiver Support Grp',
        'lead': 'David Kim',
        'reach': '120',
        'progress': 0.60,
        'status': 'On Track',
      },
    ];

    return programs.asMap().entries.map((entry) {
      final program = entry.value;
      final int index = entry.key;

      Color statusColor;
      switch (program['status']) {
        case 'On Track':
          statusColor = PrimeCareTheme.colors.emeraldTeal;
          break;
        case 'At Risk':
          statusColor = Colors.amber.shade700;
          break;
        case 'Completing':
          statusColor = PrimeCareTheme.colors.navyIndigo;
          break;
        default:
          statusColor = PrimeCareTheme.colors.slateGray;
      }

      final progVal = program['progress'] as double;
      Color progressColor = PrimeCareTheme.colors.emeraldTeal;
      if (program['status'] == 'At Risk') {
        progressColor = Colors.amber.shade700;
      }

      return Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
            child: Row(
              children: [
                Expanded(
                  flex: 3,
                  child: Text(
                    program['name'] as String,
                    style: PrimeCareTheme.typography.body.copyWith(
                      color: PrimeCareTheme.colors.navyIndigo,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Text(
                    program['lead'] as String,
                    style: PrimeCareTheme.typography.body.copyWith(
                      color: PrimeCareTheme.colors.slateGray,
                    ),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Text(
                    program['reach'] as String,
                    style: PrimeCareTheme.typography.h4.copyWith(
                      color: PrimeCareTheme.colors.navyIndigo,
                    ),
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: Padding(
                    padding: const EdgeInsets.only(right: 24.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              '${(progVal * 100).toInt()}%',
                              style: PrimeCareTheme.typography.label.copyWith(
                                color: PrimeCareTheme.colors.navyIndigo,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 4),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(4),
                          child: LinearProgressIndicator(
                            value: progVal,
                            backgroundColor:
                                PrimeCareTheme.colors.surfaceContainerHighest,
                            valueColor: AlwaysStoppedAnimation<Color>(
                              progressColor,
                            ),
                            minHeight: 6,
                          ),
                        ),
                      ],
                    ),
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
                        program['status'] as String,
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
          if (index < programs.length - 1)
            Divider(
              height: 1,
              color: PrimeCareTheme.colors.surfaceContainerHighest,
            ),
        ],
      );
    }).toList();
  }

  Widget _buildDemographicsChart() {
    return ClinicalGlassPanel(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Program Demographics',
                style: PrimeCareTheme.typography.h3.copyWith(
                  color: PrimeCareTheme.colors.navyIndigo,
                ),
              ),
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
                    value: 45,
                    title: 'Seniors',
                    radius: 50,
                    titleStyle: PrimeCareTheme.typography.label.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  PieChartSectionData(
                    color: PrimeCareTheme.colors.emeraldTeal,
                    value: 25,
                    title: 'Youth',
                    radius: 45,
                    titleStyle: PrimeCareTheme.typography.label.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  PieChartSectionData(
                    color: Colors.amber.shade600,
                    value: 20,
                    title: 'Families',
                    radius: 40,
                    titleStyle: PrimeCareTheme.typography.label.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  PieChartSectionData(
                    color: PrimeCareTheme.colors.slateGray,
                    value: 10,
                    title: 'Other',
                    radius: 35,
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
                'Seniors (65+)',
                '45%',
                PrimeCareTheme.colors.navyIndigo,
              ),
              const SizedBox(height: 12),
              _buildLegendItem(
                'Youth (Under 18)',
                '25%',
                PrimeCareTheme.colors.emeraldTeal,
              ),
              const SizedBox(height: 12),
              _buildLegendItem('Families', '20%', Colors.amber.shade600),
              const SizedBox(height: 12),
              _buildLegendItem(
                'General Adult',
                '10%',
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
