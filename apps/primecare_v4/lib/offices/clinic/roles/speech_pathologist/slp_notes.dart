import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:primecare_v4/design_system/primecare_theme.dart';
import 'package:primecare_v4/design_system/clinical_glass.dart';
import 'package:primecare_v4/shared/components/page_template.dart';

class SlpNotesScreen extends ConsumerWidget {
  const SlpNotesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return PageTemplate(
      title: 'Speech-Language Pathology Notes',
      subtitle: 'Document speech, language, swallowing, and cognitive-communication assessments.',
      kpiCards: [
        KPICardData(
          title: 'Notes Today',
          value: '5',
          icon: LucideIcons.fileText,
          trend: 0.0,
          trendLabel: 'on track',
        ),
        KPICardData(
          title: 'Swallow Studies',
          value: '2',
          icon: LucideIcons.coffee, // Representing feeding/swallowing
          trend: 0.0,
          trendLabel: 'scheduled today',
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
              _buildFilterRow('Dysphagia', 4, PrimeCareTheme.colors.emeraldTeal),
              _buildFilterRow('Aphasia', 2, PrimeCareTheme.colors.navyIndigo),
               _buildFilterRow('Cognitive-Comm', 1, PrimeCareTheme.colors.lavenderLustre),
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
                 'James Wilson',
                 'Dysphagia',
                 'May 14, 2024 • 10:15',
                 'Clinical Swallow Evaluation completed at bedside. Patient exhibited overt signs of aspiration (coughing, throat clearing) with thin liquids. Tolerated nectar-thick liquids without clinical signs. Diet recommendation: Pureed solids, Nectar-thick liquids. Initiated effortful swallow exercises.',
                 PrimeCareTheme.colors.emeraldTeal
               ),
               _buildNoteCard(
                 'Eleanor Rigby',
                 'Aphasia',
                 'May 14, 2024 • 13:45',
                 'Session focused on expressive language recovery post-CVA. Patient demonstrated improved naming of familiar objects (8/10 accuracy) using phonemic cues. Continues to struggle with multi-step commands. Plan: continue semantic feature analysis therapy.',
                 PrimeCareTheme.colors.navyIndigo
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
