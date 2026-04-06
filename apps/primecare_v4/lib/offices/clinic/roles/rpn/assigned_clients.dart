import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:primecare_v4/design_system/clinical_glass.dart';
import 'package:primecare_v4/design_system/primecare_theme.dart';

class AssignedClientsScreen extends ConsumerWidget {
  const AssignedClientsScreen({super.key});

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
                      'Assigned Clients',
                      style: PrimeCareTheme.typography.heroTitle.copyWith(
                        color: PrimeCareTheme.colors.navyIndigo,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Overview of patients requiring RPN level interventions.',
                      style: PrimeCareTheme.typography.body.copyWith(
                        color: PrimeCareTheme.colors.slateGray,
                      ),
                    ),
                  ],
                ),
                ClinicalSearchTextField(
                  hintText: 'Search clinical clients...',
                ),
              ],
            ),
            const SizedBox(height: 32),
            GridView.count(
              shrinkWrap: true,
              crossAxisCount: 3,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
              childAspectRatio: 0.85,
              children: [
                _buildClientCard('John Carmichael', 'Wound Management', 'Last visit: Yesterday', LucideIcons.user),
                _buildClientCard('Eleanor Vance', 'Catheter Maintenance', 'Last visit: 3 days ago', LucideIcons.user),
                _buildClientCard('Sylvia Plath', 'Palliative Care', 'Last visit: Today', LucideIcons.user),
                _buildClientCard('Arthur Pendelton', 'Medication Setup', 'Last visit: 1 week ago', LucideIcons.user),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildClientCard(String name, String details, String lastVisit, IconData icon) {
    return ClinicalGlassPanel(
      padding: const EdgeInsets.all(24),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircleAvatar(
            radius: 40,
            backgroundColor: PrimeCareTheme.colors.emeraldTeal.withOpacity(0.1),
            child: Icon(icon, size: 32, color: PrimeCareTheme.colors.emeraldTeal),
          ),
          const SizedBox(height: 16),
          Text(
            name,
            style: PrimeCareTheme.typography.h3,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 8),
          Text(
            details,
            style: PrimeCareTheme.typography.label.copyWith(
              color: PrimeCareTheme.colors.navyIndigo,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 8),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(
              color: PrimeCareTheme.colors.surfaceContainerLow,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              lastVisit,
              style: PrimeCareTheme.typography.label.copyWith(fontSize: 12),
            ),
          ),
          const Spacer(),
          ClinicalGlassButton(
            onPressed: () {},
            label: 'Open Chart',
            isFullWidth: true,
          ),
        ],
      ),
    );
  }
}
