import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:primecare_v4/design_system/primecare_theme.dart';
import 'package:primecare_v4/design_system/clinical_glass.dart';
import 'package:primecare_v4/shared/components/page_template.dart';

class FranchisePipelineScreen extends ConsumerWidget {
  const FranchisePipelineScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return PageTemplate(
      title: 'Franchise Pipeline',
      subtitle: 'Track candidates through the franchise awarding process.',
      kpiCards: [
        KPICardData(
          title: 'Total Applications',
          value: '42',
          icon: LucideIcons.fileText,
          trend: 8.4,
          trendLabel: 'vs last month',
        ),
        KPICardData(
          title: 'Discovery Days',
          value: '12',
          icon: LucideIcons.calendar,
          trend: 2.1,
          trendLabel: 'scheduled this month',
        ),
        KPICardData(
          title: 'Awarded YTD',
          value: '7',
          icon: LucideIcons.award,
          trend: 40.0,
          trendLabel: 'progress to goal',
        ),
        KPICardData(
          title: 'Avg Time to Award',
          value: '95d',
          icon: LucideIcons.timer,
          trend: -12.5,
          trendLabel: 'days faster',
        ),
      ],
      sidebarContent: [
        ClinicalGlassPanel(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Pipeline Status', style: PrimeCareTheme.typography.h3),
              const SizedBox(height: 16),
              _buildPipelineStatusRow('Application Received', 15),
              _buildPipelineStatusRow('Initial Interview', 10),
              _buildPipelineStatusRow('FDD Sent', 8),
              _buildPipelineStatusRow('Discovery Day', 5),
              _buildPipelineStatusRow('Final Review', 3),
              _buildPipelineStatusRow('Agreement Signed', 1),
            ],
          ),
        ),
      ],
      mainContent: [
        ClinicalGlassPanel(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Active Franchise Candidates', style: PrimeCareTheme.typography.h2),
              const SizedBox(height: 24),
              _buildCandidateRow(
                'James Robertson',
                'Toronto North',
                'Discovery Day',
                '\$500K Liquid',
                '1 week ago',
                LucideIcons.user,
              ),
              _buildCandidateRow(
                'Wellness Partners LLC',
                'Vancouver Central',
                'FDD Sent',
                '\$1.2M Liquid',
                '3 days ago',
                LucideIcons.building,
              ),
              _buildCandidateRow(
                'Lisa Wong',
                'Calgary South',
                'Initial Interview',
                '\$350K Liquid',
                'Just now',
                LucideIcons.user,
              ),
              _buildCandidateRow(
                'Apex Health Group',
                'Halifax Region',
                'Final Review',
                '\$2.5M Liquid',
                'Waiting on approval',
                LucideIcons.building,
              ),
              _buildCandidateRow(
                'Robert Davis',
                'Winnipeg West',
                'Application Received',
                'Pending Review',
                'Under review',
                LucideIcons.user,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildPipelineStatusRow(String stage, int count) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(stage, style: PrimeCareTheme.typography.body),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
            decoration: BoxDecoration(
              color: PrimeCareTheme.colors.navyIndigo.withOpacity(0.1),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Text(
              count.toString(),
              style: PrimeCareTheme.typography.label.copyWith(
                fontWeight: FontWeight.bold,
                color: PrimeCareTheme.colors.navyIndigo,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCandidateRow(String name, String territory, String stage, String financials, String lastAction, IconData icon) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: PrimeCareTheme.colors.surfaceContainerHighest.withOpacity(0.3),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: PrimeCareTheme.colors.surfaceContainerHighest),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            flex: 2,
            child: Row(
              children: [
                CircleAvatar(
                  backgroundColor: PrimeCareTheme.colors.navyIndigo.withOpacity(0.1),
                  child: Icon(icon, color: PrimeCareTheme.colors.navyIndigo),
                ),
                const SizedBox(width: 16),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(name, style: PrimeCareTheme.typography.h3),
                    const SizedBox(height: 4),
                    Text(territory, style: PrimeCareTheme.typography.label.copyWith(color: PrimeCareTheme.colors.slateGray)),
                  ],
                ),
              ],
            ),
          ),
          Expanded(
            flex: 1,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Stage', style: PrimeCareTheme.typography.label.copyWith(color: PrimeCareTheme.colors.slateGray)),
                const SizedBox(height: 4),
                Text(stage, style: PrimeCareTheme.typography.body.copyWith(fontWeight: FontWeight.w600)),
              ],
            ),
          ),
          Expanded(
            flex: 1,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Financials', style: PrimeCareTheme.typography.label.copyWith(color: PrimeCareTheme.colors.slateGray)),
                const SizedBox(height: 4),
                Text(financials, style: PrimeCareTheme.typography.body),
              ],
            ),
          ),
          Expanded(
            flex: 1,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text('Last Action', style: PrimeCareTheme.typography.label.copyWith(color: PrimeCareTheme.colors.slateGray)),
                const SizedBox(height: 4),
                Text(lastAction, style: PrimeCareTheme.typography.label.copyWith(fontStyle: FontStyle.italic)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
