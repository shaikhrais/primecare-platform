import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:primecare_v4/design_system/primecare_theme.dart';
import 'package:primecare_v4/design_system/clinical_glass.dart';
import 'package:primecare_v4/shared/components/page_template.dart';

class ReportsScreen extends ConsumerWidget {
  const ReportsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return PageTemplate(
      title: 'Business Development Reports',
      subtitle:
          'Analytics, pipeline summaries, and growth performance datasets.',
      kpiCards: [
        KPICardData(
          title: 'Reports Generated YTD',
          value: '142',
          icon: LucideIcons.fileText,
          trend: 12.0,
          trendLabel: 'increase in usage',
        ),
        KPICardData(
          title: 'Top Viewed Report',
          value: 'Q3 Pipeline',
          icon: LucideIcons.eye,
          trend: 0.0,
          trendLabel: '45 views this week',
        ),
        KPICardData(
          title: 'Automated Reports',
          value: '8',
          icon: LucideIcons.zap,
          trend: 2.0,
          trendLabel: 'new scheduled tasks',
        ),
        KPICardData(
          title: 'Data Accuracy',
          value: '99.8%',
          icon: LucideIcons.checkCircle,
          trend: 0.2,
          trendLabel: 'system validation',
        ),
      ],
      sidebarContent: [
        ClinicalGlassPanel(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Report Categories', style: PrimeCareTheme.typography.h3),
              const SizedBox(height: 16),
              _buildCategorySelector('Pipeline & Forecasting', true),
              _buildCategorySelector('Sales Performance', false),
              _buildCategorySelector('Territory Analytics', false),
              _buildCategorySelector('M&A Due Diligence', false),
              _buildCategorySelector('Partnership Summaries', false),
            ],
          ),
        ),
        const SizedBox(height: 24),
        ClinicalGlassPanel(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Scheduled Delivery', style: PrimeCareTheme.typography.h3),
              const SizedBox(height: 16),
              _buildScheduledRow('Weekly Pipeline Update', 'Every Monday 8AM'),
              _buildScheduledRow('Monthly Exec Summary', '1st of Month'),
              _buildScheduledRow('Quarterly Forecast', 'Week 1 of Quarter'),
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
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Available Reports',
                    style: PrimeCareTheme.typography.h2,
                  ),
                  ElevatedButton.icon(
                    onPressed: () {},
                    icon: const Icon(LucideIcons.plus, size: 16),
                    label: const Text('Custom Report'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: PrimeCareTheme.colors.navyIndigo,
                      foregroundColor: Colors.white,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              _buildReportCard(
                'Q3 Franchise Pipeline Summary',
                'Comprehensive overview of all franchise leads by stage, expected close dates, and territory.',
                'PDF, Excel, CSV',
                'Updated 2 hours ago',
                LucideIcons.fileText,
              ),
              _buildReportCard(
                'Win/Loss Ratio Analysis (Trailing 12M)',
                'Detailed breakdown of won and lost deals by sales rep, territory, and stated reasons.',
                'Excel, CSV, Dashboard',
                'Updated Yesterday',
                LucideIcons.barChart2,
              ),
              _buildReportCard(
                'Expansion Feasibility - Western Canada',
                'Market analysis, demographic data, and competitor density for proposed Western markets.',
                'PDF, Presentation',
                'Generated Oct 10',
                LucideIcons.map,
              ),
              _buildReportCard(
                'Key Partnerships Revenue Impact',
                'Analysis of indirect revenue and referral volume generated through strategic partners.',
                'Excel, CSV',
                'Generated Oct 1',
                Icons.handshake,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildCategorySelector(String name, bool isSelected) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: isSelected
            ? PrimeCareTheme.colors.navyIndigo.withOpacity(0.05)
            : Colors.transparent,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            name,
            style: PrimeCareTheme.typography.body.copyWith(
              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              color: isSelected
                  ? PrimeCareTheme.colors.navyIndigo
                  : PrimeCareTheme.colors.textPrimary,
            ),
          ),
          if (isSelected)
            Icon(
              LucideIcons.chevronRight,
              size: 16,
              color: PrimeCareTheme.colors.navyIndigo,
            ),
        ],
      ),
    );
  }

  Widget _buildScheduledRow(String title, String schedule) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(child: Text(title, style: PrimeCareTheme.typography.body)),
          Text(
            schedule,
            style: PrimeCareTheme.typography.label.copyWith(
              color: PrimeCareTheme.colors.slateGray,
              fontStyle: FontStyle.italic,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildReportCard(
    String title,
    String description,
    String formats,
    String timestamp,
    IconData icon,
  ) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: PrimeCareTheme.colors.surfaceContainerHighest.withOpacity(0.3),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: PrimeCareTheme.colors.surfaceContainerHighest,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: PrimeCareTheme.colors.navyIndigo.withOpacity(
                          0.1,
                        ),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Icon(
                        icon,
                        color: PrimeCareTheme.colors.navyIndigo,
                        size: 20,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Text(title, style: PrimeCareTheme.typography.h3),
                    ),
                  ],
                ),
              ),
              Row(
                children: [
                  IconButton(
                    icon: Icon(
                      LucideIcons.download,
                      color: PrimeCareTheme.colors.navyIndigo,
                    ),
                    onPressed: () {},
                    tooltip: 'Download',
                  ),
                  IconButton(
                    icon: Icon(
                      LucideIcons.share2,
                      color: PrimeCareTheme.colors.slateGray,
                    ),
                    onPressed: () {},
                    tooltip: 'Share',
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            description,
            style: PrimeCareTheme.typography.body.copyWith(
              color: PrimeCareTheme.colors.slateGray,
            ),
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(
                    LucideIcons.fileArchive,
                    size: 14,
                    color: PrimeCareTheme.colors.slateGray,
                  ),
                  const SizedBox(width: 6),
                  Text(
                    'Formats: $formats',
                    style: PrimeCareTheme.typography.label,
                  ),
                ],
              ),
              Row(
                children: [
                  Icon(
                    LucideIcons.clock,
                    size: 14,
                    color: PrimeCareTheme.colors.slateGray,
                  ),
                  const SizedBox(width: 6),
                  Text(
                    timestamp,
                    style: PrimeCareTheme.typography.label.copyWith(
                      color: PrimeCareTheme.colors.slateGray,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
