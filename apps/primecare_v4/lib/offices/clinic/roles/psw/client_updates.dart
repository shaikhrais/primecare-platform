import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:primecare_v4/design_system/clinical_glass.dart';
import 'package:primecare_v4/design_system/primecare_theme.dart';

class ClientUpdatesScreen extends ConsumerWidget {
  const ClientUpdatesScreen({super.key});

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
                      'Client Updates',
                      style: PrimeCareTheme.typography.heroTitle.copyWith(
                        color: PrimeCareTheme.colors.navyIndigo,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Latest feed from clinical team regarding your patients.',
                      style: PrimeCareTheme.typography.body.copyWith(
                        color: PrimeCareTheme.colors.slateGray,
                      ),
                    ),
                  ],
                ),
                ClinicalGlassButton(
                  onPressed: () {},
                  icon: LucideIcons.plus,
                  label: 'Add Note',
                ),
              ],
            ),
            const SizedBox(height: 32),
            _buildUpdateCard(
              clientName: 'Arthur Pendelton',
              author: 'Sarah Jenkins, RN',
              time: '2 hours ago',
              content: 'Patient complained of minor dizziness during morning walk. Vitals normal. Keep monitoring during afternoon shift.',
              isUrgent: true,
            ),
            const SizedBox(height: 16),
            _buildUpdateCard(
              clientName: 'Eleanor Vance',
              author: 'Dr. Mike Lee',
              time: 'Yesterday, 4:30 PM',
              content: 'Adjusted evening medication dosage. Ensure patient takes new pills with full glass of water.',
              isUrgent: false,
            ),
            const SizedBox(height: 16),
            _buildUpdateCard(
              clientName: 'Miriam Foster',
              author: 'Family Coordinator',
              time: '3 days ago',
              content: 'Daughter will be visiting tomorrow during the 1-3pm shift. Please coordinate with her regarding lunch.',
              isUrgent: false,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildUpdateCard({
    required String clientName,
    required String author,
    required String time,
    required String content,
    required bool isUrgent,
  }) {
    return ClinicalGlassPanel(
      padding: const EdgeInsets.all(24),
      border: Border.all(
        color: isUrgent ? PrimeCareTheme.colors.coralRed.withOpacity(0.3) : PrimeCareTheme.colors.surfaceContainerHighest,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  CircleAvatar(
                    radius: 16,
                    backgroundColor: PrimeCareTheme.colors.navyIndigo.withOpacity(0.1),
                    child: Text(
                      clientName.substring(0, 1),
                      style: PrimeCareTheme.typography.label.copyWith(color: PrimeCareTheme.colors.navyIndigo, fontWeight: FontWeight.bold),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        clientName,
                        style: PrimeCareTheme.typography.h3,
                      ),
                      Text(
                        'By: $author',
                        style: PrimeCareTheme.typography.label.copyWith(color: PrimeCareTheme.colors.slateGray),
                      ),
                    ],
                  ),
                ],
              ),
              if (isUrgent)
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                  decoration: BoxDecoration(
                    color: PrimeCareTheme.colors.coralRed.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    children: [
                      Icon(LucideIcons.alertCircle, size: 14, color: PrimeCareTheme.colors.coralRed),
                      const SizedBox(width: 4),
                      Text(
                        'Urgent',
                        style: PrimeCareTheme.typography.label.copyWith(
                          color: PrimeCareTheme.colors.coralRed,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                )
              else
                Text(
                  time,
                  style: PrimeCareTheme.typography.label.copyWith(color: PrimeCareTheme.colors.slateGray),
                ),
            ],
          ),
          const SizedBox(height: 16),
          Text(
            content,
            style: PrimeCareTheme.typography.body.copyWith(
              color: PrimeCareTheme.colors.navyIndigo.withOpacity(0.8),
              height: 1.5,
            ),
          ),
          if (isUrgent) ...[
            const SizedBox(height: 12),
            Text(
              time,
              style: PrimeCareTheme.typography.label.copyWith(color: PrimeCareTheme.colors.slateGray),
            ),
          ],
        ],
      ),
    );
  }
}
