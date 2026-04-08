import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:primecare_v4/design_system/primecare_theme.dart';
import 'package:primecare_v4/design_system/clinical_glass.dart';
import 'package:primecare_v4/shared/components/page_template.dart';

class OtNotesScreen extends ConsumerWidget {
  const OtNotesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return PageTemplate(
      title: 'Occupational Therapy Notes',
      subtitle:
          'Document ADL assessments, cognitive evaluations, and home safety recommendations.',
      kpiCards: [
        KPICardData(
          title: 'Notes Today',
          value: '4',
          icon: LucideIcons.fileText,
          trend: 0.0,
          trendLabel: 'on track',
        ),
        KPICardData(
          title: 'Home Assessments',
          value: '1',
          icon: LucideIcons.home,
          trend: 0.0,
          trendLabel: 'scheduled this week',
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
              _buildFilterRow(
                'ADL Assessment',
                3,
                PrimeCareTheme.colors.emeraldTeal,
              ),
              _buildFilterRow(
                'Cognitive Eval',
                1,
                PrimeCareTheme.colors.navyIndigo,
              ),
              _buildFilterRow(
                'Home Safety',
                0,
                PrimeCareTheme.colors.lavenderLustre,
              ),
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
                'ADL Assessment',
                'May 14, 2024 • 11:00',
                'Assessed patient\'s ability to perform lower body dressing independently. Patient required moderate verbal cues and SBA (Stand-By Assist) due to decreased hip flexion and balance confidence. Recommend use of a reacher and sock aid.',
                PrimeCareTheme.colors.emeraldTeal,
              ),
              _buildNoteCard(
                'John Smith',
                'Cognitive Eval',
                'May 14, 2024 • 14:30',
                'Administered MoCA. Score: 24/30. Mild deficits noted in delayed recall and visuospatial domains. Patient exhibited adequate safety awareness during simulated kitchen task but required cueing for sequencing. Plan: focus on compensatory memory strategies.',
                PrimeCareTheme.colors.navyIndigo,
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
                decoration: BoxDecoration(color: color, shape: BoxShape.circle),
              ),
              const SizedBox(width: 8),
              Text(label, style: PrimeCareTheme.typography.body),
            ],
          ),
          Text(
            count.toString(),
            style: PrimeCareTheme.typography.label.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNoteCard(
    String clientName,
    String category,
    String time,
    String note,
    Color themeColor,
  ) {
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
                  Text(
                    '•',
                    style: TextStyle(color: PrimeCareTheme.colors.slateGray),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    category,
                    style: PrimeCareTheme.typography.label.copyWith(
                      fontWeight: FontWeight.bold,
                      color: themeColor,
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
          const SizedBox(height: 16),
          Text(note, style: PrimeCareTheme.typography.body),
        ],
      ),
    );
  }
}
