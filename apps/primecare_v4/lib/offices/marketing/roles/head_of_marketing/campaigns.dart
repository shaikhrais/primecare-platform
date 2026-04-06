import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:primecare_v4/design_system/clinical_glass.dart';
import 'package:primecare_v4/design_system/primecare_theme.dart';

class CampaignsScreen extends ConsumerStatefulWidget {
  const CampaignsScreen({super.key});

  @override
  ConsumerState<CampaignsScreen> createState() => _CampaignsScreenState();
}

class _CampaignsScreenState extends ConsumerState<CampaignsScreen> {
  int _selectedTabIndex = 0;

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
            _buildMetricCards(),
            const SizedBox(height: 32),
            _buildCampaignsList(),
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
              'Campaigns Dashboard',
              style: PrimeCareTheme.typography.heroTitle.copyWith(
                color: PrimeCareTheme.colors.navyIndigo,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Active programs, pipeline value, and cross-channel performance',
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
              label: 'Quarterly View',
            ),
            const SizedBox(width: 16),
            ClinicalGlassButton(
              onPressed: () {},
              icon: LucideIcons.plus,
              label: 'New Campaign',
              isActive: true, // Uses primary styling
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildMetricCards() {
    return Row(
      children: [
        Expanded(
          child: _buildMetricCard(
            'Active Campaigns',
            '12',
            '+2 this month',
            LucideIcons.radio,
            PrimeCareTheme.colors.navyIndigo,
          ),
        ),
        const SizedBox(width: 24),
        Expanded(
          child: _buildMetricCard(
            'Pipeline Value',
            '\$4.8M',
            'Projected ROI 4.8x',
            LucideIcons.barChart2,
            PrimeCareTheme.colors.emeraldTeal,
          ),
        ),
        const SizedBox(width: 24),
        Expanded(
          child: _buildMetricCard(
            'Total Conversions',
            '1.2k',
            '+12% vs last quarter',
            LucideIcons.users,
            PrimeCareTheme.colors.navyIndigo, // Use main theme colors
          ),
        ),
        const SizedBox(width: 24),
        Expanded(
          child: _buildMetricCard(
            'Budget Spend (Q1)',
            '\$425k',
            '85% of Allocation',
            LucideIcons.dollarSign,
            PrimeCareTheme.colors.slateGray,
          ),
        ),
      ],
    );
  }

  Widget _buildMetricCard(String title, String value, String subtitle, IconData icon, Color accentColor) {
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
                  color: accentColor.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(icon, color: accentColor, size: 20),
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

  Widget _buildCampaignsList() {
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
                Text(
                  'Active Marketing Campaigns',
                  style: PrimeCareTheme.typography.h2.copyWith(
                    color: PrimeCareTheme.colors.navyIndigo,
                  ),
                ),
                ClinicalSearchTextField(hintText: 'Search campaigns...'),
              ],
            ),
          ),
          _buildTableHeader(),
          _buildTableRow(
            name: 'Winter Wellness Drive',
            status: 'Active',
            channel: 'Multi-Channel',
            channelIcon: LucideIcons.radioReceiver,
            spent: 120000,
            allocated: 150000,
            conversions: 450,
            cpa: 266.0,
          ),
          _buildTableRow(
            name: 'B2B Corporate Wellness',
            status: 'Active',
            channel: 'Email / LinkedIn',
            channelIcon: LucideIcons.mail,
            spent: 45000,
            allocated: 100000,
            conversions: 320,
            cpa: 140.0,
          ),
          _buildTableRow(
            name: 'Local SEO Boost - BC Region',
            status: 'Optimization',
            channel: 'Organic Search',
            channelIcon: LucideIcons.search,
            spent: 19000,
            allocated: 20000,
            conversions: 12000,
            cpa: 1.58,
          ),
          _buildTableRow(
            name: 'Spring Recruitment Surge',
            status: 'Scheduled',
            channel: 'Paid Social',
            channelIcon: LucideIcons.target,
            spent: 0,
            allocated: 50000,
            conversions: 0,
            cpa: 0,
          ),
        ],
      ),
    );
  }

  Widget _buildTableHeader() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      decoration: BoxDecoration(
        color: PrimeCareTheme.colors.surfaceContainerLow,
        border: Border(
          bottom: BorderSide(
            color: PrimeCareTheme.colors.surfaceContainerHighest.withValues(alpha: 0.5),
          ),
          top: BorderSide(
            color: PrimeCareTheme.colors.surfaceContainerHighest.withValues(alpha: 0.5),
          ),
        ),
      ),
      child: Row(
        children: [
          Expanded(flex: 3, child: Text('CAMPAIGN NAME', style: PrimeCareTheme.typography.label)),
          Expanded(flex: 2, child: Text('STATUS', style: PrimeCareTheme.typography.label)),
          Expanded(flex: 2, child: Text('CHANNEL', style: PrimeCareTheme.typography.label)),
          Expanded(flex: 3, child: Text('BUDGET SPENT / ALLOCATED', style: PrimeCareTheme.typography.label)),
          Expanded(flex: 2, child: Text('CONVERSIONS', style: PrimeCareTheme.typography.label)),
          Expanded(flex: 1, child: Text('', style: PrimeCareTheme.typography.label)), // Actions
        ],
      ),
    );
  }

  Widget _buildTableRow({
    required String name,
    required String status,
    required String channel,
    required IconData channelIcon,
    required double spent,
    required double allocated,
    required int conversions,
    required double cpa,
  }) {
    Color statusColor;
    if (status == 'Active') {
      statusColor = PrimeCareTheme.colors.emeraldTeal;
    } else if (status == 'Optimization') {
      statusColor = PrimeCareTheme.colors.navyIndigo;
    } else {
      statusColor = PrimeCareTheme.colors.slateGray;
    }

    final budgetPct = allocated > 0 ? (spent / allocated).clamp(0.0, 1.0) : 0.0;
    
    // Formatting currency simply for simulation
    String formatCurrency(double val) {
      if (val >= 1000) return '\$${(val / 1000).toStringAsFixed(0)}k';
      return '\$${val.toStringAsFixed(0)}';
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: PrimeCareTheme.colors.surfaceContainerHighest.withValues(alpha: 0.3),
          ),
        ),
      ),
      child: Row(
        children: [
          Expanded(
            flex: 3,
            child: Text(
              name,
              style: PrimeCareTheme.typography.body.copyWith(
                color: PrimeCareTheme.colors.navyIndigo,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Align(
              alignment: Alignment.centerLeft,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
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
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Row(
              children: [
                Icon(channelIcon, size: 16, color: PrimeCareTheme.colors.slateGray),
                const SizedBox(width: 8),
                Text(
                  channel,
                  style: PrimeCareTheme.typography.body.copyWith(
                    color: PrimeCareTheme.colors.slateGray,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            flex: 3,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '${formatCurrency(spent)} / ${formatCurrency(allocated)}',
                      style: PrimeCareTheme.typography.body.copyWith(
                        fontWeight: FontWeight.w600,
                        color: PrimeCareTheme.colors.navyIndigo,
                      ),
                    ),
                    Text(
                      '${(budgetPct * 100).toInt()}%',
                      style: PrimeCareTheme.typography.label.copyWith(
                        color: PrimeCareTheme.colors.slateGray,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                LinearProgressIndicator(
                  value: budgetPct,
                  backgroundColor: PrimeCareTheme.colors.surfaceContainerLow,
                  valueColor: AlwaysStoppedAnimation<Color>(
                    budgetPct > 0.9 ? PrimeCareTheme.colors.errorContainer : PrimeCareTheme.colors.navyIndigo,
                  ),
                  minHeight: 6,
                  borderRadius: BorderRadius.circular(3),
                ),
              ],
            ),
          ),
          Expanded(
            flex: 2,
            child: Padding(
              padding: const EdgeInsets.only(left: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    conversions.toString(),
                    style: PrimeCareTheme.typography.body.copyWith(
                      fontWeight: FontWeight.w600,
                      color: PrimeCareTheme.colors.emeraldTeal,
                    ),
                  ),
                  Text(
                    cpa > 0 ? 'CPA: ${formatCurrency(cpa)}' : '-',
                    style: PrimeCareTheme.typography.label.copyWith(
                      color: PrimeCareTheme.colors.slateGray,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Align(
              alignment: Alignment.centerRight,
              child: IconButton(
                icon: Icon(LucideIcons.moreVertical, color: PrimeCareTheme.colors.slateGray),
                onPressed: () {},
                splashRadius: 24,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

