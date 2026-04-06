import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:primecare_v4/design_system/clinical_glass.dart';
import 'package:primecare_v4/design_system/primecare_theme.dart';
import 'package:fl_chart/fl_chart.dart';

class CeoStrategicKpisScreen extends ConsumerStatefulWidget {
  const CeoStrategicKpisScreen({super.key});

  @override
  ConsumerState<CeoStrategicKpisScreen> createState() => _CeoStrategicKpisScreenState();
}

class _CeoStrategicKpisScreenState extends ConsumerState<CeoStrategicKpisScreen> {
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
                  child: _buildStrategicPillarsWidget(),
                ),
                const SizedBox(width: 32),
                Expanded(
                  flex: 2,
                  child: Column(
                    children: [
                      _buildMarketShareChart(),
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
                Icon(LucideIcons.target, color: PrimeCareTheme.colors.navyIndigo, size: 28),
                const SizedBox(width: 12),
                Text(
                  'Strategic KPIs',
                  style: PrimeCareTheme.typography.heroTitle.copyWith(
                    color: PrimeCareTheme.colors.navyIndigo,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              'Track long-term strategic objectives and high-level organizational health indicators.',
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
                      Text('Q3 2026', style: PrimeCareTheme.typography.body.copyWith(color: PrimeCareTheme.colors.slateGray)),
                       const SizedBox(width: 8),
                      Icon(LucideIcons.chevronDown, size: 18, color: PrimeCareTheme.colors.slateGray),
                    ],
                  ),
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
            title: 'Net Promoter Score (NPS)',
            value: '72',
            icon: LucideIcons.smile,
            trend: '+4 points (Goal: 75)',
            isPositive: true,
          ),
        ),
        const SizedBox(width: 24),
        Expanded(
          child: _buildMetricCard(
             title: 'Employee Retention',
             value: '88%',
             icon: LucideIcons.users,
             trend: 'Industry avg: 82%',
             isPositive: true,
          ),
        ),
        const SizedBox(width: 24),
         Expanded(
          child: _buildMetricCard(
             title: 'Client Acq. Cost (CAC)',
             value: '\$450',
             icon: LucideIcons.dollarSign,
             trend: '-12% YoY (Improved)',
             isPositive: true,
          ),
        ),
        const SizedBox(width: 24),
        Expanded(
          child: _buildMetricCard(
            title: 'Brand Awareness Index',
            value: '64 / 100',
            icon: LucideIcons.globe,
            trend: '+2% (Goal: 70)',
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


  Widget _buildStrategicPillarsWidget() {
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
                     Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                           Text(
                              'FY26 Strategic Pillars Progress',
                              style: PrimeCareTheme.typography.h3.copyWith(
                                 color: PrimeCareTheme.colors.navyIndigo,
                              ),
                           ),
                           const SizedBox(height: 4),
                           Text(
                              'Tracking towards annual organizational goals.',
                              style: PrimeCareTheme.typography.body.copyWith(
                                 color: PrimeCareTheme.colors.slateGray,
                              ),
                           ),
                        ],
                     ),
                     Icon(LucideIcons.layers, color: PrimeCareTheme.colors.emeraldTeal, size: 28),
                  ],
               ),
            ),
            const SizedBox(height: 8),
            _buildPillarRow('1. Digital Transformation (CareTech)', 'Deploy proprietary PrimeCare software to 80% of active franchises.', 0.65, PrimeCareTheme.colors.navyIndigo),
            Divider(height: 1, color: PrimeCareTheme.colors.surfaceContainerHighest),
            _buildPillarRow('2. Clinical Excellence & Compliance', 'Achieve 100% passing rate in unannounced internal audits.', 0.92, PrimeCareTheme.colors.emeraldTeal),
            Divider(height: 1, color: PrimeCareTheme.colors.surfaceContainerHighest),
            _buildPillarRow('3. Market Expansion (B2B)', 'Secure 15 new enterprise hospital contracts regionally.', 0.45, Colors.amber.shade700),
            Divider(height: 1, color: PrimeCareTheme.colors.surfaceContainerHighest),
            _buildPillarRow('4. Talent Acquisition & Retention', 'Reduce caregiver turnover by 15% through improved benefits.', 0.81, PrimeCareTheme.colors.emeraldTeal),
             Divider(height: 1, color: PrimeCareTheme.colors.surfaceContainerHighest),
            _buildPillarRow('5. Brand Equity & Market Share', 'Launch nationwide brand awareness campaign in Q3.', 0.25, PrimeCareTheme.colors.slateGray),
            const SizedBox(height: 16),
        ],
      )
     );
  }

  Widget _buildPillarRow(String title, String description, double progress, Color color) {
      return Padding(
         padding: const EdgeInsets.all(24.0),
         child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
               Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                     Expanded(
                        child: Text(title, style: PrimeCareTheme.typography.body.copyWith(color: PrimeCareTheme.colors.navyIndigo, fontWeight: FontWeight.bold)),
                     ),
                     Text('${(progress * 100).toInt()}%', style: PrimeCareTheme.typography.body.copyWith(color: color, fontWeight: FontWeight.bold)),
                  ],
               ),
               const SizedBox(height: 8),
               Text(description, style: PrimeCareTheme.typography.label.copyWith(color: PrimeCareTheme.colors.slateGray)),
               const SizedBox(height: 16),
               LinearProgressIndicator(
                  value: progress,
                  backgroundColor: PrimeCareTheme.colors.surfaceContainerHighest,
                  color: color,
                  minHeight: 8,
                  borderRadius: BorderRadius.circular(4),
               ),
            ],
         ),
      );
  }


   Widget _buildMarketShareChart() {
     return ClinicalGlassPanel(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
               Text(
                 'Market Share vs Competitors',
                 style: PrimeCareTheme.typography.h3.copyWith(
                   color: PrimeCareTheme.colors.navyIndigo,
                 ),
               ),
            ],
          ),
           const SizedBox(height: 16),
           Row(
              children: [
                 _buildChartLegend('PrimeCare', PrimeCareTheme.colors.emeraldTeal),
                 const SizedBox(width: 16),
                 _buildChartLegend('Competitor A', PrimeCareTheme.colors.navyIndigo),
                 const SizedBox(width: 16),
                 _buildChartLegend('Competitor B', PrimeCareTheme.colors.slateGray),
              ],
           ),
          const SizedBox(height: 48),
          SizedBox(
             height: 250,
             child: LineChart(
                LineChartData(
                   gridData: FlGridData(
                     show: true,
                     drawVerticalLine: false,
                     getDrawingHorizontalLine: (value) => FlLine(
                        color: PrimeCareTheme.colors.surfaceContainerHighest,
                        strokeWidth: 1,
                     ),
                   ),
                   titlesData: FlTitlesData(
                     show: true,
                     bottomTitles: AxisTitles(
                        sideTitles: SideTitles(
                           showTitles: true,
                           reservedSize: 30,
                           getTitlesWidget: (value, meta) {
                             const style = TextStyle(color: Color(0xFF64748B), fontSize: 11, fontWeight: FontWeight.bold);
                             String text;
                             switch (value.toInt()) {
                               case 0:
                                 text = 'Q1';
                                 break;
                               case 1:
                                 text = 'Q2';
                                 break;
                               case 2:
                                 text = 'Q3';
                                 break;
                               case 3:
                                 text = 'Q4';
                                 break;
                               default:
                                 text = '';
                                 break;
                             }
                             return SideTitleWidget(meta: meta, space: 10, child: Text(text, style: style));
                           },
                        ),
                     ),
                     leftTitles: AxisTitles(
                        sideTitles: SideTitles(
                           showTitles: true,
                           reservedSize: 40,
                           getTitlesWidget: (value, meta) {
                             const style = TextStyle(color: Color(0xFF64748B), fontSize: 11);
                             return SizedBox(
                               width: 40,
                               child: Text('${value.toInt()}%', textAlign: TextAlign.right, style: style),
                             );
                           },
                        ),
                     ),
                     topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                     rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                   ),
                   borderData: FlBorderData(show: false),
                   minX: 0,
                   maxX: 3,
                   minY: 0,
                   maxY: 30,
                   lineBarsData: [
                       LineChartBarData(
                         spots: const [
                           FlSpot(0, 18),
                           FlSpot(1, 20),
                           FlSpot(2, 22),
                           FlSpot(3, 25),
                         ],
                         isCurved: true,
                         color: PrimeCareTheme.colors.emeraldTeal,
                         barWidth: 3,
                         isStrokeCapRound: true,
                         dotData: const FlDotData(show: false),
                         belowBarData: BarAreaData(
                            show: true,
                            color: PrimeCareTheme.colors.emeraldTeal.withValues(alpha: 0.1),
                         ),
                       ),
                       LineChartBarData(
                         spots: const [
                           FlSpot(0, 24),
                           FlSpot(1, 23),
                           FlSpot(2, 21),
                           FlSpot(3, 20),
                         ],
                         isCurved: true,
                         color: PrimeCareTheme.colors.navyIndigo,
                         barWidth: 3,
                         isStrokeCapRound: true,
                         dotData: const FlDotData(show: false),
                       ),
                        LineChartBarData(
                         spots: const [
                           FlSpot(0, 15),
                           FlSpot(1, 15),
                           FlSpot(2, 14),
                           FlSpot(3, 13),
                         ],
                         isCurved: true,
                         color: PrimeCareTheme.colors.slateGray,
                         barWidth: 3,
                         isStrokeCapRound: true,
                         dotData: const FlDotData(show: false),
                       ),
                   ]
                )
             )
          )
        ],
      )
     );
   }

   Widget _buildChartLegend(String label, Color color) {
       return Row(
          children: [
             Container(
                width: 12,
                height: 12,
                decoration: BoxDecoration(color: color, shape: BoxShape.circle),
             ),
             const SizedBox(width: 6),
              Text(
                label,
                style: PrimeCareTheme.typography.label.copyWith(color: PrimeCareTheme.colors.slateGray, fontWeight: FontWeight.bold),
             ),
          ]
       );
  }

}
