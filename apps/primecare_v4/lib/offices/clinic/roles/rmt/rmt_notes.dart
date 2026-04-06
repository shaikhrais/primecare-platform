import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:primecare_v4/design_system/primecare_theme.dart';
import 'package:primecare_v4/design_system/clinical_glass.dart';
import 'package:primecare_v4/shared/components/page_template.dart';

class RmtNotesScreen extends ConsumerWidget {
  const RmtNotesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return PageTemplate(
      title: 'Massage Treatment Records',
      subtitle: 'Comprehensive overview of all clinical documentation.',
      kpiCards: [
        KPICardData(title: 'Total Notes', value: '156', icon: LucideIcons.folders, trend: 12.0, trendLabel: 'this month'),
      ],
      sidebarContent: [
        ClinicalGlassPanel(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Note Types', style: PrimeCareTheme.typography.h3),
              const SizedBox(height: 16),
              _buildFilterRow('SOAP Notes', 130, PrimeCareTheme.colors.navyIndigo),
              _buildFilterRow('Assessments', 26, PrimeCareTheme.colors.emeraldTeal),
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
                   Text('Recent Activity', style: PrimeCareTheme.typography.h2),
                   ElevatedButton.icon(
                    onPressed: () {},
                    icon: const Icon(LucideIcons.search),
                    label: const Text('Search Records'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: PrimeCareTheme.colors.surfaceContainerHighest,
                      foregroundColor: PrimeCareTheme.colors.navyIndigo,
                    ),
                  ),
                 ],
               ),
               const SizedBox(height: 24),
               _buildNoteCard('Alan Turing', 'SOAP Note', 'May 14, 2024', PrimeCareTheme.colors.navyIndigo),
               _buildNoteCard('Grace Hopper', 'Assessment', 'May 13, 2024', PrimeCareTheme.colors.emeraldTeal),
               _buildNoteCard('Ada Lovelace', 'SOAP Note', 'May 12, 2024', PrimeCareTheme.colors.navyIndigo),
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
               Container(width: 12, height: 12, decoration: BoxDecoration(color: color, shape: BoxShape.circle)),
              const SizedBox(width: 8),
              Text(label, style: PrimeCareTheme.typography.body),
            ],
          ),
          Text(count.toString(), style: PrimeCareTheme.typography.label.copyWith(fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }

  Widget _buildNoteCard(String clientName, String category, String time, Color themeColor) {
     return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: PrimeCareTheme.colors.surfaceContainerHighest.withOpacity(0.3),
        borderRadius: BorderRadius.circular(16),
        border: Border(left: BorderSide(color: themeColor, width: 4)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
           Column(
             crossAxisAlignment: CrossAxisAlignment.start,
             children: [
                Row(
                  children: [
                    Text(clientName, style: PrimeCareTheme.typography.h3),
                    const SizedBox(width: 8),
                    Text('•', style: TextStyle(color: PrimeCareTheme.colors.slateGray)),
                    const SizedBox(width: 8),
                    Text(category, style: PrimeCareTheme.typography.label.copyWith(fontWeight: FontWeight.bold, color: themeColor)),
                  ],
                ),
             ],
           ),
           Text(time, style: PrimeCareTheme.typography.label.copyWith(color: PrimeCareTheme.colors.slateGray)),
        ],
      )
     );
  }
}
