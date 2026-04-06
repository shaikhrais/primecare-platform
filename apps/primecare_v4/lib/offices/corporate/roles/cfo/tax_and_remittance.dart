import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:primecare_v4/design_system/clinical_glass.dart';
import 'package:primecare_v4/design_system/primecare_theme.dart';

class CfoTaxAndRemittanceScreen extends ConsumerStatefulWidget {
  const CfoTaxAndRemittanceScreen({super.key});

  @override
  ConsumerState<CfoTaxAndRemittanceScreen> createState() => _CfoTaxAndRemittanceScreenState();
}

class _CfoTaxAndRemittanceScreenState extends ConsumerState<CfoTaxAndRemittanceScreen> {
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
                  child: _buildTaxByJurisdictionTable(),
                ),
                const SizedBox(width: 32),
                Expanded(
                  flex: 2,
                  child: _buildRemittanceSchedule(),
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
                Icon(LucideIcons.landmark, color: PrimeCareTheme.colors.navyIndigo, size: 28),
                const SizedBox(width: 12),
                Text(
                  'Tax & Remittance Hub',
                  style: PrimeCareTheme.typography.heroTitle.copyWith(
                    color: PrimeCareTheme.colors.navyIndigo,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              'Enterprise overview of estimated tax liabilities, accrued taxes, and scheduled remittances.',
              style: PrimeCareTheme.typography.body.copyWith(
                color: PrimeCareTheme.colors.slateGray,
              ),
            ),
          ],
        ),
        ClinicalGlassButton(
          onPressed: () {},
          icon: LucideIcons.calendar,
          label: 'Q2 2026',
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
             title: 'Estimated Tax Liability',
             value: '\$2.1M',
             icon: LucideIcons.calculator,
             trend: 'For Current Quarter',
             isNeutral: true,
          ),
        ),
        const SizedBox(width: 24),
        Expanded(
          child: _buildMetricCard(
            title: 'Next Remittance Due',
            value: '\$450K',
            icon: LucideIcons.calendarClock,
            trend: 'Due in 14 Days',
            isWarning: true,
          ),
        ),
        const SizedBox(width: 24),
         Expanded(
          child: _buildMetricCard(
             title: 'Total Remitted YTD',
             value: '\$1.8M',
             icon: LucideIcons.checkSquare,
             trend: '100% Compliant',
             isPositive: true,
          ),
        ),
        const SizedBox(width: 24),
        Expanded(
          child: _buildMetricCard(
            title: 'Unfiled Returns',
            value: '0',
            icon: LucideIcons.fileX,
            trend: 'All filings up to date',
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
      trendColor = Colors.amber.shade700; // Amber for approaching deadlines
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

   Widget _buildRemittanceSchedule() {
     return ClinicalGlassPanel(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
           Text(
             'Upcoming Remittances',
             style: PrimeCareTheme.typography.h3.copyWith(
               color: PrimeCareTheme.colors.navyIndigo,
             ),
           ),
           const SizedBox(height: 24),
           _buildScheduleRow('CRA - Corporate Income Tax (Q2 Installer)', 'Apr 15', '\$450,000', true),
           const SizedBox(height: 16),
           _buildScheduleRow('CRA - HST/GST Remittance (March)', 'Apr 30', '\$125,000', false),
           const SizedBox(height: 16),
           _buildScheduleRow('Ministry of Finance BC - PST', 'Apr 30', '\$42,000', false),
           const SizedBox(height: 16),
           _buildScheduleRow('Revenu Québec - QST', 'Apr 30', '\$85,000', false),
            const SizedBox(height: 16),
           _buildScheduleRow('CRA - Payroll Source Deductions', 'May 15', '\$98,000', false),
        ],
      )
     );
  }

  Widget _buildScheduleRow(String item, String date, String amount, bool isUrgent) {
     return Container(
         padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
           color: PrimeCareTheme.colors.surfaceContainerLow,
           borderRadius: BorderRadius.circular(12),
           border: isUrgent ? Border.all(color: Colors.amber.shade700, width: 1) : null,
        ),
        child: Row(
           mainAxisAlignment: MainAxisAlignment.spaceBetween,
           children: [
              Expanded(
                child: Column(
                   crossAxisAlignment: CrossAxisAlignment.start,
                   children: [
                      Text(item, style: PrimeCareTheme.typography.body.copyWith(color: PrimeCareTheme.colors.navyIndigo, fontWeight: FontWeight.bold), overflow: TextOverflow.ellipsis),
                      const SizedBox(height: 4),
                      Text('Due: $date', style: PrimeCareTheme.typography.label.copyWith(color: isUrgent ? Colors.amber.shade700 : PrimeCareTheme.colors.slateGray, fontWeight: isUrgent ? FontWeight.bold : FontWeight.normal)),
                   ],
                ),
              ),
               Text(amount, style: PrimeCareTheme.typography.body.copyWith(color: PrimeCareTheme.colors.navyIndigo, fontWeight: FontWeight.bold)),
           ],
        ),
     );
  }

   Widget _buildTaxByJurisdictionTable() {
     return ClinicalGlassPanel(
       padding: EdgeInsets.zero,
       child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
             Padding(
                padding: const EdgeInsets.all(24.0),
                child: Text(
                  'Tax Accrual By Jurisdiction',
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
                     Expanded(flex: 2, child: Text('JURISDICTION', style: PrimeCareTheme.typography.label.copyWith(fontSize: 11, color: PrimeCareTheme.colors.slateGray, fontWeight: FontWeight.bold))),
                     Expanded(flex: 3, child: Text('TAX TYPE', style: PrimeCareTheme.typography.label.copyWith(fontSize: 11, color: PrimeCareTheme.colors.slateGray, fontWeight: FontWeight.bold))),
                     Expanded(flex: 2, child: Text('ACCRUED', textAlign: TextAlign.right, style: PrimeCareTheme.typography.label.copyWith(fontSize: 11, color: PrimeCareTheme.colors.slateGray, fontWeight: FontWeight.bold))),
                     Expanded(flex: 2, child: Text('REMITTED (YTD)', textAlign: TextAlign.right, style: PrimeCareTheme.typography.label.copyWith(fontSize: 11, color: PrimeCareTheme.colors.slateGray, fontWeight: FontWeight.bold))),
                  ],
               ),
            ),
            _buildJurisdictionRow('Federal (CRA)', 'Corporate Income Tax (CIT)', '\$1,200,000', '\$600,000'),
            Divider(height: 1, color: PrimeCareTheme.colors.surfaceContainerHighest),
            _buildJurisdictionRow('Federal (CRA)', 'HST / GST', '\$350,000', '\$225,000'),
            Divider(height: 1, color: PrimeCareTheme.colors.surfaceContainerHighest),
            _buildJurisdictionRow('British Columbia', 'Provincial Sales Tax (PST)', '\$125,000', '\$83,000'),
            Divider(height: 1, color: PrimeCareTheme.colors.surfaceContainerHighest),
             _buildJurisdictionRow('Quebec', 'Quebec Sales Tax (QST)', '\$180,000', '\$95,000'),
             Divider(height: 1, color: PrimeCareTheme.colors.surfaceContainerHighest),
            _buildJurisdictionRow('Alberta', 'Corporate Income Tax (Prov)', '\$245,000', '\$245,000'),
             const SizedBox(height: 8),
          ],
       ),
     );
   }

   Widget _buildJurisdictionRow(String jurisdiction, String type, String accrued, String paid) {
      return Padding(
         padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
         child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
               Expanded(flex: 2, child: Text(jurisdiction, style: PrimeCareTheme.typography.body.copyWith(color: PrimeCareTheme.colors.navyIndigo, fontWeight: FontWeight.bold))),
               Expanded(flex: 3, child: Text(type, style: PrimeCareTheme.typography.body.copyWith(color: PrimeCareTheme.colors.slateGray))),
                Expanded(flex: 2, child: Text(accrued, textAlign: TextAlign.right, style: PrimeCareTheme.typography.body.copyWith(color: PrimeCareTheme.colors.navyIndigo, fontWeight: FontWeight.bold))),
               Expanded(flex: 2, child: Text(paid, textAlign: TextAlign.right, style: PrimeCareTheme.typography.body.copyWith(color: PrimeCareTheme.colors.emeraldTeal, fontWeight: FontWeight.bold))),
            ],
         ),
      );
   }
}
