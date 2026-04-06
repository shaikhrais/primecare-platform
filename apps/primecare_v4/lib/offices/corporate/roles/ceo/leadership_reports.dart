import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:primecare_v4/design_system/clinical_glass.dart';
import 'package:primecare_v4/design_system/primecare_theme.dart';

class CeoLeadershipReportsScreen extends ConsumerStatefulWidget {
  const CeoLeadershipReportsScreen({super.key});

  @override
  ConsumerState<CeoLeadershipReportsScreen> createState() => _CeoLeadershipReportsScreenState();
}

class _CeoLeadershipReportsScreenState extends ConsumerState<CeoLeadershipReportsScreen> {
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
                  child: _buildReportsArchiveTable(),
                ),
                const SizedBox(width: 32),
                Expanded(
                  flex: 1,
                  child: Column(
                    children: [
                      _buildQuickGenerateWidget(),
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
                Icon(LucideIcons.fileText, color: PrimeCareTheme.colors.navyIndigo, size: 28),
                const SizedBox(width: 12),
                Text(
                  'Leadership Reports',
                  style: PrimeCareTheme.typography.heroTitle.copyWith(
                    color: PrimeCareTheme.colors.navyIndigo,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              'Access, generate, and organize high-level executive briefing documents.',
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
                icon: LucideIcons.calendarClock,
                label: 'View Schedule',
                isActive: false,
              ),
              const SizedBox(width: 16),
              ClinicalGlassButton(
                onPressed: () {},
                icon: LucideIcons.plus,
                label: 'Custom Report',
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
             title: 'Total Reports generated',
             value: '1,248',
             icon: LucideIcons.files,
             trend: 'All time archive',
             isNeutral: true,
          ),
        ),
        const SizedBox(width: 24),
        Expanded(
          child: _buildMetricCard(
            title: 'Board Packages',
            value: '45',
            icon: LucideIcons.briefcase,
            trend: 'Last generated: Oct 1',
            isPositive: true,
          ),
        ),
        const SizedBox(width: 24),
         Expanded(
          child: _buildMetricCard(
             title: 'Audit Reports',
             value: '12',
             icon: LucideIcons.shieldCheck,
             trend: '100% Compliance',
             isPositive: true,
          ),
        ),
        const SizedBox(width: 24),
        Expanded(
          child: _buildMetricCard(
            title: 'Scheduled Reports',
            value: '18',
            icon: LucideIcons.clock,
            trend: 'Monthly/Quarterly',
            isNeutral: true,
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


  Widget _buildReportsArchiveTable() {
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
                        'Executive Reports Archive',
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
                            Text('Search reports...', style: PrimeCareTheme.typography.body.copyWith(color: PrimeCareTheme.colors.slateGray)),
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
                     Expanded(flex: 3, child: Text('REPORT NAME', style: PrimeCareTheme.typography.label.copyWith(fontSize: 11, color: PrimeCareTheme.colors.slateGray, fontWeight: FontWeight.bold))),
                     Expanded(flex: 2, child: Text('CATEGORY', style: PrimeCareTheme.typography.label.copyWith(fontSize: 11, color: PrimeCareTheme.colors.slateGray, fontWeight: FontWeight.bold))),
                     Expanded(flex: 2, child: Text('GENERATED BY', style: PrimeCareTheme.typography.label.copyWith(fontSize: 11, color: PrimeCareTheme.colors.slateGray, fontWeight: FontWeight.bold))),
                     Expanded(flex: 2, child: Text('DATE', style: PrimeCareTheme.typography.label.copyWith(fontSize: 11, color: PrimeCareTheme.colors.slateGray, fontWeight: FontWeight.bold))),
                     SizedBox(width: 60, child: Text('ACTION', textAlign: TextAlign.center, style: PrimeCareTheme.typography.label.copyWith(fontSize: 11, color: PrimeCareTheme.colors.slateGray, fontWeight: FontWeight.bold))),
                  ],
               ),
            ),
            _buildReportRow('Q3 2026 Board Package', 'Board Materials', 'System Auto', 'Oct 15, 2026'),
            Divider(height: 1, color: PrimeCareTheme.colors.surfaceContainerHighest),
            _buildReportRow('September Financial Summary', 'Financial', 'M. Chen (CFO)', 'Oct 05, 2026'),
            Divider(height: 1, color: PrimeCareTheme.colors.surfaceContainerHighest),
            _buildReportRow('Annual Compliance Audit', 'Audit', 'System Auto', 'Sep 30, 2026'),
            Divider(height: 1, color: PrimeCareTheme.colors.surfaceContainerHighest),
            _buildReportRow('Franchise Expansion Plan V2', 'Strategic', 'S. Jenkins (COO)', 'Sep 12, 2026'),
            Divider(height: 1, color: PrimeCareTheme.colors.surfaceContainerHighest),
            _buildReportRow('Q2 2026 Shareholder Update', 'Investor Relations', 'System Auto', 'Jul 15, 2026'),
        ],
      )
     );
  }

  Widget _buildReportRow(String name, String category, String author, String date) {
      Color categoryColor = PrimeCareTheme.colors.slateGray;
      if (category == 'Board Materials' || category == 'Investor Relations') categoryColor = PrimeCareTheme.colors.navyIndigo;
      if (category == 'Financial' || category == 'Strategic') categoryColor = PrimeCareTheme.colors.emeraldTeal;
      if (category == 'Audit') categoryColor = Colors.amber.shade700;

      return Padding(
         padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
         child: Row(
            children: [
               Expanded(
                  flex: 3,
                  child: Row(
                     children: [
                        Icon(LucideIcons.fileText, size: 16, color: PrimeCareTheme.colors.navyIndigo),
                        const SizedBox(width: 8),
                        Text(name, style: PrimeCareTheme.typography.body.copyWith(color: PrimeCareTheme.colors.navyIndigo, fontWeight: FontWeight.bold)),
                     ],
                  ),
               ),
               Expanded(
                  flex: 2,
                  child: Row(
                     children: [
                        Container(
                           padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                           decoration: BoxDecoration(color: categoryColor.withValues(alpha: 0.1), borderRadius: BorderRadius.circular(12)),
                           child: Text(category, style: PrimeCareTheme.typography.label.copyWith(color: categoryColor, fontWeight: FontWeight.bold)),
                        ),
                     ],
                  ),
               ),
               Expanded(flex: 2, child: Text(author, style: PrimeCareTheme.typography.body.copyWith(color: PrimeCareTheme.colors.slateGray))),
               Expanded(flex: 2, child: Text(date, style: PrimeCareTheme.typography.body.copyWith(color: PrimeCareTheme.colors.slateGray))),
               SizedBox(
                  width: 60,
                  child: Center(
                     child: IconButton(
                        icon: Icon(LucideIcons.download, color: PrimeCareTheme.colors.navyIndigo, size: 20),
                        onPressed: () {},
                     ),
                  ),
               ),
            ],
         ),
      );
  }


   Widget _buildQuickGenerateWidget() {
     return ClinicalGlassPanel(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
               Text(
                 'Quick Generate',
                 style: PrimeCareTheme.typography.h3.copyWith(
                   color: PrimeCareTheme.colors.navyIndigo,
                 ),
               ),
               Icon(LucideIcons.zap, color: Colors.amber.shade600, size: 20),
            ],
          ),
          const SizedBox(height: 24),
          _buildQuickAction('Monthly Financials', 'P&L, Balance Sheet, Cash Flow', LucideIcons.dollarSign),
          const SizedBox(height: 16),
          _buildQuickAction('Quarterly Biz Review', 'QBR deck for regional managers', LucideIcons.barChart2),
          const SizedBox(height: 16),
          _buildQuickAction('Annual Operations', 'Full year operational metrics', LucideIcons.activity),
        ],
      )
     );
   }

   Widget _buildQuickAction(String title, String subtitle, IconData icon) {
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
                     color: PrimeCareTheme.colors.navyIndigo.withValues(alpha: 0.1),
                     borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(icon, color: PrimeCareTheme.colors.navyIndigo, size: 20),
               ),
               const SizedBox(width: 16),
               Expanded(
                  child: Column(
                     crossAxisAlignment: CrossAxisAlignment.start,
                     children: [
                        Text(title, style: PrimeCareTheme.typography.body.copyWith(color: PrimeCareTheme.colors.navyIndigo, fontWeight: FontWeight.bold)),
                        const SizedBox(height: 4),
                        Text(subtitle, style: PrimeCareTheme.typography.label.copyWith(color: PrimeCareTheme.colors.slateGray)),
                     ],
                  ),
               ),
               Icon(LucideIcons.chevronRight, color: PrimeCareTheme.colors.slateGray, size: 18),
            ],
         ),
      );
   }

}
