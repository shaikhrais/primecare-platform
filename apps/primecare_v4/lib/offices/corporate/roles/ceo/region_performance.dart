import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:primecare_v4/design_system/clinical_glass.dart';
import 'package:primecare_v4/design_system/primecare_theme.dart';

class RegionPerformanceScreen extends ConsumerWidget {
  const RegionPerformanceScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Regional Performance',
              style: PrimeCareTheme.typography.heroTitle.copyWith(
                color: PrimeCareTheme.colors.navyIndigo,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Comparative metrics across geographic divisions.',
              style: PrimeCareTheme.typography.body.copyWith(
                color: PrimeCareTheme.colors.slateGray,
              ),
            ),
            const SizedBox(height: 32),
            ClinicalGlassPanel(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Region Leaderboard', style: PrimeCareTheme.typography.h2),
                  const SizedBox(height: 24),
                  _buildRegionRow('North America', '\$102M', '+12%', true),
                  _buildRegionRow('Europe', '\$43M', '+8%', true),
                  _buildRegionRow('Asia-Pacific', '\$18M', '-2%', false),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRegionRow(String name, String revenue, String growth, bool positive) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Icon(LucideIcons.globe, color: PrimeCareTheme.colors.navyIndigo),
              const SizedBox(width: 16),
              Text(name, style: PrimeCareTheme.typography.h3),
            ],
          ),
          Row(
            children: [
              Text(revenue, style: PrimeCareTheme.typography.h3),
              const SizedBox(width: 16),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: positive ? PrimeCareTheme.colors.emeraldTeal.withOpacity(0.1) : PrimeCareTheme.colors.coralRed.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(growth, style: PrimeCareTheme.typography.label.copyWith(color: positive ? PrimeCareTheme.colors.emeraldTeal : PrimeCareTheme.colors.coralRed)),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
