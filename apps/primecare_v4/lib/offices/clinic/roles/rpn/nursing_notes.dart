import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:primecare_v4/design_system/clinical_glass.dart';
import 'package:primecare_v4/design_system/primecare_theme.dart';
import 'package:primecare_v4/shared/components/page_template.dart';

class NursingNotesScreen extends ConsumerWidget {
  const NursingNotesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return PageTemplate(
      title: 'Nursing Notes',
      subtitle: 'Chronological clinical charting, assessments, and progress notes.',
      headerTrailing: [
        ClinicalSearchTextField(hintText: 'Search keyword, date, or patient...'),
        const SizedBox(width: 16),
        ClinicalGlassButton(
          onPressed: () {},
          label: 'New Entry',
          icon: LucideIcons.filePlus,
          isPrimary: true,
        ),
      ],
      kpiCards: [
        MetricCardData(
          title: 'Notes Today',
          value: '14',
          icon: LucideIcons.fileText,
          trend: 'Charts updated',
          isUp: true,
        ),
        MetricCardData(
          title: 'Cosign Required',
          value: '2',
          icon: LucideIcons.edit3,
          trend: 'Pending RN review',
          isUp: false,
          color: PrimeCareTheme.colors.amberWarning,
        ),
      ],
      sidebarContent: [
        _buildTemplatesPanel(),
      ],
      mainContent: [
        _buildNotesFeed(),
      ],
    );
  }

  Widget _buildTemplatesPanel() {
    return ClinicalGlassPanel(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(LucideIcons.layoutTemplate, color: PrimeCareTheme.colors.navyIndigo, size: 20),
              const SizedBox(width: 8),
              Text('Smart Templates', style: PrimeCareTheme.typography.h3),
            ],
          ),
          const SizedBox(height: 16),
          _buildActionItem('SOAP Note', LucideIcons.stethoscope),
          _buildActionItem('Shift Handoff', LucideIcons.arrowRightLeft),
          _buildActionItem('Wound Assessment', LucideIcons.activity),
          _buildActionItem('Fall Incident', LucideIcons.alertTriangle, color: PrimeCareTheme.colors.coralRed),
        ],
      ),
    );
  }

  Widget _buildActionItem(String title, IconData icon, {Color? color}) {
    final effectiveColor = color ?? PrimeCareTheme.colors.royalPurple;
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: ClinicalGlassButton(
        onPressed: () {},
        label: title,
        icon: icon,
      ),
    );
  }

  Widget _buildNotesFeed() {
    return ClinicalGlassPanel(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(24),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Recent Entries', style: PrimeCareTheme.typography.h2),
                ClinicalGlassButton(
                  onPressed: () {},
                  label: 'Filter: Shift',
                  icon: LucideIcons.filter,
                ),
              ],
            ),
          ),
          const Divider(height: 1),
          _buildNoteCard(
            patient: 'Sylvia Plath',
            time: '14:30 PM • Today',
            type: 'Pain Assessment',
            content: 'Patient reported pain level 7/10 in lower back. Administered PRN Morphine 5mg at 14:15. Pain reassessed at 14:45, down to 3/10. Will continue to monitor.',
            author: 'Jane Doe, RPN',
          ),
          const Divider(height: 1),
          _buildNoteCard(
            patient: 'Marcus Aurelius',
            time: '11:00 AM • Today',
            type: 'Wound Care (SOAP)',
            content: 'S: Patient states "the dressing feels loose".\nO: Removed old dressing from left leg ulcer. Minimal serous exudate. Wound bed 80% granulation tissue. Cleansed with normal saline. Applied fresh foam dressing.\nA: Wound healing progressing normally.\nP: Continue daily dressing changes.',
            author: 'Jane Doe, RPN',
          ),
          const Divider(height: 1),
          _buildNoteCard(
            patient: 'John Carmichael',
            time: '08:15 AM • Today',
            type: 'Shift Assessment',
            content: 'Patient alert and oriented x3. Vital signs stable within normal limits. Lung sounds clear bilaterally. Independent with ADLs this morning.',
            author: 'Jane Doe, RPN',
          ),
        ],
      ),
    );
  }

  Widget _buildNoteCard({
    required String patient,
    required String time,
    required String type,
    required String content,
    required String author,
  }) {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: PrimeCareTheme.colors.royalPurple.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Icon(LucideIcons.fileText, color: PrimeCareTheme.colors.royalPurple, size: 16),
                  ),
                  const SizedBox(width: 12),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(patient, style: PrimeCareTheme.typography.h3),
                      Text(type, style: PrimeCareTheme.typography.label.copyWith(color: PrimeCareTheme.colors.royalPurple, fontWeight: FontWeight.bold)),
                    ],
                  ),
                ],
              ),
              Text(time, style: PrimeCareTheme.typography.label.copyWith(color: PrimeCareTheme.colors.slateGray)),
            ],
          ),
          const SizedBox(height: 16),
          Text(
            content,
            style: PrimeCareTheme.typography.body.copyWith(
              height: 1.5,
              color: PrimeCareTheme.colors.navyIndigo.withOpacity(0.8),
            ),
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Entered by: $author', style: PrimeCareTheme.typography.label),
              Row(
                children: [
                  ClinicalGlassButton(
                    onPressed: () {},
                    label: 'Edit',
                    icon: LucideIcons.edit2,
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
