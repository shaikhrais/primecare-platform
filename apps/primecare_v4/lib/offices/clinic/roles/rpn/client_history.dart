import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:primecare_v4/design_system/clinical_glass.dart';
import 'package:primecare_v4/design_system/primecare_theme.dart';

class ClientHistoryScreen extends ConsumerWidget {
  const ClientHistoryScreen({super.key});

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
              'Client History',
              style: PrimeCareTheme.typography.heroTitle.copyWith(
                color: PrimeCareTheme.colors.navyIndigo,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Review historical medical records and previous RPN/RN interventions.',
              style: PrimeCareTheme.typography.body.copyWith(
                color: PrimeCareTheme.colors.slateGray,
              ),
            ),
            const SizedBox(height: 32),
            ClinicalSearchTextField(
              hintText: 'Search by client name, conditions, or past procedures...',
            ),
            const SizedBox(height: 32),
            ClinicalGlassPanel(
              padding: const EdgeInsets.all(24),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Recent Record Access', style: PrimeCareTheme.typography.h2),
                      Icon(LucideIcons.history, color: PrimeCareTheme.colors.emeraldTeal),
                    ],
                  ),
                  const SizedBox(height: 24),
                  _buildHistoryRow('John Carmichael', 'Wound Management Log (Q3)', 'Sep 10, 2026'),
                  const Divider(),
                  _buildHistoryRow('Eleanor Vance', 'Post-Op Catheter Install', 'Aug 22, 2026'),
                  const Divider(),
                  _buildHistoryRow('Sylvia Plath', 'Initial Palliative Assessment', 'Jul 15, 2026'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHistoryRow(String patient, String event, String date) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Row(
        children: [
          CircleAvatar(
            backgroundColor: PrimeCareTheme.colors.surfaceContainerLow,
            child: Icon(LucideIcons.fileText, color: PrimeCareTheme.colors.navyIndigo, size: 18),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(patient, style: PrimeCareTheme.typography.h3),
                Text(event, style: PrimeCareTheme.typography.body.copyWith(color: PrimeCareTheme.colors.slateGray)),
              ],
            ),
          ),
          Text(date, style: PrimeCareTheme.typography.label),
          const SizedBox(width: 16),
          ClinicalGlassButton(onPressed: () {}, label: 'View Details'),
        ],
      ),
    );
  }
}
