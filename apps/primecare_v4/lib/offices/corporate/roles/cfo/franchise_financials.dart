import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:primecare_v4/design_system/clinical_glass.dart';
import 'package:primecare_v4/design_system/primecare_theme.dart';

class CfoFranchiseFinancialsScreen extends ConsumerStatefulWidget {
  const CfoFranchiseFinancialsScreen({super.key});

  @override
  ConsumerState<CfoFranchiseFinancialsScreen> createState() => _CfoFranchiseFinancialsScreenState();
}

class _CfoFranchiseFinancialsScreenState extends ConsumerState<CfoFranchiseFinancialsScreen> {
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
                  child: _buildFranchiseHealthTable(),
                ),
                const SizedBox(width: 32),
                Expanded(
                  flex: 2,
                  child: _buildTopPerformingFranchises(),
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
                Icon(LucideIcons.store, color: PrimeCareTheme.colors.navyIndigo, size: 28),
                const SizedBox(width: 12),
                Text(
                  'Franchise Financials',
                  style: PrimeCareTheme.typography.heroTitle.copyWith(
                    color: PrimeCareTheme.colors.navyIndigo,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              'Enterprise oversight of franchise network financial health and royalty compliance.',
              style: PrimeCareTheme.typography.body.copyWith(
                color: PrimeCareTheme.colors.slateGray,
              ),
            ),
          ],
        ),
        ClinicalGlassButton(
          onPressed: () {},
          icon: LucideIcons.calendar,
          label: 'This Quater',
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
            title: 'Total Franchise Revenue',
            value: '\$14.2M',
            icon: LucideIcons.barChart2,
            trend: '+5.4% vs Last Q',
            isPositive: true,
          ),
        ),
        const SizedBox(width: 24),
        Expanded(
          child: _buildMetricCard(
            title: 'Royalties Collected',
            value: '\$1.1M',
            icon: LucideIcons.checkCircle,
            trend: '92% Collection Rate',
            isPositive: true,
          ),
        ),
        const SizedBox(width: 24),
        Expanded(
          child: _buildMetricCard(
            title: 'Pending Royalties',
            value: '\$85K',
            icon: LucideIcons.clock,
            trend: 'Net 30 terms',
            isNeutral: true,
          ),
        ),
        const SizedBox(width: 24),
        Expanded(
          child: _buildMetricCard(
            title: 'Overdue Royalties',
            value: '\$12K',
            icon: LucideIcons.alertTriangle,
            trend: 'Requires Action',
            isWarning: true,
          ),
        ),
      ],
    );
  }

  Widget _buildMetricCard({required String title, required String value, required IconData icon, required String trend, bool isWarning = false, bool isPositive = false, bool isNeutral = false}) {
    Color trendColor = PrimeCareTheme.colors.slateGray;
    Color iconColor = PrimeCareTheme.colors.navyIndigo;
    
    if (isWarning) {
      trendColor = const Color(0xFFE11D48); // Ruby Red for warnings
      iconColor = const Color(0xFFE11D48);
    } else if (isPositive) {
      trendColor = PrimeCareTheme.colors.emeraldTeal;
      iconColor = PrimeCareTheme.colors.emeraldTeal;
    } else if (isNeutral) {
      trendColor = Colors.amber.shade700;
      iconColor = Colors.amber.shade700;
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

  Widget _buildTopPerformingFranchises() {
     return ClinicalGlassPanel(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
           Text(
             'Top Performers (QTR)',
             style: PrimeCareTheme.typography.h3.copyWith(
               color: PrimeCareTheme.colors.navyIndigo,
             ),
           ),
           const SizedBox(height: 24),
           _buildPerformerRow('PrimeCare Toronto Central', '\$1.2M Rev', '+\$45K YoY', true),
            const SizedBox(height: 16),
             _buildPerformerRow('PrimeCare Vancouver West', '\$980K Rev', '+\$22K YoY', true),
            const SizedBox(height: 16),
             _buildPerformerRow('PrimeCare Calgary South', '\$850K Rev', '+\$18K YoY', true),
            const SizedBox(height: 16),
             _buildPerformerRow('PrimeCare Ottawa Valley', '\$720K Rev', '-\$5K YoY', false),
        ],
      )
     );
  }

  Widget _buildPerformerRow(String name, String metric, String trend, bool isPositive) {
     return Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
           color: PrimeCareTheme.colors.surfaceContainerLow,
           borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
           mainAxisAlignment: MainAxisAlignment.spaceBetween,
           children: [
              Column(
                 crossAxisAlignment: CrossAxisAlignment.start,
                 children: [
                    Text(name, style: PrimeCareTheme.typography.body.copyWith(color: PrimeCareTheme.colors.navyIndigo, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 4),
                    Text(metric, style: PrimeCareTheme.typography.label.copyWith(color: PrimeCareTheme.colors.slateGray)),
                 ],
              ),
              Container(
                 padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                 decoration: BoxDecoration(
                    color: isPositive ? PrimeCareTheme.colors.emeraldTeal.withValues(alpha: 0.1) : const Color(0xFFE11D48).withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(8),
                 ),
                 child: Text(trend, style: PrimeCareTheme.typography.label.copyWith(color: isPositive ? PrimeCareTheme.colors.emeraldTeal : const Color(0xFFE11D48), fontWeight: FontWeight.bold)),
              )
           ],
        ),
     );
  }

   Widget _buildFranchiseHealthTable() {
     return ClinicalGlassPanel(
       padding: EdgeInsets.zero,
       child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
             Padding(
                padding: const EdgeInsets.all(24.0),
                child: Text(
                  'Franchise Health Scorecard',
                  style: PrimeCareTheme.typography.h3.copyWith(
                    color: PrimeCareTheme.colors.navyIndigo,
                  ),
                ),
             ),
             Container(
               padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
               color: PrimeCareTheme.colors.surfaceContainerLow,
               child: Row(
                  children: [
                     Expanded(flex: 3, child: Text('FRANCHISE', style: PrimeCareTheme.typography.label.copyWith(fontSize: 11, color: PrimeCareTheme.colors.slateGray, fontWeight: FontWeight.bold))),
                     Expanded(flex: 2, child: Text('REVENUE', style: PrimeCareTheme.typography.label.copyWith(fontSize: 11, color: PrimeCareTheme.colors.slateGray, fontWeight: FontWeight.bold))),
                      Expanded(flex: 2, child: Text('ROYALTIES', style: PrimeCareTheme.typography.label.copyWith(fontSize: 11, color: PrimeCareTheme.colors.slateGray, fontWeight: FontWeight.bold))),
                     Expanded(flex: 2, child: Text('STATUS', textAlign: TextAlign.right, style: PrimeCareTheme.typography.label.copyWith(fontSize: 11, color: PrimeCareTheme.colors.slateGray, fontWeight: FontWeight.bold))),
                  ],
               ),
            ),
            _buildHealthRow('Toronto Central', '\$1,200,000', '\$96,000', 'Healthy'),
            Divider(height: 1, color: PrimeCareTheme.colors.surfaceContainerHighest),
            _buildHealthRow('Vancouver West', '\$980,000', '\$78,400', 'Healthy'),
            Divider(height: 1, color: PrimeCareTheme.colors.surfaceContainerHighest),
            _buildHealthRow('Calgary South', '\$850,000', '\$68,000', 'Warning'),
            Divider(height: 1, color: PrimeCareTheme.colors.surfaceContainerHighest),
             _buildHealthRow('Edmonton North', '\$450,000', '\$36,000', 'Critical'),
             Divider(height: 1, color: PrimeCareTheme.colors.surfaceContainerHighest),
            _buildHealthRow('Ottawa Valley', '\$720,000', '\$57,600', 'Healthy'),
             const SizedBox(height: 8),
          ],
       ),
     );
   }

   Widget _buildHealthRow(String name, String revenue, String royalties, String status) {
      Color statusColor = PrimeCareTheme.colors.emeraldTeal;
      if (status == 'Critical') {
         statusColor = const Color(0xFFE11D48); // Ruby Red
      } else if (status == 'Warning') {
         statusColor = Colors.amber.shade700;
      }

      return Padding(
         padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
         child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
               Expanded(flex: 3, child: Text(name, style: PrimeCareTheme.typography.body.copyWith(color: PrimeCareTheme.colors.navyIndigo, fontWeight: FontWeight.bold))),
               Expanded(flex: 2, child: Text(revenue, style: PrimeCareTheme.typography.body.copyWith(color: PrimeCareTheme.colors.slateGray))),
                Expanded(flex: 2, child: Text(royalties, style: PrimeCareTheme.typography.body.copyWith(color: PrimeCareTheme.colors.slateGray))),
               Expanded(
                  flex: 2,
                   child: Align(
                     alignment: Alignment.centerRight,
                     child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                        decoration: BoxDecoration(color: statusColor.withValues(alpha: 0.1), borderRadius: BorderRadius.circular(12)),
                        child: Text(status, style: PrimeCareTheme.typography.label.copyWith(color: statusColor, fontWeight: FontWeight.bold)),
                     ),
                  ),
               ),
            ],
         ),
      );
   }
}
