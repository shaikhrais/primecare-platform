import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:primecare_v4/design_system/clinical_glass.dart';
import 'package:primecare_v4/design_system/primecare_theme.dart';

class TreatmentPlansScreen extends ConsumerWidget {
  const TreatmentPlansScreen({super.key});

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
                      'Treatment Plans',
                      style: PrimeCareTheme.typography.heroTitle.copyWith(
                        color: PrimeCareTheme.colors.navyIndigo,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Manage long-term therapy goals and modalities.',
                      style: PrimeCareTheme.typography.body.copyWith(
                        color: PrimeCareTheme.colors.slateGray,
                      ),
                    ),
                  ],
                ),
                ClinicalGlassButton(
                  onPressed: () {},
                  icon: LucideIcons.filePlus,
                  label: 'Create Plan',
                ),
              ],
            ),
            const SizedBox(height: 32),
            ClinicalGlassPanel(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Active Plans', style: PrimeCareTheme.typography.h2),
                  const SizedBox(height: 24),
                  _buildPlanCard('Emma Watson', 'Sciatica Management', '6 Weeks', 'Progressing well. Increased ROM.'),
                  const SizedBox(height: 16),
                  _buildPlanCard('David Lee', 'Post-Op Fibrosis Breakdown', '12 Weeks', 'Scar tissue mobilization ongoing.'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPlanCard(String patient, String focus, String duration, String notes) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: PrimeCareTheme.colors.surfaceContainerLow,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: PrimeCareTheme.colors.surfaceContainerHighest),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(patient, style: PrimeCareTheme.typography.h3),
                    const SizedBox(width: 12),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                      decoration: BoxDecoration(
                        color: PrimeCareTheme.colors.navyIndigo.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(duration, style: PrimeCareTheme.typography.label.copyWith(color: PrimeCareTheme.colors.navyIndigo)),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Text(focus, style: PrimeCareTheme.typography.body.copyWith(fontWeight: FontWeight.bold, color: PrimeCareTheme.colors.emeraldTeal)),
                const SizedBox(height: 4),
                Text('Status: $notes', style: PrimeCareTheme.typography.body.copyWith(color: PrimeCareTheme.colors.slateGray)),
              ],
            ),
          ),
          ClinicalGlassButton(onPressed: () {}, icon: LucideIcons.edit2, label: 'Update'),
        ],
      ),
    );
  }
}
