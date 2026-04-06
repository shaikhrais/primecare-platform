import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:primecare_v4/design_system/clinical_glass.dart';
import 'package:primecare_v4/design_system/primecare_theme.dart';

class GrowthPipelineScreen extends ConsumerWidget {
  const GrowthPipelineScreen({super.key});

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
              'Growth Pipeline',
              style: PrimeCareTheme.typography.heroTitle.copyWith(
                color: PrimeCareTheme.colors.navyIndigo,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Quarterly and Annual growth projections and M&A funnel.',
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
                  Text('Pipeline Value Forecast FY26', style: PrimeCareTheme.typography.h2),
                  const SizedBox(height: 24),
                  _buildQuarterMetric('Q1 26', '\$12M', true),
                  Divider(color: PrimeCareTheme.colors.surfaceContainerHighest),
                  _buildQuarterMetric('Q2 26', '\$15.5M', true),
                  Divider(color: PrimeCareTheme.colors.surfaceContainerHighest),
                  _buildQuarterMetric('Q3 26 (Projected)', '\$14M', false),
                  Divider(color: PrimeCareTheme.colors.surfaceContainerHighest),
                  _buildQuarterMetric('Q4 26 (Projected)', '\$18.2M', false),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildQuarterMetric(String quarter, String value, bool isActual) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Icon(LucideIcons.calendar, size: 20, color: PrimeCareTheme.colors.navyIndigo),
              const SizedBox(width: 16),
              Text(quarter, style: PrimeCareTheme.typography.h3),
            ],
          ),
          Row(
            children: [
              Text(value, style: PrimeCareTheme.typography.h2.copyWith(color: isActual ? PrimeCareTheme.colors.emeraldTeal : PrimeCareTheme.colors.slateGray)),
              const SizedBox(width: 12),
              if (isActual)
                 Icon(LucideIcons.checkCircle2, color: PrimeCareTheme.colors.emeraldTeal)
              else
                 Icon(LucideIcons.helpCircle, color: PrimeCareTheme.colors.slateGray),
            ],
          ),
        ],
      ),
    );
  }
}
