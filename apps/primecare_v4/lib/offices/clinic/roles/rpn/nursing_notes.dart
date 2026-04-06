import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:primecare_v4/design_system/clinical_glass.dart';
import 'package:primecare_v4/design_system/primecare_theme.dart';

class NursingNotesScreen extends ConsumerWidget {
  const NursingNotesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Nursing Notes',
                      style: PrimeCareTheme.typography.heroTitle.copyWith(
                        color: PrimeCareTheme.colors.navyIndigo,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Daily charting and SOAP notes for assigned patient roster.',
                      style: PrimeCareTheme.typography.body.copyWith(
                        color: PrimeCareTheme.colors.slateGray,
                      ),
                    ),
                  ],
                ),
                ClinicalGlassButton(
                  onPressed: () {},
                  icon: LucideIcons.penTool,
                  label: 'New Entry',
                ),
              ],
            ),
            const SizedBox(height: 32),
            ClinicalGlassPanel(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Row(
                    children: [
                      Icon(LucideIcons.fileSignature, color: PrimeCareTheme.colors.emeraldTeal),
                      const SizedBox(width: 8),
                      Text('SOAP Note Editor', style: PrimeCareTheme.typography.h3),
                    ],
                  ),
                  const SizedBox(height: 24),
                  _buildNoteArea('Subjective (S)'),
                  const SizedBox(height: 16),
                  _buildNoteArea('Objective (O)'),
                  const SizedBox(height: 16),
                  _buildNoteArea('Assessment (A)'),
                  const SizedBox(height: 16),
                  _buildNoteArea('Plan (P)'),
                  const SizedBox(height: 24),
                  Align(
                    alignment: Alignment.centerRight,
                    child: ClinicalGlassButton(onPressed: () {}, label: 'Sign & Submit'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNoteArea(String label) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: PrimeCareTheme.typography.label.copyWith(fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        Container(
          height: 100,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: PrimeCareTheme.colors.surfaceContainerHighest.withOpacity(0.3),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: PrimeCareTheme.colors.surfaceContainerHighest),
          ),
          child: const TextField(
            maxLines: null,
            decoration: InputDecoration(
              border: InputBorder.none,
              hintText: 'Start typing...',
            ),
          ),
        ),
      ],
    );
  }
}
