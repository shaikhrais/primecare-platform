import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:primecare_v4/design_system/clinical_glass.dart';
import 'package:primecare_v4/design_system/primecare_theme.dart';
import 'package:fl_chart/fl_chart.dart';

class CeoRevenueSummaryScreen extends ConsumerStatefulWidget {
  const CeoRevenueSummaryScreen({super.key});

  @override
  ConsumerState<CeoRevenueSummaryScreen> createState() => _CeoRevenueSummaryScreenState();
}

class _CeoRevenueSummaryScreenState extends ConsumerState<CeoRevenueSummaryScreen> {
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
                  flex: 3,
                  child: _buildRevenueByLineChart(),
                ),
                const SizedBox(width: 32),
                Expanded(
                  flex: 2,
                  child: Column(
                    children: [
                      _buildTopChannelsWidget(),
                      const SizedBox(height: 24),
                       _buildMarginsWidget(),
                    ],
                  ),
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
                Icon(LucideIcons.dollarSign, color: PrimeCareTheme.colors.navyIndigo, size: 28),
                const SizedBox(width: 12),
                Text(
                  'Revenue Summary',
                  style: PrimeCareTheme.typography.heroTitle.copyWith(
                    color: PrimeCareTheme.colors.navyIndigo,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              'High-level financial overview and global revenue streams across business lines.',
              style: PrimeCareTheme.typography.body.copyWith(
                color: PrimeCareTheme.colors.slateGray,
              ),
            ),
          ],
        ),
        Row(
           children: [
               Container(
                  decoration: BoxDecoration(
                    color: PrimeCareTheme.colors.surfaceContainerLow,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: PrimeCareTheme.colors.surfaceContainerHighest),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                  child: Row(
                    children: [
                      Icon(LucideIcons.calendar, size: 18, color: PrimeCareTheme.colors.slateGray),
                      const SizedBox(width: 8),
                      Text('Fiscal Year 2026', style: PrimeCareTheme.typography.body.copyWith(color: PrimeCareTheme.colors.slateGray)),
                       const SizedBox(width: 8),
                      Icon(LucideIcons.chevronDown, size: 18, color: PrimeCareTheme.colors.slateGray),
                    ],
                  ),
                ),
                const SizedBox(width: 12),
              ClinicalGlassButton(
                onPressed: () {},
                icon: LucideIcons.download,
                label: 'Financial Report',
                isActive: false,
              ),
           ]
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
            value: '\$145.8M',
            icon: LucideIcons.trendingUp,
            trend: '+12.4% vs Last Year',
            isPositive: true,
          ),
        ),
        const SizedBox(width: 24),
        Expanded(
          child: _buildMetricCard(
            title: 'Projected EOY',
            value: '\$210.5M',
            icon: LucideIcons.barChart2,
            trend: '105% of Target',
            isPositive: true,
          ),
        ),
        const SizedBox(width: 24),
         Expanded(
          child: _buildMetricCard(
             title: 'Avg Client LTV',
             value: '\$4,250',
             icon: LucideIcons.users,
             trend: 'Stable Quarter',
             isNeutral: true,
          ),
        ),
        const SizedBox(width: 24),
        Expanded(
          child: _buildMetricCard(
            title: 'Operating Margin',
            value: '22.4%',
            icon: LucideIcons.pieChart,
            trend: '-1.2% variance',
            isWarning: true,
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

  Widget _buildRevenueByLineChart() {
    return ClinicalGlassPanel(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Revenue by Service Line (YTD vs Target)',
                style: PrimeCareTheme.typography.h3.copyWith(color: PrimeCareTheme.colors.navyIndigo),
              ),
              Row(
                 children: [
                    _buildChartLegend('YTD Revenue', PrimeCareTheme.colors.navyIndigo),
                    const SizedBox(width: 16),
                     _buildChartLegend('Target', PrimeCareTheme.colors.emeraldTeal),
                 ],
              ),
            ],
          ),
          const SizedBox(height: 32),
          SizedBox(
            height: 350,
            child: BarChart(
              BarChartData(
                alignment: BarChartAlignment.spaceAround,
                maxY: 60,
                barTouchData: BarTouchData(enabled: false),
                titlesData: FlTitlesData(
                  show: true,
                  bottomTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      getTitlesWidget: (value, meta) {
                        const style = TextStyle(color: Color(0xFF64748B), fontWeight: FontWeight.bold, fontSize: 11);
                        String text;
                        switch (value.toInt()) {
                          case 0:
                            text = 'In-Home Care';
                            break;
                          case 1:
                            text = 'Medical Staffing';
                            break;
                          case 2:
                            text = 'Travel Nursing';
                            break;
                          case 3:
                            text = 'Allied Health';
                            break;
                           case 4:
                            text = 'Technology Lic.';
                            break;
                          default:
                            text = '';
                            break;
                        }
                        return SideTitleWidget(
                           meta: meta,
                           space: 8,
                           child: Text(text, style: style),
                        );
                      },
                      reservedSize: 30,
                    ),
                  ),
                  leftTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      reservedSize: 40,
                      getTitlesWidget: (value, meta) {
                         const style = TextStyle(color: Color(0xFF64748B), fontSize: 11);
                          return Text('\$${value.toInt()}M', style: style, textAlign: TextAlign.right);
                      },
                    ),
                  ),
                  topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                  rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                ),
                gridData: FlGridData(
                  show: true,
                  checkToShowHorizontalLine: (value) => true,
                  getDrawingHorizontalLine: (value) => FlLine(
                    color: PrimeCareTheme.colors.surfaceContainerHighest,
                    strokeWidth: 1,
                  ),
                   drawVerticalLine: false,
                ),
                borderData: FlBorderData(show: false),
                barGroups: [
                   _buildBarGroup(0, 52.4, 48.0),
                   _buildBarGroup(1, 38.2, 40.0),
                   _buildBarGroup(2, 28.5, 25.0),
                   _buildBarGroup(3, 15.6, 18.0),
                   _buildBarGroup(4, 11.1, 10.0),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  BarChartGroupData _buildBarGroup(int x, double ytd, double target) {
      return BarChartGroupData(
         x: x,
         barsSpace: 4,
         barRods: [
             BarChartRodData(
               toY: ytd,
               color: PrimeCareTheme.colors.navyIndigo,
               width: 20,
               borderRadius: const BorderRadius.only(topLeft: Radius.circular(4), topRight: Radius.circular(4)),
             ),
             BarChartRodData(
               toY: target,
               color: PrimeCareTheme.colors.emeraldTeal,
               width: 20,
               borderRadius: const BorderRadius.only(topLeft: Radius.circular(4), topRight: Radius.circular(4)),
             ),
         ]
      );
  }

   Widget _buildChartLegend(String label, Color color) {
       return Row(
          children: [
             Container(
                width: 12,
                height: 12,
                decoration: BoxDecoration(color: color, borderRadius: BorderRadius.circular(2)),
             ),
             const SizedBox(width: 6),
              Text(
                label,
                style: PrimeCareTheme.typography.label.copyWith(color: PrimeCareTheme.colors.slateGray),
             ),
          ]
       );
  }


  Widget _buildTopChannelsWidget() {
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
                        'Top Revenue Channels',
                        style: PrimeCareTheme.typography.h3.copyWith(
                           color: PrimeCareTheme.colors.navyIndigo,
                        ),
                     ),
                     Icon(LucideIcons.listFilter, color: PrimeCareTheme.colors.emeraldTeal, size: 20),
                  ],
               ),
            ),
            Container(
               padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
               color: PrimeCareTheme.colors.surfaceContainerLow,
               child: Row(
                  children: [
                     Expanded(flex: 3, child: Text('CHANNEL', style: PrimeCareTheme.typography.label.copyWith(fontSize: 11, color: PrimeCareTheme.colors.slateGray, fontWeight: FontWeight.bold))),
                     Expanded(flex: 2, child: Text('REVENUE', textAlign: TextAlign.right, style: PrimeCareTheme.typography.label.copyWith(fontSize: 11, color: PrimeCareTheme.colors.slateGray, fontWeight: FontWeight.bold))),
                     Expanded(flex: 2, child: Text('GROWTH', textAlign: TextAlign.right, style: PrimeCareTheme.typography.label.copyWith(fontSize: 11, color: PrimeCareTheme.colors.slateGray, fontWeight: FontWeight.bold))),
                  ],
               ),
            ),
            _buildChannelRow('Private Pay (B2C)', '\$58.2M', '+18%', PrimeCareTheme.colors.emeraldTeal),
            Divider(height: 1, color: PrimeCareTheme.colors.surfaceContainerHighest),
            _buildChannelRow('Hospital Contracts', '\$42.5M', '+5%', PrimeCareTheme.colors.navyIndigo),
            Divider(height: 1, color: PrimeCareTheme.colors.surfaceContainerHighest),
            _buildChannelRow('Government (TPA)', '\$28.1M', '-2%', Colors.amber.shade700),
            Divider(height: 1, color: PrimeCareTheme.colors.surfaceContainerHighest),
            _buildChannelRow('Insurance Providers', '\$12.8M', '+11%', PrimeCareTheme.colors.emeraldTeal),
            const SizedBox(height: 8),
        ],
      )
     );
  }

  Widget _buildChannelRow(String channel, String revenue, String growth, Color growthColor) {
      return Padding(
         padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
         child: Row(
            children: [
               Expanded(flex: 3, child: Text(channel, style: PrimeCareTheme.typography.body.copyWith(color: PrimeCareTheme.colors.navyIndigo, fontWeight: FontWeight.bold))),
               Expanded(flex: 2, child: Text(revenue, textAlign: TextAlign.right, style: PrimeCareTheme.typography.body.copyWith(color: PrimeCareTheme.colors.navyIndigo))),
               Expanded(flex: 2, child: Text(growth, textAlign: TextAlign.right, style: PrimeCareTheme.typography.label.copyWith(color: growthColor, fontWeight: FontWeight.bold))),
            ]
         )
      );
  }


   Widget _buildMarginsWidget() {
     return ClinicalGlassPanel(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
               Text(
                 'Operating Margins',
                 style: PrimeCareTheme.typography.h3.copyWith(
                   color: PrimeCareTheme.colors.navyIndigo,
                 ),
               ),
                Icon(LucideIcons.percent, color: PrimeCareTheme.colors.slateGray, size: 20),
            ],
          ),
          const SizedBox(height: 24),
          _buildMarginItem('Technology Licensing', '68%'),
          const SizedBox(height: 16),
          _buildMarginItem('Allied Health', '32%'),
           const SizedBox(height: 16),
          _buildMarginItem('In-Home Care', '24%'),
           const SizedBox(height: 16),
          _buildMarginItem('Medical Staffing', '18%'),
        ],
      )
     );
   }

   Widget _buildMarginItem(String label, String value) {
      return Row(
         mainAxisAlignment: MainAxisAlignment.spaceBetween,
         children: [
            Text(label, style: PrimeCareTheme.typography.body.copyWith(color: PrimeCareTheme.colors.slateGray)),
            Text(value, style: PrimeCareTheme.typography.body.copyWith(color: PrimeCareTheme.colors.navyIndigo, fontWeight: FontWeight.bold)),
         ],
      );
   }

}
