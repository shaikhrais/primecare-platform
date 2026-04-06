import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:primecare_v4/design_system/clinical_glass.dart';
import 'package:primecare_v4/design_system/primecare_theme.dart';

class CeoReportsScreen extends ConsumerStatefulWidget {
  const CeoReportsScreen({super.key});

  @override
  ConsumerState<CeoReportsScreen> createState() => _CeoReportsScreenState();
}

class _CeoReportsScreenState extends ConsumerState<CeoReportsScreen> {
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
            _buildKPIs(),
            const SizedBox(height: 32),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 3,
                  child: _buildReportsDatabaseTable(),
                ),
                const SizedBox(width: 32),
                Expanded(
                  flex: 1,
                  child: Column(
                    children: [
                      _buildSavedTemplatesWidget(),
                    ],
                  ),
                ),
              ],
            ),
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
            Row(
              children: [
                Icon(LucideIcons.barChart, color: PrimeCareTheme.colors.navyIndigo, size: 28),
                const SizedBox(width: 12),
                Text(
                  'Report Manager',
                  style: PrimeCareTheme.typography.heroTitle.copyWith(
                    color: PrimeCareTheme.colors.navyIndigo,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              'Generate, track, and manage customized enterprise data reports.',
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
                label: 'Configure',
                isActive: false,
              ),
              const SizedBox(width: 16),
              ClinicalGlassButton(
                onPressed: () {},
                icon: LucideIcons.plus,
                label: 'New Query',
                isActive: true,
              ),
           ]
        ),
      ],
    );
  }

  Widget _buildKPIs() {
    return Row(
      children: [
        Expanded(
          child: _buildMetricCard(
             title: 'Active Reports',
             value: '18',
             icon: LucideIcons.activity,
             trend: 'Generated this month',
             isPositive: true,
          ),
        ),
        const SizedBox(width: 24),
        Expanded(
          child: _buildMetricCard(
            title: 'Scheduled',
            value: '5',
            icon: LucideIcons.calendarClock,
            trend: 'Next generation: Oct 15',
            isNeutral: true,
          ),
        ),
        const SizedBox(width: 24),
         Expanded(
          child: _buildMetricCard(
             title: 'Archived',
             value: '1,248',
             icon: LucideIcons.archive,
             trend: 'System total',
             isNeutral: true,
          ),
        ),
        const SizedBox(width: 24),
        Expanded(
          child: _buildMetricCard(
            title: 'Custom Templates',
            value: '12',
            icon: LucideIcons.layoutTemplate,
            trend: '3 created recently',
            isPositive: true,
          ),
        ),
      ],
    );
  }

  Widget _buildMetricCard({required String title, required String value, required IconData icon, required String trend, bool isWarning = false, bool isPositive = false, bool isNeutral = false}) {
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


  Widget _buildReportsDatabaseTable() {
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
                        'Reports Database',
                        style: PrimeCareTheme.typography.h3.copyWith(
                           color: PrimeCareTheme.colors.navyIndigo,
                        ),
                     ),
                      Container(
                        width: 250,
                        decoration: BoxDecoration(
                          color: PrimeCareTheme.colors.surfaceContainerLow,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: PrimeCareTheme.colors.surfaceContainerHighest),
                        ),
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                        child: Row(
                          children: [
                            Icon(LucideIcons.search, size: 18, color: PrimeCareTheme.colors.slateGray),
                            const SizedBox(width: 8),
                            Text('Search generated reports...', style: PrimeCareTheme.typography.body.copyWith(color: PrimeCareTheme.colors.slateGray)),
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
                     Expanded(flex: 3, child: Text('REPORT TITLE', style: PrimeCareTheme.typography.label.copyWith(fontSize: 11, color: PrimeCareTheme.colors.slateGray, fontWeight: FontWeight.bold))),
                     Expanded(flex: 2, child: Text('TARGET SYSTEM', style: PrimeCareTheme.typography.label.copyWith(fontSize: 11, color: PrimeCareTheme.colors.slateGray, fontWeight: FontWeight.bold))),
                     Expanded(flex: 1, child: Text('FORMAT', style: PrimeCareTheme.typography.label.copyWith(fontSize: 11, color: PrimeCareTheme.colors.slateGray, fontWeight: FontWeight.bold))),
                     Expanded(flex: 2, child: Text('GENERATED', style: PrimeCareTheme.typography.label.copyWith(fontSize: 11, color: PrimeCareTheme.colors.slateGray, fontWeight: FontWeight.bold))),
                     SizedBox(width: 140, child: Text('ACTION', textAlign: TextAlign.center, style: PrimeCareTheme.typography.label.copyWith(fontSize: 11, color: PrimeCareTheme.colors.slateGray, fontWeight: FontWeight.bold))),
                  ],
               ),
            ),
            _buildReportRow('Q3 Franchise Revenue Rollup', 'Financial Engine', 'PDF', 'Oct 15, 2026'),
            Divider(height: 1, color: PrimeCareTheme.colors.surfaceContainerHighest),
            _buildReportRow('C-Suite Executive Summary', 'BI Analytics', 'PPTX', 'Oct 10, 2026'),
            Divider(height: 1, color: PrimeCareTheme.colors.surfaceContainerHighest),
            _buildReportRow('Global Active User Demographics', 'Identity/IAM', 'CSV', 'Oct 05, 2026'),
            Divider(height: 1, color: PrimeCareTheme.colors.surfaceContainerHighest),
            _buildReportRow('Enterprise Compliance Audit Log', 'Audit Core', 'PDF', 'Sep 30, 2026'),
            Divider(height: 1, color: PrimeCareTheme.colors.surfaceContainerHighest),
            _buildReportRow('Q2 Strategic Goals YoY', 'BI Analytics', 'XLSX', 'Aug 01, 2026'),
            const SizedBox(height: 8),
        ],
      )
     );
  }

  Widget _buildReportRow(String title, String system, String format, String date) {
      IconData formatIcon = LucideIcons.fileText;
      Color formatColor = PrimeCareTheme.colors.slateGray;

      if(format == 'PDF') {
         formatIcon = LucideIcons.fileText;
         formatColor = const Color(0xFFE11D48); // Ruby Red
      } else if (format == 'CSV' || format == 'XLSX') {
         formatIcon = LucideIcons.table;
         formatColor = PrimeCareTheme.colors.emeraldTeal;
      } else if (format == 'PPTX') {
         formatIcon = LucideIcons.presentation;
         formatColor = Colors.amber.shade700;
      }

      return Padding(
         padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
         child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
               Expanded(
                  flex: 3,
                  child: Row(
                     children: [
                        Icon(formatIcon, size: 16, color: formatColor),
                        const SizedBox(width: 8),
                        Expanded(child: Text(title, style: PrimeCareTheme.typography.body.copyWith(color: PrimeCareTheme.colors.navyIndigo, fontWeight: FontWeight.bold), maxLines: 1, overflow: TextOverflow.ellipsis)),
                     ],
                  ),
               ),
               Expanded(flex: 2, child: Text(system, style: PrimeCareTheme.typography.body.copyWith(color: PrimeCareTheme.colors.slateGray))),
               Expanded(
                  flex: 1,
                  child: Align(
                     alignment: Alignment.centerLeft,
                     child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                        decoration: BoxDecoration(color: formatColor.withValues(alpha: 0.1), borderRadius: BorderRadius.circular(12)),
                        child: Text(format, style: PrimeCareTheme.typography.label.copyWith(color: formatColor, fontWeight: FontWeight.bold)),
                     ),
                  ),
               ),
               Expanded(flex: 2, child: Text(date, style: PrimeCareTheme.typography.body.copyWith(color: PrimeCareTheme.colors.slateGray))),
               SizedBox(
                  width: 140,
                  child: Row(
                     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                     children: [
                        IconButton(
                           icon: Icon(LucideIcons.eye, color: PrimeCareTheme.colors.navyIndigo, size: 20),
                           onPressed: () {},
                           tooltip: 'View',
                           constraints: const BoxConstraints(),
                           padding: EdgeInsets.zero,
                        ),
                        IconButton(
                           icon: Icon(LucideIcons.download, color: PrimeCareTheme.colors.emeraldTeal, size: 20),
                           onPressed: () {},
                           tooltip: 'Download',
                           constraints: const BoxConstraints(),
                           padding: EdgeInsets.zero,
                        ),
                         IconButton(
                           icon: Icon(LucideIcons.share2, color: PrimeCareTheme.colors.slateGray, size: 20),
                           onPressed: () {},
                           tooltip: 'Share',
                           constraints: const BoxConstraints(),
                           padding: EdgeInsets.zero,
                        ),
                     ],
                  ),
               ),
            ],
         ),
      );
  }


   Widget _buildSavedTemplatesWidget() {
     return ClinicalGlassPanel(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
               Text(
                 'Saved Templates',
                 style: PrimeCareTheme.typography.h3.copyWith(
                   color: PrimeCareTheme.colors.navyIndigo,
                 ),
               ),
               Icon(LucideIcons.bookmark, color: PrimeCareTheme.colors.emeraldTeal, size: 20),
            ],
          ),
          const SizedBox(height: 24),
          _buildTemplateItem('Board Meeting Macro', 'Comprehensive financial & operational rollup.'),
          const SizedBox(height: 16),
          _buildTemplateItem('Regional Comparisons', 'YTD region vs region target analysis.'),
          const SizedBox(height: 16),
          _buildTemplateItem('HR Audit Summary', 'Headcount, retention, and diversity metrics.'),
          const SizedBox(height: 16),
          _buildTemplateItem('Cybersecurity Status', 'Threat mitigations and SLA compliance.'),
        ],
      )
     );
   }

   Widget _buildTemplateItem(String title, String subtitle) {
      return Container(
         padding: const EdgeInsets.all(16),
         decoration: BoxDecoration(
            color: PrimeCareTheme.colors.surfaceContainerLow,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: PrimeCareTheme.colors.surfaceContainerHighest),
         ),
         child: Row(
            children: [
               Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                     color: PrimeCareTheme.colors.emeraldTeal.withValues(alpha: 0.1),
                     borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(LucideIcons.layoutTemplate, color: PrimeCareTheme.colors.emeraldTeal, size: 20),
               ),
               const SizedBox(width: 16),
               Expanded(
                  child: Column(
                     crossAxisAlignment: CrossAxisAlignment.start,
                     children: [
                        Text(title, style: PrimeCareTheme.typography.body.copyWith(color: PrimeCareTheme.colors.navyIndigo, fontWeight: FontWeight.bold)),
                        const SizedBox(height: 4),
                        Text(subtitle, style: PrimeCareTheme.typography.label.copyWith(color: PrimeCareTheme.colors.slateGray), maxLines: 2, overflow: TextOverflow.ellipsis,),
                     ],
                  ),
               ),
               Icon(LucideIcons.chevronRight, color: PrimeCareTheme.colors.slateGray, size: 18),
            ],
         ),
      );
   }

}
