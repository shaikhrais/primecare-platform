import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:primecare_v4/design_system/clinical_glass.dart';
import 'package:primecare_v4/design_system/primecare_theme.dart';

class SessionHistoryScreen extends ConsumerWidget {
  const SessionHistoryScreen({super.key});

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
              'Session History',
              style: PrimeCareTheme.typography.heroTitle.copyWith(
                color: PrimeCareTheme.colors.navyIndigo,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Log of previous RMT encounters across all patients.',
              style: PrimeCareTheme.typography.body.copyWith(
                color: PrimeCareTheme.colors.slateGray,
              ),
            ),
            const SizedBox(height: 32),
            ClinicalGlassPanel(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Recent Sessions', style: PrimeCareTheme.typography.h2),
                      Icon(LucideIcons.list, color: PrimeCareTheme.colors.emeraldTeal),
                    ],
                  ),
                  const SizedBox(height: 24),
                  _buildHistoryRow('Emma Watson', '60 Min Massage Therapy', 'Sep 23, 2026', 'Completed'),
                  const Divider(),
                  _buildHistoryRow('Liam Chen', '45 Min Targeted Tx', 'Sep 22, 2026', 'Completed'),
                  const Divider(),
                  _buildHistoryRow('David Lee', '90 Min Full Body', 'Sep 20, 2026', 'Completed'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHistoryRow(String patient, String type, String date, String status) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Row(
        children: [
          CircleAvatar(
            backgroundColor: PrimeCareTheme.colors.surfaceContainerLow,
            child: Icon(LucideIcons.calendarDays, color: PrimeCareTheme.colors.navyIndigo, size: 18),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(patient, style: PrimeCareTheme.typography.h3),
                Text(type, style: PrimeCareTheme.typography.body.copyWith(color: PrimeCareTheme.colors.slateGray)),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(date, style: PrimeCareTheme.typography.label.copyWith(fontWeight: FontWeight.bold)),
              Text(status, style: PrimeCareTheme.typography.label.copyWith(color: PrimeCareTheme.colors.emeraldTeal)),
            ],
          ),
          const SizedBox(width: 16),
          ClinicalGlassButton(onPressed: () {}, label: 'View Notes'),
        ],
      ),
    );
  }
}
