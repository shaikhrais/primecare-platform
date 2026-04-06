import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:primecare_v4/design_system/primecare_theme.dart';
import 'package:primecare_v4/design_system/clinical_glass.dart';
import 'package:primecare_v4/shared/components/page_template.dart';

class RpnMedicationSupportScreen extends ConsumerWidget {
  const RpnMedicationSupportScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return PageTemplate(
      title: 'Medication Administration (MAR)',
      subtitle: 'Administer, witness, and document patient medications securely.',
      kpiCards: [
        KPICardData(
          title: 'Scheduled Now',
          value: '12',
          icon: LucideIcons.pill,
          trend: 2.0,
          trendLabel: 'due within hour',
        ),
        KPICardData(
          title: 'Administered',
          value: '45',
          icon: LucideIcons.checkCircle,
          trend: 10.0,
          trendLabel: 'this shift',
        ),
        KPICardData(
          title: 'Missed/Refused',
          value: '1',
          icon: LucideIcons.alertTriangle,
          trend: -1.0,
          trendLabel: 'requires review',
        ),
      ],
      sidebarContent: [
        ClinicalGlassPanel(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Time Blocks', style: PrimeCareTheme.typography.h3),
              const SizedBox(height: 16),
              _buildFilterRow('08:00 (Morning)', 0, PrimeCareTheme.colors.emeraldTeal),
              _buildFilterRow('12:00 (Noon)', 12, PrimeCareTheme.colors.navyIndigo),
              _buildFilterRow('17:00 (Evening)', 8, PrimeCareTheme.colors.lavenderLustre),
              _buildFilterRow('PRN (As Needed)', 3, PrimeCareTheme.colors.slateGray),
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
                   Text('Current Med Pass (12:00)', style: PrimeCareTheme.typography.h2),
                   ElevatedButton.icon(
                    onPressed: () {},
                    icon: const Icon(LucideIcons.scanLine),
                    label: const Text('Scan Patient ID'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: PrimeCareTheme.colors.navyIndigo,
                      foregroundColor: Colors.white,
                    ),
                  ),
                 ],
               ),
               const SizedBox(height: 24),
               _buildMedicationCard(
                 'Maria Garcia',
                 'Metformin - 500mg',
                 'PO (Oral) • With Food',
                 'Due at 12:00 PM',
                 PrimeCareTheme.colors.navyIndigo,
                 'Pending'
               ),
               _buildMedicationCard(
                 'John Smith',
                 'Insulin Lispro (Humalog) - 5 units',
                 'SubQ • With Meal',
                 'Due at 12:00 PM',
                 PrimeCareTheme.colors.coralRed,
                 'Requires Co-Sign'
               ),
               _buildMedicationCard(
                 'Eleanor Rigby',
                 'Acetaminophen - 650mg',
                 'PO (Oral) • PRN for Pain',
                 'Requested 11:45 PM',
                 PrimeCareTheme.colors.lavenderLustre,
                 'Pending'
               ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildFilterRow(String label, int count, Color color) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
               Container(
                width: 12,
                height: 12,
                decoration: BoxDecoration(
                  color: color,
                  shape: BoxShape.circle,
                ),
              ),
              const SizedBox(width: 8),
              Text(label, style: PrimeCareTheme.typography.body),
            ],
          ),
          Text(count.toString(), style: PrimeCareTheme.typography.label.copyWith(fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }

  Widget _buildMedicationCard(String clientName, String medication, String route, String time, Color themeColor, String status) {
     return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: PrimeCareTheme.colors.surfaceContainerHighest.withOpacity(0.3),
        borderRadius: BorderRadius.circular(16),
        border: Border(left: BorderSide(color: themeColor, width: 4)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
           Row(
             mainAxisAlignment: MainAxisAlignment.spaceBetween,
             children: [
                Row(
                  children: [
                    Text(clientName, style: PrimeCareTheme.typography.h3),
                    const SizedBox(width: 8),
                    Text('•', style: TextStyle(color: PrimeCareTheme.colors.slateGray)),
                    const SizedBox(width: 8),
                    Text(time, style: PrimeCareTheme.typography.label),
                  ],
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: status == 'Pending' ? PrimeCareTheme.colors.coralRed.withOpacity(0.1) : themeColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text(status, style: PrimeCareTheme.typography.label.copyWith(
                    color: status == 'Pending' ? PrimeCareTheme.colors.coralRed : themeColor, 
                    fontWeight: FontWeight.bold
                  )),
                )
             ],
           ),
           const SizedBox(height: 12),
           Text(medication, style: PrimeCareTheme.typography.h2.copyWith(color: themeColor)),
           const SizedBox(height: 4),
           Text(route, style: PrimeCareTheme.typography.body),
           const SizedBox(height: 16),
           Row(
             mainAxisAlignment: MainAxisAlignment.end,
             children: [
                OutlinedButton(
                  onPressed: () {},
                  child: const Text('Hold/Refused'),
                ),
                const SizedBox(width: 12),
                ElevatedButton.icon(
                  onPressed: () {},
                  icon: const Icon(LucideIcons.check),
                  label: const Text('Administer'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: PrimeCareTheme.colors.navyIndigo,
                    foregroundColor: Colors.white,
                  ),
                )
             ],
           )
        ],
      )
     );
  }
}
