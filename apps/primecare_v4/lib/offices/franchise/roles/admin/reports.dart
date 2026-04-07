import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:primecare_v4/design_system/clinical_glass.dart';
import 'package:primecare_v4/design_system/primecare_theme.dart';

class FranchiseReportsScreen extends ConsumerStatefulWidget {
  const FranchiseReportsScreen({super.key});

  @override
  ConsumerState<FranchiseReportsScreen> createState() =>
      _FranchiseReportsScreenState();
}

class _FranchiseReportsScreenState
    extends ConsumerState<FranchiseReportsScreen> {
  String _selectedReportType = 'Profit & Loss (P&L)';
  String _selectedDateRange = 'This Quarter (Q4 2026)';

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
              Expanded(flex: 1, child: _buildReportGenerator()),
              const SizedBox(width: 32),
              Expanded(flex: 2, child: _buildGeneratedReportsList()),
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
                  LucideIcons.barChart3,
                  color: PrimeCareTheme.colors.navyIndigo,
                  size: 28,
                ),
                const SizedBox(width: 12),
                Text(
                  'Financial Reports',
                  style: PrimeCareTheme.typography.heroTitle.copyWith(
                    color: PrimeCareTheme.colors.navyIndigo,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              'Generate, view, and export core financial reporting packages.',
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
              icon: LucideIcons.settings,
              label: 'Report Settings',
            ),
            const SizedBox(width: 16),
            ClinicalGlassButton(
              onPressed: () {},
              icon: LucideIcons.calendarDays,
              label: 'Schedule Report',
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
            title: 'Monthly Recurring (MRR)',
            value: '\$142,500',
            icon: LucideIcons.repeat,
            trend: '+12%',
            positiveTrend: true,
          ),
        ),
        const SizedBox(width: 24),
        Expanded(
          child: _buildMetricCard(
            title: 'Top Revenue Source',
            value: 'Medicare',
            icon: LucideIcons.award,
            trend: '54% of Total',
            positiveTrend: true,
          ),
        ),
        const SizedBox(width: 24),
        Expanded(
          child: _buildMetricCard(
            title: 'Total Expenses (MTD)',
            value: '\$45,200',
            icon: LucideIcons.trendingDown,
            trend: '-2%',
            positiveTrend: true, // Lower expenses are better
          ),
        ),
        const SizedBox(width: 24),
        Expanded(
          child: _buildMetricCard(
            title: 'Net Margin',
            value: '22.4%',
            icon: LucideIcons.activity,
            trend: '+1.2%',
            positiveTrend: true,
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
    required bool positiveTrend,
  }) {
    Color trendColor = positiveTrend
        ? PrimeCareTheme.colors.emeraldTeal
        : PrimeCareTheme.colors.coralRed;
    IconData? trendIcon;

    if (trend.startsWith('+')) {
      trendIcon = LucideIcons.trendingUp;
    } else if (trend.startsWith('-')) {
      trendIcon = LucideIcons.trendingDown;
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
                trendIcon != null ? '$trend vs. Prior Period' : trend,
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

  Widget _buildReportGenerator() {
    return ClinicalGlassPanel(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                LucideIcons.filePlus2,
                color: PrimeCareTheme.colors.navyIndigo,
                size: 24,
              ),
              const SizedBox(width: 12),
              Text(
                'Generate Report',
                style: PrimeCareTheme.typography.h3.copyWith(
                  color: PrimeCareTheme.colors.navyIndigo,
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          _buildDropdown(
            label: 'Report Type',
            value: _selectedReportType,
            items: [
              'Profit & Loss (P&L)',
              'Balance Sheet',
              'A/R Aging Summary',
              'Tax Liability',
              'Cash Flow Statement',
            ],
            onChanged: (val) {
              if (val != null)
                setState(() {
                  _selectedReportType = val;
                });
            },
          ),
          const SizedBox(height: 16),
          _buildDropdown(
            label: 'Date Range',
            value: _selectedDateRange,
            items: [
              'This Month',
              'Last Month',
              'This Quarter (Q4 2026)',
              'Last Quarter (Q3 2026)',
              'Year to Date',
              'Custom...',
            ],
            onChanged: (val) {
              if (val != null)
                setState(() {
                  _selectedDateRange = val;
                });
            },
          ),
          const SizedBox(height: 16),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Include Zero Balances',
                style: PrimeCareTheme.typography.body.copyWith(
                  color: PrimeCareTheme.colors.navyIndigo,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  Switch(
                    value: false,
                    onChanged: (_) {},
                    activeColor: PrimeCareTheme.colors.emeraldTeal,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    'Exclude accounts with \$0.00 balance',
                    style: PrimeCareTheme.typography.label.copyWith(
                      color: PrimeCareTheme.colors.slateGray,
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 24),
          SizedBox(
            width: double.infinity,
            child: ClinicalGlassButton(
              onPressed: () {},
              icon: LucideIcons.playCircle,
              label: 'Run Report',
              isActive: true,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDropdown({
    required String label,
    required String value,
    required List<String> items,
    required Function(String?) onChanged,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: PrimeCareTheme.typography.body.copyWith(
            color: PrimeCareTheme.colors.navyIndigo,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          decoration: BoxDecoration(
            color: PrimeCareTheme.colors.surfaceContainerLow,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: PrimeCareTheme.colors.surfaceContainerHighest,
            ),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              isExpanded: true,
              value: value,
              icon: Icon(
                LucideIcons.chevronDown,
                color: PrimeCareTheme.colors.slateGray,
              ),
              items: items.map((String item) {
                return DropdownMenuItem<String>(
                  value: item,
                  child: Text(
                    item,
                    style: PrimeCareTheme.typography.body.copyWith(
                      color: PrimeCareTheme.colors.navyIndigo,
                    ),
                  ),
                );
              }).toList(),
              onChanged: onChanged,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildGeneratedReportsList() {
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
                  'Recent Reports',
                  style: PrimeCareTheme.typography.h3.copyWith(
                    color: PrimeCareTheme.colors.navyIndigo,
                  ),
                ),
                Container(
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
                        'Search archives...',
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
                  flex: 3,
                  child: Text(
                    'DOCUMENT NAME',
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
                    'DATE RANGE',
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
                    'GENERATED ON',
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
                    'GENERATED BY',
                    style: PrimeCareTheme.typography.label.copyWith(
                      fontSize: 11,
                      color: PrimeCareTheme.colors.slateGray,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(width: 120), // For action buttons
              ],
            ),
          ),
          ..._buildReportRows(),
        ],
      ),
    );
  }

  List<Widget> _buildReportRows() {
    final reports = [
      {
        'name': 'Q3 2026 P&L Statement',
        'type': 'PDF',
        'range': 'Jul 1 - Sep 30',
        'generated': 'Oct 15, 2026',
        'author': 'System (Auto)',
      },
      {
        'name': 'September AR Aging Detail',
        'type': 'EXCEL',
        'range': 'As of Sep 30',
        'generated': 'Oct 2, 2026',
        'author': 'J. Smith (Admin)',
      },
      {
        'name': 'Q3 Tax Liability Summary',
        'type': 'PDF',
        'range': 'Jul 1 - Sep 30',
        'generated': 'Oct 1, 2026',
        'author': 'System (Auto)',
      },
      {
        'name': 'August P&L Statement',
        'type': 'PDF',
        'range': 'Aug 1 - Aug 31',
        'generated': 'Sep 5, 2026',
        'author': 'M. Jones',
      },
      {
        'name': 'Trailing 12-Month Cash Flow',
        'type': 'PDF',
        'range': 'Sep 25 - Sep 25',
        'generated': 'Sep 1, 2026',
        'author': 'J. Smith (Admin)',
      },
    ];

    return reports.asMap().entries.map((entry) {
      final report = entry.value;
      final int index = entry.key;

      final isPdf = report['type'] == 'PDF';
      final fileIcon = isPdf
          ? LucideIcons.fileText
          : LucideIcons.fileSpreadsheet;
      final fileColor = isPdf
          ? PrimeCareTheme.colors.coralRed
          : PrimeCareTheme.colors.emeraldTeal;

      return Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
            child: Row(
              children: [
                Expanded(
                  flex: 3,
                  child: Row(
                    children: [
                      Icon(fileIcon, color: fileColor, size: 20),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              report['name']!,
                              style: PrimeCareTheme.typography.h4.copyWith(
                                color: PrimeCareTheme.colors.navyIndigo,
                                fontSize: 14,
                              ),
                            ),
                            Text(
                              report['type']!,
                              style: PrimeCareTheme.typography.label.copyWith(
                                color: PrimeCareTheme.colors.slateGray,
                                fontSize: 10,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Text(
                    report['range']!,
                    style: PrimeCareTheme.typography.body.copyWith(
                      color: PrimeCareTheme.colors.navyIndigo,
                    ),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Text(
                    report['generated']!,
                    style: PrimeCareTheme.typography.body.copyWith(
                      color: PrimeCareTheme.colors.slateGray,
                    ),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Text(
                    report['author']!,
                    style: PrimeCareTheme.typography.body.copyWith(
                      color: PrimeCareTheme.colors.slateGray,
                    ),
                  ),
                ),
                SizedBox(
                  width: 120,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      IconButton(
                        icon: Icon(
                          LucideIcons.eye,
                          color: PrimeCareTheme.colors.navyIndigo,
                          size: 20,
                        ),
                        onPressed: () {},
                        tooltip: 'View Report',
                      ),
                      const SizedBox(width: 8),
                      IconButton(
                        icon: Icon(
                          LucideIcons.download,
                          color: PrimeCareTheme.colors.emeraldTeal,
                          size: 20,
                        ),
                        onPressed: () {},
                        tooltip: 'Download',
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          if (index < reports.length - 1)
            Divider(
              height: 1,
              color: PrimeCareTheme.colors.surfaceContainerHighest,
            ),
        ],
      );
    }).toList();
  }
}
