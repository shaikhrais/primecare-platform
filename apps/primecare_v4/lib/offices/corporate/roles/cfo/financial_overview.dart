import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:primecare_v4/design_system/clinical_glass.dart';
import 'package:primecare_v4/design_system/primecare_theme.dart';

class CfoFinancialOverviewScreen extends ConsumerStatefulWidget {
  const CfoFinancialOverviewScreen({super.key});

  @override
  ConsumerState<CfoFinancialOverviewScreen> createState() =>
      _CfoFinancialOverviewScreenState();
}

class _CfoFinancialOverviewScreenState
    extends ConsumerState<CfoFinancialOverviewScreen> {
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
              Expanded(flex: 2, child: _buildFinancialPerformanceChart()),
              const SizedBox(width: 32),
              Expanded(
                flex: 1,
                child: Column(
                  children: [
                    _buildRevenueBreakdown(),
                    const SizedBox(height: 32),
                    _buildFinancialAlerts(),
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
                  LucideIcons.landmark,
                  color: PrimeCareTheme.colors.navyIndigo,
                  size: 28,
                ),
                const SizedBox(width: 12),
                Text(
                  'Financial Overview',
                  style: PrimeCareTheme.typography.heroTitle.copyWith(
                    color: PrimeCareTheme.colors.navyIndigo,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              'High-level financial performance, revenue streams, and cash flow across the enterprise.',
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
              label: 'This Quarter',
              isActive: false,
            ),
            const SizedBox(width: 16),
            ClinicalGlassButton(
              onPressed: () {},
              icon: LucideIcons.download,
              label: 'Export Ledger',
              isActive: true,
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildKPIs() {
    return Row(
      children: [
        Expanded(
          child: _buildMetricCard(
            title: 'Total Revenue',
            value: '\$14.2M',
            icon: LucideIcons.trendingUp,
            trend: '+12.4% vs Last QTR',
            isPositive: true,
          ),
        ),
        const SizedBox(width: 24),
        Expanded(
          child: _buildMetricCard(
            title: 'Operating Expenses',
            value: '\$8.1M',
            icon: LucideIcons.receipt,
            trend: '-2.1% vs Last QTR',
            isPositive: true, // Decreasing expenses is positive
          ),
        ),
        const SizedBox(width: 24),
        Expanded(
          child: _buildMetricCard(
            title: 'Net Income',
            value: '\$6.1M',
            icon: LucideIcons.pieChart,
            trend: '+15.2% vs Last QTR',
            isPositive: true,
          ),
        ),
        const SizedBox(width: 24),
        Expanded(
          child: _buildMetricCard(
            title: 'Cash Flow',
            value: '\$2.4M',
            icon: LucideIcons.wallet,
            trend: '+8.1% vs Last QTR',
            isPositive: true,
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

  Widget _buildFinancialPerformanceChart() {
    return ClinicalGlassPanel(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '12-Month Performance',
                style: PrimeCareTheme.typography.h3.copyWith(
                  color: PrimeCareTheme.colors.navyIndigo,
                ),
              ),
              Row(
                children: [
                  _buildLegendItem(
                    'Revenue',
                    PrimeCareTheme.colors.emeraldTeal,
                  ),
                  const SizedBox(width: 16),
                  _buildLegendItem('Expenses', const Color(0xFFE11D48)),
                ],
              ),
            ],
          ),
          const SizedBox(height: 24),
          SizedBox(
            height: 350,
            child: CustomPaint(
              painter: _FinancialChartPainter(),
              size: Size.infinite,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLegendItem(String label, Color color) {
    return Row(
      children: [
        Container(
          width: 12,
          height: 12,
          decoration: BoxDecoration(color: color, shape: BoxShape.circle),
        ),
        const SizedBox(width: 8),
        Text(
          label,
          style: PrimeCareTheme.typography.label.copyWith(
            color: PrimeCareTheme.colors.slateGray,
          ),
        ),
      ],
    );
  }

  Widget _buildRevenueBreakdown() {
    return ClinicalGlassPanel(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Revenue by Division',
            style: PrimeCareTheme.typography.h3.copyWith(
              color: PrimeCareTheme.colors.navyIndigo,
            ),
          ),
          const SizedBox(height: 24),
          _buildBreakdownItem(
            'Franchise Royalties',
            55,
            PrimeCareTheme.colors.navyIndigo,
            '\$7.8M',
          ),
          const SizedBox(height: 16),
          _buildBreakdownItem(
            'Corporate Clinics',
            35,
            PrimeCareTheme.colors.emeraldTeal,
            '\$5.0M',
          ),
          const SizedBox(height: 16),
          _buildBreakdownItem(
            'Direct B2B Clients',
            10,
            Colors.amber.shade700,
            '\$1.4M',
          ),
        ],
      ),
    );
  }

  Widget _buildBreakdownItem(
    String label,
    int percentage,
    Color color,
    String amount,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              label,
              style: PrimeCareTheme.typography.body.copyWith(
                color: PrimeCareTheme.colors.navyIndigo,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              amount,
              style: PrimeCareTheme.typography.body.copyWith(
                color: PrimeCareTheme.colors.slateGray,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            Expanded(
              child: Container(
                height: 8,
                decoration: BoxDecoration(
                  color: PrimeCareTheme.colors.surfaceContainerHighest,
                  borderRadius: BorderRadius.circular(4),
                ),
                child: FractionallySizedBox(
                  alignment: Alignment.centerLeft,
                  widthFactor: percentage / 100,
                  child: Container(
                    decoration: BoxDecoration(
                      color: color,
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(width: 12),
            SizedBox(
              width: 40,
              child: Text(
                '$percentage%',
                style: PrimeCareTheme.typography.label.copyWith(
                  color: PrimeCareTheme.colors.slateGray,
                ),
                textAlign: TextAlign.right,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildFinancialAlerts() {
    return ClinicalGlassPanel(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Financial Alerts',
                style: PrimeCareTheme.typography.h3.copyWith(
                  color: PrimeCareTheme.colors.navyIndigo,
                ),
              ),
              Icon(
                LucideIcons.bellRing,
                color: Colors.amber.shade700,
                size: 20,
              ),
            ],
          ),
          const SizedBox(height: 24),
          _buildAlertItem(
            'Unreconciled Accounts',
            '3 accounts pending reconciliation over 7 days.',
            isWarning: true,
          ),
          const SizedBox(height: 16),
          _buildAlertItem(
            'Expense Anomaly',
            'Travel expenses spiked 15% in Region East.',
            isWarning: true,
          ),
          const SizedBox(height: 16),
          _buildAlertItem(
            'Tax Remittance',
            'Q3 HST remittance due in 5 days.',
            isNeutral: true,
          ),
        ],
      ),
    );
  }

  Widget _buildAlertItem(
    String title,
    String subtitle, {
    bool isWarning = false,
    bool isNeutral = false,
  }) {
    Color iconColor = PrimeCareTheme.colors.emeraldTeal;
    IconData icon = LucideIcons.checkCircle;

    if (isWarning) {
      iconColor = Colors.amber.shade700;
      icon = LucideIcons.alertTriangle;
    } else if (isNeutral) {
      iconColor = PrimeCareTheme.colors.navyIndigo;
      icon = LucideIcons.info;
    }

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: iconColor.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(icon, color: iconColor, size: 16),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: PrimeCareTheme.typography.body.copyWith(
                  color: PrimeCareTheme.colors.navyIndigo,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                subtitle,
                style: PrimeCareTheme.typography.label.copyWith(
                  color: PrimeCareTheme.colors.slateGray,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _FinancialChartPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paintLineRev = Paint()
      ..color =
          const Color(0xFF0D9488) // Emerald Teal
      ..strokeWidth = 3
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    final paintLineExp = Paint()
      ..color =
          const Color(0xFFE11D48) // Ruby Red
      ..strokeWidth = 3
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    final paintBgLine = Paint()
      ..color = const Color(0xFFE2E8F0)
      ..strokeWidth = 1
      ..style = PaintingStyle.stroke;

    // Draw horizontal grid lines
    for (int i = 0; i < 5; i++) {
      double y = size.height - (i * (size.height / 4));
      if (i > 0) {
        // Don't draw bottom line
        canvas.drawLine(Offset(0, y), Offset(size.width, y), paintBgLine);
      }
    }

    final pathRev = Path();
    final pathExp = Path();

    // Sample Data
    final revData = [40, 50, 45, 60, 55, 70, 65, 80, 75, 90, 85, 100];
    final expData = [30, 35, 32, 40, 38, 45, 42, 50, 48, 55, 50, 60];

    final widthStep = size.width / 11;

    for (int i = 0; i < 12; i++) {
      double x = i * widthStep;
      double yRev = size.height - (revData[i] / 100 * size.height);
      double yExp = size.height - (expData[i] / 100 * size.height);

      if (i == 0) {
        pathRev.moveTo(x, yRev);
        pathExp.moveTo(x, yExp);
      } else {
        // Smooth curves
        double prevX = (i - 1) * widthStep;
        double prevYRev = size.height - (revData[i - 1] / 100 * size.height);
        double prevYExp = size.height - (expData[i - 1] / 100 * size.height);

        pathRev.cubicTo(
          prevX + widthStep / 2,
          prevYRev,
          x - widthStep / 2,
          yRev,
          x,
          yRev,
        );

        pathExp.cubicTo(
          prevX + widthStep / 2,
          prevYExp,
          x - widthStep / 2,
          yExp,
          x,
          yExp,
        );
      }
    }

    canvas.drawPath(pathRev, paintLineRev);
    canvas.drawPath(pathExp, paintLineExp);

    // Draw dots at the end
    final dotPaintRev = Paint()
      ..color = const Color(0xFF0D9488)
      ..style = PaintingStyle.fill;
    final dotPaintExp = Paint()
      ..color = const Color(0xFFE11D48)
      ..style = PaintingStyle.fill;

    canvas.drawCircle(
      Offset(size.width, size.height - (100 / 100 * size.height)),
      6,
      dotPaintRev,
    );
    canvas.drawCircle(
      Offset(size.width, size.height - (60 / 100 * size.height)),
      6,
      dotPaintExp,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
