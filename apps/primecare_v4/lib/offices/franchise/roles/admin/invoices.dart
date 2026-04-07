import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:primecare_v4/design_system/clinical_glass.dart';
import 'package:primecare_v4/design_system/primecare_theme.dart';

class FranchiseInvoicesScreen extends ConsumerStatefulWidget {
  const FranchiseInvoicesScreen({super.key});

  @override
  ConsumerState<FranchiseInvoicesScreen> createState() =>
      _FranchiseInvoicesScreenState();
}

class _FranchiseInvoicesScreenState
    extends ConsumerState<FranchiseInvoicesScreen> {
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
          _buildInvoicesTable(),
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
              'Invoices Dashboard',
              style: PrimeCareTheme.typography.heroTitle.copyWith(
                color: PrimeCareTheme.colors.navyIndigo,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Track outbound client and corporate invoices, review payment statuses, and manage billing activity.',
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
              label: 'Export CSV',
            ),
            const SizedBox(width: 16),
            ClinicalGlassButton(
              onPressed: () {},
              icon: LucideIcons.plus,
              label: 'Create Invoice',
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
            title: 'Monthly Billed',
            value: '\$142,500',
            trend: '+8.4%',
            positiveTrend: true,
          ),
        ),
        const SizedBox(width: 24),
        Expanded(
          child: _buildMetricCard(
            title: 'Total Collected',
            value: '\$118,200',
            trend: '+12.1%',
            positiveTrend: true,
          ),
        ),
        const SizedBox(width: 24),
        Expanded(
          child: _buildMetricCard(
            title: 'Outstanding',
            value: '\$24,300',
            trend: '-2.5%',
            positiveTrend: true, // Less outstanding is better
          ),
        ),
        const SizedBox(width: 24),
        Expanded(
          child: _buildMetricCard(
            title: 'Overdue (>30d)',
            value: '\$4,500',
            trend: '+1.2%',
            positiveTrend: false, // More overdue is bad
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
                '$trend vs. Last Month',
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

  Widget _buildInvoicesTable() {
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
                  'Recent Invoices',
                  style: PrimeCareTheme.typography.h3.copyWith(
                    color: PrimeCareTheme.colors.navyIndigo,
                  ),
                ),
                Row(
                  children: [
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
                            'Search invoices...',
                            style: PrimeCareTheme.typography.body.copyWith(
                              color: PrimeCareTheme.colors.slateGray,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 16),
                    ClinicalGlassButton(
                      onPressed: () {},
                      icon: LucideIcons.filter,
                      label: 'Filter',
                    ),
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
                    'INVOICE ID',
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
                    'RECIPIENT',
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
                    'DATE ISSUED',
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
                const SizedBox(width: 32), // Actions spacer
              ],
            ),
          ),
          ..._buildInvoiceRows(),
        ],
      ),
    );
  }

  List<Widget> _buildInvoiceRows() {
    final invoices = [
      {
        'id': 'INV-2026-0045',
        'recipient': 'Maplewood Senior Care',
        'date': 'Oct 15, 2026',
        'due': 'Nov 14, 2026',
        'amount': '\$12,450.00',
        'status': 'Pending',
      },
      {
        'id': 'INV-2026-0044',
        'recipient': 'Dr. Robert Chen Family Practice',
        'date': 'Oct 12, 2026',
        'due': 'Oct 26, 2026',
        'amount': '\$1,850.00',
        'status': 'Paid',
      },
      {
        'id': 'INV-2026-0043',
        'recipient': 'Elm Street Assisted Living',
        'date': 'Oct 05, 2026',
        'due': 'Nov 04, 2026',
        'amount': '\$8,900.00',
        'status': 'Pending',
      },
      {
        'id': 'INV-2026-0042',
        'recipient': 'Regional Health Authority',
        'date': 'Sep 28, 2026',
        'due': 'Oct 28, 2026',
        'amount': '\$45,200.00',
        'status': 'Paid',
      },
      {
        'id': 'INV-2026-0041',
        'recipient': 'Oasis Rehabilitation Center',
        'date': 'Sep 15, 2026',
        'due': 'Oct 15, 2026',
        'amount': '\$6,420.00',
        'status': 'Overdue',
      },
      {
        'id': 'INV-2026-0040',
        'recipient': 'Private Client: Smith Family',
        'date': 'Sep 10, 2026',
        'due': 'Sep 24, 2026',
        'amount': '\$850.00',
        'status': 'Cancelled',
      },
      {
        'id': 'INV-2026-0039',
        'recipient': 'Sunrise Medical Group',
        'date': 'Sep 05, 2026',
        'due': 'Oct 05, 2026',
        'amount': '\$14,100.00',
        'status': 'Paid',
      },
    ];

    return invoices.asMap().entries.map((entry) {
      final invoice = entry.value;
      final int index = entry.key;

      Color statusColor;
      switch (invoice['status']) {
        case 'Paid':
          statusColor = PrimeCareTheme.colors.emeraldTeal;
          break;
        case 'Pending':
          statusColor = Colors.amber.shade700;
          break;
        case 'Overdue':
          statusColor = PrimeCareTheme.colors.coralRed;
          break;
        case 'Cancelled':
          statusColor = PrimeCareTheme.colors.slateGray;
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
                    invoice['id'] as String,
                    style: PrimeCareTheme.typography.h4.copyWith(
                      color: PrimeCareTheme.colors.navyIndigo,
                    ),
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: Text(
                    invoice['recipient'] as String,
                    style: PrimeCareTheme.typography.body.copyWith(
                      color: PrimeCareTheme.colors.navyIndigo,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Text(
                    invoice['date'] as String,
                    style: PrimeCareTheme.typography.body.copyWith(
                      color: PrimeCareTheme.colors.slateGray,
                    ),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Text(
                    invoice['due'] as String,
                    style: PrimeCareTheme.typography.body.copyWith(
                      color: invoice['status'] == 'Overdue'
                          ? PrimeCareTheme.colors.coralRed
                          : PrimeCareTheme.colors.slateGray,
                      fontWeight: invoice['status'] == 'Overdue'
                          ? FontWeight.bold
                          : FontWeight.normal,
                    ),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Text(
                    invoice['amount'] as String,
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
                        invoice['status'] as String,
                        style: PrimeCareTheme.typography.label.copyWith(
                          color: statusColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
                Icon(
                  LucideIcons.moreHorizontal,
                  size: 20,
                  color: PrimeCareTheme.colors.slateGray,
                ),
              ],
            ),
          ),
          if (index < invoices.length - 1)
            Divider(
              height: 1,
              color: PrimeCareTheme.colors.surfaceContainerHighest,
            ),
        ],
      );
    }).toList();
  }
}
