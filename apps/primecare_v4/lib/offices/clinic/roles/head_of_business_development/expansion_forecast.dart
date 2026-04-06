import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:primecare_v4/design_system/clinical_glass.dart';
import 'package:primecare_v4/design_system/primecare_theme.dart';

class ExpansionForecastScreen extends ConsumerWidget {
  const ExpansionForecastScreen({super.key});

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
                      'Expansion Forecast',
                      style: PrimeCareTheme.typography.heroTitle.copyWith(
                        color: PrimeCareTheme.colors.navyIndigo,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Track projected clinic rollouts and territory mapping.',
                      style: PrimeCareTheme.typography.body.copyWith(
                        color: PrimeCareTheme.colors.slateGray,
                      ),
                    ),
                  ],
                ),
                ClinicalGlassButton(
                  onPressed: () {},
                  icon: LucideIcons.download,
                  label: 'Export Report',
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
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('National Rollout Map', style: PrimeCareTheme.typography.h2),
                      Row(
                        children: [
                          _buildLegendItem('Signed', PrimeCareTheme.colors.emeraldTeal),
                          const SizedBox(width: 16),
                          _buildLegendItem('In Progress', PrimeCareTheme.colors.amberWarning),
                          const SizedBox(width: 16),
                          _buildLegendItem('Target', PrimeCareTheme.colors.coralRed),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  Container(
                    height: 400,
                    decoration: BoxDecoration(
                      color: PrimeCareTheme.colors.navyIndigo.withOpacity(0.05),
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: PrimeCareTheme.colors.surfaceContainerHighest),
                    ),
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(LucideIcons.map, size: 64, color: PrimeCareTheme.colors.navyIndigo.withOpacity(0.3)),
                          const SizedBox(height: 16),
                          Text('Interactive Map Canvas Initializing...', style: PrimeCareTheme.typography.body.copyWith(color: PrimeCareTheme.colors.slateGray)),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            Row(
              children: [
                Expanded(
                  flex: 3,
                  child: ClinicalGlassPanel(
                    padding: const EdgeInsets.all(24),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Projected Revenue by Region', style: PrimeCareTheme.typography.h2),
                        const SizedBox(height: 24),
                        _buildRegionForecast('Ontario', '\$2.4M', 12),
                        const SizedBox(height: 16),
                        _buildRegionForecast('British Columbia', '\$1.1M', 5),
                        const SizedBox(height: 16),
                        _buildRegionForecast('Alberta', '\$850k', 3),
                      ],
                    ),
                  ),
                ),
                const SizedBox(width: 24),
                Expanded(
                  flex: 2,
                  child: ClinicalGlassPanel(
                    padding: const EdgeInsets.all(24),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Timeline', style: PrimeCareTheme.typography.h2),
                        const SizedBox(height: 24),
                        _buildTimelineEvent('Q3 2026', 'Opening 3 clinics in GTA'),
                        const SizedBox(height: 12),
                        _buildTimelineEvent('Q4 2026', 'Soft launch in Vancouver'),
                        const SizedBox(height: 12),
                        _buildTimelineEvent('Q1 2027', 'Calgary flagship opening'),
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

  Widget _buildLegendItem(String label, Color color) {
    return Row(
      children: [
        Container(
          width: 12,
          height: 12,
          decoration: BoxDecoration(color: color, shape: BoxShape.circle),
        ),
        const SizedBox(width: 8),
        Text(label, style: PrimeCareTheme.typography.label),
      ],
    );
  }

  Widget _buildRegionForecast(String region, String revenue, int clinics) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(region, style: PrimeCareTheme.typography.h3),
            Text('Projected: $clinics new clinics', style: PrimeCareTheme.typography.label.copyWith(color: PrimeCareTheme.colors.slateGray)),
          ],
        ),
        Text(revenue, style: PrimeCareTheme.typography.h2.copyWith(color: PrimeCareTheme.colors.emeraldTeal)),
      ],
    );
  }

  Widget _buildTimelineEvent(String date, String event) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: const EdgeInsets.only(top: 4, right: 12),
          width: 8,
          height: 8,
          decoration: BoxDecoration(color: PrimeCareTheme.colors.navyIndigo, shape: BoxShape.circle),
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(date, style: PrimeCareTheme.typography.label.copyWith(fontWeight: FontWeight.bold, color: PrimeCareTheme.colors.navyIndigo)),
              const SizedBox(height: 4),
              Text(event, style: PrimeCareTheme.typography.body),
            ],
          ),
        ),
      ],
    );
  }
}
