import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:primecare_v4/design_system/clinical_glass.dart';
import 'package:primecare_v4/design_system/primecare_theme.dart';

class CfoAccountsPayableScreen extends ConsumerStatefulWidget {
  const CfoAccountsPayableScreen({super.key});

  @override
  ConsumerState<CfoAccountsPayableScreen> createState() =>
      _CfoAccountsPayableScreenState();
}

class _CfoAccountsPayableScreenState
    extends ConsumerState<CfoAccountsPayableScreen> {
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
              Expanded(flex: 3, child: _buildUpcomingPaymentsTable()),
              const SizedBox(width: 32),
              Expanded(flex: 2, child: _buildAgingSummary()),
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
                  LucideIcons.fileOutput,
                  color: PrimeCareTheme.colors.navyIndigo,
                  size: 28,
                ),
                const SizedBox(width: 12),
                Text(
                  'Accounts Payable',
                  style: PrimeCareTheme.typography.heroTitle.copyWith(
                    color: PrimeCareTheme.colors.navyIndigo,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              'Enterprise tracking of outgoing payments, vendor obligations, and cash utilization.',
              style: PrimeCareTheme.typography.body.copyWith(
                color: PrimeCareTheme.colors.slateGray,
              ),
            ),
          ],
        ),
        ClinicalGlassButton(
          onPressed: () {},
          icon: LucideIcons.calendar,
          label: 'As of Today',
          isActive: false,
        ),
      ],
    );
  }

  Widget _buildKPIs() {
    return Row(
      children: [
        Expanded(
          child: _buildMetricCard(
            title: 'Total Accounts Payable',
            value: '\$1.4M',
            icon: LucideIcons.creditCard,
            trend: '+2.1% vs Last Month',
            isWarning: true,
          ),
        ),
        const SizedBox(width: 24),
        Expanded(
          child: _buildMetricCard(
            title: 'Days Payable Outstanding',
            value: '28 Days',
            icon: LucideIcons.calendarClock,
            trend: 'Optimized Cash Flow',
            isPositive: true,
          ),
        ),
        const SizedBox(width: 24),
        Expanded(
          child: _buildMetricCard(
            title: 'Current (0-30 Days)',
            value: '\$1.2M',
            icon: LucideIcons.checkCircle,
            trend: '85% of Total AP',
            isPositive: true,
          ),
        ),
        const SizedBox(width: 24),
        Expanded(
          child: _buildMetricCard(
            title: 'Payments Due This Week',
            value: '\$450K',
            icon: LucideIcons.clock,
            trend: 'Scheduled for Friday',
            isNeutral: true,
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
      trendColor = const Color(0xFFE11D48); // Ruby Red
      iconColor = const Color(0xFFE11D48);
    } else if (isPositive) {
      trendColor = PrimeCareTheme.colors.emeraldTeal;
      iconColor = PrimeCareTheme.colors.emeraldTeal;
    } else if (isNeutral) {
      trendColor = Colors.amber.shade700;
      iconColor = Colors.amber.shade700;
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

  Widget _buildAgingSummary() {
    return ClinicalGlassPanel(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'AP Aging Summary',
            style: PrimeCareTheme.typography.h3.copyWith(
              color: PrimeCareTheme.colors.navyIndigo,
            ),
          ),
          const SizedBox(height: 24),
          _buildAgingRow(
            'Current (0-30 Days)',
            '\$1,200,000',
            85,
            PrimeCareTheme.colors.emeraldTeal,
          ),
          const SizedBox(height: 16),
          _buildAgingRow('31-60 Days', '\$150,000', 10, Colors.amber.shade600),
          const SizedBox(height: 16),
          _buildAgingRow('61-90 Days', '\$35,000', 3, Colors.orange.shade700),
          const SizedBox(height: 16),
          _buildAgingRow('>90 Days', '\$15,000', 2, const Color(0xFFE11D48)),
        ],
      ),
    );
  }

  Widget _buildAgingRow(
    String bucket,
    String amount,
    int percentage,
    Color color,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              bucket,
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

  Widget _buildUpcomingPaymentsTable() {
    return ClinicalGlassPanel(
      padding: EdgeInsets.zero,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(24.0),
            child: Text(
              'Upcoming Scheduled Payments',
              style: PrimeCareTheme.typography.h3.copyWith(
                color: PrimeCareTheme.colors.navyIndigo,
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
            color: PrimeCareTheme.colors.surfaceContainerLow,
            child: Row(
              children: [
                Expanded(
                  flex: 3,
                  child: Text(
                    'VENDOR',
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
                    'DUE DATE',
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
                    'AMOUNT',
                    textAlign: TextAlign.right,
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
                    textAlign: TextAlign.right,
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
          _buildPaymentRow(
            'Colliers Real Estate',
            'Apr 10, 2026',
            '\$125,000',
            'Scheduled',
          ),
          Divider(
            height: 1,
            color: PrimeCareTheme.colors.surfaceContainerHighest,
          ),
          _buildPaymentRow(
            'AWS Web Services',
            'Apr 12, 2026',
            '\$42,500',
            'Scheduled',
          ),
          Divider(
            height: 1,
            color: PrimeCareTheme.colors.surfaceContainerHighest,
          ),
          _buildPaymentRow(
            'McCarthy Tétrault',
            'Apr 15, 2026',
            '\$85,000',
            'Pending Approval',
          ),
          Divider(
            height: 1,
            color: PrimeCareTheme.colors.surfaceContainerHighest,
          ),
          _buildPaymentRow(
            'Salesforce Enterprise',
            'Apr 20, 2026',
            '\$18,400',
            'Scheduled',
          ),
          Divider(
            height: 1,
            color: PrimeCareTheme.colors.surfaceContainerHighest,
          ),
          _buildPaymentRow(
            'Delta Airlines',
            'Apr 22, 2026',
            '\$38,200',
            'Pending Approval',
          ),
          const SizedBox(height: 8),
        ],
      ),
    );
  }

  Widget _buildPaymentRow(
    String vendor,
    String date,
    String amount,
    String status,
  ) {
    Color statusColor = PrimeCareTheme.colors.emeraldTeal;
    if (status == 'Pending Approval') {
      statusColor = Colors.amber.shade700;
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            flex: 3,
            child: Text(
              vendor,
              style: PrimeCareTheme.typography.body.copyWith(
                color: PrimeCareTheme.colors.navyIndigo,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Text(
              date,
              style: PrimeCareTheme.typography.body.copyWith(
                color: PrimeCareTheme.colors.slateGray,
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Text(
              amount,
              textAlign: TextAlign.right,
              style: PrimeCareTheme.typography.body.copyWith(
                color: PrimeCareTheme.colors.navyIndigo,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Align(
              alignment: Alignment.centerRight,
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
                  status,
                  style: PrimeCareTheme.typography.label.copyWith(
                    color: statusColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
