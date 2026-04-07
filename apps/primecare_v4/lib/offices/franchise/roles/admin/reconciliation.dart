import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:primecare_v4/design_system/clinical_glass.dart';
import 'package:primecare_v4/design_system/primecare_theme.dart';
import 'dart:math' as math;

class FranchiseReconciliationScreen extends ConsumerStatefulWidget {
  const FranchiseReconciliationScreen({super.key});

  @override
  ConsumerState<FranchiseReconciliationScreen> createState() =>
      _FranchiseReconciliationScreenState();
}

class _FranchiseReconciliationScreenState
    extends ConsumerState<FranchiseReconciliationScreen> {
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
              Expanded(flex: 3, child: _buildReconciliationLedger()),
              const SizedBox(width: 32),
              Expanded(
                flex: 1,
                child: Column(
                  children: [
                    _buildMatchingSummaryChart(),
                    const SizedBox(height: 32),
                    _buildNextStepsWidget(),
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
                  LucideIcons.gitMerge,
                  color: PrimeCareTheme.colors.navyIndigo,
                  size: 28,
                ),
                const SizedBox(width: 12),
                Text(
                  'Reconciliation',
                  style: PrimeCareTheme.typography.heroTitle.copyWith(
                    color: PrimeCareTheme.colors.navyIndigo,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              'Reconcile expected payments vs actual clearinghouse deposits.',
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
              icon: LucideIcons.refreshCw,
              label: 'Sync Bank Feed',
            ),
            const SizedBox(width: 16),
            ClinicalGlassButton(
              onPressed: () {},
              icon: LucideIcons.checkCircle2,
              label: 'Run Auto-Match',
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
            title: 'Expected Deposits',
            value: '\$145,200',
            icon: LucideIcons.fileText,
            subtext: 'Based on cleared invoices',
          ),
        ),
        const SizedBox(width: 24),
        Expanded(
          child: _buildMetricCard(
            title: 'Actual Bank Feed',
            value: '\$142,850',
            icon: LucideIcons.landmark,
            subtext: 'Last synced 2h ago',
          ),
        ),
        const SizedBox(width: 24),
        Expanded(
          child: _buildDiscrepancyCard(
            title: 'Discrepancy',
            value: '-\$2,350',
            icon: LucideIcons.alertOctagon,
            isAlert: true,
          ),
        ),
        const SizedBox(width: 24),
        Expanded(
          child: _buildMetricCard(
            title: 'Unmatched Items',
            value: '14',
            icon: LucideIcons.helpCircle,
            subtext: 'Requires manual review',
            isWarning: true,
          ),
        ),
      ],
    );
  }

  Widget _buildMetricCard({
    required String title,
    required String value,
    required IconData icon,
    required String subtext,
    bool isWarning = false,
  }) {
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
                icon,
                color: isWarning
                    ? Colors.amber.shade700
                    : PrimeCareTheme.colors.navyIndigo,
                size: 20,
              ),
            ],
          ),
          const SizedBox(height: 16),
          Text(
            value,
            style: PrimeCareTheme.typography.h1.copyWith(
              color: isWarning
                  ? Colors.amber.shade700
                  : PrimeCareTheme.colors.navyIndigo,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            subtext,
            style: PrimeCareTheme.typography.label.copyWith(
              color: PrimeCareTheme.colors.slateGray,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDiscrepancyCard({
    required String title,
    required String value,
    required IconData icon,
    required bool isAlert,
  }) {
    final alertColor = PrimeCareTheme.colors.coralRed;
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
                  color: isAlert ? alertColor : PrimeCareTheme.colors.slateGray,
                ),
              ),
              Icon(
                icon,
                color: isAlert ? alertColor : PrimeCareTheme.colors.navyIndigo,
                size: 20,
              ),
            ],
          ),
          const SizedBox(height: 16),
          Text(
            value,
            style: PrimeCareTheme.typography.h1.copyWith(
              color: isAlert ? alertColor : PrimeCareTheme.colors.navyIndigo,
            ),
          ),
          const SizedBox(height: 8),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: alertColor.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              'Requires Investigation',
              style: PrimeCareTheme.typography.label.copyWith(
                color: alertColor,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildReconciliationLedger() {
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
                  'Reconciliation Ledger',
                  style: PrimeCareTheme.typography.h3.copyWith(
                    color: PrimeCareTheme.colors.navyIndigo,
                  ),
                ),
                Row(
                  children: [
                    _buildFilterChip('All', false),
                    const SizedBox(width: 8),
                    _buildFilterChip('Matched', false),
                    const SizedBox(width: 8),
                    _buildFilterChip('Discrepancy', true),
                  ],
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
            color: PrimeCareTheme.colors.surfaceContainerLow,
            child: Row(
              children: [
                Expanded(
                  flex: 2,
                  child: Text(
                    'DATE',
                    style: PrimeCareTheme.typography.label.copyWith(
                      fontSize: 11,
                      color: PrimeCareTheme.colors.slateGray,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: Text(
                    'PAYER / DESCRIPTION',
                    style: PrimeCareTheme.typography.label.copyWith(
                      fontSize: 11,
                      color: PrimeCareTheme.colors.slateGray,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Text(
                    'EXPECTED',
                    style: PrimeCareTheme.typography.label.copyWith(
                      fontSize: 11,
                      color: PrimeCareTheme.colors.slateGray,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Text(
                    'ACTUAL (BANK)',
                    style: PrimeCareTheme.typography.label.copyWith(
                      fontSize: 11,
                      color: PrimeCareTheme.colors.slateGray,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Text(
                    'VARIANCE',
                    style: PrimeCareTheme.typography.label.copyWith(
                      fontSize: 11,
                      color: PrimeCareTheme.colors.slateGray,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Text(
                    'STATUS',
                    style: PrimeCareTheme.typography.label.copyWith(
                      fontSize: 11,
                      color: PrimeCareTheme.colors.slateGray,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(
                  width: 80,
                  child: Text(
                    'ACTION',
                    textAlign: TextAlign.center,
                    style: PrimeCareTheme.typography.label.copyWith(
                      fontSize: 11,
                      color: PrimeCareTheme.colors.slateGray,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
          ..._buildLedgerRows(),
        ],
      ),
    );
  }

  Widget _buildFilterChip(String label, bool isActive) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: isActive ? PrimeCareTheme.colors.navyIndigo : Colors.transparent,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: isActive
              ? PrimeCareTheme.colors.navyIndigo
              : PrimeCareTheme.colors.surfaceContainerHighest,
        ),
      ),
      child: Text(
        label,
        style: PrimeCareTheme.typography.label.copyWith(
          color: isActive ? Colors.white : PrimeCareTheme.colors.slateGray,
          fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
        ),
      ),
    );
  }

  List<Widget> _buildLedgerRows() {
    final entries = [
      {
        'date': 'Oct 26',
        'desc': 'Medicare Batched Payment',
        'expected': '\$45,200.00',
        'actual': '\$45,200.00',
        'variance': '\$0.00',
        'status': 'Matched',
      },
      {
        'date': 'Oct 26',
        'desc': 'Regional Health Authority',
        'expected': '\$18,400.00',
        'actual': '\$16,050.00',
        'variance': '-\$2,350.00',
        'status': 'Discrepancy',
      },
      {
        'date': 'Oct 25',
        'desc': 'Blue Cross Shield',
        'expected': '\$12,100.00',
        'actual': '\$12,100.00',
        'variance': '\$0.00',
        'status': 'Matched',
      },
      {
        'date': 'Oct 25',
        'desc': 'Private: Aetna',
        'expected': '\$5,400.00',
        'actual': '\$5,400.00',
        'variance': '\$0.00',
        'status': 'Matched',
      },
      {
        'date': 'Oct 24',
        'desc': 'Unknown Origin EFT',
        'expected': '\$0.00',
        'actual': '\$1,250.00',
        'variance': '+\$1,250.00',
        'status': 'Unmatched',
      },
      {
        'date': 'Oct 23',
        'desc': 'Global Health Partners',
        'expected': '\$12,450.00',
        'actual': '\$12,450.00',
        'variance': '\$0.00',
        'status': 'Matched',
      },
    ];

    return entries.asMap().entries.map((entry) {
      final data = entry.value;
      final int index = entry.key;

      Color statusColor;
      Color varianceColor = PrimeCareTheme.colors.slateGray;

      switch (data['status']) {
        case 'Matched':
          statusColor = PrimeCareTheme.colors.emeraldTeal;
          break;
        case 'Discrepancy':
          statusColor = PrimeCareTheme.colors.coralRed;
          varianceColor = PrimeCareTheme.colors.coralRed;
          break;
        case 'Unmatched':
          statusColor = Colors.amber.shade700;
          varianceColor = Colors.amber.shade700;
          break;
        default:
          statusColor = PrimeCareTheme.colors.navyIndigo;
      }

      return Column(
        children: [
          Container(
            color: data['status'] == 'Discrepancy'
                ? PrimeCareTheme.colors.coralRed.withValues(alpha: 0.05)
                : Colors.transparent,
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
            child: Row(
              children: [
                Expanded(
                  flex: 2,
                  child: Text(
                    data['date'] as String,
                    style: PrimeCareTheme.typography.body.copyWith(
                      color: PrimeCareTheme.colors.slateGray,
                    ),
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: Text(
                    data['desc'] as String,
                    style: PrimeCareTheme.typography.body.copyWith(
                      color: PrimeCareTheme.colors.navyIndigo,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Text(
                    data['expected'] as String,
                    style: PrimeCareTheme.typography.body.copyWith(
                      color: PrimeCareTheme.colors.navyIndigo,
                    ),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Text(
                    data['actual'] as String,
                    style: PrimeCareTheme.typography.body.copyWith(
                      color: PrimeCareTheme.colors.navyIndigo,
                    ),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Text(
                    data['variance'] as String,
                    style: PrimeCareTheme.typography.body.copyWith(
                      color: varianceColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: statusColor.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        data['status'] as String,
                        style: PrimeCareTheme.typography.label.copyWith(
                          color: statusColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: 80,
                  child: Align(
                    alignment: Alignment.center,
                    child: IconButton(
                      icon: Icon(
                        LucideIcons.moreHorizontal,
                        color: PrimeCareTheme.colors.slateGray,
                      ),
                      onPressed: () {},
                    ),
                  ),
                ),
              ],
            ),
          ),
          if (index < entries.length - 1)
            Divider(
              height: 1,
              color: PrimeCareTheme.colors.surfaceContainerHighest,
            ),
        ],
      );
    }).toList();
  }

  Widget _buildMatchingSummaryChart() {
    return ClinicalGlassPanel(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Matching Summary',
                style: PrimeCareTheme.typography.h3.copyWith(
                  color: PrimeCareTheme.colors.navyIndigo,
                ),
              ),
              Icon(
                LucideIcons.pieChart,
                color: PrimeCareTheme.colors.slateGray,
                size: 20,
              ),
            ],
          ),
          const SizedBox(height: 32),
          Center(
            child: SizedBox(
              width: 160,
              height: 160,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  CustomPaint(
                    painter: _ReconChartPainter(
                      segments: [
                        _ChartSegment(
                          value: 0.85,
                          color: PrimeCareTheme.colors.emeraldTeal,
                        ),
                        _ChartSegment(
                          value: 0.10,
                          color: Colors.amber.shade500,
                        ),
                        _ChartSegment(
                          value: 0.05,
                          color: PrimeCareTheme.colors.coralRed,
                        ),
                      ],
                    ),
                  ),
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        '85%',
                        style: PrimeCareTheme.typography.h2.copyWith(
                          color: PrimeCareTheme.colors.navyIndigo,
                          fontSize: 28,
                        ),
                      ),
                      Text(
                        'Matched',
                        style: PrimeCareTheme.typography.label.copyWith(
                          color: PrimeCareTheme.colors.slateGray,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 32),
          _buildMethodLegendRow(
            'Auto-Matched',
            '85%',
            PrimeCareTheme.colors.emeraldTeal,
          ),
          _buildMethodLegendRow(
            'Unmatched (Review)',
            '10%',
            Colors.amber.shade500,
          ),
          _buildMethodLegendRow(
            'Discrepancy (Error)',
            '5%',
            PrimeCareTheme.colors.coralRed,
          ),
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
              Container(
                width: 10,
                height: 10,
                decoration: BoxDecoration(
                  color: color,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              const SizedBox(width: 12),
              Text(
                label,
                style: PrimeCareTheme.typography.body.copyWith(
                  color: PrimeCareTheme.colors.navyIndigo,
                ),
              ),
            ],
          ),
          Text(
            value,
            style: PrimeCareTheme.typography.body.copyWith(
              color: PrimeCareTheme.colors.slateGray,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNextStepsWidget() {
    return ClinicalGlassPanel(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                LucideIcons.listTodo,
                color: PrimeCareTheme.colors.navyIndigo,
                size: 24,
              ),
              const SizedBox(width: 12),
              Text(
                'Required Actions',
                style: PrimeCareTheme.typography.h3.copyWith(
                  color: PrimeCareTheme.colors.navyIndigo,
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          _buildActionItem(
            'Clear \$2,350 Discrepancy',
            'Regional Health Authority deposit was short paid. Investigate remittance advice.',
            LucideIcons.alertCircle,
            PrimeCareTheme.colors.coralRed,
          ),
          const SizedBox(height: 16),
          _buildActionItem(
            'Allocate \$1,250 Deposit',
            'Unknown deposit requires manual mapping to an open invoice.',
            LucideIcons.helpCircle,
            Colors.amber.shade700,
          ),
        ],
      ),
    );
  }

  Widget _buildActionItem(
    String title,
    String desc,
    IconData icon,
    Color color,
  ) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: PrimeCareTheme.colors.surfaceContainerLow,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: PrimeCareTheme.colors.surfaceContainerHighest,
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: color, size: 20),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: PrimeCareTheme.typography.h4.copyWith(
                    color: PrimeCareTheme.colors.navyIndigo,
                    fontSize: 13,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  desc,
                  style: PrimeCareTheme.typography.label.copyWith(
                    color: PrimeCareTheme.colors.slateGray,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Resolve Now ↗',
                  style: PrimeCareTheme.typography.label.copyWith(
                    color: PrimeCareTheme.colors.emeraldTeal,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _ChartSegment {
  final double value;
  final Color color;
  _ChartSegment({required this.value, required this.color});
}

class _ReconChartPainter extends CustomPainter {
  final List<_ChartSegment> segments;

  _ReconChartPainter({required this.segments});

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius =
        math.min(size.width / 2, size.height / 2) - 8; // Donut thickness
    final strokeWidth = 16.0;

    double currentAngle = -math.pi / 2;

    for (int i = 0; i < segments.length; i++) {
      final sweepAngle = 2 * math.pi * segments[i].value;

      final paint = Paint()
        ..color = segments[i].color
        ..style = PaintingStyle.stroke
        ..strokeWidth = strokeWidth
        ..strokeCap = StrokeCap.round;

      final gap = 0.08;

      canvas.drawArc(
        Rect.fromCircle(center: center, radius: radius),
        currentAngle + (gap / 2),
        sweepAngle - gap,
        false,
        paint,
      );

      currentAngle += sweepAngle;
    }
  }

  @override
  bool shouldRepaint(covariant _ReconChartPainter oldDelegate) {
    return true;
  }
}
