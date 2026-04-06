import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:primecare_v4/design_system/clinical_glass.dart';
import 'package:primecare_v4/design_system/primecare_theme.dart';

class IntakeFormsScreen extends ConsumerWidget {
  const IntakeFormsScreen({super.key});

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
              'Intake Forms',
              style: PrimeCareTheme.typography.heroTitle.copyWith(
                color: PrimeCareTheme.colors.navyIndigo,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Consent, medical history, and pre-assessment paperwork.',
              style: PrimeCareTheme.typography.body.copyWith(
                color: PrimeCareTheme.colors.slateGray,
              ),
            ),
            const SizedBox(height: 32),
            ClinicalSearchTextField(hintText: 'Search patient intakes...'),
            const SizedBox(height: 32),
            Row(
              children: [
                Expanded(
                  child: ClinicalGlassPanel(
                    padding: const EdgeInsets.all(24),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Pending Review', style: PrimeCareTheme.typography.h2),
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                              decoration: BoxDecoration(color: PrimeCareTheme.colors.coralRed, borderRadius: BorderRadius.circular(12)),
                              child: const Text('2', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        _buildFormItem('Chris Evans', 'Initial Health History', 'Awaiting RMT signoff'),
                        _buildFormItem('Laura Croft', 'Consent to Treat', 'Submitted Today'),
                      ],
                    ),
                  ),
                ),
                const SizedBox(width: 24),
                Expanded(
                  child: ClinicalGlassPanel(
                    padding: const EdgeInsets.all(24),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Recent Approvals', style: PrimeCareTheme.typography.h2),
                        const SizedBox(height: 16),
                        _buildFormItem('Emma Watson', 'Initial Health History', 'Approved Sep 22'),
                        _buildFormItem('David Lee', 'COVID Screening', 'Approved Sep 20'),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFormItem(String patient, String formType, String status) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(patient, style: PrimeCareTheme.typography.h3),
                Text('$formType - $status', style: PrimeCareTheme.typography.label.copyWith(color: PrimeCareTheme.colors.slateGray)),
              ],
            ),
          ),
          Icon(LucideIcons.fileCheck, color: PrimeCareTheme.colors.navyIndigo),
        ],
      ),
    );
  }
}
