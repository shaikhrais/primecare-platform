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
        padding: const EdgeInsets.all(32.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeader(),
            const SizedBox(height: 32),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 3,
                  child: _buildClientsTable(),
                ),
                const SizedBox(width: 32),
                Expanded(
                  flex: 1,
                  child: _buildPatientLoadAnalytics(),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
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
              'Manage and view your assigned patient roster and acuity levels.',
              style: PrimeCareTheme.typography.body.copyWith(
                color: PrimeCareTheme.colors.slateGray,
              ),
            ),
          ],
        ),
        SizedBox(
          width: 300,
          child: ClinicalSearchTextField(
            hintText: 'Search patients...',
          ),
        ),
      ],
    );
  }

  Widget _buildClientsTable() {
    return ClinicalGlassPanel(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Active Roster',
                style: PrimeCareTheme.typography.h2.copyWith(
                  color: PrimeCareTheme.colors.navyIndigo,
                ),
              ),
              TextButton.icon(
                onPressed: () {},
                icon: const Icon(LucideIcons.listFilter, size: 16),
                label: const Text('Filter'),
              ),
            ],
          ),
          const SizedBox(height: 24),
          _buildClientRow('John Carmichael', '78', 'Wound Care Mgmt', 'Room 302', 'High Acuity', Colors.orange),
          const Divider(height: 32, color: Colors.black12),
          _buildClientRow('Eleanor Vance', '82', 'Catheter Maintenance', 'Room 105', 'Routine', PrimeCareTheme.colors.emeraldTeal),
          const Divider(height: 32, color: Colors.black12),
          _buildClientRow('Sylvia Plath', '65', 'Palliative Support', 'Home Health', 'Routine', PrimeCareTheme.colors.emeraldTeal),
          const Divider(height: 32, color: Colors.black12),
          _buildClientRow('Arthur Pendelton', '90', 'Medication Admin', 'Room 214', 'Routine', PrimeCareTheme.colors.emeraldTeal),
          const Divider(height: 32, color: Colors.black12),
          _buildClientRow('Margaret Atwood', '74', 'Post-Op Observation', 'Room 410', 'Observation', Colors.blue),
        ],
      ),
    );
  }

  Widget _buildClientRow(String name, String age, String dx, String room, String status, MaterialColor color) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          flex: 2,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                name,
                style: PrimeCareTheme.typography.h3.copyWith(
                  color: PrimeCareTheme.colors.navyIndigo,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                'Age: $age • $room',
                style: PrimeCareTheme.typography.label.copyWith(color: PrimeCareTheme.colors.slateGray),
              ),
            ],
          ),
        ),
        Expanded(
          flex: 2,
          child: Text(
            dx,
            style: PrimeCareTheme.typography.body.copyWith(
              color: PrimeCareTheme.colors.navyIndigo,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            color: color.shade50,
            borderRadius: BorderRadius.circular(24),
            border: Border.all(color: color.shade200),
          ),
          child: Text(
            status,
            style: PrimeCareTheme.typography.label.copyWith(
              color: color.shade700,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        const SizedBox(width: 16),
        IconButton(
          onPressed: () {},
          icon: Icon(LucideIcons.chevronRight, color: PrimeCareTheme.colors.slateGray),
        ),
      ],
    );
  }

  Widget _buildPatientLoadAnalytics() {
    return ClinicalGlassPanel(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Patient Load',
            style: PrimeCareTheme.typography.h3.copyWith(
              color: PrimeCareTheme.colors.navyIndigo,
            ),
          ),
          const SizedBox(height: 24),
          _buildLoadBar('High Acuity', 0.2, Colors.orange),
          const SizedBox(height: 16),
          _buildLoadBar('Observation', 0.15, Colors.blue),
          const SizedBox(height: 16),
          _buildLoadBar('Routine', 0.65, PrimeCareTheme.colors.emeraldTeal),
          const SizedBox(height: 32),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: PrimeCareTheme.colors.surfaceContainerLow,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              children: [
                Icon(LucideIcons.users, color: PrimeCareTheme.colors.emeraldTeal),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Total Patients',
                        style: PrimeCareTheme.typography.label,
                      ),
                      Text(
                        '14 Assigned',
                        style: PrimeCareTheme.typography.h3,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLoadBar(String label, double fill, Color color) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: PrimeCareTheme.typography.label.copyWith(color: PrimeCareTheme.colors.slateGray),
        ),
        const SizedBox(height: 8),
        Container(
          height: 8,
          width: double.infinity,
          decoration: BoxDecoration(
            color: PrimeCareTheme.colors.slateGray.withOpacity(0.1),
            borderRadius: BorderRadius.circular(4),
          ),
          child: FractionallySizedBox(
            alignment: Alignment.centerLeft,
            widthFactor: fill,
            child: Container(
              decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.circular(4),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

