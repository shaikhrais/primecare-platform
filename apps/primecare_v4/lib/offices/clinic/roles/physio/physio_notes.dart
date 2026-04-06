import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:primecare_v4/design_system/primecare_theme.dart';
import 'package:primecare_v4/design_system/clinical_glass.dart';
import 'package:primecare_v4/shared/components/page_template.dart';

class PhysioNotesScreen extends ConsumerWidget {
  const PhysioNotesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return PageTemplate(
      title: 'Physiotherapy Notes',
      subtitle: 'Document MSK assessments, range of motion, and therapeutic exercises.',
      kpiCards: [
        KPICardData(
          title: 'Assessments Today',
          value: '3',
          icon: LucideIcons.activity,
          trend: 0.5,
          trendLabel: 'vs yesterday',
        ),
        KPICardData(
          title: 'Exercises Prescribed',
          value: '12',
          icon: LucideIcons.dumbbell,
          trend: 1.2,
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
              _buildFilterRow('Initial Eval', 2, PrimeCareTheme.colors.navyIndigo),
              _buildFilterRow('Progress Note', 5, PrimeCareTheme.colors.emeraldTeal),
               _buildFilterRow('Discharge Exam', 1, PrimeCareTheme.colors.lavenderLustre),
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
                 'David Chen',
                 'Initial Eval',
                 'May 14, 2024 • 08:30',
                 'Patient s/p right ACL reconstruction (patellar tendon autograft) 2 weeks ago. Currently PWB (Partial Weight Bearing) with crutches. Knee flexion AROM 0-70 degrees. Moderate effusion noted. Performed gentle patellar mobilizations and initiated quad sets. Plan: 3x/week for range of motion and strengthening.',
                 PrimeCareTheme.colors.navyIndigo
               ),
               _buildNoteCard(
                 'Sarah Miller',
                 'Progress Note',
                 'May 14, 2024 • 13:00',
                 'Session 6 for adhesive capsulitis (frozen shoulder) left side. Tolerated grade III anterior/inferior glides well. Active forward flexion improved to 120 degrees (+10 deg from last session). Instructed on wall walking exercises for home program.',
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
