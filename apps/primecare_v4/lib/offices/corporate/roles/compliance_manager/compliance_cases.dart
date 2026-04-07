import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:primecare_v4/design_system/clinical_glass.dart';
import 'package:primecare_v4/design_system/primecare_theme.dart';
import 'package:primecare_v4/shared/components/page_template.dart';

class ComplianceCasesScreen extends ConsumerWidget {
  const ComplianceCasesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return PageTemplate(
      title: 'Compliance Cases & Investigations',
      subtitle:
          'Manage internal investigations, whistleblower reports, and regulatory compliance inquiries.',
      headerTrailing: [
        ClinicalSearchTextField(hintText: 'Search cases by ID or keyword...'),
        const SizedBox(width: 16),
        ClinicalGlassButton(
          onPressed: () {},
          label: 'Export Data',
          icon: LucideIcons.download,
        ),
        const SizedBox(width: 12),
        ClinicalGlassButton(
          onPressed: () {},
          label: 'Open Case',
          icon: LucideIcons.plus,
          isPrimary: true,
        ),
      ],
      kpiCards: [
        KPICardData(
          title: 'Active Investigations',
          value: '7',
          icon: LucideIcons.search,
          trend: 'Active tracking',
          isUp: true,
          color: PrimeCareTheme.colors.royalPurple,
        ),
        KPICardData(
          title: 'High Priority',
          value: '2',
          icon: LucideIcons.alertTriangle,
          trend: 'Requires immediate action',
          isUp: false,
          color: PrimeCareTheme.colors.coralRed,
        ),
        KPICardData(
          title: 'Closed (YTD)',
          value: '31',
          icon: LucideIcons.folderClosed,
          trend: 'Average age: 14 days',
          isUp: true,
        ),
      ],
      sidebarContent: [
        _buildCaseSources(),
        const SizedBox(height: 24),
        _buildInvestigatorWorkload(),
      ],
      mainContent: [_buildCaseList()],
    );
  }

  Widget _buildCaseSources() {
    return ClinicalGlassPanel(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                LucideIcons.inbox,
                color: PrimeCareTheme.colors.navyIndigo,
                size: 20,
              ),
              const SizedBox(width: 8),
              Text('Case Sources (YTD)', style: PrimeCareTheme.typography.h3),
            ],
          ),
          const SizedBox(height: 16),
          _buildSourceRow('Whistleblower Hotline', '12'),
          const SizedBox(height: 12),
          _buildSourceRow('Internal Audit Finding', '9'),
          const SizedBox(height: 12),
          _buildSourceRow('Patient/Family Complaint', '8'),
          const SizedBox(height: 12),
          _buildSourceRow('Regulatory Inquiry', '2'),
        ],
      ),
    );
  }

  Widget _buildSourceRow(String source, String count) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(source, style: PrimeCareTheme.typography.body),
        Text(
          count,
          style: PrimeCareTheme.typography.label.copyWith(
            color: PrimeCareTheme.colors.slateGray,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  Widget _buildInvestigatorWorkload() {
    return ClinicalGlassPanel(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                LucideIcons.users,
                color: PrimeCareTheme.colors.navyIndigo,
                size: 20,
              ),
              const SizedBox(width: 8),
              Text(
                'Investigator Workload',
                style: PrimeCareTheme.typography.h3,
              ),
            ],
          ),
          const SizedBox(height: 16),
          _buildInvestigatorRow('M. Ramirez (Director)', '3 Active'),
          const SizedBox(height: 12),
          _buildInvestigatorRow('S. Jenkins (Officer)', '4 Active'),
          const SizedBox(height: 12),
          _buildInvestigatorRow('L. Thomas (HR)', '0 Active'),
        ],
      ),
    );
  }

  Widget _buildInvestigatorRow(String name, String count) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(name, style: PrimeCareTheme.typography.body),
        Text(
          count,
          style: PrimeCareTheme.typography.label.copyWith(
            color: PrimeCareTheme.colors.slateGray,
          ),
        ),
      ],
    );
  }

  Widget _buildCaseList() {
    return ClinicalGlassPanel(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(24),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Active Compliance Cases',
                  style: PrimeCareTheme.typography.h2,
                ),
                ClinicalGlassButton(
                  onPressed: () {},
                  label: 'Filter',
                  icon: LucideIcons.filter,
                ),
              ],
            ),
          ),
          const Divider(height: 1),
          _buildCaseItem(
            id: 'CASE-2026-092',
            title: 'Alleged HIPAA violation in Rehab Unit',
            source: 'Whistleblower',
            priority: 'High',
            status: 'Investigation Ongoing',
            assignedTo: 'M. Ramirez',
          ),
          const Divider(height: 1),
          _buildCaseItem(
            id: 'CASE-2026-088',
            title: 'Irregularities in Narcotic Logbook',
            source: 'Internal Audit',
            priority: 'Critical',
            status: 'Interviews Scheduled',
            assignedTo: 'S. Jenkins',
          ),
          const Divider(height: 1),
          _buildCaseItem(
            id: 'CASE-2026-075',
            title: 'Inquiry regarding billing practices',
            source: 'Regulatory Inquiry',
            priority: 'Medium',
            status: 'Document Review',
            assignedTo: 'M. Ramirez',
          ),
        ],
      ),
    );
  }

  Widget _buildCaseItem({
    required String id,
    required String title,
    required String source,
    required String priority,
    required String status,
    required String assignedTo,
  }) {
    Color priorityColor;
    switch (priority) {
      case 'Critical':
      case 'High':
        priorityColor = PrimeCareTheme.colors.coralRed;
        break;
      case 'Medium':
        priorityColor = PrimeCareTheme.colors.amberWarning;
        break;
      default:
        priorityColor = PrimeCareTheme.colors.emeraldTeal;
    }

    return Padding(
      padding: const EdgeInsets.all(24),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: priorityColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(LucideIcons.briefcase, color: priorityColor, size: 20),
          ),
          const SizedBox(width: 20),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      id,
                      style: PrimeCareTheme.typography.body.copyWith(
                        color: PrimeCareTheme.colors.slateGray,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Text(title, style: PrimeCareTheme.typography.h3),
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Icon(
                      LucideIcons.tag,
                      size: 14,
                      color: PrimeCareTheme.colors.slateGray,
                    ),
                    const SizedBox(width: 4),
                    Text(source, style: PrimeCareTheme.typography.label),
                    const SizedBox(width: 16),
                    Icon(
                      LucideIcons.user,
                      size: 14,
                      color: PrimeCareTheme.colors.slateGray,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      'Lead: $assignedTo',
                      style: PrimeCareTheme.typography.label,
                    ),
                  ],
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: PrimeCareTheme.colors.cloudGray,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  status,
                  style: PrimeCareTheme.typography.label.copyWith(
                    color: PrimeCareTheme.colors.navyIndigo,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 12),
              ClinicalGlassButton(
                onPressed: () {},
                label: 'View Case',
                icon: LucideIcons.folderOpen,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
