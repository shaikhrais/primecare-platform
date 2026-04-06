import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:primecare_v4/design_system/primecare_theme.dart';
import 'package:primecare_v4/design_system/clinical_glass.dart';
import 'package:primecare_v4/shared/components/page_template.dart';

class ClientPaymentsScreen extends ConsumerWidget {
  const ClientPaymentsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return PageTemplate(
      title: 'Payments & Invoices',
      subtitle: 'Manage your financial accounts securely',
      icon: LucideIcons.creditCard,
      actions: [
        Container(
          decoration: BoxDecoration(
            color: PrimeCareTheme.primaryContainer,
            borderRadius: BorderRadius.circular(PrimeCareTheme.radiusXl),
            boxShadow: [
              BoxShadow(
                color: PrimeCareTheme.primary.withOpacity(0.08),
                blurRadius: 16,
                offset: const Offset(0, 4),
              )
            ],
          ),
          child: ElevatedButton.icon(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.transparent,
              shadowColor: Colors.transparent,
              padding: const EdgeInsets.symmetric(horizontal: PrimeCareTheme.spacing5, vertical: PrimeCareTheme.spacing3),
            ),
            icon: const Icon(LucideIcons.dollarSign, color: PrimeCareTheme.primary),
            label: Text('Make Payment', style: PrimeCareTheme.titleSmall.copyWith(color: PrimeCareTheme.primary)),
          ),
        ),
      ],
      body: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Left Column: Balances and Summaries
          Expanded(
            flex: 4,
            child: Column(
               children: [
                 // Balance Card
                 Container(
                    padding: const EdgeInsets.all(PrimeCareTheme.spacing6),
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [PrimeCareTheme.surfaceContainerLowest, PrimeCareTheme.surfaceContainerLow],
                      ),
                      borderRadius: BorderRadius.circular(PrimeCareTheme.radiusXl),
                      boxShadow: [
                        BoxShadow(
                          color: PrimeCareTheme.primary.withOpacity(0.04),
                          blurRadius: 24,
                          offset: const Offset(0, 8),
                        )
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                         Row(
                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
                           children: [
                             Text('Total Outstanding', style: PrimeCareTheme.titleMedium.copyWith(color: PrimeCareTheme.onSurfaceVariant)),
                             Container(
                               padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                               decoration: BoxDecoration(
                                 color: PrimeCareTheme.primaryContainer,
                                 borderRadius: BorderRadius.circular(4),
                               ),
                               child: Text('Current', style: PrimeCareTheme.labelSmall.copyWith(color: PrimeCareTheme.primary, fontWeight: FontWeight.bold)),
                             )
                           ],
                         ),
                         const SizedBox(height: PrimeCareTheme.spacing2),
                         Text('\$450.00', style: PrimeCareTheme.displayLarge.copyWith(fontWeight: FontWeight.bold)),
                         const SizedBox(height: PrimeCareTheme.spacing4),
                         Divider(color: PrimeCareTheme.surfaceContainerHighest.withOpacity(0.5), height: 1),
                         const SizedBox(height: PrimeCareTheme.spacing4),
                         _buildSummaryRow('Due Oct 15', '\$200.00', false),
                         const SizedBox(height: PrimeCareTheme.spacing2),
                         _buildSummaryRow('Due Nov 01', '\$250.00', true),
                      ],
                    ),
                 ),
                 const SizedBox(height: PrimeCareTheme.spacing6),
                 
                 // Payment Methods
                 ClinicalGlassPanel(
                    padding: const EdgeInsets.all(PrimeCareTheme.spacing5),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                         Row(
                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
                           children: [
                             Text('Payment Methods', style: PrimeCareTheme.titleLarge),
                             TextButton(onPressed: () {}, child: Text('Add New', style: PrimeCareTheme.titleSmall.copyWith(color: PrimeCareTheme.primary))),
                           ],
                         ),
                         const SizedBox(height: PrimeCareTheme.spacing4),
                         _buildPaymentMethodCard('Visa ending in 4242', 'Expires 12/28', LucideIcons.creditCard, true),
                         const SizedBox(height: PrimeCareTheme.spacing3),
                         _buildPaymentMethodCard('Scotiabank Chequing', '**** 9012', LucideIcons.landmark, false),
                      ],
                    ),
                 )
               ],
            ),
          ),
          const SizedBox(width: PrimeCareTheme.spacing5),

          // Right Column: Invoice History
          Expanded(
            flex: 6,
            child: ClinicalGlassPanel(
              padding: const EdgeInsets.all(PrimeCareTheme.spacing6),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                       Text('Invoice History', style: PrimeCareTheme.titleLarge),
                       IconButton(icon: const Icon(LucideIcons.filter, size: 20), onPressed: () {}),
                    ],
                  ),
                  const SizedBox(height: PrimeCareTheme.spacing5),
                  _buildInvoiceRow('INV-2026-098', 'Nursing Care (Sep)', 'Oct 1, 2026', '\$850.00', 'Paid', PrimeCareTheme.tertiary),
                  const SizedBox(height: PrimeCareTheme.spacing4),
                  _buildInvoiceRow('INV-2026-104', 'PT & Rehab Svcs', 'Oct 15, 2026', '\$200.00', 'Pending', PrimeCareTheme.primary),
                  const SizedBox(height: PrimeCareTheme.spacing4),
                  _buildInvoiceRow('INV-2026-119', 'Personal Support', 'Nov 1, 2026', '\$250.00', 'Upcoming', PrimeCareTheme.onSurfaceVariant),
                  const SizedBox(height: PrimeCareTheme.spacing4),
                  _buildInvoiceRow('INV-2026-042', 'Nursing Care (Aug)', 'Sep 1, 2026', '\$850.00', 'Paid', PrimeCareTheme.tertiary),
                  const SizedBox(height: PrimeCareTheme.spacing6),
                  Center(
                    child: TextButton(
                      onPressed: () {},
                      child: Text('View Full Statement', style: PrimeCareTheme.titleMedium.copyWith(color: PrimeCareTheme.primary)),
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildSummaryRow(String label, String amount, bool muted) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: PrimeCareTheme.bodyMedium.copyWith(color: muted ? PrimeCareTheme.onSurfaceVariant : PrimeCareTheme.onSurface)),
        Text(amount, style: PrimeCareTheme.titleSmall.copyWith(color: muted ? PrimeCareTheme.onSurfaceVariant : PrimeCareTheme.onSurface)),
      ],
    );
  }

  Widget _buildPaymentMethodCard(String title, String subtitle, IconData icon, bool isDefault) {
     return Container(
       padding: const EdgeInsets.all(PrimeCareTheme.spacing4),
       decoration: BoxDecoration(
         color: PrimeCareTheme.surfaceContainerHigh.withOpacity(0.3),
         borderRadius: BorderRadius.circular(PrimeCareTheme.radiusLg),
       ),
       child: Row(
         children: [
           Container(
             padding: const EdgeInsets.all(10),
             decoration: const BoxDecoration(
                color: PrimeCareTheme.surfaceContainerLowest,
                shape: BoxShape.circle,
             ),
             child: Icon(icon, color: PrimeCareTheme.primary, size: 20),
           ),
           const SizedBox(width: PrimeCareTheme.spacing4),
           Expanded(
             child: Column(
               crossAxisAlignment: CrossAxisAlignment.start,
               children: [
                 Text(title, style: PrimeCareTheme.titleMedium),
                 Text(subtitle, style: PrimeCareTheme.labelSmall.copyWith(color: PrimeCareTheme.onSurfaceVariant)),
               ],
             ),
           ),
           if (isDefault)
             Container(
               padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
               decoration: BoxDecoration(
                 color: PrimeCareTheme.secondaryContainer,
                 borderRadius: BorderRadius.circular(4),
               ),
               child: Text('Default', style: PrimeCareTheme.labelSmall.copyWith(color: PrimeCareTheme.onSecondaryContainer, fontWeight: FontWeight.bold)),
             )
         ],
       ),
     );
  }

  Widget _buildInvoiceRow(String invoiceId, String description, String date, String amount, String status, Color statusColor) {
    return Container(
      padding: const EdgeInsets.all(PrimeCareTheme.spacing4),
      decoration: BoxDecoration(
         color: PrimeCareTheme.surfaceContainerLowest,
         borderRadius: BorderRadius.circular(PrimeCareTheme.radiusMd),
         boxShadow: [
           BoxShadow(
             color: PrimeCareTheme.primary.withOpacity(0.02),
             blurRadius: 8,
             offset: const Offset(0, 2),
           )
         ]
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
           Expanded(
             flex: 3,
             child: Column(
               crossAxisAlignment: CrossAxisAlignment.start,
               children: [
                 Text(description, style: PrimeCareTheme.titleMedium),
                 Text('$invoiceId • $date', style: PrimeCareTheme.labelSmall.copyWith(color: PrimeCareTheme.onSurfaceVariant)),
               ],
             ),
           ),
           Expanded(
             flex: 1,
             child: Text(amount, style: PrimeCareTheme.titleMedium.copyWith(fontWeight: FontWeight.bold), textAlign: TextAlign.right),
           ),
           Expanded(
             flex: 1,
             child: Align(
               alignment: Alignment.centerRight,
               child: Container(
                 padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                 decoration: BoxDecoration(
                   color: statusColor.withOpacity(0.1),
                   borderRadius: BorderRadius.circular(4),
                 ),
                 child: Text(status, style: PrimeCareTheme.labelSmall.copyWith(color: statusColor, fontWeight: FontWeight.bold)),
               ),
             ),
           ),
           const SizedBox(width: PrimeCareTheme.spacing3),
           IconButton(
             icon: const Icon(LucideIcons.download, size: 18),
             onPressed: () {},
             color: PrimeCareTheme.primary,
             tooltip: 'Download Invoice',
           )
        ],
      ),
    );
  }
}
