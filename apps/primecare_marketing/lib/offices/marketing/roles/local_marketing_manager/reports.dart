import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:primecare_v4/design_system/clinical_glass.dart';
import 'package:primecare_v4/design_system/primecare_theme.dart';

class LocalReportsScreen extends ConsumerStatefulWidget {
  const LocalReportsScreen({super.key});

  @override
  ConsumerState<LocalReportsScreen> createState() => _LocalReportsScreenState();
}

class _LocalReportsScreenState extends ConsumerState<LocalReportsScreen> {
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
              Expanded(flex: 2, child: _buildCpaTrendChart()),
              const SizedBox(width: 32),
              Expanded(flex: 1, child: _buildChannelPerformance()),
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
              'Performance Reports',
              style: PrimeCareTheme.typography.heroTitle.copyWith(
                color: PrimeCareTheme.colors.navyIndigo,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Local marketing performance roll-up and channel ROI tracking.',
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
              label: 'Last 30 Days',
            ),
            const SizedBox(width: 16),
            ClinicalGlassButton(
              onPressed: () {},
              icon: LucideIcons.download,
              label: 'Export PDF',
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
            title: 'Total Marketing Spend',
            value: '\$4,120',
            trend: '+5%',
            positiveTrend: false,
          ),
        ),
        const SizedBox(width: 24),
        Expanded(
          child: _buildMetricCard(
            title: 'Cost Per Acquisition (CPA)',
            value: '\$65.40',
            trend: '-12%',
            positiveTrend: true,
          ),
        ),
        const SizedBox(width: 24),
        Expanded(
          child: _buildMetricCard(
            title: 'New Patients (from Mktg)',
            value: '63',
            trend: '+18%',
            positiveTrend: true,
          ),
        ),
        const SizedBox(width: 24),
        Expanded(
          child: _buildMetricCard(
            title: 'Estimated ROI',
            value: '2.4x',
            trend: '+0.3x',
            positiveTrend: true,
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
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: PrimeCareTheme.typography.label.copyWith(
                  color: PrimeCareTheme.colors.slateGray,
                ),
              ),
              Icon(
                LucideIcons.barChart2,
                size: 16,
                color: PrimeCareTheme.colors.surfaceContainerHighest,
              ),
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
          Row(
            children: [
              Icon(trendIcon, size: 16, color: trendColor),
              const SizedBox(width: 4),
              Text(
                '$trend vs. last period',
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

  Widget _buildCpaTrendChart() {
    return ClinicalGlassPanel(
      padding: const EdgeInsets.all(32),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Cost Per Acquisition Trend',
                style: PrimeCareTheme.typography.h3.copyWith(
                  color: PrimeCareTheme.colors.navyIndigo,
                ),
              ),
              Row(
                children: [
                  Container(
                    width: 12,
                    height: 12,
                    decoration: BoxDecoration(
                      color: PrimeCareTheme.colors.emeraldTeal,
                      shape: BoxShape.circle,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    'CPA (\$)',
                    style: PrimeCareTheme.typography.label.copyWith(
                      color: PrimeCareTheme.colors.slateGray,
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 32),
          // Chart placeholder
          Container(
            height: 300,
            width: double.infinity,
            decoration: BoxDecoration(
              border: Border(
                left: BorderSide(
                  color: PrimeCareTheme.colors.surfaceContainerHighest,
                ),
                bottom: BorderSide(
                  color: PrimeCareTheme.colors.surfaceContainerHighest,
                ),
              ),
            ),
            child: Stack(
              children: [
                // Y-axis gridlines
                for (int i = 0; i < 5; i++)
                  Positioned(
                    bottom: (300 / 4) * i,
                    left: 0,
                    right: 0,
                    child: Container(
                      height: 1,
                      color: PrimeCareTheme.colors.surfaceContainerHighest
                          .withValues(alpha: 0.5),
                    ),
                  ),
                // Data line (simulated)
                Positioned.fill(
                  child: CustomPaint(
                    painter: _CpaLinePainter(PrimeCareTheme.colors.emeraldTeal),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          // X-axis labels
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: ['May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct']
                .map(
                  (e) => Text(
                    e,
                    style: PrimeCareTheme.typography.label.copyWith(
                      color: PrimeCareTheme.colors.slateGray,
                    ),
                  ),
                )
                .toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildChannelPerformance() {
    return ClinicalGlassPanel(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Top Channels',
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
          _buildChannelRow(
            channel: 'Local SEO / Maps',
            patients: 25,
            cpa: '\$15.00',
            progress: 0.8,
          ),
          const SizedBox(height: 20),
          _buildChannelRow(
            channel: 'Community Events',
            patients: 18,
            cpa: '\$45.50',
            progress: 0.6,
          ),
          const SizedBox(height: 20),
          _buildChannelRow(
            channel: 'Direct Mail',
            patients: 12,
            cpa: '\$85.00',
            progress: 0.4,
          ),
          const SizedBox(height: 20),
          _buildChannelRow(
            channel: 'Facebook Ads',
            patients: 8,
            cpa: '\$120.00',
            progress: 0.25,
          ),
        ],
      ),
    );
  }

  Widget _buildChannelRow({
    required String channel,
    required int patients,
    required String cpa,
    required double progress,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              channel,
              style: PrimeCareTheme.typography.h4.copyWith(
                color: PrimeCareTheme.colors.navyIndigo,
              ),
            ),
            Text(
              '$patients patients',
              style: PrimeCareTheme.typography.label.copyWith(
                color: PrimeCareTheme.colors.navyIndigo,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        LinearProgressIndicator(
          value: progress,
          backgroundColor: PrimeCareTheme.colors.surfaceContainerLow,
          valueColor: AlwaysStoppedAnimation<Color>(
            PrimeCareTheme.colors.navyIndigo,
          ),
          minHeight: 6,
          borderRadius: BorderRadius.circular(3),
        ),
        const SizedBox(height: 8),
        Text(
          'CPA: $cpa',
          style: PrimeCareTheme.typography.label.copyWith(
            color: PrimeCareTheme.colors.slateGray,
            fontSize: 11,
          ),
        ),
      ],
    );
  }
}

// Simple painter to simulate a line chart
class _CpaLinePainter extends CustomPainter {
  final Color color;
  _CpaLinePainter(this.color);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = 3
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    final path = Path();
    // Simulated data points: [100, 120, 95, 80, 75, 65] CPA trend going down
    final points = [
      Offset(0, size.height * 0.4),
      Offset(size.width * 0.2, size.height * 0.3),
      Offset(size.width * 0.4, size.height * 0.5),
      Offset(size.width * 0.6, size.height * 0.6),
      Offset(size.width * 0.8, size.height * 0.7),
      Offset(size.width, size.height * 0.8),
    ];

    path.moveTo(points[0].dx, points[0].dy);
    for (int i = 1; i < points.length; i++) {
      path.lineTo(points[i].dx, points[i].dy);
    }

    canvas.drawPath(path, paint);

    // Draw dots
    final dotPaint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;
    final whitePaint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;

    for (var point in points) {
      canvas.drawCircle(point, 6, dotPaint);
      canvas.drawCircle(point, 3, whitePaint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
