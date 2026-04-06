import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:primecare_v4/design_system/clinical_glass.dart';
import 'package:primecare_v4/design_system/primecare_theme.dart';
import 'dart:math' as math;

class TerritoryReportsScreen extends ConsumerStatefulWidget {
  const TerritoryReportsScreen({super.key});

  @override
  ConsumerState<TerritoryReportsScreen> createState() => _TerritoryReportsScreenState();
}

class _TerritoryReportsScreenState extends ConsumerState<TerritoryReportsScreen> {
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
            _buildHighLevelMetrics(),
            const SizedBox(height: 32),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 3,
                  child: Column(
                    children: [
                      _buildQuotaAttainment(),
                      const SizedBox(height: 32),
                      _buildRegionalMapPlaceholder(),
                    ],
                  ),
                ),
                const SizedBox(width: 32),
                Expanded(
                  flex: 5,
                  child: _buildRepPerformanceTable(),
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
            Text(
              'Territory Performance Reports',
              style: PrimeCareTheme.typography.heroTitle.copyWith(
                color: PrimeCareTheme.colors.navyIndigo,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Roll-up reporting of territory revenue, quota attainment, and individual rep performance.',
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
              label: 'Year to Date',
            ),
            const SizedBox(width: 16),
            ClinicalGlassButton(
              onPressed: () {},
              icon: LucideIcons.printer,
              isActive: true,
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildHighLevelMetrics() {
    return Row(
      children: [
        Expanded(
          child: _buildMetricCard(
            title: 'Territory Revenue (YTD)',
            value: '\$8.45M',
            trend: '+15.2%',
            positiveTrend: true,
          ),
        ),
        const SizedBox(width: 24),
        Expanded(
          child: _buildMetricCard(
            title: 'Overall Quota Attainment',
            value: '92.4%',
            trend: '+4.1%',
            positiveTrend: true,
          ),
        ),
        const SizedBox(width: 24),
        Expanded(
          child: _buildMetricCard(
            title: 'Avg Rep Production',
            value: '\$704k',
            trend: '+8.3%',
            positiveTrend: true,
          ),
        ),
        const SizedBox(width: 24),
        Expanded(
          child: _buildMetricCard(
            title: 'Customer Churn (B2B)',
            value: '2.1%',
            trend: '-0.5%',
            positiveTrend: true, // Lower is better
          ),
        ),
      ],
    );
  }

  Widget _buildMetricCard({required String title, required String value, required String trend, required bool positiveTrend}) {
    Color trendColor = positiveTrend ? PrimeCareTheme.colors.emeraldTeal : PrimeCareTheme.colors.coralRed;
    IconData trendIcon = positiveTrend ? LucideIcons.trendingUp : LucideIcons.trendingDown;

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
                '$trend vs. Prior Year',
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

  Widget _buildQuotaAttainment() {
    return ClinicalGlassPanel(
      padding: const EdgeInsets.all(32),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              'YTD Quota Attainment',
              style: PrimeCareTheme.typography.h3.copyWith(color: PrimeCareTheme.colors.navyIndigo),
            ),
          ),
          const SizedBox(height: 32),
          // Simulate a Gauge / Donut chart
          Stack(
            alignment: Alignment.center,
            children: [
              SizedBox(
                width: 200,
                height: 200,
                child: CustomPaint(
                  painter: _DonutChartPainter(
                    percentage: 0.924,
                    color: PrimeCareTheme.colors.emeraldTeal,
                    backgroundColor: PrimeCareTheme.colors.surfaceContainerHighest,
                  ),
                ),
              ),
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    '92.4%',
                    style: PrimeCareTheme.typography.heroTitle.copyWith(color: PrimeCareTheme.colors.navyIndigo, fontSize: 36),
                  ),
                  Text(
                    'of \$9.14M Target',
                    style: PrimeCareTheme.typography.label.copyWith(color: PrimeCareTheme.colors.slateGray),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Column(
                children: [
                  Text('On Track', style: PrimeCareTheme.typography.label.copyWith(color: PrimeCareTheme.colors.slateGray)),
                  Text('8 Reps', style: PrimeCareTheme.typography.body.copyWith(color: PrimeCareTheme.colors.navyIndigo, fontWeight: FontWeight.bold)),
                ],
              ),
              Container(width: 1, height: 24, color: PrimeCareTheme.colors.surfaceContainerHighest),
              Column(
                children: [
                  Text('At Risk', style: PrimeCareTheme.typography.label.copyWith(color: PrimeCareTheme.colors.slateGray)),
                  Text('3 Reps', style: PrimeCareTheme.typography.body.copyWith(color: PrimeCareTheme.colors.coralRed, fontWeight: FontWeight.bold)),
                ],
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget _buildRegionalMapPlaceholder() {
    return ClinicalGlassPanel(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Territory Heatmap',
                style: PrimeCareTheme.typography.h3.copyWith(color: PrimeCareTheme.colors.navyIndigo),
              ),
              Icon(LucideIcons.mapPin, size: 20, color: PrimeCareTheme.colors.slateGray),
            ],
          ),
          const SizedBox(height: 24),
          Container(
            height: 250,
            decoration: BoxDecoration(
              color: PrimeCareTheme.colors.surfaceContainerLow,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(LucideIcons.map, size: 48, color: PrimeCareTheme.colors.slateGray.withValues(alpha: 0.5)),
                  const SizedBox(height: 16),
                  Text('Interactive Map Visualization', style: PrimeCareTheme.typography.body.copyWith(color: PrimeCareTheme.colors.slateGray)),
                  Text('Regions scaled by revenue contribution', style: PrimeCareTheme.typography.label.copyWith(color: PrimeCareTheme.colors.slateGray, fontSize: 11)),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRepPerformanceTable() {
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
                  'Sales Representative Performance',
                  style: PrimeCareTheme.typography.h3.copyWith(color: PrimeCareTheme.colors.navyIndigo),
                ),
                ClinicalGlassButton(onPressed: () {}, icon: LucideIcons.search, label: 'Search Reps'),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
            color: PrimeCareTheme.colors.surfaceContainerLow,
            child: Row(
              children: [
                Expanded(flex: 3, child: Text('REPRESENTATIVE', style: PrimeCareTheme.typography.label.copyWith(fontSize: 11, color: PrimeCareTheme.colors.slateGray, fontWeight: FontWeight.bold))),
                Expanded(flex: 2, child: Text('QUOTA TARGET', style: PrimeCareTheme.typography.label.copyWith(fontSize: 11, color: PrimeCareTheme.colors.slateGray, fontWeight: FontWeight.bold))),
                Expanded(flex: 2, child: Text('CLOSED REVENUE', style: PrimeCareTheme.typography.label.copyWith(fontSize: 11, color: PrimeCareTheme.colors.slateGray, fontWeight: FontWeight.bold))),
                Expanded(flex: 3, child: Text('ATTAINMENT', style: PrimeCareTheme.typography.label.copyWith(fontSize: 11, color: PrimeCareTheme.colors.slateGray, fontWeight: FontWeight.bold))),
              ],
            ),
          ),
          ..._buildRepRows(),
        ],
      ),
    );
  }

  List<Widget> _buildRepRows() {
    final reps = [
      {'name': 'Sarah Jenkins', 'target': '\$950k', 'closed': '\$1.05M', 'attainment': 110.5},
      {'name': 'Michael Chang', 'target': '\$850k', 'closed': '\$820k', 'attainment': 96.4},
      {'name': 'Aisha Patel', 'target': '\$1.1M', 'closed': '\$980k', 'attainment': 89.0},
      {'name': 'David R.', 'target': '\$800k', 'closed': '\$600k', 'attainment': 75.0},
      {'name': 'Elena O.', 'target': '\$750k', 'closed': '\$760k', 'attainment': 101.3},
      {'name': 'Marcus L.', 'target': '\$900k', 'closed': '\$910k', 'attainment': 101.1},
      {'name': 'Sofia M.', 'target': '\$850k', 'closed': '\$800k', 'attainment': 94.1},
    ];

    return reps.asMap().entries.map((entry) {
      final rep = entry.value;
      final int index = entry.key;
      final double attainment = rep['attainment'] as double;
      Color attainmentColor = attainment >= 100 ? PrimeCareTheme.colors.emeraldTeal : (attainment >= 85 ? Colors.amber.shade700 : PrimeCareTheme.colors.coralRed);

      return Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
            child: Row(
              children: [
                Expanded(
                  flex: 3,
                  child: Row(
                    children: [
                      CircleAvatar(
                        radius: 16,
                        backgroundColor: PrimeCareTheme.colors.surfaceContainerHighest,
                        child: Text((rep['name'] as String)[0], style: TextStyle(color: PrimeCareTheme.colors.navyIndigo, fontWeight: FontWeight.bold)),
                      ),
                      const SizedBox(width: 12),
                      Text(rep['name'] as String, style: PrimeCareTheme.typography.h4.copyWith(color: PrimeCareTheme.colors.navyIndigo)),
                    ],
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Text(rep['target'] as String, style: PrimeCareTheme.typography.body.copyWith(color: PrimeCareTheme.colors.slateGray)),
                ),
                Expanded(
                  flex: 2,
                  child: Text(rep['closed'] as String, style: PrimeCareTheme.typography.body.copyWith(color: PrimeCareTheme.colors.navyIndigo, fontWeight: FontWeight.bold)),
                ),
                Expanded(
                  flex: 3,
                  child: Row(
                    children: [
                      Expanded(
                        child: LinearProgressIndicator(
                          value: (attainment / 150).clamp(0.0, 1.0), // Scale up to 150% max for visual
                          backgroundColor: PrimeCareTheme.colors.surfaceContainerHighest,
                          valueColor: AlwaysStoppedAnimation<Color>(attainmentColor),
                          minHeight: 8,
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ),
                      const SizedBox(width: 16),
                      SizedBox(
                        width: 45,
                        child: Text('${attainment.toStringAsFixed(1)}%', style: PrimeCareTheme.typography.label.copyWith(color: attainmentColor, fontWeight: FontWeight.bold)),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          if (index < reps.length - 1)
            Divider(height: 1, color: PrimeCareTheme.colors.surfaceContainerHighest, indent: 24, endIndent: 24),
        ],
      );
    }).toList();
  }
}

class _DonutChartPainter extends CustomPainter {
  final double percentage;
  final Color color;
  final Color backgroundColor;

  _DonutChartPainter({required this.percentage, required this.color, required this.backgroundColor});

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = math.min(size.width / 2, size.height / 2) - 15;
    final strokeWidth = 30.0;

    // Background circle
    final bgPaint = Paint()
      ..color = backgroundColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round;
    canvas.drawCircle(center, radius, bgPaint);

    // Foreground arc
    final fgPaint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round;

    final sweepAngle = 2 * math.pi * percentage;
    // Start from top (-pi/2)
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      -math.pi / 2,
      sweepAngle,
      false,
      fgPaint,
    );
  }

  @override
  bool shouldRepaint(covariant _DonutChartPainter oldDelegate) {
    return oldDelegate.percentage != percentage || oldDelegate.color != color || oldDelegate.backgroundColor != backgroundColor;
  }
}
