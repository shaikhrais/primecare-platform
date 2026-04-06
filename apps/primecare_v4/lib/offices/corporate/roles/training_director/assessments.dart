import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:primecare_v4/design_system/clinical_glass.dart';
import 'package:primecare_v4/design_system/primecare_theme.dart';
import 'package:primecare_v4/shared/components/page_template.dart';

class AssessmentsScreen extends ConsumerWidget {
  const AssessmentsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return PageTemplate(
      title: 'Skill & Competency Assessments',
      subtitle: 'Manage and review clinical, procedural, and compliance assessments across staff.',
      headerTrailing: [
        ClinicalSearchTextField(hintText: 'Search assessments or staff...'),
        const SizedBox(width: 16),
        ClinicalGlassButton(
          onPressed: () {},
          label: 'Create Assessment',
          icon: LucideIcons.filePlus,
          isPrimary: true,
        ),
      ],
      kpiCards: [
        MetricCardData(
          title: 'Pending Reviews',
          value: '42',
          icon: LucideIcons.clipboardSignature,
          trend: 'Requires instructor sign-off',
          isUp: false,
          color: PrimeCareTheme.colors.amberWarning,
        ),
        MetricCardData(
          title: 'Average Score',
          value: '88%',
          icon: LucideIcons.percent,
          trend: '+2% from last quarter',
          isUp: true,
        ),
        MetricCardData(
          title: 'Failure Rate',
          value: '4.5%',
          icon: LucideIcons.trendingDown,
          trend: 'Highest in Medication Safety',
          isUp: false,
          color: PrimeCareTheme.colors.coralRed,
        ),
      ],
      sidebarContent: [
        _buildAssessmentCategories(),
        const SizedBox(height: 24),
        _buildTopPerformers(),
      ],
      mainContent: [
        _buildRecentAssessments(),
      ],
    );
  }

  Widget _buildAssessmentCategories() {
    return ClinicalGlassPanel(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(LucideIcons.library, color: PrimeCareTheme.colors.navyIndigo, size: 20),
              const SizedBox(width: 8),
              Text('Categories', style: PrimeCareTheme.typography.h3),
            ],
          ),
          const SizedBox(height: 16),
          _buildCatRow('Clinical Skills', 124),
          const SizedBox(height: 12),
          _buildCatRow('Equipment Use', 86),
          const SizedBox(height: 12),
          _buildCatRow('Health & Safety', 210),
          const SizedBox(height: 12),
          _buildCatRow('Soft Skills / Comm.', 45),
        ],
      ),
    );
  }

  Widget _buildCatRow(String name, int count) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(name, style: PrimeCareTheme.typography.body),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
          decoration: BoxDecoration(
            color: PrimeCareTheme.colors.cloudGray,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(count.toString(), style: PrimeCareTheme.typography.label),
        ),
      ],
    );
  }

  Widget _buildTopPerformers() {
    return ClinicalGlassPanel(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(LucideIcons.award, color: PrimeCareTheme.colors.navyIndigo, size: 20),
              const SizedBox(width: 8),
              Text('Top Performers', style: PrimeCareTheme.typography.h3),
            ],
          ),
          const SizedBox(height: 16),
          _buildPerformerRow('Sarah Jenkins (RN)', '100% Avg'),
          const SizedBox(height: 12),
          _buildPerformerRow('David Okafor (PT)', '98% Avg'),
          const SizedBox(height: 12),
          _buildPerformerRow('Emma Swan (PSW)', '97% Avg'),
        ],
      ),
    );
  }

  Widget _buildPerformerRow(String name, String score) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(name, style: PrimeCareTheme.typography.body),
        Text(score, style: PrimeCareTheme.typography.label.copyWith(
          color: PrimeCareTheme.colors.emeraldTeal,
          fontWeight: FontWeight.bold,
        )),
      ],
    );
  }

  Widget _buildRecentAssessments() {
    return ClinicalGlassPanel(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(24),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Recent Assessment Submissions', style: PrimeCareTheme.typography.h2),
                ClinicalGlassButton(
                  onPressed: () {},
                  label: 'Filter: Pending',
                  icon: LucideIcons.filter,
                ),
              ],
            ),
          ),
          const Divider(height: 1),
          _buildAssessmentRow(
            staffName: 'Michael Ray',
            role: 'PSW',
            assessmentName: 'Safe Patient Transfer Techniques',
            date: 'Today, 10:15 AM',
            score: '92%',
            status: 'Passed',
          ),
          const Divider(height: 1),
          _buildAssessmentRow(
            staffName: 'Elena Rostova',
            role: 'MD',
            assessmentName: 'Advanced Life Support (ALS) SIM',
            date: 'Yesterday, 02:30 PM',
            score: 'Pending Review',
            status: 'Requires Sign-off',
          ),
          const Divider(height: 1),
          _buildAssessmentRow(
            staffName: 'John Carmichael',
            role: 'RN',
            assessmentName: 'IV Pump Operation',
            date: 'Oct 12, 09:00 AM',
            score: '68%',
            status: 'Failed',
          ),
        ],
      ),
    );
  }

  Widget _buildAssessmentRow({
    required String staffName,
    required String role,
    required String assessmentName,
    required String date,
    required String score,
    required String status,
  }) {
    Color statusColor;
    if (status == 'Passed') {
      statusColor = PrimeCareTheme.colors.emeraldTeal;
    } else if (status == 'Failed') {
      statusColor = PrimeCareTheme.colors.coralRed;
    } else {
      statusColor = PrimeCareTheme.colors.amberWarning;
    }

    return Padding(
      padding: const EdgeInsets.all(24),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: statusColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(status == 'Passed' ? LucideIcons.checkCircle : (status == 'Failed' ? LucideIcons.xCircle : LucideIcons.clipboardSignature), color: statusColor, size: 20),
          ),
          const SizedBox(width: 20),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(staffName, style: PrimeCareTheme.typography.h3),
                    const SizedBox(width: 8),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                      decoration: BoxDecoration(
                        color: PrimeCareTheme.colors.cloudGray,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(role, style: PrimeCareTheme.typography.label),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Icon(LucideIcons.fileText, size: 14, color: PrimeCareTheme.colors.slateGray),
                    const SizedBox(width: 4),
                    Text(assessmentName, style: PrimeCareTheme.typography.body),
                    const SizedBox(width: 16),
                    Icon(LucideIcons.clock, size: 14, color: PrimeCareTheme.colors.slateGray),
                    const SizedBox(width: 4),
                    Text(date, style: PrimeCareTheme.typography.label),
                  ],
                ),
              ],
            ),
          ),
          Column(
             crossAxisAlignment: CrossAxisAlignment.end,
             children: [
                Text(
                  status == 'Requires Sign-off' ? score : 'Score: $score',
                  style: PrimeCareTheme.typography.body.copyWith(
                    fontWeight: FontWeight.bold,
                    color: status == 'Requires Sign-off' ? statusColor : PrimeCareTheme.colors.navyIndigo,
                  ),
                ),
                const SizedBox(height: 4),
                Container(
                 padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                 decoration: BoxDecoration(
                   color: statusColor.withOpacity(0.1),
                   borderRadius: BorderRadius.circular(12),
                 ),
                 child: Text(
                   status,
                   style: PrimeCareTheme.typography.label.copyWith(
                     color: statusColor,
                     fontWeight: FontWeight.bold,
                   ),
                 ),
                ),
                const SizedBox(height: 12),
                if (status == 'Requires Sign-off')
                   ClinicalGlassButton(
                     onPressed: () {},
                     label: 'Review',
                     icon: LucideIcons.edit2,
                   )
                else
                   ClinicalGlassButton(
                     onPressed: () {},
                     label: 'View Result',
                     icon: LucideIcons.eye,
                   ),
             ],
          ),
        ],
      ),
    );
  }
}
