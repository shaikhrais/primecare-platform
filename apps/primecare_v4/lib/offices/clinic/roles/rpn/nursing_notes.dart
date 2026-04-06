import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:primecare_v4/design_system/primecare_theme.dart';
import 'package:primecare_v4/design_system/clinical_glass.dart';
import 'package:primecare_v4/shared/components/page_template.dart';

class RpnNursingNotesScreen extends ConsumerWidget {
  const RpnNursingNotesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return PageTemplate(
      title: 'Nursing Notes',
      subtitle: 'Document clinical observations and patient interactions.',
      kpiCards: [
        KPICardData(
          title: 'Notes Today',
          value: '12',
          icon: LucideIcons.fileText,
          trend: 2.0,
          trendLabel: 'vs yesterday',
        ),
        KPICardData(
          title: 'Required Notes',
          value: '4',
          icon: LucideIcons.alertCircle,
          trend: 0.0,
          trendLabel: 'end of shift',
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
              _buildFilterRow('Routine Care', 8, PrimeCareTheme.colors.emeraldTeal),
              _buildFilterRow('Change in Status', 1, PrimeCareTheme.colors.coralRed),
               _buildFilterRow('Family Communication', 3, PrimeCareTheme.colors.navyIndigo),
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
                   Text('Recent Notes', style: PrimeCareTheme.typography.h2),
                   ElevatedButton.icon(
                    onPressed: () {},
                    icon: const Icon(LucideIcons.plus),
                    label: const Text('Add Note'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: PrimeCareTheme.colors.navyIndigo,
                      foregroundColor: Colors.white,
                    ),
                  ),
                 ],
               ),
               const SizedBox(height: 24),
               _buildNoteCard(
                 'Maria Garcia',
                 'Change in Status',
                 'May 14, 2024 • 13:45',
                 'Patient reported feeling dizzy when standing up. Vitals taken. BP 110/70 lying down, 90/60 standing. Instructed patient to sit on edge of bed before standing. Monitored for 30 mins, dizziness resolved.',
                 PrimeCareTheme.colors.coralRed
               ),
               _buildNoteCard(
                 'John Smith',
                 'Routine Care',
                 'May 14, 2024 • 10:00',
                 'Assisted with morning ADLs. Patient ate 100% of breakfast. Complained of mild pain in left shoulder (2/10), repositioned for comfort. PRN Tylenol offered but declined.',
                 PrimeCareTheme.colors.emeraldTeal
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

  Widget _buildNoteCard(String clientName, String category, String time, String note, Color themeColor) {
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
                    Text(category, style: PrimeCareTheme.typography.label.copyWith(fontWeight: FontWeight.bold, color: themeColor)),
                  ],
                ),
                Text(time, style: PrimeCareTheme.typography.label.copyWith(color: PrimeCareTheme.colors.slateGray)),
             ],
           ),
           const SizedBox(height: 16),
           Text(note, style: PrimeCareTheme.typography.body),
        ],
      )
     );
  }
}
