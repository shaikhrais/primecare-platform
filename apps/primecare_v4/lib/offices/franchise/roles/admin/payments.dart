import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:primecare_v4/design_system/clinical_glass.dart';
import 'package:primecare_v4/design_system/primecare_theme.dart';
import 'dart:math' as math;

class FranchisePaymentsScreen extends ConsumerStatefulWidget {
  const FranchisePaymentsScreen({super.key});

  @override
  ConsumerState<FranchisePaymentsScreen> createState() => _FranchisePaymentsScreenState();
}

class _FranchisePaymentsScreenState extends ConsumerState<FranchisePaymentsScreen> {
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
                  child: _buildRecentPaymentsTable(),
                ),
                const SizedBox(width: 32),
                Expanded(
                  flex: 1,
                  child: Column(
                    children: [
                      _buildPaymentMethodsChart(),
                      const SizedBox(height: 32),
                      _buildUnallocatedPaymentsWidget(),
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
            Text(
              'Payments Dashboard',
              style: PrimeCareTheme.typography.heroTitle.copyWith(
                color: PrimeCareTheme.colors.navyIndigo,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Track incoming payments, distribution methods, and unallocated funds.',
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
              icon: LucideIcons.download,
              label: 'Export Data',
            ),
            const SizedBox(width: 16),
            ClinicalGlassButton(
              onPressed: () {},
              icon: LucideIcons.plus,
              label: 'Receive Payment',
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
            title: 'Payments Today',
            value: '\$12,450',
            icon: LucideIcons.calendar,
            trend: '+15%',
            positiveTrend: true,
          ),
        ),
        const SizedBox(width: 24),
        Expanded(
          child: _buildMetricCard(
            title: 'Payments This Week',
            value: '\$84,200',
            icon: LucideIcons.calendarDays,
            trend: '+5%',
            positiveTrend: true,
          ),
        ),
        const SizedBox(width: 24),
        Expanded(
          child: _buildMetricCard(
            title: 'Avg Payment Size',
            value: '\$1,250',
            icon: LucideIcons.calculator,
            trend: '-2%',
            positiveTrend: false, // Smaller avg payment
          ),
        ),
        const SizedBox(width: 24),
        Expanded(
          child: _buildMetricCard(
            title: 'Unallocated Funds',
            value: '\$8,400',
            icon: LucideIcons.alertCircle,
            trend: '+12%',
            positiveTrend: false, // More unallocated is bad
          ),
        ),
      ],
    );
  }

  Widget _buildMetricCard({required String title, required String value, required IconData icon, required String trend, required bool positiveTrend}) {
    Color trendColor = positiveTrend ? PrimeCareTheme.colors.emeraldTeal : PrimeCareTheme.colors.coralRed;
    IconData trendIcon = positiveTrend ? LucideIcons.trendingUp : LucideIcons.trendingDown;

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
              Icon(icon, color: PrimeCareTheme.colors.navyIndigo, size: 20),
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
                '$trend vs. Prior Period',
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

  Widget _buildRecentPaymentsTable() {
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
                  'Recent Payments',
                  style: PrimeCareTheme.typography.h3.copyWith(color: PrimeCareTheme.colors.navyIndigo),
                ),
                Container(
                  width: 250,
                  decoration: BoxDecoration(
                    color: PrimeCareTheme.colors.surfaceContainerLow,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: PrimeCareTheme.colors.surfaceContainerHighest),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  child: Row(
                    children: [
                      Icon(LucideIcons.search, size: 18, color: PrimeCareTheme.colors.slateGray),
                      const SizedBox(width: 8),
                      Text('Search Payments...', style: PrimeCareTheme.typography.body.copyWith(color: PrimeCareTheme.colors.slateGray)),
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
                Expanded(flex: 2, child: Text('PAYMENT ID', style: PrimeCareTheme.typography.label.copyWith(fontSize: 11, color: PrimeCareTheme.colors.slateGray, fontWeight: FontWeight.bold))),
                Expanded(flex: 3, child: Text('CLIENT', style: PrimeCareTheme.typography.label.copyWith(fontSize: 11, color: PrimeCareTheme.colors.slateGray, fontWeight: FontWeight.bold))),
                Expanded(flex: 2, child: Text('DATE', style: PrimeCareTheme.typography.label.copyWith(fontSize: 11, color: PrimeCareTheme.colors.slateGray, fontWeight: FontWeight.bold))),
                Expanded(flex: 2, child: Text('METHOD', style: PrimeCareTheme.typography.label.copyWith(fontSize: 11, color: PrimeCareTheme.colors.slateGray, fontWeight: FontWeight.bold))),
                Expanded(flex: 2, child: Text('AMOUNT', style: PrimeCareTheme.typography.label.copyWith(fontSize: 11, color: PrimeCareTheme.colors.slateGray, fontWeight: FontWeight.bold))),
                Expanded(flex: 2, child: Text('STATUS', style: PrimeCareTheme.typography.label.copyWith(fontSize: 11, color: PrimeCareTheme.colors.slateGray, fontWeight: FontWeight.bold))),
              ],
            ),
          ),
          ..._buildPaymentRows(),
        ],
      ),
    );
  }

  List<Widget> _buildPaymentRows() {
    final payments = [
      {'id': 'PAY-89241', 'client': 'Regional Health Authority', 'date': 'Today, 10:45 AM', 'method': 'EFT', 'amount': '\$18,400.00', 'status': 'Cleared'},
      {'id': 'PAY-89240', 'client': 'Medicare', 'date': 'Today, 09:12 AM', 'method': 'Direct Deposit', 'amount': '\$31,200.00', 'status': 'Cleared'},
      {'id': 'PAY-89239', 'client': 'Private: Smith Family', 'date': 'Yesterday, 14:30 PM', 'method': 'Credit Card', 'amount': '\$850.00', 'status': 'Processing'},
      {'id': 'PAY-89238', 'client': 'Global Health Partners', 'date': 'Oct 25, 2026', 'method': 'Wire Transfer', 'amount': '\$12,450.00', 'status': 'Cleared'},
      {'id': 'PAY-89237', 'client': 'Private: John Doe', 'date': 'Oct 24, 2026', 'method': 'Cheque', 'amount': '\$450.00', 'status': 'Pending'},
      {'id': 'PAY-89236', 'client': 'Elm Street Assisted', 'date': 'Oct 23, 2026', 'method': 'EFT', 'amount': '\$4,200.00', 'status': 'Cleared'},
      {'id': 'PAY-89235', 'client': 'Private: A. Turing', 'date': 'Oct 23, 2026', 'method': 'Credit Card', 'amount': '\$1,200.00', 'status': 'Failed'},
    ];

    return payments.asMap().entries.map((entry) {
      final payment = entry.value;
      final int index = entry.key;

      Color statusColor;
      switch (payment['status']) {
        case 'Cleared':
          statusColor = PrimeCareTheme.colors.emeraldTeal;
          break;
        case 'Processing':
        case 'Pending':
          statusColor = Colors.amber.shade700;
          break;
        case 'Failed':
          statusColor = PrimeCareTheme.colors.coralRed;
          break;
        default:
          statusColor = PrimeCareTheme.colors.navyIndigo;
      }

      return Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
            child: Row(
              children: [
                Expanded(flex: 2, child: Text(payment['id'] as String, style: PrimeCareTheme.typography.h4.copyWith(color: PrimeCareTheme.colors.navyIndigo))),
                Expanded(flex: 3, child: Text(payment['client'] as String, style: PrimeCareTheme.typography.body.copyWith(color: PrimeCareTheme.colors.navyIndigo, fontWeight: FontWeight.bold))),
                Expanded(flex: 2, child: Text(payment['date'] as String, style: PrimeCareTheme.typography.body.copyWith(color: PrimeCareTheme.colors.slateGray))),
                Expanded(flex: 2, child: Text(payment['method'] as String, style: PrimeCareTheme.typography.body.copyWith(color: PrimeCareTheme.colors.slateGray))),
                Expanded(flex: 2, child: Text(payment['amount'] as String, style: PrimeCareTheme.typography.body.copyWith(color: PrimeCareTheme.colors.navyIndigo))),
                Expanded(
                  flex: 2,
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                      decoration: BoxDecoration(color: statusColor.withValues(alpha: 0.1), borderRadius: BorderRadius.circular(12)),
                      child: Text(payment['status'] as String, style: PrimeCareTheme.typography.label.copyWith(color: statusColor, fontWeight: FontWeight.bold)),
                    ),
                  ),
                ),
              ],
            ),
          ),
          if (index < payments.length - 1)
            Divider(height: 1, color: PrimeCareTheme.colors.surfaceContainerHighest),
        ],
      );
    }).toList();
  }

  Widget _buildPaymentMethodsChart() {
    return ClinicalGlassPanel(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Payment Methods',
            style: PrimeCareTheme.typography.h3.copyWith(color: PrimeCareTheme.colors.navyIndigo),
          ),
          const SizedBox(height: 32),
          Center(
            child: SizedBox(
              width: 180,
              height: 180,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  CustomPaint(
                    painter: _MethodChartPainter(
                      segments: [
                        _ChartSegment(value: 0.45, color: PrimeCareTheme.colors.emeraldTeal), // EFT
                        _ChartSegment(value: 0.35, color: PrimeCareTheme.colors.navyIndigo), // Direct Deposit
                        _ChartSegment(value: 0.15, color: Colors.amber.shade600), // Credit Card
                        _ChartSegment(value: 0.05, color: Colors.deepOrange.shade400), // Wire / Cheque
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 32),
          _buildMethodLegendRow('EFT', '45%', PrimeCareTheme.colors.emeraldTeal),
          _buildMethodLegendRow('Direct Deposit', '35%', PrimeCareTheme.colors.navyIndigo),
          _buildMethodLegendRow('Credit Card', '15%', Colors.amber.shade600),
          _buildMethodLegendRow('Wire / Cheque', '5%', Colors.deepOrange.shade400),
        ],
      ),
    );
  }

  Widget _buildMethodLegendRow(String label, String value, Color color) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Container(width: 10, height: 10, decoration: BoxDecoration(color: color, borderRadius: BorderRadius.circular(2))),
              const SizedBox(width: 12),
              Text(label, style: PrimeCareTheme.typography.body.copyWith(color: PrimeCareTheme.colors.navyIndigo)),
            ],
          ),
          Text(value, style: PrimeCareTheme.typography.body.copyWith(color: PrimeCareTheme.colors.slateGray, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }

  Widget _buildUnallocatedPaymentsWidget() {
    return ClinicalGlassPanel(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(LucideIcons.alertCircle, color: Colors.amber.shade700, size: 24),
              const SizedBox(width: 12),
              Text(
                'Unallocated Funds',
                style: PrimeCareTheme.typography.h3.copyWith(
                  color: PrimeCareTheme.colors.navyIndigo,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Text(
            'There are 4 payments that have not been applied to open invoices.',
            style: PrimeCareTheme.typography.body.copyWith(color: PrimeCareTheme.colors.slateGray),
          ),
          const SizedBox(height: 24),
          SizedBox(
            width: double.infinity,
            child: ClinicalGlassButton(
              onPressed: () {},
              icon: LucideIcons.arrowRight,
              label: 'Review Unallocated',
              isActive: false, // Make it look less prominent but still actionable
            ),
          )
        ],
      ),
    );
  }
}

class _ChartSegment {
  final double value; // 0.0 to 1.0
  final Color color;
  _ChartSegment({required this.value, required this.color});
}

class _MethodChartPainter extends CustomPainter {
  final List<_ChartSegment> segments;

  _MethodChartPainter({required this.segments});

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = math.min(size.width / 2, size.height / 2) - 15;
    final strokeWidth = 20.0; // Thinner than donut, flat ends
    
    double currentAngle = -math.pi / 2;

    for (int i = 0; i < segments.length; i++) {
      final sweepAngle = 2 * math.pi * segments[i].value;
      
      final paint = Paint()
        ..color = segments[i].color
        ..style = PaintingStyle.stroke
        ..strokeWidth = strokeWidth
        ..strokeCap = StrokeCap.butt; 

      final gap = 0.03; // Small gap
      
      canvas.drawArc(
        Rect.fromCircle(center: center, radius: radius),
        currentAngle + (gap/2),
        sweepAngle - gap,
        false,
        paint,
      );
      
      currentAngle += sweepAngle;
    }
  }

  @override
  bool shouldRepaint(covariant _MethodChartPainter oldDelegate) {
    return true; 
  }
}
