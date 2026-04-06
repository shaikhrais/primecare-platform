import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:primecare_v4/design_system/clinical_glass.dart';
import 'package:primecare_v4/design_system/primecare_theme.dart';
import 'package:fl_chart/fl_chart.dart';

class CeoEnterpriseOverviewScreen extends ConsumerStatefulWidget {
  const CeoEnterpriseOverviewScreen({super.key});

  @override
  ConsumerState<CeoEnterpriseOverviewScreen> createState() => _CeoEnterpriseOverviewScreenState();
}

class _CeoEnterpriseOverviewScreenState extends ConsumerState<CeoEnterpriseOverviewScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: SingleChildScrollView(
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
                Expanded(
                  flex: 2,
                  child: _buildEnterprisePerformanceChart(),
                ),
                const SizedBox(width: 32),
                Expanded(
                  flex: 1,
                  child: _buildExecutiveBriefing(),
                ),
              ],
            ),
          ],
        ),
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
                Icon(LucideIcons.globe, color: PrimeCareTheme.colors.navyIndigo, size: 28),
                const SizedBox(width: 12),
                Text(
                  'Enterprise Overview',
                  style: PrimeCareTheme.typography.heroTitle.copyWith(
                    color: PrimeCareTheme.colors.navyIndigo,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              'High-level executive summary of PrimeCare global network performance.',
              style: PrimeCareTheme.typography.body.copyWith(
                color: PrimeCareTheme.colors.slateGray,
              ),
            ),
          ],
        ),
        ClinicalGlassButton(
          onPressed: () {},
          icon: LucideIcons.externalLink,
          label: 'Export Briefing',
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
             title: 'Global Revenue (YTD)',
             value: '\$142.5M',
             icon: LucideIcons.dollarSign,
             trend: '+12.4% vs prev year',
             isPositive: true,
          ),
        ),
        const SizedBox(width: 24),
        Expanded(
          child: _buildMetricCard(
            title: 'Active Franchises',
            value: '215',
            icon: LucideIcons.building,
            trend: '+8 this quarter',
            isPositive: true,
          ),
        ),
        const SizedBox(width: 24),
        Expanded(
          child: _buildMetricCard(
            title: 'Total Active Staff',
            value: '4,850',
            icon: LucideIcons.users,
            trend: '+450 vs last year',
            isPositive: true,
          ),
        ),
        const SizedBox(width: 24),
        Expanded(
          child: _buildMetricCard(
            title: 'System Health',
            value: '99.9%',
            icon: LucideIcons.activity,
            trend: 'All systems operational',
            isNeutral: true,
          ),
        ),
      ],
    );
  }

  Widget _buildMetricCard({required String title, required String value, required IconData icon, required String trend, bool isWarning = false, bool isPositive = false, bool isNeutral = false}) {
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

  Widget _buildEnterprisePerformanceChart() {
    return ClinicalGlassPanel(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
               Text(
                 'Global Revenue vs Target (YTD)',
                 style: PrimeCareTheme.typography.h3.copyWith(
                   color: PrimeCareTheme.colors.navyIndigo,
                 ),
               ),
               Container(
                 padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                 decoration: BoxDecoration(
                   color: PrimeCareTheme.colors.surfaceContainerLow,
                   borderRadius: BorderRadius.circular(20),
                   border: Border.all(color: PrimeCareTheme.colors.surfaceContainerHighest),
                 ),
                 child: Row(
                   children: [
                     Icon(LucideIcons.calendar, size: 14, color: PrimeCareTheme.colors.navyIndigo),
                     const SizedBox(width: 4),
                     Text('2026', style: PrimeCareTheme.typography.label.copyWith(color: PrimeCareTheme.colors.navyIndigo)),
                     const SizedBox(width: 4),
                     Icon(LucideIcons.chevronDown, size: 14, color: PrimeCareTheme.colors.navyIndigo),
                   ],
                 ),
               )
            ],
          ),
          const SizedBox(height: 32),
          SizedBox(
            height: 300,
            child: BarChart(
              BarChartData(
                alignment: BarChartAlignment.spaceAround,
                maxY: 20,
                barTouchData: BarTouchData(enabled: false),
                titlesData: FlTitlesData(
                  show: true,
                  bottomTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      getTitlesWidget: (value, meta) {
                        const style = TextStyle(color: Colors.grey, fontWeight: FontWeight.bold, fontSize: 12);
                        Widget text;
                        switch (value.toInt()) {
                          case 0: text = const Text('Q1', style: style); break;
                          case 1: text = const Text('Q2', style: style); break;
                          case 2: text = const Text('Q3', style: style); break;
                          case 3: text = const Text('Q4 (Est)', style: style); break;
                          default: text = const Text('', style: style); break;
                        }
                        return Padding(padding: const EdgeInsets.only(top: 10.0), child: text);
                      },
                    ),
                  ),
                  leftTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      getTitlesWidget: (value, meta) {
                        if (value == 0) return const SizedBox.shrink();
                        return Text('\$${value.toInt()}M', style: const TextStyle(color: Colors.grey, fontSize: 12));
                      },
                      reservedSize: 40,
                    ),
                  ),
                  topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                  rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                ),
                gridData: FlGridData(
                  show: true,
                  drawVerticalLine: false,
                  horizontalInterval: 5,
                  getDrawingHorizontalLine: (value) => FlLine(color: Colors.grey.withValues(alpha: 0.2), strokeWidth: 1),
                ),
                borderData: FlBorderData(show: false),
                 barGroups: [
                  _buildBarGroup(0, 12.5, 14.2),
                  _buildBarGroup(1, 14.0, 15.8),
                  _buildBarGroup(2, 15.5, 16.5),
                  _buildBarGroup(3, 17.0, 18.0, isEst: true),
                ],
              ),
            ),
          ),
          const SizedBox(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
               Row(
                 children: [
                   Container(width: 12, height: 12, decoration: BoxDecoration(color: PrimeCareTheme.colors.navyIndigo, borderRadius: BorderRadius.circular(2))),
                   const SizedBox(width: 8),
                   Text('Actual Revenue', style: PrimeCareTheme.typography.label.copyWith(color: PrimeCareTheme.colors.slateGray)),
                 ],
               ),
               const SizedBox(width: 24),
               Row(
                 children: [
                   Container(width: 12, height: 12, decoration: BoxDecoration(color: PrimeCareTheme.colors.emeraldTeal.withValues(alpha: 0.5), borderRadius: BorderRadius.circular(2))),
                   const SizedBox(width: 8),
                   Text('Target Revenue', style: PrimeCareTheme.typography.label.copyWith(color: PrimeCareTheme.colors.slateGray)),
                 ],
               ),
            ],
          )
        ],
      )
    );
  }

   BarChartGroupData _buildBarGroup(int x, double target, double actual, {bool isEst = false}) {
    return BarChartGroupData(
      x: x,
      barRods: [
        BarChartRodData(
          toY: target,
          color: PrimeCareTheme.colors.emeraldTeal.withValues(alpha: 0.5),
          width: 20,
          borderRadius: const BorderRadius.only(topLeft: Radius.circular(4), topRight: Radius.circular(4)),
        ),
         BarChartRodData(
          toY: actual,
          color: isEst ? PrimeCareTheme.colors.navyIndigo.withValues(alpha: 0.5) : PrimeCareTheme.colors.navyIndigo,
          width: 20,
          borderRadius: const BorderRadius.only(topLeft: Radius.circular(4), topRight: Radius.circular(4)),
        ),
      ],
      barsSpace: 4,
    );
  }

  Widget _buildExecutiveBriefing() {
     return ClinicalGlassPanel(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
               Text(
                 'Executive Briefing',
                 style: PrimeCareTheme.typography.h3.copyWith(
                   color: PrimeCareTheme.colors.navyIndigo,
                 ),
               ),
               Icon(LucideIcons.bell, color: PrimeCareTheme.colors.slateGray, size: 20),
            ],
          ),
          const SizedBox(height: 24),
          _buildBriefingItem('Q3 Earnings Call Prep', 'Review final Q3 figures with CFO. Focus on the 12.4% YTD increase.', 'Today, 2:00 PM', LucideIcons.presentation, PrimeCareTheme.colors.navyIndigo),
          const SizedBox(height: 16),
          _buildBriefingItem('New Franchise Agreement', 'Texas Region Expansion MOU pending final approval.', 'Requires Action', LucideIcons.fileSignature, PrimeCareTheme.colors.emeraldTeal),
           const SizedBox(height: 16),
          _buildBriefingItem('Compliance Alert (UK)', 'New GDPR regulations impact data retention policies in UK branches.', 'High Priority', LucideIcons.alertTriangle, Colors.amber.shade700),
           const SizedBox(height: 16),
          _buildBriefingItem('Board Update', 'Monthly strategic KPI report due for board packet distribution.', 'Drafting', LucideIcons.clipboardList, PrimeCareTheme.colors.slateGray),
        ],
      ),
    );
  }

  Widget _buildBriefingItem(String title, String desc, String status, IconData icon, Color color) {
     return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.1),
            shape: BoxShape.circle,
          ),
          child: Icon(icon, color: color, size: 16),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
               Row(
                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
                 children: [
                   Text(title, style: PrimeCareTheme.typography.h4.copyWith(color: PrimeCareTheme.colors.navyIndigo, fontSize: 13)),
                 ],
               ),
               const SizedBox(height: 4),
               Text(desc, style: PrimeCareTheme.typography.body.copyWith(color: PrimeCareTheme.colors.slateGray)),
               const SizedBox(height: 8),
                Text(status, style: PrimeCareTheme.typography.label.copyWith(color: color, fontWeight: FontWeight.bold)),
            ],
          ),
        )
      ],
    );
  }
}
