import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:primecare_v4/design_system/clinical_glass.dart';
import 'package:primecare_v4/design_system/primecare_theme.dart';

class BodyChartScreen extends ConsumerWidget {
  const BodyChartScreen({super.key});

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
                      'Body Chart',
                      style: PrimeCareTheme.typography.heroTitle.copyWith(
                        color: PrimeCareTheme.colors.navyIndigo,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Visual mapping of pain, tension, and trigger points.',
                      style: PrimeCareTheme.typography.body.copyWith(
                        color: PrimeCareTheme.colors.slateGray,
                      ),
                    ),
                  ],
                ),
                ClinicalGlassButton(
                  onPressed: () {},
                  icon: LucideIcons.save,
                  label: 'Save Chart Map',
                ),
              ],
            ),
            const SizedBox(height: 32),
            ClinicalGlassPanel(
              padding: const EdgeInsets.all(24),
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 48),
                  child: Column(
                    children: [
                      Icon(LucideIcons.image, size: 48, color: PrimeCareTheme.colors.emeraldTeal),
                      const SizedBox(height: 16),
                      Text(
                        'Interactive Canvas Pending',
                        style: PrimeCareTheme.typography.h3,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'The Canvas rendering engine is initializing the 2D skeletal view.',
                        style: PrimeCareTheme.typography.body.copyWith(color: PrimeCareTheme.colors.slateGray),
                      ),
                      const SizedBox(height: 24),
                      ClinicalGlassButton(onPressed: () {}, label: 'Select Patient to Load Diagram')
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
