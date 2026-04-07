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
    return InkWell(
      onTap: () {},
      borderRadius: BorderRadius.circular(12),
      child: Container(
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Completion Trend (YTD)',
                      style: PrimeCareTheme.typography.h3,
                    ),
                    Icon(
                      LucideIcons.moreHorizontal,
                      color: PrimeCareTheme.colors.slateGray,
                      size: 20,
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                SizedBox(
                  height: 220,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _buildLinePoint('Jan', 0.3),
                      _buildLinePoint('Feb', 0.5),
                      _buildLinePoint('Mar', 0.4),
                      _buildLinePoint('Apr', 0.7),
                      _buildLinePoint('May', 0.6),
                      _buildLinePoint('Jun', 0.8),
                      _buildLinePoint('Jul', 0.9),
                    ],
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Dept Distribution',
                      style: PrimeCareTheme.typography.h3,
                    ),
                    Icon(
                      LucideIcons.pieChart,
                      color: PrimeCareTheme.colors.slateGray,
                      size: 20,
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                Center(
                  child: Container(
                    height: 180,
                    width: 180,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: PrimeCareTheme.colors.emeraldTeal.withOpacity(0.3),
                        width: 24,
                      ),
                    ),
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            '42%',
                            style: PrimeCareTheme.typography.h2.copyWith(
                              color: PrimeCareTheme.colors.emeraldTeal,
                            ),
                          ),
                          Text(
                            'Nursing',
                            style: PrimeCareTheme.typography.label,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildLinePoint(String label, double heightRatio) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Container(
          width: 12,
          height: 180 * heightRatio,
          decoration: BoxDecoration(
            color: PrimeCareTheme.colors.navyIndigo,
            borderRadius: BorderRadius.circular(6),
          ),
        ),
        const SizedBox(height: 12),
        Text(
          label,
          style: PrimeCareTheme.typography.label.copyWith(
            color: PrimeCareTheme.colors.slateGray,
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
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 8),
            child: Divider(height: 1, thickness: 1),
          ),
          _buildExportRow(
            'Nursing_Training_Matrix.xlsx',
            'Oct 12, 2026',
            '1.1 MB',
          ),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 8),
            child: Divider(height: 1, thickness: 1),
          ),
          _buildExportRow('Trainer_Scores_Sep26.csv', 'Oct 01, 2026', '450 KB'),
        ],
      ),
    );
  }

  Widget _buildExportRow(String title, String date, String size) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: PrimeCareTheme.colors.cloudGray.withOpacity(0.5),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  LucideIcons.fileText,
                  size: 20,
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
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '$date  •  $size',
                    style: PrimeCareTheme.typography.label.copyWith(
                      color: PrimeCareTheme.colors.slateGray,
                    ),
                  ),
                ],
              ),
            ],
          ),
          IconButton(
            icon: const Icon(LucideIcons.download),
            onPressed: () {},
            color: PrimeCareTheme.colors.slateGray,
            splashRadius: 24,
          ),
        ],
      ),
    );
  }
}
