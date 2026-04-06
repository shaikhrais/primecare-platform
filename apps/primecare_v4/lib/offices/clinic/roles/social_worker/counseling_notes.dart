import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:primecare_v4/design_system/primecare_theme.dart';
import 'package:primecare_v4/design_system/clinical_glass.dart';
import 'package:primecare_v4/shared/components/page_template.dart';

class CounselingNotesScreen extends ConsumerWidget {
  const CounselingNotesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return PageTemplate(
      title: 'Social Work & Counseling Notes',
      subtitle: 'Document psychosocial assessments, counseling sessions, and resource coordination.',
      kpiCards: [
        KPICardData(
          title: 'Sessions Today',
          value: '4',
          icon: LucideIcons.users,
          trend: 0.0,
          trendLabel: 'on track',
        ),
        KPICardData(
          title: 'Referrals Made',
          value: '3',
          icon: LucideIcons.share2,
          trend: 1.0,
          trendLabel: 'this week',
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
              _buildFilterRow('Therapy Session', 5, PrimeCareTheme.colors.emeraldTeal),
              _buildFilterRow('Psychosocial Eval', 2, PrimeCareTheme.colors.navyIndigo),
               _buildFilterRow('Discharge Planning', 4, PrimeCareTheme.colors.lavenderLustre),
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
                 'Robert Ford',
                 'Discharge Planning',
                 'May 14, 2024 • 09:30',
                 'Met with patient and family regarding upcoming discharge. Confirmed home health nursing is arranged for wound care. Family expressed anxiety about managing medications; referred back to pharmacy for blister pack consultation. Ordered walker through vendor.',
                 PrimeCareTheme.colors.lavenderLustre
               ),
               _buildNoteCard(
                 'Emily Clark',
                 'Therapy Session',
                 'May 14, 2024 • 11:15',
                 'Individual CBT session focusing on anxiety management related to recent diagnosis. Patient reported utilizing deep breathing exercises with moderate success. Discussed identifying cognitive distortions. Plan: continue weekly sessions.',
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
