import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:primecare_v4/design_system/clinical_glass.dart';
import 'package:primecare_v4/design_system/primecare_theme.dart';

class SoapNotesScreen extends ConsumerWidget {
  const SoapNotesScreen({super.key});

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
                      'SOAP Notes',
                      style: PrimeCareTheme.typography.heroTitle.copyWith(
                        color: PrimeCareTheme.colors.navyIndigo,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Charting for clinical massage encounters (Subjective, Objective, Assessment, Plan).',
                      style: PrimeCareTheme.typography.body.copyWith(
                        color: PrimeCareTheme.colors.slateGray,
                      ),
                    ),
                  ],
                ),
                ClinicalGlassButton(
                  onPressed: () {},
                  icon: LucideIcons.penTool,
                  label: 'Draft Note',
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
                      Text('SOAP Flow', style: PrimeCareTheme.typography.h3),
                    ],
                  ),
                  const SizedBox(height: 24),
                  _buildNoteArea('Subjective (Patient symptoms & complaints)'),
                  const SizedBox(height: 16),
                  _buildNoteArea('Objective (Palpation findings, ROM)'),
                  const SizedBox(height: 16),
                  _buildNoteArea('Assessment (Changes, response to treatment)'),
                  const SizedBox(height: 16),
                  _buildNoteArea('Plan (Future treatments, homecare)'),
                  const SizedBox(height: 24),
                  Align(
                    alignment: Alignment.centerRight,
                    child: ClinicalGlassButton(onPressed: () {}, label: 'Sign & Lock'),
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
              hintText: 'Start clinical documentation...',
            ),
          ),
        ),
      ],
    );
  }
}
