import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:primecare_v4/design_system/clinical_glass.dart';
import 'package:primecare_v4/design_system/primecare_theme.dart';

class FranchiseRefundsScreen extends ConsumerStatefulWidget {
  const FranchiseRefundsScreen({super.key});

  @override
  ConsumerState<FranchiseRefundsScreen> createState() =>
      _FranchiseRefundsScreenState();
}

class _FranchiseRefundsScreenState
    extends ConsumerState<FranchiseRefundsScreen> {
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
              Expanded(flex: 3, child: _buildRefundsTable()),
              const SizedBox(width: 32),
              Expanded(
                flex: 1,
                child: Column(
                  children: [
                    _buildPendingApprovalsWidget(),
                    const SizedBox(height: 32),
                    _buildRefundPolicyHelpWidget(),
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
                  LucideIcons.undo2,
                  color: PrimeCareTheme.colors.navyIndigo,
                  size: 28,
                ),
                const SizedBox(width: 12),
                Text(
                  'Refunds Management',
                  style: PrimeCareTheme.typography.heroTitle.copyWith(
                    color: PrimeCareTheme.colors.navyIndigo,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              'Manage issued and pending client refunds and adjudications.',
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
              label: 'Export Ledger',
            ),
            const SizedBox(width: 16),
            ClinicalGlassButton(
              onPressed: () {},
              icon: LucideIcons.plus,
              label: 'Initiate Refund',
              isActive: true, // Primary action
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
            title: 'Total Refunded MTD',
            value: '\$4,250',
            icon: LucideIcons.history,
            trend: '+5%',
            positiveTrend: false, // More refunds is negative
          ),
        ),
        const SizedBox(width: 24),
        Expanded(
          child: _buildMetricCard(
            title: 'Pending Approvals',
            value: '3',
            icon: LucideIcons.clipboardCheck,
            trend: 'Action Required',
            positiveTrend: null,
          ),
        ),
        const SizedBox(width: 24),
        Expanded(
          child: _buildMetricCard(
            title: 'Avg Processing Time',
            value: '2.4 days',
            icon: LucideIcons.clock,
            trend: '-0.3 days',
            positiveTrend: true, // Shorter time is better
          ),
        ),
        const SizedBox(width: 24),
        Expanded(
          child: _buildMetricCard(
            title: 'Refund Rate',
            value: '0.8%',
            icon: LucideIcons.percent,
            trend: '-0.1%',
            positiveTrend: true, // Lower rate is better
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
    required bool? positiveTrend,
  }) {
    Color trendColor = PrimeCareTheme.colors.slateGray;
    IconData? trendIcon;

    if (positiveTrend != null) {
      trendColor = positiveTrend
          ? PrimeCareTheme.colors.emeraldTeal
          : PrimeCareTheme.colors.coralRed;
      trendIcon = trend.startsWith('+')
          ? LucideIcons.trendingUp
          : LucideIcons.trendingDown;
    } else {
      trendColor = Colors.amber.shade700;
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
              if (trendIcon != null) ...[
                Icon(trendIcon, size: 16, color: trendColor),
                const SizedBox(width: 4),
              ],
              Text(
                positiveTrend == null ? trend : '$trend vs. Prior Month',
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

  Widget _buildRefundsTable() {
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
                  'Recent Refunds',
                  style: PrimeCareTheme.typography.h3.copyWith(
                    color: PrimeCareTheme.colors.navyIndigo,
                  ),
                ),
                Container(
                  width: 250,
                  decoration: BoxDecoration(
                    color: PrimeCareTheme.colors.surfaceContainerLow,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: PrimeCareTheme.colors.surfaceContainerHighest,
                    ),
                  ),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 12,
                  ),
                  child: Row(
                    children: [
                      Icon(
                        LucideIcons.search,
                        size: 18,
                        color: PrimeCareTheme.colors.slateGray,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        'Search refunds...',
                        style: PrimeCareTheme.typography.body.copyWith(
                          color: PrimeCareTheme.colors.slateGray,
                        ),
                      ),
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
                Expanded(
                  flex: 2,
                  child: Text(
                    'REFUND ID',
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
                    'CLIENT',
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
                    'ORIGINAL INVOICE',
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
                    'REASON',
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
              ],
            ),
          ),
          ..._buildRefundRows(),
        ],
      ),
    );
  }

  List<Widget> _buildRefundRows() {
    final refunds = [
      {
        'id': 'REF-1094',
        'client': 'Private: Smith Family',
        'invoice': 'INV-40921',
        'reason': 'Overpayment',
        'amount': '\$150.00',
        'status': 'Pending',
      },
      {
        'id': 'REF-1093',
        'client': 'Regional Health Authority',
        'invoice': 'INV-40850',
        'reason': 'Duplicate Payment',
        'amount': '\$4,200.00',
        'status': 'Processed',
      },
      {
        'id': 'REF-1092',
        'client': 'Medicare',
        'invoice': 'INV-40522',
        'reason': 'Services Cancelled',
        'amount': '\$850.00',
        'status': 'Processed',
      },
      {
        'id': 'REF-1091',
        'client': 'Private: J. Doe',
        'invoice': 'INV-40411',
        'reason': 'Billing Error',
        'amount': '\$50.00',
        'status': 'Processed',
      },
      {
        'id': 'REF-1090',
        'client': 'Elm Street Assisted',
        'invoice': 'INV-40398',
        'reason': 'Overpayment',
        'amount': '\$320.00',
        'status': 'Failed',
      },
      {
        'id': 'REF-1089',
        'client': 'Private: A. Turing',
        'invoice': 'INV-40210',
        'reason': 'Appeal Adjusted',
        'amount': '\$1,200.00',
        'status': 'Processed',
      },
    ];

    return refunds.asMap().entries.map((entry) {
      final refund = entry.value;
      final int index = entry.key;

      Color statusColor;
      switch (refund['status']) {
        case 'Processed':
          statusColor = PrimeCareTheme.colors.emeraldTeal;
          break;
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
                Expanded(
                  flex: 2,
                  child: Text(
                    refund['id'] as String,
                    style: PrimeCareTheme.typography.h4.copyWith(
                      color: PrimeCareTheme.colors.navyIndigo,
                    ),
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: Text(
                    refund['client'] as String,
                    style: PrimeCareTheme.typography.body.copyWith(
                      color: PrimeCareTheme.colors.navyIndigo,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Text(
                    refund['invoice'] as String,
                    style: PrimeCareTheme.typography.body.copyWith(
                      color: PrimeCareTheme.colors.slateGray,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: Text(
                    refund['reason'] as String,
                    style: PrimeCareTheme.typography.body.copyWith(
                      color: PrimeCareTheme.colors.slateGray,
                    ),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Text(
                    refund['amount'] as String,
                    style: PrimeCareTheme.typography.body.copyWith(
                      color: PrimeCareTheme.colors.navyIndigo,
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
                        refund['status'] as String,
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
          ),
          if (index < refunds.length - 1)
            Divider(
              height: 1,
              color: PrimeCareTheme.colors.surfaceContainerHighest,
            ),
        ],
      );
    }).toList();
  }

  Widget _buildPendingApprovalsWidget() {
    return ClinicalGlassPanel(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                LucideIcons.clipboardCheck,
                color: Colors.amber.shade700,
                size: 24,
              ),
              const SizedBox(width: 12),
              Text(
                'Awaiting Approval',
                style: PrimeCareTheme.typography.h3.copyWith(
                  color: PrimeCareTheme.colors.navyIndigo,
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          _buildApprovalItem('REF-1094', 'Private: Smith Family', '\$150.00'),
          const SizedBox(height: 16),
          _buildApprovalItem(
            'REF-1095',
            'Global Health Partners',
            '\$2,400.00',
          ),
          const SizedBox(height: 16),
          _buildApprovalItem('REF-1096', 'Medicare', '\$450.00'),
        ],
      ),
    );
  }

  Widget _buildApprovalItem(String id, String client, String amount) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: PrimeCareTheme.colors.surfaceContainerLow,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: PrimeCareTheme.colors.surfaceContainerHighest,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                id,
                style: PrimeCareTheme.typography.label.copyWith(
                  color: PrimeCareTheme.colors.slateGray,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                amount,
                style: PrimeCareTheme.typography.h4.copyWith(
                  color: PrimeCareTheme.colors.navyIndigo,
                ),
              ),
            ],
          ),
          const SizedBox(height: 4),
          Text(
            client,
            style: PrimeCareTheme.typography.body.copyWith(
              color: PrimeCareTheme.colors.navyIndigo,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: ClinicalGlassButton(
                  onPressed: () {},
                  icon: LucideIcons.x,
                  label: 'Decline',
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: ClinicalGlassButton(
                  onPressed: () {},
                  icon: LucideIcons.check,
                  label: 'Approve',
                  isActive: true,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildRefundPolicyHelpWidget() {
    return ClinicalGlassPanel(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                LucideIcons.fileQuestion,
                color: PrimeCareTheme.colors.slateGray,
                size: 24,
              ),
              const SizedBox(width: 12),
              Text(
                'Refund Policies',
                style: PrimeCareTheme.typography.h3.copyWith(
                  color: PrimeCareTheme.colors.navyIndigo,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Text(
            'Refunds exceeding \$1,000 must be approved by the Finance Director. Process times depend on the original payment method.',
            style: PrimeCareTheme.typography.body.copyWith(
              color: PrimeCareTheme.colors.slateGray,
            ),
          ),
          const SizedBox(height: 24),
          SizedBox(
            width: double.infinity,
            child: ClinicalGlassButton(
              onPressed: () {},
              icon: LucideIcons.externalLink,
              label: 'View Full Policy Guide',
            ),
          ),
        ],
      ),
    );
  }
}
