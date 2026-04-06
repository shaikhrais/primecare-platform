import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:primecare_v4/design_system/clinical_glass.dart';
import 'package:primecare_v4/design_system/primecare_theme.dart';

class ClientsScreen extends ConsumerWidget {
  const ClientsScreen({super.key});

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
                      'Client Roster',
                      style: PrimeCareTheme.typography.heroTitle.copyWith(
                        color: PrimeCareTheme.colors.navyIndigo,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Search and manage your massage therapy clients.',
                      style: PrimeCareTheme.typography.body.copyWith(
                        color: PrimeCareTheme.colors.slateGray,
                      ),
                    ),
                  ],
                ),
                ClinicalSearchTextField(
                  hintText: 'Search clients by name, condition...',
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
                _buildClientCard('Emma Watson', 'Sciatica', 'Last visit: Yesterday', LucideIcons.user),
                _buildClientCard('Liam Chen', 'Chronic Shoulder Pain', 'Last visit: 3 days ago', LucideIcons.user),
                _buildClientCard('Sophia Ramirez', 'Sports Recovery', 'Last visit: Today', LucideIcons.user),
                _buildClientCard('David Lee', 'Post-Op Fibrosis', 'Last visit: 1 week ago', LucideIcons.user),
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
