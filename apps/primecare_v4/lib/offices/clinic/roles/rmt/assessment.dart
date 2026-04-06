import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:primecare_v4/design_system/clinical_glass.dart';
import 'package:primecare_v4/design_system/primecare_theme.dart';

class AssessmentScreen extends ConsumerWidget {
  const AssessmentScreen({super.key});

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
                      'Assessments',
                      style: PrimeCareTheme.typography.heroTitle.copyWith(
                        color: PrimeCareTheme.colors.navyIndigo,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Postural, functional, and neurological assessments.',
                      style: PrimeCareTheme.typography.body.copyWith(
                        color: PrimeCareTheme.colors.slateGray,
                      ),
                    ),
                  ],
                ),
                ClinicalGlassButton(
                  onPressed: () {},
                  icon: LucideIcons.plus,
                  label: 'New Assessment',
                ),
              ],
            ),
            const SizedBox(height: 32),
            ClinicalGlassPanel(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(LucideIcons.clipboardList, color: PrimeCareTheme.colors.emeraldTeal),
                      const SizedBox(width: 8),
                      Text('Assessment Categories', style: PrimeCareTheme.typography.h2),
                    ],
                  ),
                  const SizedBox(height: 24),
                  Row(
                    children: [
                      Expanded(
                        child: _buildCategoryCard('Postural', LucideIcons.user),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: _buildCategoryCard('Orthopedic', LucideIcons.bone),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: _buildCategoryCard('Neurological', LucideIcons.activity),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCategoryCard(String title, IconData icon) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: PrimeCareTheme.colors.surfaceContainerLow,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: PrimeCareTheme.colors.surfaceContainerHighest),
      ),
      child: Column(
        children: [
          Icon(icon, size: 40, color: PrimeCareTheme.colors.navyIndigo),
          const SizedBox(height: 16),
          Text(title, style: PrimeCareTheme.typography.h3),
          const SizedBox(height: 16),
          ClinicalGlassButton(
            onPressed: () {},
            label: 'Start Form',
            isFullWidth: true,
          ),
        ],
      ),
    );
  }
}
