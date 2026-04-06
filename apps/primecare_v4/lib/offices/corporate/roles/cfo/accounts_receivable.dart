import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:primecare_v4/design_system/clinical_glass.dart';
import 'package:primecare_v4/design_system/primecare_theme.dart';

class CfoAccountsReceivableScreen extends ConsumerStatefulWidget {
  const CfoAccountsReceivableScreen({super.key});

  @override
  ConsumerState<CfoAccountsReceivableScreen> createState() => _CfoAccountsReceivableScreenState();
}

class _CfoAccountsReceivableScreenState extends ConsumerState<CfoAccountsReceivableScreen> {
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
                  flex: 2,
                  child: _buildAgingSummary(),
                ),
                const SizedBox(width: 32),
                Expanded(
                  flex: 3,
                  child: _buildOutstandingInvoicesTable(),
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
                Icon(LucideIcons.fileInput, color: PrimeCareTheme.colors.navyIndigo, size: 28),
                const SizedBox(width: 12),
                Text(
                  'Accounts Receivable',
                  style: PrimeCareTheme.typography.heroTitle.copyWith(
                    color: PrimeCareTheme.colors.navyIndigo,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              'Enterprise tracking of outstanding invoices, collection status, and aging summary.',
              style: PrimeCareTheme.typography.body.copyWith(
                color: PrimeCareTheme.colors.slateGray,
              ),
            ),
          ],
        ),
        ClinicalGlassButton(
          onPressed: () {},
          icon: LucideIcons.calendar,
          label: 'As of Today',
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
             title: 'Total Outstanding AR',
             value: '\$2.8M',
             icon: LucideIcons.creditCard,
             trend: '-1.5% vs Last Month',
             isPositive: true,
          ),
        ),
        const SizedBox(width: 24),
        Expanded(
          child: _buildMetricCard(
            title: 'Days Sales Outstanding',
            value: '42 Days',
            icon: LucideIcons.calendarClock,
            trend: '+3 Days vs Target',
            isWarning: true,
          ),
        ),
        const SizedBox(width: 24),
         Expanded(
          child: _buildMetricCard(
             title: 'Current (0-30 Days)',
             value: '\$1.9M',
             icon: LucideIcons.checkCircle,
             trend: '68% of Total AR',
             isPositive: true,
          ),
        ),
        const SizedBox(width: 24),
        Expanded(
          child: _buildMetricCard(
            title: '>90 Days Past Due',
            value: '\$145K',
            icon: LucideIcons.alertTriangle,
            trend: 'Requires Collection Action',
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
      trendColor = const Color(0xFFE11D48); // Ruby Red for high risk
      iconColor = const Color(0xFFE11D48);
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

   Widget _buildAgingSummary() {
     return ClinicalGlassPanel(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
           Text(
             'AR Aging Summary',
             style: PrimeCareTheme.typography.h3.copyWith(
               color: PrimeCareTheme.colors.navyIndigo,
             ),
           ),
           const SizedBox(height: 24),
           _buildAgingRow('Current', '\$1,900,000', 68, PrimeCareTheme.colors.emeraldTeal),
            const SizedBox(height: 16),
             _buildAgingRow('1-30 Days Past Due', '\$450,000', 16, Colors.amber.shade600),
            const SizedBox(height: 16),
             _buildAgingRow('31-60 Days Past Due', '\$205,000', 7, Colors.orange.shade700),
            const SizedBox(height: 16),
             _buildAgingRow('61-90 Days Past Due', '\$100,000', 4, const Color(0xFFE11D48).withValues(alpha: 0.8)),
            const SizedBox(height: 16),
             _buildAgingRow('>90 Days Past Due', '\$145,000', 5, const Color(0xFFE11D48)),
        ],
      )
     );
  }

  Widget _buildAgingRow(String bucket, String amount, int percentage, Color color) {
     return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
           Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                 Text(bucket, style: PrimeCareTheme.typography.body.copyWith(color: PrimeCareTheme.colors.navyIndigo, fontWeight: FontWeight.bold)),
                 Text(amount, style: PrimeCareTheme.typography.body.copyWith(color: PrimeCareTheme.colors.slateGray, fontWeight: FontWeight.bold)),
              ],
           ),
           const SizedBox(height: 8),
            Row(
               children: [
                  Expanded(
                     child: Container(
                        height: 8,
                        decoration: BoxDecoration(
                           color: PrimeCareTheme.colors.surfaceContainerHighest,
                           borderRadius: BorderRadius.circular(4),
                        ),
                        child: FractionallySizedBox(
                           alignment: Alignment.centerLeft,
                           widthFactor: percentage / 100,
                           child: Container(
                              decoration: BoxDecoration(
                                 color: color,
                                 borderRadius: BorderRadius.circular(4),
                              ),
                           ),
                        ),
                     ),
                  ),
                  const SizedBox(width: 12),
                  SizedBox(
                     width: 40,
                     child: Text('$percentage%', style: PrimeCareTheme.typography.label.copyWith(color: PrimeCareTheme.colors.slateGray), textAlign: TextAlign.right),
                  )
               ],
            )
        ],
     );
  }

   Widget _buildOutstandingInvoicesTable() {
     return ClinicalGlassPanel(
       padding: EdgeInsets.zero,
       child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
             Padding(
                padding: const EdgeInsets.all(24.0),
                child: Text(
                  'Largest Outstanding Invoices',
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
                     Expanded(flex: 3, child: Text('CLIENT / PARTNER', style: PrimeCareTheme.typography.label.copyWith(fontSize: 11, color: PrimeCareTheme.colors.slateGray, fontWeight: FontWeight.bold))),
                     Expanded(flex: 2, child: Text('INVOICE DATE', style: PrimeCareTheme.typography.label.copyWith(fontSize: 11, color: PrimeCareTheme.colors.slateGray, fontWeight: FontWeight.bold))),
                      Expanded(flex: 2, child: Text('AMOUNT', textAlign: TextAlign.right, style: PrimeCareTheme.typography.label.copyWith(fontSize: 11, color: PrimeCareTheme.colors.slateGray, fontWeight: FontWeight.bold))),
                     Expanded(flex: 2, child: Text('STATUS', textAlign: TextAlign.right, style: PrimeCareTheme.typography.label.copyWith(fontSize: 11, color: PrimeCareTheme.colors.slateGray, fontWeight: FontWeight.bold))),
                  ],
               ),
            ),
            _buildInvoiceRow('Ministry of Health (ON)', 'Mar 01, 2026', '\$420,500', 'Current'),
            Divider(height: 1, color: PrimeCareTheme.colors.surfaceContainerHighest),
            _buildInvoiceRow('City Hospital Group', 'Feb 15, 2026', '\$185,000', '1-30 Days'),
            Divider(height: 1, color: PrimeCareTheme.colors.surfaceContainerHighest),
            _buildInvoiceRow('Regional Health Authority', 'Jan 10, 2026', '\$95,200', '31-60 Days'),
            Divider(height: 1, color: PrimeCareTheme.colors.surfaceContainerHighest),
             _buildInvoiceRow('Oakville Retirement Network', 'Dec 05, 2025', '\$72,100', '>90 Days'),
             Divider(height: 1, color: PrimeCareTheme.colors.surfaceContainerHighest),
            _buildInvoiceRow('Provincial Funding Body', 'Mar 15, 2026', '\$210,000', 'Current'),
             const SizedBox(height: 8),
          ],
       ),
     );
   }

   Widget _buildInvoiceRow(String client, String date, String amount, String status) {
      Color statusColor = PrimeCareTheme.colors.emeraldTeal;
      if (status == '>90 Days' || status == '61-90 Days') {
         statusColor = const Color(0xFFE11D48); // Ruby Red
      } else if (status == '31-60 Days' || status == '1-30 Days') {
         statusColor = Colors.amber.shade700;
      }

      return Padding(
         padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
         child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
               Expanded(flex: 3, child: Text(client, style: PrimeCareTheme.typography.body.copyWith(color: PrimeCareTheme.colors.navyIndigo, fontWeight: FontWeight.bold))),
               Expanded(flex: 2, child: Text(date, style: PrimeCareTheme.typography.body.copyWith(color: PrimeCareTheme.colors.slateGray))),
                Expanded(flex: 2, child: Text(amount, textAlign: TextAlign.right, style: PrimeCareTheme.typography.body.copyWith(color: PrimeCareTheme.colors.navyIndigo, fontWeight: FontWeight.bold))),
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
