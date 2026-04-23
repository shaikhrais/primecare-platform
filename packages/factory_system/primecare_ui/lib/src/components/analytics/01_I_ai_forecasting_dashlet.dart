// Layer: 01_INFRASTRUCTURE
import 'package:fl_chart/fl_chart.dart';
import 'package:primecare_ui/primecare_ui.dart';

class AIForecastingDashlet extends StatelessWidget {
  final AIAnalyticsForecastingData data;

  const AIForecastingDashlet({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    final ds = PrimeCareDesignSystem.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildHeader(context, ds),
        const SizedBox(height: 24),
        _buildProjectionsChart(context, ds),
        const SizedBox(height: 24),
        _buildKPIsGrid(context, ds),
        const SizedBox(height: 24),
        _buildInsightsAndConfidence(context, ds),
      ],
    );
  }

  Widget _buildHeader(BuildContext context, PrimeCareDesignSystem ds) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: ds.colors.primary.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(LucideIcons.sparkles, color: ds.colors.primary, size: 20),
        ),
        const SizedBox(width: 16),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'AI PREDICTIVE ANALYTICS',
              style: TextStyle(
                color: ds.colors.primary,
                fontSize: 11,
                fontWeight: FontWeight.w900,
                letterSpacing: 1.5,
              ),
            ),
            Text(
              'Q3 Clinical & Financial Projections',
              style: TextStyle(
                color: ds.colors.textPrimary,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildProjectionsChart(BuildContext context, PrimeCareDesignSystem ds) {
    return PrimeCareCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'EXTRAPOLATED PERFORMANCE TRAJECTORY',
            style: ds.typography.labelSmall.copyWith(
              color: ds.colors.textSecondary,
              fontWeight: FontWeight.bold,
              letterSpacing: 1.2,
            ),
          ),
          const SizedBox(height: 16),
          Container(
            height: 300,
            padding: const EdgeInsets.only(top: 24, right: 24, left: 0, bottom: 0),
            child: LineChart(
              LineChartData(
                lineTouchData: LineTouchData(
                  touchTooltipData: LineTouchTooltipData(
                    getTooltipColor: (_) => ds.colors.surface,
                    getTooltipItems: (touchedSpots) {
                      return touchedSpots.map((spot) {
                        final isRevenue = spot.barIndex == 0;
                        return LineTooltipItem(
                          "${isRevenue ? 'Revenue' : 'Costs'}: \$${spot.y.toStringAsFixed(0)}k",
                          TextStyle(
                            color: isRevenue ? ds.colors.primary : ds.colors.danger,
                            fontWeight: FontWeight.bold,
                          ),
                        );
                      }).toList();
                    },
                  ),
                ),
                gridData: FlGridData(
                  show: true,
                  drawVerticalLine: false,
                  getDrawingHorizontalLine: (value) => FlLine(
                    color: ds.colors.borderSubtle.withValues(alpha: 0.5),
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
                        final index = value.toInt();
                        if (index < 0 || index >= data.projections.length) {
                          return const SizedBox.shrink();
                        }
                        return Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: Text(
                            data.projections[index].month,
                            style: TextStyle(
                              color: ds.colors.textTertiary,
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  leftTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      reservedSize: 50,
                      getTitlesWidget: (value, meta) {
                        return Text(
                          '\$${value.toInt()}k',
                          style: TextStyle(
                            color: ds.colors.textTertiary,
                            fontSize: 10,
                          ),
                        );
                      },
                    ),
                  ),
                  topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                  rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                ),
                borderData: FlBorderData(show: false),
                lineBarsData: [
                  // Revenue Line
                  LineChartBarData(
                    spots: data.projections.asMap().entries.map((e) {
                      return FlSpot(e.key.toDouble(), e.value.revenue);
                    }).toList(),
                    isCurved: true,
                    color: ds.colors.primary,
                    barWidth: 4,
                    isStrokeCapRound: true,
                    dotData: const FlDotData(show: false),
                    belowBarData: BarAreaData(
                      show: true,
                      gradient: LinearGradient(
                        colors: [
                          ds.colors.primary.withValues(alpha: 0.2),
                          ds.colors.primary.withValues(alpha: 0.0),
                        ],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                      ),
                    ),
                  ),
                  // Costs Line
                  LineChartBarData(
                    spots: data.projections.asMap().entries.map((e) {
                      return FlSpot(e.key.toDouble(), e.value.costs);
                    }).toList(),
                    isCurved: true,
                    color: ds.colors.danger,
                    barWidth: 3,
                    dashArray: [5, 5],
                    isStrokeCapRound: true,
                    dotData: const FlDotData(show: false),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildKPIsGrid(BuildContext context, PrimeCareDesignSystem ds) {
    return PrimeResponsiveGrid(
      children: [
        PrimeCareStatCard(
          title: 'Projected Q3 Revenue',
          value: '\$${(data.kpis.quarterlyRevenue / 1000).toStringAsFixed(1)}M',
          icon: LucideIcons.trendingUp,
          iconColor: ds.colors.success,
        ),
        PrimeCareStatCard(
          title: 'Anticipated Growth',
          value: '${(data.kpis.projectedGrowth * 100).toStringAsFixed(1)}%',
          icon: LucideIcons.arrowUpRight,
          iconColor: ds.colors.primary,
        ),
        PrimeCareStatCard(
          title: 'Margin Efficiency',
          value: '${(data.kpis.marginEfficiency * 100).toStringAsFixed(1)}%',
          icon: LucideIcons.percent,
          iconColor: ds.colors.warning,
        ),
        PrimeCareStatCard(
          title: 'Projected Patients',
          value: data.kpis.projectedAdmissions.toString(),
          icon: LucideIcons.users,
          iconColor: ds.colors.secondary,
        ),
      ],
    );
  }

  Widget _buildInsightsAndConfidence(BuildContext context, PrimeCareDesignSystem ds) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 2,
          child: PrimeCareCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'AI STRATEGIC INSIGHTS',
                  style: ds.typography.labelSmall.copyWith(
                    color: ds.colors.textSecondary,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.2,
                  ),
                ),
                const SizedBox(height: 16),
                ...data.insights.map((insight) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 12.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Icon(LucideIcons.checkCircle2, color: ds.colors.success, size: 16),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Text(
                            insight,
                            style: TextStyle(color: ds.colors.textSecondary, fontSize: 13),
                          ),
                        ),
                      ],
                    ),
                  );
                }),
              ],
            ),
          ),
        ),
        const SizedBox(width: 24),
        Expanded(
          child: PrimeCareCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'CONFIDENCE',
                  style: ds.typography.labelSmall.copyWith(
                    color: ds.colors.textSecondary,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.2,
                  ),
                ),
                const SizedBox(height: 16),
                Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Stack(
                        alignment: Alignment.center,
                        children: [
                          SizedBox(
                            height: 80,
                            width: 80,
                            child: CircularProgressIndicator(
                              value: data.confidenceScore,
                              strokeWidth: 8,
                              backgroundColor: ds.colors.borderSubtle,
                              color: _getConfidenceColor(ds, data.confidenceScore),
                            ),
                          ),
                          Text(
                            '${(data.confidenceScore * 100).toInt()}%',
                            style: TextStyle(
                              color: ds.colors.textPrimary,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      Text(
                        'Model Reliability',
                        style: TextStyle(color: ds.colors.textTertiary, fontSize: 11),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Color _getConfidenceColor(PrimeCareDesignSystem ds, double score) {
    if (score > 0.8) return ds.colors.success;
    if (score > 0.6) return ds.colors.warning;
    return ds.colors.danger;
  }
}
