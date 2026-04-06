import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:primecare_v4/design_system/clinical_glass.dart';
import 'package:primecare_v4/design_system/primecare_theme.dart';
import 'package:primecare_v4/shared/components/page_template.dart';

class PoliciesScreen extends ConsumerWidget {
  const PoliciesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return PageTemplate(
      title: 'Policy & Procedures Management',
      subtitle: 'Author, distribute, and track staff acknowledgment of corporate policies and clinical procedures.',
      headerTrailing: [
        ClinicalSearchTextField(hintText: 'Search policies by title or keyword...'),
        const SizedBox(width: 16),
        ClinicalGlassButton(
          onPressed: () {},
          label: 'Author New Policy',
          icon: LucideIcons.filePlus,
          isPrimary: true,
        ),
      ],
      kpiCards: [
        MetricCardData(
          title: 'Pending Acknowledgment',
          value: '184',
          icon: LucideIcons.users,
          trend: 'Across all active policies',
          isUp: false,
          color: PrimeCareTheme.colors.amberWarning,
        ),
        MetricCardData(
          title: 'Due for Review',
          value: '6',
          icon: LucideIcons.calendarClock,
          trend: 'Requires compliance review',
          isUp: false,
          color: PrimeCareTheme.colors.coralRed,
        ),
        MetricCardData(
          title: 'Total Active Policies',
          value: '420',
          icon: LucideIcons.library,
          trend: '+5 added this quarter',
          isUp: true,
        ),
      ],
      sidebarContent: [
        _buildPolicyCategories(),
        const SizedBox(height: 24),
        _buildRecentRevisions(),
      ],
      mainContent: [
        _buildPolicyDirectory(),
      ],
    );
  }

  Widget _buildPolicyCategories() {
    return ClinicalGlassPanel(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(LucideIcons.folders, color: PrimeCareTheme.colors.navyIndigo, size: 20),
              const SizedBox(width: 8),
              Text('Categories', style: PrimeCareTheme.typography.h3),
            ],
          ),
          const SizedBox(height: 16),
          _buildCatRow('Clinical Care', 145),
          const SizedBox(height: 12),
          _buildCatRow('Human Resources', 82),
          const SizedBox(height: 12),
          _buildCatRow('Information Security', 34),
          const SizedBox(height: 12),
          _buildCatRow('Health & Safety', 95),
          const SizedBox(height: 12),
          _buildCatRow('Finance & Administration', 64),
        ],
      ),
    );
  }

  Widget _buildCatRow(String name, int count) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(name, style: PrimeCareTheme.typography.body),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
          decoration: BoxDecoration(
            color: PrimeCareTheme.colors.cloudGray,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(count.toString(), style: PrimeCareTheme.typography.label),
        ),
      ],
    );
  }

  Widget _buildRecentRevisions() {
    return ClinicalGlassPanel(
      padding: const EdgeInsets.all(24),
      border: Border.all(color: PrimeCareTheme.colors.emeraldTeal.withOpacity(0.3)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(LucideIcons.history, color: PrimeCareTheme.colors.emeraldTeal, size: 20),
              const SizedBox(width: 8),
              Text('Recent Approvals', style: PrimeCareTheme.typography.h3),
            ],
          ),
          const SizedBox(height: 16),
          _buildRevisionItem('Infection Control v4.2', 'Approved Yesterday'),
          const SizedBox(height: 12),
          _buildRevisionItem('Remote Work Policy v2.0', 'Approved Oct 12'),
        ],
      ),
    );
  }

  Widget _buildRevisionItem(String title, String date) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: PrimeCareTheme.typography.body.copyWith(fontWeight: FontWeight.bold)),
        Text(date, style: PrimeCareTheme.typography.label.copyWith(color: PrimeCareTheme.colors.slateGray)),
      ],
    );
  }

  Widget _buildPolicyDirectory() {
    return ClinicalGlassPanel(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(24),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Policy Directory', style: PrimeCareTheme.typography.h2),
                ClinicalGlassButton(
                  onPressed: () {},
                  label: 'Filter: Requires Action',
                  icon: LucideIcons.filter,
                ),
              ],
            ),
          ),
          const Divider(height: 1),
          _buildPolicyRow(
            policyID: 'POL-CL-004',
            title: 'Medication Administration & Reconciliation',
            category: 'Clinical Care',
            status: 'Requires Review',
            lastUpdated: 'Nov 2024',
            ackRate: 98.2,
          ),
          const Divider(height: 1),
          _buildPolicyRow(
            policyID: 'POL-IT-012',
            title: 'Acceptable Use of Corporate Devices',
            category: 'Information Security',
            status: 'New Release (Pending Ack)',
            lastUpdated: 'Oct 2026',
            ackRate: 42.5,
          ),
          const Divider(height: 1),
          _buildPolicyRow(
            policyID: 'POL-HR-002',
            title: 'Workplace Anti-Harassment',
            category: 'Human Resources',
            status: 'Active',
            lastUpdated: 'Jan 2026',
            ackRate: 100.0,
          ),
        ],
      ),
    );
  }

  Widget _buildPolicyRow({
    required String policyID,
    required String title,
    required String category,
    required String status,
    required String lastUpdated,
    required double ackRate,
  }) {
    final requiresAction = status.contains('Review') || status.contains('Pending');
    final iconColor = requiresAction ? PrimeCareTheme.colors.amberWarning : PrimeCareTheme.colors.navyIndigo;

    return Padding(
      padding: const EdgeInsets.all(24),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: iconColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(LucideIcons.fileText, color: iconColor, size: 20),
          ),
          const SizedBox(width: 20),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(policyID, style: PrimeCareTheme.typography.body.copyWith(
                      color: PrimeCareTheme.colors.slateGray,
                      fontWeight: FontWeight.bold,
                    )),
                    const SizedBox(width: 12),
                    Text(title, style: PrimeCareTheme.typography.h3),
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Icon(LucideIcons.tag, size: 14, color: PrimeCareTheme.colors.slateGray),
                    const SizedBox(width: 4),
                    Text(category, style: PrimeCareTheme.typography.label),
                    const SizedBox(width: 16),
                    Icon(LucideIcons.calendar, size: 14, color: PrimeCareTheme.colors.slateGray),
                    const SizedBox(width: 4),
                    Text('Updated: $lastUpdated', style: PrimeCareTheme.typography.label),
                  ],
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
                   color: requiresAction ? PrimeCareTheme.colors.amberWarning.withOpacity(0.2) : PrimeCareTheme.colors.cloudGray,
                   borderRadius: BorderRadius.circular(12),
                 ),
                 child: Text(
                   status,
                   style: PrimeCareTheme.typography.label.copyWith(
                     color: requiresAction ? PrimeCareTheme.colors.brownSolid : PrimeCareTheme.colors.navyIndigo,
                     fontWeight: FontWeight.bold,
                   ),
                 ),
                ),
                const SizedBox(height: 12),
                Text(
                  '$ackRate% Acknowledged',
                  style: PrimeCareTheme.typography.label.copyWith(
                    color: ackRate < 90 ? PrimeCareTheme.colors.coralRed : PrimeCareTheme.colors.emeraldTeal,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                ClinicalGlassButton(
                  onPressed: () {},
                  label: requiresAction ? 'Review/Action' : 'View Policy',
                  icon: LucideIcons.arrowRight,
                ),
             ],
          ),
        ],
      ),
    );
  }
}
