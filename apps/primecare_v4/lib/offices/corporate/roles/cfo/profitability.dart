import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:primecare_v4/design_system/clinical_glass.dart';
import 'package:primecare_v4/design_system/primecare_theme.dart';

class ProfitabilityScreen extends ConsumerWidget {
  const ProfitabilityScreen({super.key});

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
              'Profitability Analysis',
              style: PrimeCareTheme.typography.heroTitle.copyWith(
                color: PrimeCareTheme.colors.navyIndigo,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Operating margin breakdowns by service line and clinic.',
              style: PrimeCareTheme.typography.body.copyWith(
                color: PrimeCareTheme.colors.slateGray,
              ),
            ),
            const SizedBox(height: 32),
            Row(
              children: [
                Expanded(
                  child: ClinicalGlassPanel(
                    padding: const EdgeInsets.all(24),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('By Service Line', style: PrimeCareTheme.typography.h3),
                        const SizedBox(height: 16),
                        _buildLineMargin('Physiotherapy', '42%'),
                        _buildLineMargin('Chiropractic', '38%'),
                        _buildLineMargin('Massage Therapy', '28%'),
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
                        Text('Highest Performing Clinics', style: PrimeCareTheme.typography.h3),
                        const SizedBox(height: 16),
                        _buildLineMargin('Downtown Toronto', '45%'),
                        _buildLineMargin('Vancouver Central', '41%'),
                        _buildLineMargin('Halifax Flagship', '39%'),
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

  Widget _buildLineMargin(String title, String margin) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Icon(LucideIcons.activity, color: PrimeCareTheme.colors.emeraldTeal, size: 16),
              const SizedBox(width: 8),
              Text(title, style: PrimeCareTheme.typography.body),
            ],
          ),
          Text(margin, style: PrimeCareTheme.typography.h3.copyWith(color: PrimeCareTheme.colors.navyIndigo)),
        ],
      ),
    );
  }
}
