import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:primecare_v4/design_system/clinical_glass.dart';
import 'package:primecare_v4/design_system/primecare_theme.dart';

class CommunityReportsScreen extends ConsumerStatefulWidget {
  const CommunityReportsScreen({super.key});

  @override
  ConsumerState<CommunityReportsScreen> createState() =>
      _CommunityReportsScreenState();
}

class _CommunityReportsScreenState
    extends ConsumerState<CommunityReportsScreen> {
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
              Expanded(flex: 3, child: _buildReportArchive()),
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
                  LucideIcons.barChart2,
                  color: PrimeCareTheme.colors.navyIndigo,
                  size: 28,
                ),
                const SizedBox(width: 12),
                Text(
                  'Impact Reporting',
                  style: PrimeCareTheme.typography.heroTitle.copyWith(
                    color: PrimeCareTheme.colors.navyIndigo,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              'Generate and analyze community outreach and engagement metrics.',
              style: PrimeCareTheme.typography.body.copyWith(
                color: PrimeCareTheme.colors.slateGray,
              ),
            ),
          ],
        ),
        ClinicalGlassButton(
          onPressed: () {},
          icon: LucideIcons.externalLink,
          label: 'Export Dashboard',
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
            title: 'Reports Generated',
            value: '42',
            icon: LucideIcons.fileText,
            trend: 'This Month',
            isNeutral: true,
          ),
        ),
        const SizedBox(width: 24),
        Expanded(
          child: _buildMetricCard(
            title: 'Reporting Workflows',
            value: '5',
            icon: LucideIcons.workflow,
            trend: 'Automated schedules',
            isPositive: true,
          ),
        ),
        const SizedBox(width: 24),
        Expanded(
          child: _buildMetricCard(
            title: 'Data Sources',
            value: '12',
            icon: LucideIcons.database,
            trend: 'Fully Integrated',
            isPositive: true,
          ),
        ),
        const SizedBox(width: 24),
        Expanded(
          child: _buildMetricCard(
            title: 'Processing Issues',
            value: '0',
            icon: LucideIcons.checkCircle,
            trend: 'System healthy',
            isPositive: true,
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
      trendColor = Colors.amber.shade700;
      iconColor = Colors.amber.shade700;
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

  Widget _buildReportGenerator() {
    return ClinicalGlassPanel(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                LucideIcons.settings,
                color: PrimeCareTheme.colors.navyIndigo,
                size: 20,
              ),
              const SizedBox(width: 8),
              Text(
                'Report Builder',
                style: PrimeCareTheme.typography.h3.copyWith(
                  color: PrimeCareTheme.colors.navyIndigo,
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          _buildFormLabel('Report Focus Area'),
          const SizedBox(height: 8),
          _buildDropdown('Select Focus', [
            'Event Attendance',
            'Program Impact',
            'Partnership Review',
            'Volunteer Engagement',
            'General Outreach',
          ]),
          const SizedBox(height: 20),
          _buildFormLabel('Date Range'),
          const SizedBox(height: 8),
          _buildDateRangeSelector(),
          const SizedBox(height: 20),
          _buildFormLabel('Export Format'),
          const SizedBox(height: 8),
          Row(
            children: [
              _buildFormatChip('PDF', true),
              const SizedBox(width: 8),
              _buildFormatChip('CSV', false),
              const SizedBox(width: 8),
              _buildFormatChip('XLSX', false),
            ],
          ),
          const SizedBox(height: 32),
          SizedBox(
            width: double.infinity,
            child: ClinicalGlassButton(
              onPressed: () {},
              icon: LucideIcons.playCircle,
              label: 'Generate Report',
              isActive: true,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFormLabel(String text) {
    return Text(
      text,
      style: PrimeCareTheme.typography.label.copyWith(
        color: PrimeCareTheme.colors.slateGray,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Widget _buildDropdown(String hint, List<String> items) {
    return Container(
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
          Text(
            hint,
            style: PrimeCareTheme.typography.body.copyWith(
              color: PrimeCareTheme.colors.slateGray,
            ),
          ),
          Icon(
            LucideIcons.chevronDown,
            size: 16,
            color: PrimeCareTheme.colors.navyIndigo,
          ),
        ],
      ),
    );
  }

  Widget _buildDateRangeSelector() {
    return Container(
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
              Icon(
                LucideIcons.calendar,
                size: 16,
                color: PrimeCareTheme.colors.navyIndigo,
              ),
              const SizedBox(width: 8),
              Text(
                'Oct 1 - Oct 31, 2026',
                style: PrimeCareTheme.typography.body.copyWith(
                  color: PrimeCareTheme.colors.navyIndigo,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildFormatChip(String label, bool isSelected) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: isSelected
            ? PrimeCareTheme.colors.navyIndigo
            : Colors.transparent,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: isSelected
              ? PrimeCareTheme.colors.navyIndigo
              : PrimeCareTheme.colors.surfaceContainerHighest,
        ),
      ),
      child: Text(
        label,
        style: PrimeCareTheme.typography.label.copyWith(
          color: isSelected ? Colors.white : PrimeCareTheme.colors.slateGray,
          fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
        ),
      ),
    );
  }

  Widget _buildReportArchive() {
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
                  'Generated Reports Archive',
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
                        'Search archive...',
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
                    'REPORT NAME',
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
                    'DATE GENERATED',
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
                    'FOCUS AREA',
                    style: PrimeCareTheme.typography.label.copyWith(
                      fontSize: 11,
                      color: PrimeCareTheme.colors.slateGray,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(
                  width: 100,
                  child: Text(
                    'FORMAT',
                    textAlign: TextAlign.center,
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
          ..._buildArchiveRows(),
        ],
      ),
    );
  }

  List<Widget> _buildArchiveRows() {
    final reports = [
      {
        'name': 'Q3 Impact Summary',
        'date': 'Today, 09:12 AM',
        'focus': 'General Outreach',
        'format': 'PDF',
      },
      {
        'name': 'Oct Partner Review',
        'date': 'Yesterday',
        'focus': 'Partnership Review',
        'format': 'XLSX',
      },
      {
        'name': 'Health Fair Attendance',
        'date': 'Oct 28, 2026',
        'focus': 'Event Attendance',
        'format': 'CSV',
      },
      {
        'name': 'Volunteer Engagement YTD',
        'date': 'Oct 15, 2026',
        'focus': 'Volunteer Engagement',
        'format': 'PDF',
      },
      {
        'name': 'Senior Program Metrics',
        'date': 'Oct 01, 2026',
        'focus': 'Program Impact',
        'format': 'PDF',
      },
    ];

    return reports.asMap().entries.map((entry) {
      final report = entry.value;
      final int index = entry.key;

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
                      Icon(
                        report['format'] == 'PDF'
                            ? LucideIcons.fileText
                            : LucideIcons.fileSpreadsheet,
                        size: 16,
                        color: PrimeCareTheme.colors.navyIndigo,
                      ),
                      const SizedBox(width: 12),
                      Text(
                        report['name']!,
                        style: PrimeCareTheme.typography.body.copyWith(
                          color: PrimeCareTheme.colors.navyIndigo,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Text(
                    report['date']!,
                    style: PrimeCareTheme.typography.body.copyWith(
                      color: PrimeCareTheme.colors.slateGray,
                    ),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Text(
                    report['focus']!,
                    style: PrimeCareTheme.typography.body.copyWith(
                      color: PrimeCareTheme.colors.slateGray,
                    ),
                  ),
                ),
                SizedBox(
                  width: 100,
                  child: Align(
                    alignment: Alignment.center,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: PrimeCareTheme.colors.surfaceContainerHighest,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        report['format']!,
                        style: PrimeCareTheme.typography.label.copyWith(
                          color: PrimeCareTheme.colors.navyIndigo,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: 80,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        LucideIcons.download,
                        size: 18,
                        color: PrimeCareTheme.colors.navyIndigo,
                      ),
                      const SizedBox(width: 16),
                      Icon(
                        LucideIcons.moreVertical,
                        size: 18,
                        color: PrimeCareTheme.colors.slateGray,
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
