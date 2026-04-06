import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:primecare_v4/design_system/clinical_glass.dart';
import 'package:primecare_v4/design_system/primecare_theme.dart';

class CompletedVisitsScreen extends ConsumerWidget {
  const CompletedVisitsScreen({super.key});

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
                      'Completed Visits',
                      style: PrimeCareTheme.typography.heroTitle.copyWith(
                        color: PrimeCareTheme.colors.navyIndigo,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Past shift logs and completion records.',
                      style: PrimeCareTheme.typography.body.copyWith(
                        color: PrimeCareTheme.colors.slateGray,
                      ),
                    ),
                  ],
                ),
                ClinicalGlassPanel(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  child: Row(
                    children: [
                      Icon(LucideIcons.listFilter, color: PrimeCareTheme.colors.emeraldTeal, size: 20),
                      const SizedBox(width: 8),
                      Text(
                        'This Week',
                        style: PrimeCareTheme.typography.label.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 32),
            _buildVisitHistoryCard('Sep 23, 2026', 'Miriam Foster', 'Shift Completed (2h 15m)', true),
            const SizedBox(height: 16),
            _buildVisitHistoryCard('Sep 23, 2026', 'Arthur Pendelton', 'Shift Completed (1h 50m)', true),
            const SizedBox(height: 16),
            _buildVisitHistoryCard('Sep 22, 2026', 'Eleanor Vance', 'Shift Completed (3h 05m)', true),
            const SizedBox(height: 16),
            _buildVisitHistoryCard('Sep 22, 2026', 'Sylvia Plath', 'Missed / Rescheduled', false),
          ],
        ),
      ),
    );
  }

  Widget _buildVisitHistoryCard(String date, String patient, String status, bool completed) {
    return ClinicalGlassPanel(
      padding: const EdgeInsets.all(24),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: completed ? PrimeCareTheme.colors.emeraldTeal.withOpacity(0.1) : PrimeCareTheme.colors.coralRed.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  completed ? LucideIcons.checkCircle : LucideIcons.xCircle,
                  color: completed ? PrimeCareTheme.colors.emeraldTeal : PrimeCareTheme.colors.coralRed,
                ),
              ),
              const SizedBox(width: 16),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    patient,
                    style: PrimeCareTheme.typography.h3,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '$date • $status',
                    style: PrimeCareTheme.typography.body.copyWith(
                      color: PrimeCareTheme.colors.slateGray,
                    ),
                  ),
                ],
              ),
            ],
          ),
          ClinicalGlassButton(
            onPressed: () {},
            label: 'View Logs',
            icon: LucideIcons.fileText,
          ),
        ],
      ),
    );
  }
}
