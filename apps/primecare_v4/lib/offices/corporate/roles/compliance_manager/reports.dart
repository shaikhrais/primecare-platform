import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:primecare_v4/design_system/clinical_glass.dart';
import 'package:primecare_v4/design_system/primecare_theme.dart';
import 'package:primecare_v4/shared/components/page_template.dart';

class ComplianceReportsScreen extends ConsumerWidget {
  const ComplianceReportsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return PageTemplate(
      title: 'Compliance Reporting & Analytics',
      subtitle:
          'Generate and review periodic regulatory reports, board presentations, and internal compliance summaries.',
      headerTrailing: [
        ClinicalSearchTextField(hintText: 'Search generated reports...'),
        const SizedBox(width: 16),
        ClinicalGlassButton(
          onPressed: () {},
          label: 'Generate Board Report',
          icon: LucideIcons.fileText,
          isPrimary: true,
        ),
      ],
      kpiCards: [
        KPICardData(
          title: 'Generated (Mtd)',
          value: '42',
          icon: LucideIcons.fileOutput,
          trend: '+12% from last month',
          isUp: true,
        ),
        KPICardData(
          title: 'Ministry Submissions',
          value: '2',
          icon: LucideIcons.landmark,
          trend: 'Next due: Nov 30',
          isUp: true,
          color: PrimeCareTheme.colors.navyIndigo,
        ),
        KPICardData(
          title: 'Automated Reports',
          value: '85%',
          icon: LucideIcons.cpu,
          trend: 'Reduced manual effort',
          isUp: true,
          color: PrimeCareTheme.colors.emeraldTeal,
        ),
      ],
      sidebarContent: [
        _buildReportCategories(),
        const SizedBox(height: 24),
        _buildScheduledReports(),
      ],
      mainContent: [_buildRecentReportsList()],
    );
  }

  Widget _buildReportCategories() {
    return ClinicalGlassPanel(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                LucideIcons.folder,
                color: PrimeCareTheme.colors.navyIndigo,
                size: 20,
              ),
              const SizedBox(width: 8),
              Text('Report Categories', style: PrimeCareTheme.typography.h3),
            ],
          ),
          const SizedBox(height: 16),
          _buildCatRow('Ministry of Health (MOH)', LucideIcons.landmark),
          const SizedBox(height: 12),
          _buildCatRow('Internal Audits', LucideIcons.clipboardCheck),
          const SizedBox(height: 12),
          _buildCatRow('Board of Directors', LucideIcons.presentation),
          const SizedBox(height: 12),
          _buildCatRow('Incident & Safety', LucideIcons.shieldAlert),
        ],
      ),
    );
  }

  Widget _buildCatRow(String title, IconData icon) {
    return Row(
      children: [
        Icon(icon, size: 16, color: PrimeCareTheme.colors.slateGray),
        const SizedBox(width: 12),
        Text(title, style: PrimeCareTheme.typography.body),
      ],
    );
  }

  Widget _buildScheduledReports() {
    return ClinicalGlassPanel(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                LucideIcons.calendarClock,
                color: PrimeCareTheme.colors.navyIndigo,
                size: 20,
              ),
              const SizedBox(width: 8),
              Text('Upcoming Scheduled', style: PrimeCareTheme.typography.h3),
            ],
          ),
          const SizedBox(height: 16),
          _buildScheduledRow(
            'Monthly Fall Incident Summary',
            'Tomorrow, 08:00 AM',
          ),
          const SizedBox(height: 12),
          _buildScheduledRow('Q3 Staffing Compliance', 'Nov 01, 2026'),
          const SizedBox(height: 12),
          _buildScheduledRow('Bi-Annual Infection Control', 'Nov 15, 2026'),
        ],
      ),
    );
  }

  Widget _buildScheduledRow(String title, String time) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: PrimeCareTheme.typography.body.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          time,
          style: PrimeCareTheme.typography.label.copyWith(
            color: PrimeCareTheme.colors.slateGray,
          ),
        ),
      ],
    );
  }

  Widget _buildRecentReportsList() {
    return ClinicalGlassPanel(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(24),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Recent Reports', style: PrimeCareTheme.typography.h2),
                ClinicalGlassButton(
                  onPressed: () {},
                  label: 'Filter',
                  icon: LucideIcons.filter,
                ),
              ],
            ),
          ),
          const Divider(height: 1),
          _buildReportItem(
            name: 'Q3 Board of Directors Compliance Summary',
            generatedDate: 'Today, 10:15 AM',
            format: 'PDF',
            category: 'Board of Directors',
          ),
          const Divider(height: 1),
          _buildReportItem(
            name: 'MOH Monthly Critical Incidents (Sept 2026)',
            generatedDate: 'Oct 01, 2026',
            format: 'XML / Excel',
            category: 'Ministry of Health (MOH)',
          ),
          const Divider(height: 1),
          _buildReportItem(
            name: 'Internal Audit: Medication Room Security',
            generatedDate: 'Sep 28, 2026',
            format: 'PDF',
            category: 'Internal Audits',
          ),
        ],
      ),
    );
  }

  Widget _buildReportItem({
    required String name,
    required String generatedDate,
    required String format,
    required String category,
  }) {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: PrimeCareTheme.colors.navyIndigo.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(
              format.contains('PDF')
                  ? LucideIcons.fileCode
                  : LucideIcons.fileSpreadsheet,
              color: PrimeCareTheme.colors.navyIndigo,
              size: 20,
            ),
          ),
          const SizedBox(width: 20),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(name, style: PrimeCareTheme.typography.h3),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Icon(
                      LucideIcons.calendar,
                      size: 14,
                      color: PrimeCareTheme.colors.slateGray,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      'Generated: $generatedDate',
                      style: PrimeCareTheme.typography.label,
                    ),
                    const SizedBox(width: 16),
                    Icon(
                      LucideIcons.tag,
                      size: 14,
                      color: PrimeCareTheme.colors.slateGray,
                    ),
                    const SizedBox(width: 4),
                    Text(category, style: PrimeCareTheme.typography.label),
                  ],
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: PrimeCareTheme.colors.cloudGray,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  format,
                  style: PrimeCareTheme.typography.label.copyWith(
                    color: PrimeCareTheme.colors.navyIndigo,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 12),
              ClinicalGlassButton(
                onPressed: () {},
                label: 'Download',
                icon: LucideIcons.download,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
