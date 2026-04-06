import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:primecare_v4/design_system/clinical_glass.dart';
import 'package:primecare_v4/design_system/primecare_theme.dart';

class SalesPerformanceScreen extends ConsumerWidget {
  const SalesPerformanceScreen({super.key});

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
              'Sales & Performance',
              style: PrimeCareTheme.typography.heroTitle.copyWith(
                color: PrimeCareTheme.colors.navyIndigo,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Analyze franchise sales team performance vs targets.',
              style: PrimeCareTheme.typography.body.copyWith(
                color: PrimeCareTheme.colors.slateGray,
              ),
            ),
            const SizedBox(height: 32),
            Row(
              children: [
                Expanded(child: _buildKPI('YTD Actual', '\$12.5M', '+15% vs Target', LucideIcons.trendingUp)),
                const SizedBox(width: 16),
                Expanded(child: _buildKPI('Current Pipeline', '\$8.1M', 'Needs attention', LucideIcons.alertCircle)),
                const SizedBox(width: 16),
                Expanded(child: _buildKPI('Win Rate', '35%', '+2% MoM', LucideIcons.award)),
              ],
            ),
            const SizedBox(height: 32),
            ClinicalGlassPanel(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Regional Leaders', style: PrimeCareTheme.typography.h2),
                  const SizedBox(height: 24),
                  _buildLeaderRow('Jessica Wong', 'Ontario', '\$4.2M contracted', 1),
                  _buildLeaderRow('David Smith', 'BC', '\$3.1M contracted', 2),
                  _buildLeaderRow('Amir K.', 'Alberta', '\$2.8M contracted', 3),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildKPI(String title, String value, String subtitle, IconData icon) {
    return ClinicalGlassPanel(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(title, style: PrimeCareTheme.typography.label.copyWith(color: PrimeCareTheme.colors.slateGray)),
              Icon(icon, color: PrimeCareTheme.colors.emeraldTeal, size: 20),
            ],
          ),
          const SizedBox(height: 16),
          Text(value, style: PrimeCareTheme.typography.heroTitle),
          const SizedBox(height: 4),
          Text(subtitle, style: PrimeCareTheme.typography.label.copyWith(color: PrimeCareTheme.colors.navyIndigo)),
        ],
      ),
    );
  }

  Widget _buildLeaderRow(String name, String region, String stats, int rank) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          CircleAvatar(
            backgroundColor: rank == 1 ? PrimeCareTheme.colors.amberWarning.withOpacity(0.2) : PrimeCareTheme.colors.navyIndigo.withOpacity(0.1),
            child: Text('#$rank', style: TextStyle(fontWeight: FontWeight.bold, color: rank == 1 ? PrimeCareTheme.colors.amberWarning : PrimeCareTheme.colors.navyIndigo)),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(name, style: PrimeCareTheme.typography.h3),
                Text(region, style: PrimeCareTheme.typography.label.copyWith(color: PrimeCareTheme.colors.slateGray)),
              ],
            ),
          ),
          Text(stats, style: PrimeCareTheme.typography.h3.copyWith(color: PrimeCareTheme.colors.emeraldTeal)),
        ],
      ),
    );
  }
}
