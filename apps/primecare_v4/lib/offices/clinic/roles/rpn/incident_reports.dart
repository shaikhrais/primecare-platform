import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:primecare_v4/design_system/primecare_theme.dart';
import 'package:primecare_v4/design_system/clinical_glass.dart';
import 'package:primecare_v4/shared/components/page_template.dart';

class RpnIncidentReportsScreen extends ConsumerWidget {
  const RpnIncidentReportsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return PageTemplate(
      title: 'Incident Reports',
      subtitle: 'Document and track clinical incidents and near misses.',
      kpiCards: [
        KPICardData(
          title: 'Reports Filed',
          value: '2',
          icon: LucideIcons.fileText,
          trend: 0.0,
          trendLabel: 'this month',
        ),
        KPICardData(
          title: 'Awaiting Sign-off',
          value: '1',
          icon: LucideIcons.clock,
          trend: 1.0,
          trendLabel: 'from RN/Manager',
        ),
        KPICardData(
          title: 'Closed Incidents',
          value: '45',
          icon: LucideIcons.checkCircle,
          trend: 5.0,
          trendLabel: 'YTD',
        ),
      ],
      sidebarContent: [
        ClinicalGlassPanel(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Categories', style: PrimeCareTheme.typography.h3),
              const SizedBox(height: 16),
              _buildFilterRow('Fall / Injury', 1, PrimeCareTheme.colors.coralRed),
               _buildFilterRow('Medication Error', 0, PrimeCareTheme.colors.navyIndigo),
              _buildFilterRow('Near Miss', 1, PrimeCareTheme.colors.lavenderLustre),
               _buildFilterRow('Behavioural', 0, PrimeCareTheme.colors.slateGray),
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
                   Text('Recent Reports', style: PrimeCareTheme.typography.h2),
                   ElevatedButton.icon(
                    onPressed: () {},
                    icon: const Icon(LucideIcons.filePlus),
                    label: const Text('New Report'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: PrimeCareTheme.colors.coralRed,
                      foregroundColor: Colors.white,
                    ),
                  ),
                 ],
               ),
               const SizedBox(height: 24),
               _buildIncidentCard(
                 'IR-2024-089',
                 'Maria Garcia',
                 'Fall / Injury',
                 'May 14, 2024 • 14:30',
                 'Client found on floor beside bed. Stated she slipped while reaching for water. No apparent injuries, neuro vitals stable. RN notified and physician informed.',
                 PrimeCareTheme.colors.coralRed,
                 'Awaiting Sign-off'
               ),
               _buildIncidentCard(
                 'IR-2024-081',
                 'Eleanor Rigby',
                 'Near Miss',
                 'May 02, 2024 • 09:15',
                 'Incorrect medication dosage dispensed from pharmacy. Caught during MAR verification prior to administration. Pharmacy contacted and correct dose obtained.',
                 PrimeCareTheme.colors.lavenderLustre,
                 'Closed'
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

  Widget _buildIncidentCard(String id, String clientName, String category, String time, String description, Color highlightColor, String status) {
     return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: PrimeCareTheme.colors.surfaceContainerHighest.withOpacity(0.3),
        borderRadius: BorderRadius.circular(16),
        border: Border(left: BorderSide(color: highlightColor, width: 4)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
           Row(
             mainAxisAlignment: MainAxisAlignment.spaceBetween,
             children: [
                Row(
                  children: [
                    Text(id, style: PrimeCareTheme.typography.label.copyWith(color: PrimeCareTheme.colors.navyIndigo, fontWeight: FontWeight.bold)),
                    const SizedBox(width: 12),
                    Text(clientName, style: PrimeCareTheme.typography.h3),
                  ],
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: highlightColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text(status, style: PrimeCareTheme.typography.label.copyWith(color: highlightColor, fontWeight: FontWeight.bold)),
                )
             ],
           ),
           const SizedBox(height: 12),
           Row(
             children: [
                Icon(LucideIcons.tag, size: 14, color: PrimeCareTheme.colors.slateGray),
                const SizedBox(width: 4),
                Text(category, style: PrimeCareTheme.typography.label.copyWith(color: PrimeCareTheme.colors.slateGray)),
                const SizedBox(width: 16),
                Icon(LucideIcons.calendar, size: 14, color: PrimeCareTheme.colors.slateGray),
                const SizedBox(width: 4),
                Text(time, style: PrimeCareTheme.typography.label.copyWith(color: PrimeCareTheme.colors.slateGray)),
             ],
           ),
           const SizedBox(height: 12),
           Text(description, style: PrimeCareTheme.typography.body),
           const SizedBox(height: 16),
           Align(
             alignment: Alignment.centerRight,
             child: OutlinedButton(
                onPressed: () {},
                child: const Text('View Full Report'),
              )
           )
        ],
      )
     );
  }
}
