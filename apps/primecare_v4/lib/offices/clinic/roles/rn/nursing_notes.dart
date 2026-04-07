import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:primecare_v4/design_system/primecare_theme.dart';
import 'package:primecare_v4/design_system/clinical_glass.dart';
import 'package:primecare_v4/shared/components/page_template.dart';

class NursingNotesScreen extends ConsumerWidget {
  const NursingNotesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return PageTemplate(
      title: 'Nursing Notes',
      subtitle: 'Document clinical observations, interventions, and outcomes.',
      kpiCards: [
        KPICardData(
          title: 'Notes Today',
          value: '12',
          icon: LucideIcons.fileSignature,
          trend: 20.0,
          trendLabel: 'vs yesterday',
        ),
        KPICardData(
          title: 'Awaiting Signature',
          value: '1',
          icon: LucideIcons.penTool,
          trend: 0.0,
          trendLabel: 'from supervisor',
        ),
        KPICardData(
          title: 'Drafts',
          value: '3',
          icon: LucideIcons.files,
          trend: 0.0,
          trendLabel: 'in progress',
        ),
      ],
      sidebarContent: [
        ClinicalGlassPanel(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Note Types', style: PrimeCareTheme.typography.h3),
              const SizedBox(height: 16),
              _buildNoteTypeFilter('Assessment Note', true),
              _buildNoteTypeFilter('Progress Note', false),
              _buildNoteTypeFilter('Transfer Note', false),
              _buildNoteTypeFilter('Discharge Summary', false),
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
                    label: const Text('New Note'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: PrimeCareTheme.colors.navyIndigo,
                      foregroundColor: Colors.white,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              _buildNoteCard(
                'Eleanor Rigby',
                'Assessment Note',
                '10:30 AM',
                'Completed full body assessment. Wound on left hip shows signs of healing, no exudate. Client denies pain at rest, reports 2/10 during mobility exercises.',
                'Signed',
                PrimeCareTheme.colors.emeraldTeal,
              ),
              _buildNoteCard(
                'John Smith',
                'Progress Note',
                '09:15 AM',
                'Administered morning medications as scheduled. Blood glucose was 6.5 mmol/L. Client ate 100% of breakfast.',
                'Draft',
                PrimeCareTheme.colors.coralRed,
              ),
              _buildNoteCard(
                'Maria Garcia',
                'Assessment Note',
                'Yesterday, 3:00 PM',
                'Routine follow-up. Blood pressure remains elevated at 145/90. Discussed dietary modifications and importance of sodium restriction.',
                'Signed',
                PrimeCareTheme.colors.emeraldTeal,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildNoteTypeFilter(String label, bool isSelected) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
      decoration: BoxDecoration(
        color: isSelected
            ? PrimeCareTheme.colors.navyIndigo.withOpacity(0.05)
            : Colors.transparent,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: PrimeCareTheme.typography.body.copyWith(
              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              color: isSelected
                  ? PrimeCareTheme.colors.navyIndigo
                  : PrimeCareTheme.colors.textPrimary,
            ),
          ),
          if (isSelected)
            Icon(
              LucideIcons.check,
              size: 16,
              color: PrimeCareTheme.colors.navyIndigo,
            ),
        ],
      ),
    );
  }

  Widget _buildNoteCard(
    String clientName,
    String type,
    String time,
    String content,
    String status,
    Color statusColor,
  ) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: PrimeCareTheme.colors.surfaceContainerHighest.withOpacity(0.3),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: PrimeCareTheme.colors.surfaceContainerHighest,
        ),
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
                  Text(
                    '•',
                    style: TextStyle(color: PrimeCareTheme.colors.slateGray),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    type,
                    style: PrimeCareTheme.typography.label.copyWith(
                      fontWeight: FontWeight.bold,
                      color: PrimeCareTheme.colors.navyIndigo,
                    ),
                  ),
                ],
              ),
              Text(
                time,
                style: PrimeCareTheme.typography.label.copyWith(
                  color: PrimeCareTheme.colors.slateGray,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(content, style: PrimeCareTheme.typography.body),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  color: statusColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Text(
                  status,
                  style: PrimeCareTheme.typography.label.copyWith(
                    color: statusColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              TextButton(
                onPressed: () {},
                style: TextButton.styleFrom(
                  foregroundColor: PrimeCareTheme.colors.navyIndigo,
                ),
                child: const Text('View / Edit'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
