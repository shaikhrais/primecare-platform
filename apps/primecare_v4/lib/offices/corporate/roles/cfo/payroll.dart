import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:primecare_v4/design_system/clinical_glass.dart';
import 'package:primecare_v4/design_system/primecare_theme.dart';

class CfoPayrollScreen extends ConsumerStatefulWidget {
  const CfoPayrollScreen({super.key});

  @override
  ConsumerState<CfoPayrollScreen> createState() => _CfoPayrollScreenState();
}

class _CfoPayrollScreenState extends ConsumerState<CfoPayrollScreen> {
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
              Expanded(flex: 3, child: _buildDepartmentPayrollTable()),
              const SizedBox(width: 32),
              Expanded(flex: 2, child: _buildRecentPayrollRuns()),
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
                  LucideIcons.users,
                  color: PrimeCareTheme.colors.navyIndigo,
                  size: 28,
                ),
                const SizedBox(width: 12),
                Text(
                  'Payroll Intelligence',
                  style: PrimeCareTheme.typography.heroTitle.copyWith(
                    color: PrimeCareTheme.colors.navyIndigo,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              'Detailed analysis of corporate payroll, department headcount, and compensation metrics.',
              style: PrimeCareTheme.typography.body.copyWith(
                color: PrimeCareTheme.colors.slateGray,
              ),
            ),
          ],
        ),
        ClinicalGlassButton(
          onPressed: () {},
          icon: LucideIcons.calendar,
          label: 'Current Period',
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
            title: 'Total Monthly Payroll',
            value: '\$5.2M',
            icon: LucideIcons.fileMinus,
            trend: '+1.2% vs Last Month',
            isWarning: true,
          ),
        ),
        const SizedBox(width: 24),
        Expanded(
          child: _buildMetricCard(
            title: 'Enterprise Headcount',
            value: '4,102',
            icon: LucideIcons.userPlus,
            trend: '+15 New Hires',
            isPositive: true,
          ),
        ),
        const SizedBox(width: 24),
        Expanded(
          child: _buildMetricCard(
            title: 'Overtime Costs',
            value: '\$125K',
            icon: LucideIcons.clock,
            trend: '-3.5% vs Last Month',
            isPositive: true,
          ),
        ),
        const SizedBox(width: 24),
        Expanded(
          child: _buildMetricCard(
            title: 'Benefits & Taxes',
            value: '\$1.1M',
            icon: LucideIcons.shieldCheck,
            trend: 'Fixed Overhead',
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
      trendColor = const Color(0xFFE11D48); // Ruby Red for high expenses
      iconColor = const Color(0xFFE11D48);
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

  Widget _buildRecentPayrollRuns() {
    return ClinicalGlassPanel(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Recent Payroll History',
            style: PrimeCareTheme.typography.h3.copyWith(
              color: PrimeCareTheme.colors.navyIndigo,
            ),
          ),
          const SizedBox(height: 24),
          _buildRunRow('Period Ending Apr 15', 'Processed', '\$2.6M'),
          const SizedBox(height: 16),
          _buildRunRow('Period Ending Mar 31', 'Completed', '\$2.6M'),
          const SizedBox(height: 16),
          _buildRunRow('Period Ending Mar 15', 'Completed', '\$2.5M'),
          const SizedBox(height: 16),
          _buildRunRow('Special Bonus Run', 'Completed', '\$120K'),
        ],
      ),
    );
  }

  Widget _buildRunRow(String name, String status, String amount) {
    bool isCompleted = status == 'Completed';

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: PrimeCareTheme.colors.surfaceContainerLow,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                name,
                style: PrimeCareTheme.typography.body.copyWith(
                  color: PrimeCareTheme.colors.navyIndigo,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                status,
                style: PrimeCareTheme.typography.label.copyWith(
                  color: isCompleted
                      ? PrimeCareTheme.colors.emeraldTeal
                      : Colors.amber.shade700,
                ),
              ),
            ],
          ),
          Text(
            amount,
            style: PrimeCareTheme.typography.body.copyWith(
              color: PrimeCareTheme.colors.navyIndigo,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDepartmentPayrollTable() {
    return ClinicalGlassPanel(
      padding: EdgeInsets.zero,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(24.0),
            child: Text(
              'Payroll By Department',
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
                    'DEPARTMENT',
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
                    'HEADCOUNT',
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
                    'PAYROLL COST',
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
          _buildDepartmentRow('Clinical Operations', '2,850', '\$3,100,000'),
          Divider(
            height: 1,
            color: PrimeCareTheme.colors.surfaceContainerHighest,
          ),
          _buildDepartmentRow('Administration', '420', '\$850,000'),
          Divider(
            height: 1,
            color: PrimeCareTheme.colors.surfaceContainerHighest,
          ),
          _buildDepartmentRow('IT & Engineering', '315', '\$680,000'),
          Divider(
            height: 1,
            color: PrimeCareTheme.colors.surfaceContainerHighest,
          ),
          _buildDepartmentRow('Sales & Marketing', '210', '\$320,000'),
          Divider(
            height: 1,
            color: PrimeCareTheme.colors.surfaceContainerHighest,
          ),
          _buildDepartmentRow('Human Resources', '95', '\$125,000'),
          Divider(
            height: 1,
            color: PrimeCareTheme.colors.surfaceContainerHighest,
          ),
          _buildDepartmentRow('Executive', '12', '\$125,000'),
          const SizedBox(height: 8),
        ],
      ),
    );
  }

  Widget _buildDepartmentRow(String name, String headcount, String cost) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            flex: 3,
            child: Text(
              name,
              style: PrimeCareTheme.typography.body.copyWith(
                color: PrimeCareTheme.colors.navyIndigo,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Text(
              headcount,
              textAlign: TextAlign.right,
              style: PrimeCareTheme.typography.body.copyWith(
                color: PrimeCareTheme.colors.slateGray,
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Text(
              cost,
              textAlign: TextAlign.right,
              style: PrimeCareTheme.typography.body.copyWith(
                color: PrimeCareTheme.colors.navyIndigo,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
