import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:primecare_v4/design_system/clinical_glass.dart';
import 'package:primecare_v4/design_system/primecare_theme.dart';

class FranchisePipelineScreen extends ConsumerWidget {
  const FranchisePipelineScreen({super.key});

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
              'Franchise Pipeline',
              style: PrimeCareTheme.typography.heroTitle.copyWith(
                color: PrimeCareTheme.colors.navyIndigo,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Track the progress of franchise onboarding and establishment.',
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
                  Text('Onboarding Stages', style: PrimeCareTheme.typography.h2),
                  const SizedBox(height: 16),
                  _buildStageRow('1', 'Legal & Compliance', '3 Franchises', 0.8),
                  const SizedBox(height: 12),
                  _buildStageRow('2', 'Real Estate & Fit-out', '5 Franchises', 0.6),
                  const SizedBox(height: 12),
                  _buildStageRow('3', 'Staff Procurement', '2 Franchises', 0.4),
                  const SizedBox(height: 12),
                  _buildStageRow('4', 'Final Training', '1 Franchise', 0.9),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStageRow(String num, String title, String count, double progress) {
    return Row(
      children: [
        CircleAvatar(
          backgroundColor: PrimeCareTheme.colors.navyIndigo.withOpacity(0.1),
          foregroundColor: PrimeCareTheme.colors.navyIndigo,
          child: Text(num, style: const TextStyle(fontWeight: FontWeight.bold)),
        ),
        const SizedBox(width: 16),
        Expanded(
          flex: 2,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: PrimeCareTheme.typography.h3),
              Text(count, style: PrimeCareTheme.typography.label.copyWith(color: PrimeCareTheme.colors.slateGray)),
            ],
          ),
        ),
        Expanded(
          flex: 3,
          child: LinearProgressIndicator(
            value: progress,
            backgroundColor: PrimeCareTheme.colors.surfaceContainerHighest,
            valueColor: AlwaysStoppedAnimation<Color>(PrimeCareTheme.colors.emeraldTeal),
            minHeight: 8,
            borderRadius: BorderRadius.circular(4),
          ),
        ),
        const SizedBox(width: 16),
        Text('${(progress * 100).toInt()}%', style: PrimeCareTheme.typography.label),
      ],
    );
  }
}
