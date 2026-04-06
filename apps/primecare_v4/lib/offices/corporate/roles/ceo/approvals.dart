import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:primecare_v4/design_system/clinical_glass.dart';
import 'package:primecare_v4/design_system/primecare_theme.dart';

class ApprovalsScreen extends ConsumerWidget {
  const ApprovalsScreen({super.key});

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
              'Executive Approvals',
              style: PrimeCareTheme.typography.heroTitle.copyWith(
                color: PrimeCareTheme.colors.navyIndigo,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Requires CEO authorization for major expenditures or strategic agreements.',
              style: PrimeCareTheme.typography.body.copyWith(
                color: PrimeCareTheme.colors.slateGray,
              ),
            ),
            const SizedBox(height: 32),
            ListView(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              children: [
                _buildApprovalItem('Acquisition: TechMed', 'Value: \$4.2M • Requires sign-off by EOD'),
                _buildApprovalItem('Q4 Marketing Budget Expansion', 'Value: \$500k • From CMO'),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget _buildApprovalItem(String title, String subtitle) {
    return ClinicalGlassPanel(
      padding: const EdgeInsets.all(20),
      margin: const EdgeInsets.only(bottom: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: PrimeCareTheme.typography.h3),
                const SizedBox(height: 4),
                Text(subtitle, style: PrimeCareTheme.typography.body.copyWith(color: PrimeCareTheme.colors.slateGray)),
              ],
            ),
          ),
          Row(
            children: [
              TextButton(
                onPressed: () {},
                child: Text('Reject', style: PrimeCareTheme.typography.label.copyWith(color: PrimeCareTheme.colors.coralRed)),
              ),
              const SizedBox(width: 8),
              ClinicalGlassButton(
                onPressed: () {},
                icon: LucideIcons.check,
                label: 'Approve',
              ),
            ],
          ),
        ],
      ),
    );
  }
}
