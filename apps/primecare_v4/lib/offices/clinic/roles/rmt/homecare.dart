import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:primecare_v4/design_system/clinical_glass.dart';
import 'package:primecare_v4/design_system/primecare_theme.dart';

class HomecareScreen extends ConsumerWidget {
  const HomecareScreen({super.key});

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
                      'Homecare Prescriptions',
                      style: PrimeCareTheme.typography.heroTitle.copyWith(
                        color: PrimeCareTheme.colors.navyIndigo,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Assign stretching, hydrotherapy, and remedial exercises.',
                      style: PrimeCareTheme.typography.body.copyWith(
                        color: PrimeCareTheme.colors.slateGray,
                      ),
                    ),
                  ],
                ),
                ClinicalGlassButton(
                  onPressed: () {},
                  icon: LucideIcons.send,
                  label: 'Send New Program',
                ),
              ],
            ),
            const SizedBox(height: 32),
            ClinicalGlassPanel(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Exercise Library', style: PrimeCareTheme.typography.h2),
                  const SizedBox(height: 16),
                  ClinicalSearchTextField(hintText: 'Search exercises, stretches, or hydrotherapy...'),
                  const SizedBox(height: 24),
                  Row(
                    children: [
                      Expanded(child: _buildLibraryCard('Upper Body Stretches', LucideIcons.activity)),
                      const SizedBox(width: 16),
                      Expanded(child: _buildLibraryCard('Lower Back Regimen', LucideIcons.activity)),
                      const SizedBox(width: 16),
                      Expanded(child: _buildLibraryCard('Hydrotherapy (Contrast)', LucideIcons.droplet)),
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

  Widget _buildLibraryCard(String title, IconData icon) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: PrimeCareTheme.colors.surfaceContainerLow,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: PrimeCareTheme.colors.surfaceContainerHighest),
      ),
      child: Column(
        children: [
          Icon(icon, size: 32, color: PrimeCareTheme.colors.emeraldTeal),
          const SizedBox(height: 12),
          Text(title, style: PrimeCareTheme.typography.body.copyWith(fontWeight: FontWeight.bold), textAlign: TextAlign.center),
        ],
      ),
    );
  }
}
