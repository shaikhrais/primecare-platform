import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:primecare_v4/design_system/clinical_glass.dart';
import 'package:primecare_v4/design_system/primecare_theme.dart';

class PerformanceReportsScreen extends ConsumerStatefulWidget {
  const PerformanceReportsScreen({super.key});

  @override
  ConsumerState<PerformanceReportsScreen> createState() =>
      _PerformanceReportsScreenState();
}

class _PerformanceReportsScreenState
    extends ConsumerState<PerformanceReportsScreen> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(32.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildHeader(),
          const SizedBox(height: 32),
          _buildHighLevelMetrics(),
          const SizedBox(height: 32),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(flex: 1, child: _buildReportingSidebar()),
              const SizedBox(width: 24),
              Expanded(flex: 3, child: _buildDataTableView()),
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
            Text(
              'Performance Reports',
              style: PrimeCareTheme.typography.heroTitle.copyWith(
                color: PrimeCareTheme.colors.navyIndigo,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Exportable analytics, deep CPA analysis, and customer lifetime value reporting.',
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
              icon: LucideIcons.fileText,
              label: 'Export PDF',
            ),
            const SizedBox(width: 16),
            ClinicalGlassButton(
              onPressed: () {},
              icon: LucideIcons.download,
              label: 'Export CSV',
              isActive: true,
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildHighLevelMetrics() {
    return Row(
      children: [
        Expanded(
          child: _buildMetricCard(
            'Blended CPA',
            '\$142.50',
            '- 4.2% YoY',
            LucideIcons.trendingDown,
            PrimeCareTheme.colors.emeraldTeal,
          ),
        ),
        const SizedBox(width: 24),
        Expanded(
          child: _buildMetricCard(
            'Est. Patient CLV',
            '\$3,450',
            '+ 8.5% YoY',
            LucideIcons.trendingUp,
            PrimeCareTheme.colors.emeraldTeal,
          ),
        ),
        const SizedBox(width: 24),
        Expanded(
          child: _buildMetricCard(
            'Lead to Appointment',
            '18.4%',
            'Target: 20%',
            LucideIcons.activity,
            Colors.amber.shade700,
          ),
        ),
        const SizedBox(width: 24),
        Expanded(
          child: _buildMetricCard(
            'Total Ad Spend (YTD)',
            '\$1.85M',
            'Of \$2.5M Budget',
            LucideIcons.dollarSign,
            PrimeCareTheme.colors.navyIndigo,
          ),
        ),
      ],
    );
  }

  Widget _buildMetricCard(
    String title,
    String value,
    String subtitle,
    IconData icon,
    Color actionColor,
  ) {
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

  Widget _buildReportingSidebar() {
    return ClinicalGlassPanel(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Report Configuration',
            style: PrimeCareTheme.typography.h3.copyWith(
              color: PrimeCareTheme.colors.navyIndigo,
            ),
          ),
          const SizedBox(height: 24),
          _buildSidebarFilter(
            'Date Range',
            'Year to Date',
            LucideIcons.calendar,
          ),
          const SizedBox(height: 16),
          _buildSidebarFilter(
            'Attribution Model',
            'Time Decay',
            LucideIcons.share2,
          ),
          const SizedBox(height: 16),
          _buildSidebarFilter('Channel', 'All Channels', LucideIcons.globe),
          const SizedBox(height: 16),
          _buildSidebarFilter('Region', 'Global', LucideIcons.map),
          const SizedBox(height: 32),
          Text(
            'Saved Views',
            style: PrimeCareTheme.typography.label.copyWith(
              fontWeight: FontWeight.bold,
              color: PrimeCareTheme.colors.navyIndigo,
            ),
          ),
          const SizedBox(height: 16),
          _buildSavedViewItem('Q3 Board Deck Data', isActive: true),
          _buildSavedViewItem('Paid Search Efficiency', isActive: false),
          _buildSavedViewItem('Social Media ROI', isActive: false),
        ],
      ),
    );
  }

  Widget _buildSidebarFilter(String label, String value, IconData icon) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: PrimeCareTheme.typography.label.copyWith(
            color: PrimeCareTheme.colors.slateGray,
          ),
        ),
        const SizedBox(height: 8),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          decoration: BoxDecoration(
            color: PrimeCareTheme.colors.surfaceContainerLow,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: PrimeCareTheme.colors.surfaceContainerHighest,
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(icon, size: 16, color: PrimeCareTheme.colors.navyIndigo),
                  const SizedBox(width: 8),
                  Text(
                    value,
                    style: PrimeCareTheme.typography.body.copyWith(
                      color: PrimeCareTheme.colors.navyIndigo,
                    ),
                  ),
                ],
              ),
              Icon(
                LucideIcons.chevronDown,
                size: 16,
                color: PrimeCareTheme.colors.slateGray,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildSavedViewItem(String name, {required bool isActive}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: Row(
        children: [
          Icon(
            LucideIcons.bookmark,
            size: 16,
            color: isActive
                ? PrimeCareTheme.colors.emeraldTeal
                : PrimeCareTheme.colors.slateGray,
          ),
          const SizedBox(width: 8),
          Text(
            name,
            style: PrimeCareTheme.typography.body.copyWith(
              color: isActive
                  ? PrimeCareTheme.colors.navyIndigo
                  : PrimeCareTheme.colors.slateGray,
              fontWeight: isActive ? FontWeight.w600 : FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDataTableView() {
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
                  'Detailed Performance Breakdown',
                  style: PrimeCareTheme.typography.h2.copyWith(
                    color: PrimeCareTheme.colors.navyIndigo,
                  ),
                ),
                ClinicalSearchTextField(hintText: 'Search dimensions...'),
              ],
            ),
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: ConstrainedBox(
              constraints: const BoxConstraints(minWidth: 1000),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildTableHeader(),
                  _buildTableRow(
                    'Search - Non-Brand',
                    85000,
                    125000,
                    480,
                    145,
                    12.5,
                  ),
                  _buildTableRow(
                    'Search - Brand',
                    25000,
                    450000,
                    310,
                    80,
                    24.2,
                  ),
                  _buildTableRow(
                    'Facebook - Retargeting',
                    40000,
                    180000,
                    290,
                    137,
                    15.8,
                  ),
                  _buildTableRow(
                    'Facebook - Prospecting',
                    60000,
                    95000,
                    180,
                    333,
                    8.4,
                  ),
                  _buildTableRow('LinkedIn - B2B', 35000, 75000, 85, 411, 4.2),
                  _buildTableRow(
                    'Local SEO / Maps',
                    15000,
                    320000,
                    610,
                    24,
                    28.5,
                  ),
                  _buildTableRow(
                    'Print Media - Direct',
                    55000,
                    80000,
                    75,
                    733,
                    2.1,
                  ),
                ],
              ),
            ),
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
            color: PrimeCareTheme.colors.surfaceContainerHighest.withValues(
              alpha: 0.5,
            ),
          ),
          top: BorderSide(
            color: PrimeCareTheme.colors.surfaceContainerHighest.withValues(
              alpha: 0.5,
            ),
          ),
        ),
      ),
      child: Row(
        children: [
          Expanded(
            flex: 3,
            child: Text(
              'CAMPAIGN / SOURCE',
              style: PrimeCareTheme.typography.label,
            ),
          ),
          Expanded(
            flex: 2,
            child: Text('SPEND', style: PrimeCareTheme.typography.label),
          ),
          Expanded(
            flex: 2,
            child: Text('IMPRESSIONS', style: PrimeCareTheme.typography.label),
          ),
          Expanded(
            flex: 2,
            child: Text('LEADS', style: PrimeCareTheme.typography.label),
          ),
          Expanded(
            flex: 2,
            child: Text('CPA', style: PrimeCareTheme.typography.label),
          ),
          Expanded(
            flex: 2,
            child: Text('CONV. RATE', style: PrimeCareTheme.typography.label),
          ),
        ],
      ),
    );
  }

  Widget _buildTableRow(
    String source,
    double spend,
    int impressions,
    int leads,
    double cpa,
    double cr,
  ) {
    String formatCurrency(double val) {
      if (val >= 1000) return '\$${(val / 1000).toStringAsFixed(1)}k';
      return '\$${val.toStringAsFixed(0)}';
    }

    String formatNumber(int val) {
      if (val >= 1000) return '${(val / 1000).toStringAsFixed(1)}k';
      return val.toString();
    }

    Color cpaColor = cpa > 200
        ? PrimeCareTheme.colors.coralRed
        : (cpa < 100
              ? PrimeCareTheme.colors.emeraldTeal
              : PrimeCareTheme.colors.slateGray);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: PrimeCareTheme.colors.surfaceContainerHighest.withValues(
              alpha: 0.3,
            ),
          ),
        ),
      ),
      child: Row(
        children: [
          Expanded(
            flex: 3,
            child: Text(
              source,
              style: PrimeCareTheme.typography.body.copyWith(
                color: PrimeCareTheme.colors.navyIndigo,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Text(
              formatCurrency(spend),
              style: PrimeCareTheme.typography.body.copyWith(
                color: PrimeCareTheme.colors.slateGray,
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Text(
              formatNumber(impressions),
              style: PrimeCareTheme.typography.body.copyWith(
                color: PrimeCareTheme.colors.slateGray,
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Text(
              leads.toString(),
              style: PrimeCareTheme.typography.body.copyWith(
                color: PrimeCareTheme.colors.slateGray,
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Text(
              '\$${cpa.toStringAsFixed(0)}',
              style: PrimeCareTheme.typography.body.copyWith(
                color: cpaColor,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Text(
              '${cr.toStringAsFixed(1)}%',
              style: PrimeCareTheme.typography.body.copyWith(
                color: PrimeCareTheme.colors.slateGray,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
