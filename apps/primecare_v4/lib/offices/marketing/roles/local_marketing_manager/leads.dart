import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:primecare_v4/design_system/clinical_glass.dart';
import 'package:primecare_v4/design_system/primecare_theme.dart';

class LocalLeadsScreen extends ConsumerWidget {
  const LocalLeadsScreen({super.key});

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
              'Local CRM & Leads',
              style: PrimeCareTheme.typography.heroTitle.copyWith(
                color: PrimeCareTheme.colors.navyIndigo,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Focused CRM view for local area leads and consultation tracking.',
              style: PrimeCareTheme.typography.body.copyWith(
                color: PrimeCareTheme.colors.slateGray,
              ),
            ),
            const SizedBox(height: 32),
            ClinicalGlassPanel(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                   Row(
                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                     children: [
                       Text('Actionable Leads', style: PrimeCareTheme.typography.h2),
                       ClinicalSearchTextField(hintText: 'Search patient/lead...'),
                     ],
                   ),
                   const SizedBox(height: 24),
                   _buildCRMRow('Jessica K.', 'Via: Google Ad', 'New', 'Contact Request'),
                   _buildCRMRow('Mark T.', 'Via: Facebook', 'Attempted', 'No Answer'),
                   _buildCRMRow('Amir H.', 'Via: Walk-in', 'Consult Scheduled', 'April 15'),
                   _buildCRMRow('Sarah M.', 'Via: Referral', 'Converted', 'Patient'),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildCRMRow(String name, String source, String status, String note) {
    Color statusColor;
    if (status == 'New') statusColor = PrimeCareTheme.colors.coralRed;
    else if (status == 'Converted') statusColor = PrimeCareTheme.colors.emeraldTeal;
    else statusColor = PrimeCareTheme.colors.amberWarning;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            flex: 2,
            child: Row(
              children: [
                Icon(LucideIcons.user, color: PrimeCareTheme.colors.navyIndigo, size: 20),
                const SizedBox(width: 12),
                Text(name, style: PrimeCareTheme.typography.h3),
              ],
            ),
          ),
          Expanded(flex: 2, child: Text(source, style: PrimeCareTheme.typography.body.copyWith(color: PrimeCareTheme.colors.slateGray))),
          Expanded(flex: 2, child: Text(note, style: PrimeCareTheme.typography.body)),
          Expanded(
            flex: 1, 
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: statusColor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Center(child: Text(status, style: PrimeCareTheme.typography.label.copyWith(color: statusColor, fontWeight: FontWeight.bold))),
            )
          ),
        ],
      ),
    );
  }
}
