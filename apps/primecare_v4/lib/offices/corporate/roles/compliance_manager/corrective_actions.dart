import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:primecare_v4/design_system/clinical_glass.dart';
import 'package:primecare_v4/design_system/primecare_theme.dart';
import 'package:primecare_v4/shared/components/page_template.dart';

class CorrectiveActionsScreen extends ConsumerWidget {
  const CorrectiveActionsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return PageTemplate(
      title: 'Corrective & Preventive Actions (CAPA)',
      subtitle:
          'Track and manage post-incident actions to prevent recurrence and ensure regulatory compliance.',
      headerTrailing: [
        ClinicalSearchTextField(
          hintText: 'Search actions or linked incidents...',
        ),
        const SizedBox(width: 16),
        ClinicalGlassButton(
          onPressed: () {},
          label: 'New Action',
          icon: LucideIcons.plus,
          isPrimary: true,
        ),
      ],
      kpiCards: [
        MetricCardData(
          title: 'Overdue Actions',
          value: '5',
          icon: LucideIcons.alertTriangle,
          trend: 'Requires escalation',
          isUp: false,
          color: PrimeCareTheme.colors.coralRed,
        ),
        MetricCardData(
          title: 'In Progress',
          value: '22',
          icon: LucideIcons.activity,
          trend: 'On schedule',
          isUp: true,
        ),
        MetricCardData(
          title: 'Closed (YTD)',
          value: '148',
          icon: LucideIcons.checkCheck,
          trend: 'Avg 12 days to close',
          isUp: true,
          color: PrimeCareTheme.colors.emeraldTeal,
        ),
      ],
      sidebarContent: [
        _buildCAPAStatusSummary(),
        const SizedBox(height: 24),
        _buildActionOwners(),
      ],
      mainContent: [_buildCAPAList()],
    );
  }

  Widget _buildCAPAStatusSummary() {
    return ClinicalGlassPanel(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                LucideIcons.barChart,
                color: PrimeCareTheme.colors.navyIndigo,
                size: 20,
              ),
              const SizedBox(width: 8),
              Text('Status Summary', style: PrimeCareTheme.typography.h3),
            ],
          ),
          const SizedBox(height: 16),
          _buildStatusRow('Overdue', '5', PrimeCareTheme.colors.coralRed),
          const SizedBox(height: 12),
          _buildStatusRow(
            'Pending Approval',
            '8',
            PrimeCareTheme.colors.amberWarning,
          ),
          const SizedBox(height: 12),
          _buildStatusRow(
            'In Progress',
            '14',
            PrimeCareTheme.colors.royalPurple,
          ),
          const SizedBox(height: 12),
          _buildStatusRow(
            'Awaiting Verification',
            '3',
            PrimeCareTheme.colors.slateGray,
          ),
        ],
      ),
    );
  }

  Widget _buildStatusRow(String label, String count, Color color) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Container(
              width: 12,
              height: 12,
              decoration: BoxDecoration(color: color, shape: BoxShape.circle),
            ),
            const SizedBox(width: 12),
            Text(label, style: PrimeCareTheme.typography.body),
          ],
        ),
        Text(
          count,
          style: PrimeCareTheme.typography.body.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  Widget _buildActionOwners() {
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
              Text('Top Assignees', style: PrimeCareTheme.typography.h3),
            ],
          ),
          const SizedBox(height: 16),
          _buildAssigneeRow('Dr. H. Kim', '4 Pending'),
          const SizedBox(height: 12),
          _buildAssigneeRow('Facility Mgmt', '3 Pending'),
          const SizedBox(height: 12),
          _buildAssigneeRow('L. Chen (RN)', '2 Pending'),
        ],
      ),
    );
  }

  Widget _buildAssigneeRow(String name, String count) {
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

  Widget _buildCAPAList() {
    return ClinicalGlassPanel(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(24),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Active CAPAs', style: PrimeCareTheme.typography.h2),
                ClinicalGlassButton(
                  onPressed: () {},
                  label: 'Filter',
                  icon: LucideIcons.filter,
                ),
              ],
            ),
          ),
          const Divider(height: 1),
          _buildCAPAItem(
            id: 'CAPA-402',
            title: 'Revise Hand Hygiene Protocol Context',
            linkedIncident: 'INC-9021',
            assignee: 'Dr. H. Kim',
            dueDate: 'Nov 12, 2026',
            status: 'Overdue',
          ),
          const Divider(height: 1),
          _buildCAPAItem(
            id: 'CAPA-405',
            title: 'Repair/Replace Backup Generator Phase 2',
            linkedIncident: 'INC-8911',
            assignee: 'Facility Mgmt',
            dueDate: 'Nov 20, 2026',
            status: 'In Progress',
          ),
          const Divider(height: 1),
          _buildCAPAItem(
            id: 'CAPA-410',
            title: 'Implement Dual-Signoff for High-Risk Meds',
            linkedIncident: 'INC-9002',
            assignee: 'Nursing Director',
            dueDate: 'Dec 05, 2026',
            status: 'Pending Approval',
          ),
        ],
      ),
    );
  }

  Widget _buildCAPAItem({
    required String id,
    required String title,
    required String linkedIncident,
    required String assignee,
    required String dueDate,
    required String status,
  }) {
    Color statusColor = status == 'Overdue'
        ? PrimeCareTheme.colors.coralRed
        : status == 'In Progress'
        ? PrimeCareTheme.colors.emeraldTeal
        : PrimeCareTheme.colors.amberWarning;

    return Padding(
      padding: const EdgeInsets.all(24),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: statusColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(
              status == 'Overdue'
                  ? LucideIcons.clockAlert
                  : LucideIcons.checkSquare,
              color: statusColor,
              size: 20,
            ),
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
                        color: PrimeCareTheme.colors.navyIndigo,
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
                      LucideIcons.link,
                      size: 14,
                      color: PrimeCareTheme.colors.slateGray,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      'Linked: $linkedIncident',
                      style: PrimeCareTheme.typography.label,
                    ),
                    const SizedBox(width: 16),
                    Icon(
                      LucideIcons.user,
                      size: 14,
                      color: PrimeCareTheme.colors.slateGray,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      'Assignee: $assignee',
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
              Text(
                status,
                style: PrimeCareTheme.typography.body.copyWith(
                  fontWeight: FontWeight.bold,
                  color: statusColor,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                'Due: $dueDate',
                style: PrimeCareTheme.typography.label.copyWith(
                  color: PrimeCareTheme.colors.slateGray,
                ),
              ),
              const SizedBox(height: 12),
              ClinicalGlassButton(
                onPressed: () {},
                label: 'View Action',
                icon: LucideIcons.arrowRight,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
