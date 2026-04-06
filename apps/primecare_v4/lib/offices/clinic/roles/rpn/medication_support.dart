import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:primecare_v4/design_system/clinical_glass.dart';
import 'package:primecare_v4/design_system/primecare_theme.dart';

class MedicationSupportScreen extends ConsumerWidget {
  const MedicationSupportScreen({super.key});

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
                      'Medication Support',
                      style: PrimeCareTheme.typography.heroTitle.copyWith(
                        color: PrimeCareTheme.colors.navyIndigo,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Track eMAR (Electronic Medication Administration Record) and compliance.',
                      style: PrimeCareTheme.typography.body.copyWith(
                        color: PrimeCareTheme.colors.slateGray,
                      ),
                    ),
                  ],
                ),
                ClinicalSearchTextField(
                  hintText: 'Search medications or patients...',
                ),
              ],
            ),
            const SizedBox(height: 32),
            Text('Due Now (Next 2 Hours)', style: PrimeCareTheme.typography.h2),
            const SizedBox(height: 16),
            _buildMedicationCard('John Carmichael', 'Metformin 500mg (Oral)', 'With meal', 'Due at 12:00 PM', true),
            const SizedBox(height: 16),
            _buildMedicationCard('Eleanor Vance', 'Lisinopril 10mg (Oral)', 'Once daily', 'Due at 01:00 PM', true),
            
            const SizedBox(height: 32),
            Text('Completed Today', style: PrimeCareTheme.typography.h2),
            const SizedBox(height: 16),
            _buildMedicationCard('Sylvia Plath', 'Morphine 5mg (SubQ)', 'PRN for pain', 'Administered 08:30 AM', false),
          ],
        ),
      ),
    );
  }

  Widget _buildMedicationCard(String patient, String medication, String instructions, String status, bool pending) {
    return ClinicalGlassPanel(
      padding: const EdgeInsets.all(24),
      border: Border.all(
        color: pending ? PrimeCareTheme.colors.amberWarning.withOpacity(0.3) : PrimeCareTheme.colors.surfaceContainerHighest,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: pending ? PrimeCareTheme.colors.amberWarning.withOpacity(0.1) : PrimeCareTheme.colors.emeraldTeal.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(
              LucideIcons.pill,
              size: 28,
              color: pending ? PrimeCareTheme.colors.amberWarning : PrimeCareTheme.colors.emeraldTeal,
            ),
          ),
          const SizedBox(width: 24),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  medication,
                  style: PrimeCareTheme.typography.h3,
                ),
                const SizedBox(height: 4),
                Text(
                  'Patient: $patient',
                  style: PrimeCareTheme.typography.body.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  instructions,
                  style: PrimeCareTheme.typography.body.copyWith(
                    color: PrimeCareTheme.colors.slateGray,
                  ),
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: PrimeCareTheme.colors.surfaceContainerLow,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  status,
                  style: PrimeCareTheme.typography.label.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 16),
              if (pending)
                ClinicalGlassButton(
                  onPressed: () {},
                  label: 'Scan & Administer',
                  icon: LucideIcons.scan,
                )
              else
                Row(
                  children: [
                    Icon(LucideIcons.checkCircle, color: PrimeCareTheme.colors.emeraldTeal, size: 16),
                    const SizedBox(width: 8),
                    Text(
                      'Verified',
                      style: PrimeCareTheme.typography.label.copyWith(
                        color: PrimeCareTheme.colors.emeraldTeal,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
            ],
          ),
        ],
      ),
    );
  }
}
