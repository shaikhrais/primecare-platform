import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:primecare_v4/design_system/clinical_glass.dart';
import 'package:primecare_v4/design_system/primecare_theme.dart';

class IncidentReportsScreen extends ConsumerWidget {
  const IncidentReportsScreen({super.key});

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
                      'Incident Reports',
                      style: PrimeCareTheme.typography.heroTitle.copyWith(
                        color: PrimeCareTheme.colors.navyIndigo,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Log and manage workplace or patient incidents.',
                      style: PrimeCareTheme.typography.body.copyWith(
                        color: PrimeCareTheme.colors.slateGray,
                      ),
                    ),
                  ],
                ),
                ClinicalGlassButton(
                  onPressed: () {},
                  icon: LucideIcons.plus,
                  label: 'New Report',
                ),
              ],
            ),
            const SizedBox(height: 32),
            _buildIncidentCard('Slip and Fall - Minor', 'Eleanor Vance', 'Sep 21, 2026', 'Resolved', false),
            const SizedBox(height: 16),
            _buildIncidentCard('Medication Refusal', 'Arthur Pendelton', 'Sep 15, 2026', 'Under Review', true),
            const SizedBox(height: 16),
            _buildIncidentCard('Property Damage - Broken Lamp', 'Miriam Foster', 'Aug 30, 2026', 'Resolved', false),
          ],
        ),
      ),
    );
  }

  Widget _buildIncidentCard(String title, String patient, String date, String status, bool pendingReview) {
    return ClinicalGlassPanel(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: PrimeCareTheme.typography.h3,
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: pendingReview ? PrimeCareTheme.colors.amberWarning.withOpacity(0.1) : PrimeCareTheme.colors.emeraldTeal.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  status,
                  style: PrimeCareTheme.typography.label.copyWith(
                    color: pendingReview ? PrimeCareTheme.colors.amberWarning : PrimeCareTheme.colors.emeraldTeal,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Icon(LucideIcons.user, size: 14, color: PrimeCareTheme.colors.slateGray),
              const SizedBox(width: 4),
              Text(
                patient,
                style: PrimeCareTheme.typography.body.copyWith(color: PrimeCareTheme.colors.slateGray),
              ),
              const SizedBox(width: 16),
              Icon(LucideIcons.calendar, size: 14, color: PrimeCareTheme.colors.slateGray),
              const SizedBox(width: 4),
              Text(
                date,
                style: PrimeCareTheme.typography.body.copyWith(color: PrimeCareTheme.colors.slateGray),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
