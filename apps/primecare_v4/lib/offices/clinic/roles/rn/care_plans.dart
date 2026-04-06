import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:primecare_v4/design_system/primecare_theme.dart';
import 'package:primecare_v4/design_system/clinical_glass.dart';
import 'package:primecare_v4/shared/components/page_template.dart';

class CarePlansScreen extends ConsumerWidget {
  const CarePlansScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return PageTemplate(
      title: 'Care Plans',
      subtitle: 'Review, evaluate, and update nursing care plans.',
      kpiCards: [
        KPICardData(
          title: 'Active Care Plans',
          value: '18',
          icon: LucideIcons.fileText,
          trend: 0.0,
          trendLabel: 'matching caseload',
        ),
        KPICardData(
          title: 'Due for Review',
          value: '4',
          icon: LucideIcons.refreshCw,
          trend: 2.0,
          trendLabel: 'require updates',
        ),
        KPICardData(
          title: 'Goals Achieved',
          value: '12',
          icon: LucideIcons.target,
          trend: 5.0,
          trendLabel: 'in past 30 days',
        ),
        KPICardData(
          title: 'New Orders',
          value: '2',
          icon: LucideIcons.filePlus,
          trend: 0.0,
          trendLabel: 'pending integration',
        ),
      ],
      sidebarContent: [
        ClinicalGlassPanel(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Care Plan Status', style: PrimeCareTheme.typography.h3),
              const SizedBox(height: 16),
              _buildStatusRow('Active & Updated', 12, PrimeCareTheme.colors.emeraldTeal),
              _buildStatusRow('Review Pending', 4, PrimeCareTheme.colors.coralRed),
              _buildStatusRow('New - Awaiting Drafting', 2, PrimeCareTheme.colors.navyIndigo),
            ],
          ),
        ),
        const SizedBox(height: 24),
        ClinicalGlassPanel(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Common Interventions', style: PrimeCareTheme.typography.h3),
              const SizedBox(height: 16),
              _buildInterventionRow('Wound Care Protocol', '8 clients'),
              _buildInterventionRow('Medication Management', '15 clients'),
              _buildInterventionRow('Pain Assessment', '10 clients'),
              _buildInterventionRow('Fall Risk Precautions', '12 clients'),
            ],
          ),
        ),
      ],
      mainContent: [
        ClinicalGlassPanel(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Care Plans Due for Review', style: PrimeCareTheme.typography.h2),
              const SizedBox(height: 24),
              _buildCarePlanCard(
                'Eleanor Rigby',
                'Post-op Hip Replacement',
                'Evaluate mobility goals and pain management effectiveness.',
                'Due Today',
                PrimeCareTheme.colors.coralRed,
              ),
              _buildCarePlanCard(
                'John Smith',
                'Diabetic Foot Ulcer',
                'Update wound measurement and review antibiotic therapy.',
                'Due Tomorrow',
                PrimeCareTheme.colors.coralRed,
              ),
              const SizedBox(height: 32),
              Text('Recently Updated', style: PrimeCareTheme.typography.h3),
              const SizedBox(height: 16),
              _buildCarePlanCard(
                'Maria Garcia',
                'Hypertension Management',
                'Added daily BP monitoring logs and adjusted sodium intake goals.',
                'Updated 2 days ago',
                PrimeCareTheme.colors.emeraldTeal,
              ),
              _buildCarePlanCard(
                'Robert Chen',
                'IV Antibiotics (PICC line)',
                'PICC line dressing changed. No signs of infection at site.',
                'Updated Yesterday',
                PrimeCareTheme.colors.emeraldTeal,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildStatusRow(String label, int count, Color color) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Container(
                width: 12,
                height: 12,
                decoration: BoxDecoration(
                  color: color,
                  shape: BoxShape.circle,
                ),
              ),
              const SizedBox(width: 8),
              Text(label, style: PrimeCareTheme.typography.body),
            ],
          ),
          Text(count.toString(), style: PrimeCareTheme.typography.label.copyWith(fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }

  Widget _buildInterventionRow(String name, String usage) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(child: Text(name, style: PrimeCareTheme.typography.body)),
          Text(usage, style: PrimeCareTheme.typography.label.copyWith(color: PrimeCareTheme.colors.slateGray)),
        ],
      ),
    );
  }

  Widget _buildCarePlanCard(String clientName, String primaryDiagnosis, String reviewNotes, String status, Color statusColor) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: PrimeCareTheme.colors.surfaceContainerHighest.withOpacity(0.3),
        borderRadius: BorderRadius.circular(16),
        border: Border(left: BorderSide(color: statusColor, width: 4)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(clientName, style: PrimeCareTheme.typography.h3),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: statusColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Text(
                  status,
                  style: PrimeCareTheme.typography.label.copyWith(color: statusColor, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
          const SizedBox(height: 4),
          Row(
            children: [
              Icon(LucideIcons.activity, size: 14, color: PrimeCareTheme.colors.slateGray),
              const SizedBox(width: 6),
              Text(primaryDiagnosis, style: PrimeCareTheme.typography.label.copyWith(color: PrimeCareTheme.colors.slateGray)),
            ],
          ),
          const SizedBox(height: 16),
          Text('Key Focus:', style: PrimeCareTheme.typography.label.copyWith(fontWeight: FontWeight.bold)),
          const SizedBox(height: 4),
          Text(reviewNotes, style: PrimeCareTheme.typography.body),
          const SizedBox(height: 16),
          Align(
            alignment: Alignment.centerRight,
            child: TextButton(
              onPressed: () {},
              style: TextButton.styleFrom(
                foregroundColor: PrimeCareTheme.colors.navyIndigo,
              ),
              child: const Text('View Full Plan'),
            ),
          )
        ],
      ),
    );
  }
}
