import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:primecare_v4/design_system/clinical_glass.dart';
import 'package:primecare_v4/design_system/primecare_theme.dart';

class CfoInvoicesScreen extends ConsumerStatefulWidget {
  const CfoInvoicesScreen({super.key});

  @override
  ConsumerState<CfoInvoicesScreen> createState() => _CfoInvoicesScreenState();
}

class _CfoInvoicesScreenState extends ConsumerState<CfoInvoicesScreen> {
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
                  child: _buildRecentInvoicesTable(),
                ),
                const SizedBox(width: 32),
                Expanded(
                  flex: 2,
                  child: _buildInvoiceStatus(),
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
                  'Corporate Invoicing',
                  style: PrimeCareTheme.typography.heroTitle.copyWith(
                    color: PrimeCareTheme.colors.navyIndigo,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              'Enterprise management of generated invoices, statuses, and collections.',
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
                 icon: LucideIcons.plus,
                 label: 'New Invoice',
                 isActive: true, // Primary Action
               ),
               const SizedBox(width: 16),
              ClinicalGlassButton(
                onPressed: () {},
                icon: LucideIcons.calendar,
                label: 'YTD',
                isActive: false,
              ),
           ],
        )
      ],
    );
  }

  Widget _buildKPIs() {
    return Row(
      children: [
        Expanded(
          child: _buildMetricCard(
             title: 'Total Invoices YTD',
             value: '4,285',
             icon: LucideIcons.fileText,
             trend: '+15% vs Last Year',
             isPositive: true,
          ),
        ),
        const SizedBox(width: 24),
        Expanded(
          child: _buildMetricCard(
            title: 'Invoiced Amount YTD',
            value: '\$28.5M',
            icon: LucideIcons.dollarSign,
            trend: '+12.4% vs Last Year',
            isPositive: true,
          ),
        ),
        const SizedBox(width: 24),
         Expanded(
          child: _buildMetricCard(
             title: 'Collected YTD',
             value: '\$25.7M',
             icon: LucideIcons.checkCircle,
             trend: '90% Collection Rate',
             isPositive: true,
          ),
        ),
        const SizedBox(width: 24),
        Expanded(
          child: _buildMetricCard(
            title: 'Voided / Cancelled',
            value: '42',
            icon: LucideIcons.xCircle,
            trend: '<\$100K Value',
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
      trendColor = const Color(0xFFE11D48); 
      iconColor = const Color(0xFFE11D48);
    } else if (isPositive) {
      trendColor = PrimeCareTheme.colors.emeraldTeal;
      iconColor = PrimeCareTheme.colors.emeraldTeal;
    } else if (isNeutral) {
      trendColor = PrimeCareTheme.colors.slateGray;
      iconColor = PrimeCareTheme.colors.slateGray;
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

   Widget _buildInvoiceStatus() {
     return ClinicalGlassPanel(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
           Text(
             'Status Breakdown (YTD)',
             style: PrimeCareTheme.typography.h3.copyWith(
               color: PrimeCareTheme.colors.navyIndigo,
             ),
           ),
           const SizedBox(height: 24),
           _buildStatusRow('Paid', '3,850', 90, PrimeCareTheme.colors.emeraldTeal),
           const SizedBox(height: 16),
           _buildStatusRow('Sent (Awaiting Payment)', '350', 8, Colors.amber.shade700),
           const SizedBox(height: 16),
           _buildStatusRow('Draft', '43', 1, PrimeCareTheme.colors.navyIndigo),
           const SizedBox(height: 16),
           _buildStatusRow('Voided / Cancelled', '42', 1, PrimeCareTheme.colors.slateGray),
        ],
      )
     );
  }

  Widget _buildStatusRow(String status, String count, int percentage, Color color) {
     return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
           Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                 Text(status, style: PrimeCareTheme.typography.body.copyWith(color: PrimeCareTheme.colors.navyIndigo, fontWeight: FontWeight.bold)),
                 Text(count, style: PrimeCareTheme.typography.body.copyWith(color: PrimeCareTheme.colors.slateGray, fontWeight: FontWeight.bold)),
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

   Widget _buildRecentInvoicesTable() {
     return ClinicalGlassPanel(
       padding: EdgeInsets.zero,
       child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
             Padding(
                padding: const EdgeInsets.all(24.0),
                child: Text(
                  'Recent Invoices',
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
                     Expanded(flex: 1, child: Text('INV #', style: PrimeCareTheme.typography.label.copyWith(fontSize: 11, color: PrimeCareTheme.colors.slateGray, fontWeight: FontWeight.bold))),
                     Expanded(flex: 2, child: Text('CLIENT', style: PrimeCareTheme.typography.label.copyWith(fontSize: 11, color: PrimeCareTheme.colors.slateGray, fontWeight: FontWeight.bold))),
                     Expanded(flex: 2, child: Text('DATE', style: PrimeCareTheme.typography.label.copyWith(fontSize: 11, color: PrimeCareTheme.colors.slateGray, fontWeight: FontWeight.bold))),
                     Expanded(flex: 2, child: Text('AMOUNT', textAlign: TextAlign.right, style: PrimeCareTheme.typography.label.copyWith(fontSize: 11, color: PrimeCareTheme.colors.slateGray, fontWeight: FontWeight.bold))),
                     Expanded(flex: 2, child: Text('STATUS', textAlign: TextAlign.right, style: PrimeCareTheme.typography.label.copyWith(fontSize: 11, color: PrimeCareTheme.colors.slateGray, fontWeight: FontWeight.bold))),
                  ],
               ),
            ),
            _buildInvoiceRecordRow('INV-2026-4286', 'Ministry of Health', 'Apr 06, 2026', '\$12,500.00', 'Sent'),
            Divider(height: 1, color: PrimeCareTheme.colors.surfaceContainerHighest),
            _buildInvoiceRecordRow('INV-2026-4285', 'City Hospital', 'Apr 05, 2026', '\$8,200.00', 'Paid'),
            Divider(height: 1, color: PrimeCareTheme.colors.surfaceContainerHighest),
            _buildInvoiceRecordRow('INV-2026-4284', 'Oakville Retirement', 'Apr 04, 2026', '\$4,500.00', 'Paid'),
            Divider(height: 1, color: PrimeCareTheme.colors.surfaceContainerHighest),
             _buildInvoiceRecordRow('INV-2026-4283', 'Regional Authority', 'Apr 02, 2026', '\$15,100.00', 'Sent'),
             Divider(height: 1, color: PrimeCareTheme.colors.surfaceContainerHighest),
            _buildInvoiceRecordRow('INV-2026-4282', 'Provincial Funding', 'Apr 01, 2026', '\$22,000.00', 'Paid'),
             const SizedBox(height: 8),
          ],
       ),
     );
   }

   Widget _buildInvoiceRecordRow(String invoiceNo, String client, String date, String amount, String status) {
      Color statusColor = PrimeCareTheme.colors.emeraldTeal;
      if (status == 'Sent') {
         statusColor = Colors.amber.shade700; 
      } else if (status == 'Voided') {
         statusColor = PrimeCareTheme.colors.slateGray;
      }

      return Padding(
         padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
         child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
               Expanded(flex: 1, child: Text(invoiceNo, style: PrimeCareTheme.typography.body.copyWith(color: PrimeCareTheme.colors.navyIndigo, fontWeight: FontWeight.bold))),
               Expanded(flex: 2, child: Text(client, style: PrimeCareTheme.typography.body.copyWith(color: PrimeCareTheme.colors.navyIndigo))),
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
