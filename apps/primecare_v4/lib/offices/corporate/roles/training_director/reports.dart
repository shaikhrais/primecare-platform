import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:primecare_v4/design_system/clinical_glass.dart';
import 'package:primecare_v4/design_system/primecare_theme.dart';
import 'package:primecare_v4/shared/components/page_template.dart';

class TrainingReportsScreen extends ConsumerWidget {
  const TrainingReportsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return PageTemplate(
      title: 'Training Analytics & Reports',
      subtitle:
          'Data-driven insights into corporate training performance and costs.',
      headerTrailing: [
        ClinicalGlassButton(
          onPressed: () {},
          label: 'Export All Data',
          icon: LucideIcons.downloadCloud,
          isPrimary: true,
        ),
      ],
      kpiCards: [
        KPICardData(
          title: 'Total Training Hours',
          value: '12,450',
          icon: LucideIcons.clock,
          trend: '+12% vs last quarter',
          isUp: true,
          color: PrimeCareTheme.colors.navyIndigo,
        ),
        KPICardData(
          title: 'Avg Completion Time',
          value: '4.2 Days',
          icon: LucideIcons.timer,
          trend: '-1.1 Days (Faster)',
          isUp: true,
          color: PrimeCareTheme.colors.emeraldTeal,
        ),
        KPICardData(
          title: 'Cost per Trainee',
          value: '\$145',
          icon: LucideIcons.dollarSign,
          trend: '-5% vs budget',
          isUp: true,
          color: PrimeCareTheme.colors.amberWarning,
        ),
      ],
      sidebarContent: [_buildReportCategories()],
      mainContent: [
        _buildChartsSection(),
        const SizedBox(height: 24),
        _buildRecentExports(),
      ],
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
                LucideIcons.barChart2,
                color: PrimeCareTheme.colors.navyIndigo,
                size: 20,
              ),
              const SizedBox(width: 8),
              Text('Available Reports', style: PrimeCareTheme.typography.h3),
            ],
          ),
          const SizedBox(height: 16),
          _buildReportLink('Compliance Summary'),
          const SizedBox(height: 12),
          _buildReportLink('Department Breakdown'),
          const SizedBox(height: 12),
          _buildReportLink('Cost Analytics'),
          const SizedBox(height: 12),
          _buildReportLink('Trainer Performance'),
          const SizedBox(height: 12),
          _buildReportLink('Overdue Certifications'),
        ],
      ),
    );
  }

  Widget _buildReportLink(String title) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: PrimeCareTheme.colors.cloudGray.withOpacity(0.5),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.transparent),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title, style: PrimeCareTheme.typography.body),
          Icon(
            LucideIcons.chevronRight,
            size: 16,
            color: PrimeCareTheme.colors.slateGray,
          ),
        ],
      ),
    );
  }

  Widget _buildChartsSection() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 2,
          child: ClinicalGlassPanel(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Completion Trend (YTD)',
                  style: PrimeCareTheme.typography.h3,
                ),
                const SizedBox(height: 16),
                Container(
                  height: 200,
                  decoration: BoxDecoration(
                    color: PrimeCareTheme.colors.cloudGray.withOpacity(0.3),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          LucideIcons.lineChart,
                          size: 48,
                          color: PrimeCareTheme.colors.slateGray.withOpacity(
                            0.5,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Line Chart Placeholder',
                          style: PrimeCareTheme.typography.label,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(width: 24),
        Expanded(
          flex: 1,
          child: ClinicalGlassPanel(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Dept Distribution', style: PrimeCareTheme.typography.h3),
                const SizedBox(height: 16),
                Container(
                  height: 200,
                  decoration: BoxDecoration(
                    color: PrimeCareTheme.colors.cloudGray.withOpacity(0.3),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          LucideIcons.pieChart,
                          size: 48,
                          color: PrimeCareTheme.colors.slateGray.withOpacity(
                            0.5,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Pie Chart Placeholder',
                          style: PrimeCareTheme.typography.label,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildRecentExports() {
    return ClinicalGlassPanel(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Recent Exports', style: PrimeCareTheme.typography.h3),
              Text(
                'View All',
                style: PrimeCareTheme.typography.label.copyWith(
                  color: PrimeCareTheme.colors.emeraldTeal,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          _buildExportRow('Q3 Compliance Report.pdf', 'Oct 15, 2026', '2.4 MB'),
          const Divider(),
          _buildExportRow(
            'Nursing_Training_Matrix.xlsx',
            'Oct 12, 2026',
            '1.1 MB',
          ),
          const Divider(),
          _buildExportRow('Trainer_Scores_Sep26.csv', 'Oct 01, 2026', '450 KB'),
        ],
      ),
    );
  }

  Widget _buildExportRow(String title, String date, String size) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: PrimeCareTheme.colors.cloudGray,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(
                  LucideIcons.fileText,
                  size: 18,
                  color: PrimeCareTheme.colors.navyIndigo,
                ),
              ),
              const SizedBox(width: 16),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: PrimeCareTheme.typography.body.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    '$date  •  $size',
                    style: PrimeCareTheme.typography.label,
                  ),
                ],
              ),
            ],
          ),
          IconButton(
            icon: const Icon(LucideIcons.download),
            onPressed: () {},
            color: PrimeCareTheme.colors.slateGray,
          ),
        ],
      ),
    );
  }
}
