import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:primecare_v4/design_system/clinical_glass.dart';
import 'package:primecare_v4/design_system/primecare_theme.dart';
import 'dart:math' as math;

class FranchiseOutstandingBalancesScreen extends ConsumerStatefulWidget {
  const FranchiseOutstandingBalancesScreen({super.key});

  @override
  ConsumerState<FranchiseOutstandingBalancesScreen> createState() => _FranchiseOutstandingBalancesScreenState();
}

class _FranchiseOutstandingBalancesScreenState extends ConsumerState<FranchiseOutstandingBalancesScreen> {
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
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 1,
                  child: Column(
                    children: [
                      _buildTotalOutstandingCard(),
                      const SizedBox(height: 32),
                      _buildAgingSummaryChart(),
                    ],
                  ),
                ),
                const SizedBox(width: 32),
                Expanded(
                  flex: 2,
                  child: _buildAccountsInArrearsTable(),
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
              'Outstanding Balances',
              style: PrimeCareTheme.typography.heroTitle.copyWith(
                color: PrimeCareTheme.colors.navyIndigo,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Focus strictly on collections, arrears, and account aging.',
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
              icon: LucideIcons.bell,
              label: 'Send Mass Reminders',
            ),
            const SizedBox(width: 16),
            ClinicalGlassButton(
              onPressed: () {},
              icon: LucideIcons.download,
              label: 'Export Arrears',
              isActive: true,
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildTotalOutstandingCard() {
    return ClinicalGlassPanel(
      padding: const EdgeInsets.all(32),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Total Outstanding',
                style: PrimeCareTheme.typography.label.copyWith(color: PrimeCareTheme.colors.slateGray),
              ),
              Icon(LucideIcons.alertTriangle, color: Colors.amber.shade700, size: 20),
            ],
          ),
          const SizedBox(height: 16),
          Text(
            '\$214,850',
            style: PrimeCareTheme.typography.heroTitle.copyWith(color: PrimeCareTheme.colors.navyIndigo, fontSize: 42),
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Icon(LucideIcons.trendingUp, size: 16, color: PrimeCareTheme.colors.coralRed),
              const SizedBox(width: 4),
              Text(
                '+4.2% vs. 30 days ago',
                style: PrimeCareTheme.typography.label.copyWith(color: PrimeCareTheme.colors.coralRed, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildAgingSummaryChart() {
    return ClinicalGlassPanel(
      padding: const EdgeInsets.all(32),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Aging Summary',
            style: PrimeCareTheme.typography.h3.copyWith(color: PrimeCareTheme.colors.navyIndigo),
          ),
          const SizedBox(height: 32),
          Center(
            child: SizedBox(
              width: 220,
              height: 220,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  CustomPaint(
                    painter: _AgingChartPainter(
                      segments: [
                        _ChartSegment(value: 0.50, color: PrimeCareTheme.colors.emeraldTeal), // 1-30
                        _ChartSegment(value: 0.25, color: Colors.amber.shade600), // 31-60
                        _ChartSegment(value: 0.15, color: Colors.deepOrange.shade400), // 61-90
                        _ChartSegment(value: 0.10, color: PrimeCareTheme.colors.coralRed), // >90
                      ],
                    ),
                  ),
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text('142', style: PrimeCareTheme.typography.heroTitle.copyWith(color: PrimeCareTheme.colors.navyIndigo, fontSize: 36)),
                      Text('Accounts', style: PrimeCareTheme.typography.label.copyWith(color: PrimeCareTheme.colors.slateGray)),
                    ],
                  )
                ],
              ),
            ),
          ),
          const SizedBox(height: 32),
          _buildAgingLegendRow('1 - 30 Days', '\$107,425', PrimeCareTheme.colors.emeraldTeal),
          _buildAgingLegendRow('31 - 60 Days', '\$53,712', Colors.amber.shade600),
          _buildAgingLegendRow('61 - 90 Days', '\$32,227', Colors.deepOrange.shade400),
          _buildAgingLegendRow('90+ Days', '\$21,486', PrimeCareTheme.colors.coralRed),
        ],
      ),
    );
  }

  Widget _buildAgingLegendRow(String label, String value, Color color) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Container(width: 12, height: 12, decoration: BoxDecoration(color: color, shape: BoxShape.circle)),
              const SizedBox(width: 12),
              Text(label, style: PrimeCareTheme.typography.body.copyWith(color: PrimeCareTheme.colors.navyIndigo)),
            ],
          ),
          Text(value, style: PrimeCareTheme.typography.body.copyWith(color: PrimeCareTheme.colors.slateGray, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }

  Widget _buildAccountsInArrearsTable() {
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
                  'Accounts in Arrears',
                  style: PrimeCareTheme.typography.h3.copyWith(color: PrimeCareTheme.colors.navyIndigo),
                ),
                Container(
                  width: 300,
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
                      Text('Search accounts...', style: PrimeCareTheme.typography.body.copyWith(color: PrimeCareTheme.colors.slateGray)),
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
                Expanded(flex: 3, child: Text('CLIENT NAME', style: PrimeCareTheme.typography.label.copyWith(fontSize: 11, color: PrimeCareTheme.colors.slateGray, fontWeight: FontWeight.bold))),
                Expanded(flex: 2, child: Text('DAYS OVERDUE', style: PrimeCareTheme.typography.label.copyWith(fontSize: 11, color: PrimeCareTheme.colors.slateGray, fontWeight: FontWeight.bold))),
                Expanded(flex: 2, child: Text('AMOUNT', style: PrimeCareTheme.typography.label.copyWith(fontSize: 11, color: PrimeCareTheme.colors.slateGray, fontWeight: FontWeight.bold))),
                Expanded(flex: 2, child: Text('STATUS', style: PrimeCareTheme.typography.label.copyWith(fontSize: 11, color: PrimeCareTheme.colors.slateGray, fontWeight: FontWeight.bold))),
                Expanded(flex: 2, child: Text('LAST CONTACT', style: PrimeCareTheme.typography.label.copyWith(fontSize: 11, color: PrimeCareTheme.colors.slateGray, fontWeight: FontWeight.bold))),
                const SizedBox(width: 80), // Actions
              ],
            ),
          ),
          ..._buildAccountRows(),
        ],
      ),
    );
  }

  List<Widget> _buildAccountRows() {
    final accounts = [
      {'client': 'Regional Health Authority', 'days': 94, 'amount': '\$18,400', 'status': 'Escalated', 'contact': 'Oct 01, 2026'},
      {'client': 'Oakridge Seniors Living', 'days': 62, 'amount': '\$9,250', 'status': 'Final Notice', 'contact': 'Oct 15, 2026'},
      {'client': 'Maplewood Senior Care', 'days': 45, 'amount': '\$12,450', 'status': 'Second Notice', 'contact': 'Oct 20, 2026'},
      {'client': 'Private: Smith Family', 'days': 35, 'amount': '\$3,800', 'status': 'Promised to Pay', 'contact': 'Oct 22, 2026'},
      {'client': 'Elm Street Assisted', 'days': 20, 'amount': '\$8,900', 'status': 'First Notice', 'contact': 'Oct 25, 2026'},
      {'client': 'Sunrise Medical Group', 'days': 15, 'amount': '\$6,100', 'status': 'Friendly Reminder', 'contact': 'Oct 26, 2026'},
      {'client': 'Global Health Partners', 'days': 5, 'amount': '\$14,200', 'status': 'In Grace Period', 'contact': 'None'},
      {'client': 'City Care Services', 'days': 90, 'amount': '\$5,400', 'status': 'Collections', 'contact': 'Sep 15, 2026'},
    ];

    return accounts.asMap().entries.map((entry) {
      final account = entry.value;
      final int index = entry.key;
      final int days = account['days'] as int;
      
      Color urgencyColor;
      if (days > 90) {
        urgencyColor = PrimeCareTheme.colors.coralRed;
      } else if (days > 60) {
        urgencyColor = Colors.deepOrange.shade400;
      } else if (days > 30) {
        urgencyColor = Colors.amber.shade600;
      } else {
        urgencyColor = PrimeCareTheme.colors.emeraldTeal;
      }

      return Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
            child: Row(
              children: [
                Expanded(flex: 3, child: Text(account['client'] as String, style: PrimeCareTheme.typography.h4.copyWith(color: PrimeCareTheme.colors.navyIndigo))),
                Expanded(
                  flex: 2,
                  child: Row(
                    children: [
                      Container(width: 8, height: 8, decoration: BoxDecoration(color: urgencyColor, shape: BoxShape.circle)),
                      const SizedBox(width: 8),
                      Text('$days Days', style: PrimeCareTheme.typography.body.copyWith(color: urgencyColor, fontWeight: FontWeight.bold)),
                    ],
                  )
                ),
                Expanded(flex: 2, child: Text(account['amount'] as String, style: PrimeCareTheme.typography.body.copyWith(color: PrimeCareTheme.colors.navyIndigo))),
                Expanded(flex: 2, child: Text(account['status'] as String, style: PrimeCareTheme.typography.body.copyWith(color: PrimeCareTheme.colors.slateGray))),
                Expanded(flex: 2, child: Text(account['contact'] as String, style: PrimeCareTheme.typography.body.copyWith(color: PrimeCareTheme.colors.slateGray))),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: Icon(LucideIcons.mail, size: 18, color: PrimeCareTheme.colors.emeraldTeal),
                      onPressed: () {},
                      tooltip: 'Send Reminder',
                    ),
                    IconButton(
                      icon: Icon(LucideIcons.phoneCall, size: 18, color: PrimeCareTheme.colors.navyIndigo),
                      onPressed: () {},
                      tooltip: 'Log Call',
                    ),
                  ],
                ),
              ],
            ),
          ),
          if (index < accounts.length - 1)
            Divider(height: 1, color: PrimeCareTheme.colors.surfaceContainerHighest),
        ],
      );
    }).toList();
  }
}

class _ChartSegment {
  final double value; // 0.0 to 1.0
  final Color color;
  _ChartSegment({required this.value, required this.color});
}

class _AgingChartPainter extends CustomPainter {
  final List<_ChartSegment> segments;

  _AgingChartPainter({required this.segments});

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = math.min(size.width / 2, size.height / 2) - 15;
    final strokeWidth = 30.0;
    
    // Rotate to start from top
    double currentAngle = -math.pi / 2;

    for (int i = 0; i < segments.length; i++) {
      final sweepAngle = 2 * math.pi * segments[i].value;
      
      final paint = Paint()
        ..color = segments[i].color
        ..style = PaintingStyle.stroke
        ..strokeWidth = strokeWidth
        ..strokeCap = i == segments.length - 1 && segments[0].value == 1.0 ? StrokeCap.round : StrokeCap.butt; // Approximation

      // Add a tiny gap between segments
      final gap = 0.05;
      
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
  bool shouldRepaint(covariant _AgingChartPainter oldDelegate) {
    return true; // Simple repaint logic for now
  }
}
