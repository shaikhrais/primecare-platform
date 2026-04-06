import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:primecare_v4/design_system/clinical_glass.dart';
import 'package:primecare_v4/design_system/primecare_theme.dart';

class TerritoryMapScreen extends ConsumerWidget {
  const TerritoryMapScreen({super.key});

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
                      'Territory Optimization',
                      style: PrimeCareTheme.typography.heroTitle.copyWith(
                        color: PrimeCareTheme.colors.navyIndigo,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Analyze demographics and white-space for optimal clinic placement.',
                      style: PrimeCareTheme.typography.body.copyWith(
                        color: PrimeCareTheme.colors.slateGray,
                      ),
                    ),
                  ],
                ),
                ClinicalGlassButton(
                  onPressed: () {},
                  icon: LucideIcons.mapPin,
                  label: 'Add Territory',
                ),
              ],
            ),
            const SizedBox(height: 32),
            Container(
              height: 500,
              decoration: BoxDecoration(
                color: PrimeCareTheme.colors.surfaceContainerHighest.withOpacity(0.3),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(LucideIcons.map, size: 80, color: PrimeCareTheme.colors.slateGray.withOpacity(0.5)),
                    const SizedBox(height: 16),
                    Text('GIS Map Canvas Rendering Module Required.', style: PrimeCareTheme.typography.h3.copyWith(color: PrimeCareTheme.colors.slateGray)),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),
            Row(
              children: [
                Expanded(
                  child: ClinicalGlassPanel(
                    padding: const EdgeInsets.all(24),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('High Priority Zones', style: PrimeCareTheme.typography.h3),
                        const SizedBox(height: 16),
                        _buildZoneRow('Greater Toronto Area', 'Demographics align 92%', LucideIcons.checkCircle),
                        _buildZoneRow('Montreal Metro', 'Demographics align 85%', LucideIcons.checkCircle),
                      ],
                    ),
                  ),
                ),
                const SizedBox(width: 24),
                Expanded(
                  child: ClinicalGlassPanel(
                    padding: const EdgeInsets.all(24),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Saturated Zones', style: PrimeCareTheme.typography.h3),
                        const SizedBox(height: 16),
                        _buildZoneRow('Downtown Vancouver', 'High competition detected', LucideIcons.alertTriangle),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildZoneRow(String title, String subtitle, IconData icon) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Icon(icon, color: PrimeCareTheme.colors.navyIndigo, size: 16),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: PrimeCareTheme.typography.label.copyWith(fontWeight: FontWeight.bold)),
                Text(subtitle, style: PrimeCareTheme.typography.label.copyWith(color: PrimeCareTheme.colors.slateGray)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
