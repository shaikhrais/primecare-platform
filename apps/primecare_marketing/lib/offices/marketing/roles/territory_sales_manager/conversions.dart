import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:primecare_v4/design_system/clinical_glass.dart';
import 'package:primecare_v4/design_system/primecare_theme.dart';

class TerritoryConversionsScreen extends ConsumerStatefulWidget {
  const TerritoryConversionsScreen({super.key});

  @override
  ConsumerState<TerritoryConversionsScreen> createState() =>
      _TerritoryConversionsScreenState();
}

class _TerritoryConversionsScreenState
    extends ConsumerState<TerritoryConversionsScreen> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(32.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildHeader(),
          const SizedBox(height: 32),
          _buildFunnelSection(),
          const SizedBox(height: 32),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(flex: 2, child: _buildTrendChart()),
              const SizedBox(width: 32),
              Expanded(flex: 1, child: _buildClinicPerformance()),
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
              'Conversion Rates',
              style: PrimeCareTheme.typography.heroTitle.copyWith(
                color: PrimeCareTheme.colors.navyIndigo,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Analyze the patient acquisition funnel from initial contact to active patient.',
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
              icon: LucideIcons.filter,
              label: 'All Clinics',
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildFunnelSection() {
    return Row(
      children: [
        Expanded(
          child: _buildFunnelStage(
            stageName: 'Initial Inquiries',
            count: '1,240',
            dropOff: '-15%',
            color: PrimeCareTheme.colors.slateGray,
          ),
        ),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Icon(LucideIcons.chevronRight, color: Colors.grey),
        ),
        Expanded(
          child: _buildFunnelStage(
            stageName: 'Consultations Booked',
            count: '1,054',
            dropOff: '-30%',
            color: PrimeCareTheme.colors.navyIndigo.withValues(alpha: 0.6),
          ),
        ),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Icon(LucideIcons.chevronRight, color: Colors.grey),
        ),
        Expanded(
          child: _buildFunnelStage(
            stageName: 'Consults Completed',
            count: '738',
            dropOff: '-25%',
            color: PrimeCareTheme.colors.navyIndigo,
          ),
        ),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Icon(LucideIcons.chevronRight, color: Colors.grey),
        ),
        Expanded(
          child: _buildFunnelStage(
            stageName: 'Converted (New Patients)',
            count: '553',
            dropOff: 'Final',
            color: PrimeCareTheme.colors.emeraldTeal,
            isFinal: true,
          ),
        ),
      ],
    );
  }

  Widget _buildFunnelStage({
    required String stageName,
    required String count,
    required String dropOff,
    required Color color,
    bool isFinal = false,
  }) {
    return ClinicalGlassPanel(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Text(
              stageName,
              style: PrimeCareTheme.typography.label.copyWith(
                color: color,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(height: 24),
          Text(
            count,
            style: PrimeCareTheme.typography.heroTitle.copyWith(
              color: PrimeCareTheme.colors.navyIndigo,
            ),
          ),
          const SizedBox(height: 8),
          if (!isFinal)
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  LucideIcons.arrowDownRight,
                  size: 14,
                  color: PrimeCareTheme.colors.coralRed,
                ),
                const SizedBox(width: 4),
                Text(
                  '$dropOff Drop-off',
                  style: PrimeCareTheme.typography.label.copyWith(
                    color: PrimeCareTheme.colors.coralRed,
                  ),
                ),
              ],
            )
          else
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  LucideIcons.checkCircle,
                  size: 14,
                  color: PrimeCareTheme.colors.emeraldTeal,
                ),
                const SizedBox(width: 4),
                Text(
                  '44.6% Overall Conv.',
                  style: PrimeCareTheme.typography.label.copyWith(
                    color: PrimeCareTheme.colors.emeraldTeal,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
        ],
      ),
    );
  }

  Widget _buildTrendChart() {
    return ClinicalGlassPanel(
      padding: const EdgeInsets.all(32),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Conversion Trend (Consult to Patient)',
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
                    'Conversion Rate',
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
                    painter: _ConversionTrendPainter(
                      PrimeCareTheme.colors.emeraldTeal,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          // X-axis labels (weeks)
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children:
                ['Week 1', 'Week 2', 'Week 3', 'Week 4', 'Week 5', 'Week 6']
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

  Widget _buildClinicPerformance() {
    return ClinicalGlassPanel(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Top Converting Clinics',
            style: PrimeCareTheme.typography.h3.copyWith(
              color: PrimeCareTheme.colors.navyIndigo,
            ),
          ),
          const SizedBox(height: 24),
          _buildClinicRow(
            name: 'Maplewood Clinic',
            rate: '68%',
            progress: 0.68,
          ),
          const SizedBox(height: 20),
          _buildClinicRow(name: 'Cedar Point', rate: '61%', progress: 0.61),
          const SizedBox(height: 20),
          _buildClinicRow(name: 'Oakville Center', rate: '52%', progress: 0.52),
          const SizedBox(height: 32),
          Text(
            'Needs Improvement',
            style: PrimeCareTheme.typography.h3.copyWith(
              color: PrimeCareTheme.colors.navyIndigo,
            ),
          ),
          const SizedBox(height: 24),
          _buildClinicRow(
            name: 'Pine Valley',
            rate: '35%',
            progress: 0.35,
            isWarning: true,
          ),
          const SizedBox(height: 20),
          _buildClinicRow(
            name: 'Westside Med',
            rate: '28%',
            progress: 0.28,
            isWarning: true,
          ),
        ],
      ),
    );
  }

  Widget _buildClinicRow({
    required String name,
    required String rate,
    required double progress,
    bool isWarning = false,
  }) {
    Color barColor = isWarning
        ? PrimeCareTheme.colors.coralRed
        : PrimeCareTheme.colors.emeraldTeal;

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
              rate,
              style: PrimeCareTheme.typography.label.copyWith(
                color: barColor,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        LinearProgressIndicator(
          value: progress,
          backgroundColor: PrimeCareTheme.colors.surfaceContainerLow,
          valueColor: AlwaysStoppedAnimation<Color>(barColor),
          minHeight: 6,
          borderRadius: BorderRadius.circular(3),
        ),
      ],
    );
  }
}

// Simple painter to simulate a line chart
class _ConversionTrendPainter extends CustomPainter {
  final Color color;
  _ConversionTrendPainter(this.color);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = 3
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    final path = Path();
    // Simulated data points: [40, 42, 38, 45, 50, 55] trending up
    final points = [
      Offset(0, size.height * 0.6),
      Offset(size.width * 0.2, size.height * 0.55),
      Offset(size.width * 0.4, size.height * 0.65),
      Offset(size.width * 0.6, size.height * 0.45),
      Offset(size.width * 0.8, size.height * 0.35),
      Offset(size.width, size.height * 0.2),
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
