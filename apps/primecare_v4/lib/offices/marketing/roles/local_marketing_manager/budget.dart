import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:primecare_v4/design_system/clinical_glass.dart';
import 'package:primecare_v4/design_system/primecare_theme.dart';

class LocalBudgetScreen extends ConsumerStatefulWidget {
  const LocalBudgetScreen({super.key});

  @override
  ConsumerState<LocalBudgetScreen> createState() => _LocalBudgetScreenState();
}

class _LocalBudgetScreenState extends ConsumerState<LocalBudgetScreen> {
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
            _buildMetricsRow(),
            const SizedBox(height: 32),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(flex: 3, child: _buildRecentExpensesList()),
                const SizedBox(width: 24),
                Expanded(flex: 2, child: _buildCategoryBreakdown()),
              ],
            )
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
              'Local Marketing Budget',
              style: PrimeCareTheme.typography.heroTitle.copyWith(
                color: PrimeCareTheme.colors.navyIndigo,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Manage your Q3 clinic marketing allocation, track ad spend, and submit expenses.',
              style: PrimeCareTheme.typography.body.copyWith(
                color: PrimeCareTheme.colors.slateGray,
              ),
            ),
          ],
        ),
        ClinicalGlassButton(
          onPressed: () {},
          icon: LucideIcons.plus,
          label: 'Submit Expense',
          isActive: true,
        ),
      ],
    );
  }

  Widget _buildMetricsRow() {
    return Row(
      children: [
        Expanded(
          child: _buildMetricCard(
            'Q3 Allocated Budget',
            '\$12,500',
            'Jul 1 - Sep 30',
            LucideIcons.dollarSign,
            PrimeCareTheme.colors.slateGray,
          ),
        ),
        const SizedBox(width: 24),
        Expanded(
          child: _buildMetricCard(
            'Total Spend (YTD)',
            '\$5,420',
            '43% of total allocated',
            LucideIcons.trendingUp,
            PrimeCareTheme.colors.emeraldTeal,
          ),
        ),
        const SizedBox(width: 24),
        Expanded(
          child: _buildMetricCard(
            'Remaining Balance',
            '\$7,080',
            '57% available',
            LucideIcons.wallet,
            PrimeCareTheme.colors.navyIndigo,
          ),
        ),
        const SizedBox(width: 24),
        Expanded(
          child: _buildMetricCard(
            'Pending Expenses',
            '\$450',
            '2 items awaiting approval',
            LucideIcons.clock,
            Colors.amber.shade700,
          ),
        ),
      ],
    );
  }

  Widget _buildMetricCard(String title, String value, String subtitle, IconData icon, Color actionColor) {
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
                  fontWeight: FontWeight.w600,
                ),
              ),
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: actionColor.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(icon, color: actionColor, size: 20),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Text(
            value,
            style: PrimeCareTheme.typography.display.copyWith(
              color: PrimeCareTheme.colors.navyIndigo,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            subtitle,
            style: PrimeCareTheme.typography.body.copyWith(
              color: PrimeCareTheme.colors.slateGray,
              fontSize: 13,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRecentExpensesList() {
    return ClinicalGlassPanel(
      padding: const EdgeInsets.all(0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(24),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Recent Expenses', style: PrimeCareTheme.typography.h3.copyWith(color: PrimeCareTheme.colors.navyIndigo)),
                InkWell(
                  onTap: () {},
                  child: Text('View All', style: PrimeCareTheme.typography.body.copyWith(color: PrimeCareTheme.colors.emeraldTeal, fontWeight: FontWeight.w600)),
                )
              ],
            ),
          ),
          _buildExpenseRow('Facebook Ads (Aug)', 'Digital Advertising', '\$1,200.00', 'Approved', 'Aug 14, 2026'),
          _buildExpenseRow('Local Print Mailers', 'Print Media', '\$850.00', 'Approved', 'Aug 05, 2026'),
          _buildExpenseRow('Community Event Banner', 'Event Sponsorship', '\$300.00', 'Pending', 'Aug 02, 2026'),
          _buildExpenseRow('Google Local Ads (Jul)', 'Digital Advertising', '\$950.00', 'Approved', 'Jul 31, 2026'),
          _buildExpenseRow('Radio Spot - Q3 Promo', 'Broadcast', '\$1,500.00', 'Approved', 'Jul 15, 2026'),
          _buildExpenseRow('Flyer Distribution', 'Print Media', '\$150.00', 'Pending', 'Jul 10, 2026'),
        ],
      ),
    );
  }

  Widget _buildExpenseRow(String title, String category, String amount, String status, String date) {
    Color statusColor = status == 'Approved' ? PrimeCareTheme.colors.emeraldTeal : (status == 'Pending' ? Colors.amber.shade700 : PrimeCareTheme.colors.coralRed);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      decoration: BoxDecoration(
        border: Border(top: BorderSide(color: PrimeCareTheme.colors.surfaceContainerHighest.withValues(alpha: 0.5))),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: PrimeCareTheme.colors.surfaceContainerLow,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: PrimeCareTheme.colors.surfaceContainerHighest),
                ),
                child: Icon(LucideIcons.receipt, size: 20, color: PrimeCareTheme.colors.navyIndigo),
              ),
              const SizedBox(width: 16),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: PrimeCareTheme.typography.body.copyWith(color: PrimeCareTheme.colors.navyIndigo, fontWeight: FontWeight.w600)),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      Text(category, style: PrimeCareTheme.typography.label.copyWith(color: PrimeCareTheme.colors.slateGray)),
                      const SizedBox(width: 8),
                      Text('•', style: PrimeCareTheme.typography.label.copyWith(color: PrimeCareTheme.colors.surfaceContainerHighest)),
                      const SizedBox(width: 8),
                      Text(date, style: PrimeCareTheme.typography.label.copyWith(color: PrimeCareTheme.colors.slateGray)),
                    ],
                  ),
                ],
              ),
            ],
          ),
          Row(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: statusColor.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: statusColor.withValues(alpha: 0.2)),
                ),
                child: Text(
                  status,
                  style: PrimeCareTheme.typography.label.copyWith(
                    color: statusColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 11,
                  ),
                ),
              ),
              const SizedBox(width: 24),
              Text(
                amount,
                style: PrimeCareTheme.typography.body.copyWith(
                  color: PrimeCareTheme.colors.navyIndigo,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryBreakdown() {
    return ClinicalGlassPanel(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Spend by Category', style: PrimeCareTheme.typography.h3.copyWith(color: PrimeCareTheme.colors.navyIndigo)),
          const SizedBox(height: 32),
          // Donut Chart Mock
          Center(
            child: Stack(
              alignment: Alignment.center,
              children: [
                SizedBox(
                  width: 200,
                  height: 200,
                  child: CircularProgressIndicator(
                    value: 0.8,
                    strokeWidth: 24,
                    color: PrimeCareTheme.colors.emeraldTeal,
                    backgroundColor: PrimeCareTheme.colors.navyIndigo.withValues(alpha: 0.1),
                  ),
                ),
                SizedBox(
                  width: 200,
                  height: 200,
                  child: CircularProgressIndicator(
                    value: 0.35,
                    strokeWidth: 24,
                    color: PrimeCareTheme.colors.navyIndigo,
                    backgroundColor: Colors.transparent,
                  ),
                ),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text('Total Spend', style: PrimeCareTheme.typography.label.copyWith(color: PrimeCareTheme.colors.slateGray)),
                    const SizedBox(height: 4),
                    Text('\$5,420', style: PrimeCareTheme.typography.h2.copyWith(color: PrimeCareTheme.colors.navyIndigo)),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 40),
          _buildLegendItem('Digital Advertising', '\$3,100', PrimeCareTheme.colors.navyIndigo),
          const SizedBox(height: 16),
          _buildLegendItem('Print Media', '\$1,000', PrimeCareTheme.colors.emeraldTeal),
          const SizedBox(height: 16),
          _buildLegendItem('Event Sponsorship', '\$820', PrimeCareTheme.colors.slateGray),
          const SizedBox(height: 16),
          _buildLegendItem('Broadcast (Radio/TV)', '\$500', PrimeCareTheme.colors.secondary),
        ],
      ),
    );
  }

  Widget _buildLegendItem(String category, String amount, Color color) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Container(width: 12, height: 12, decoration: BoxDecoration(color: color, shape: BoxShape.circle)),
            const SizedBox(width: 12),
            Text(category, style: PrimeCareTheme.typography.body.copyWith(color: PrimeCareTheme.colors.slateGray)),
          ],
        ),
        Text(amount, style: PrimeCareTheme.typography.body.copyWith(color: PrimeCareTheme.colors.navyIndigo, fontWeight: FontWeight.bold)),
      ],
    );
  }
}
