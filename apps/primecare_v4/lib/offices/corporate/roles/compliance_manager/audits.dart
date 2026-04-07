import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:primecare_v4/design_system/clinical_glass.dart';
import 'package:primecare_v4/design_system/primecare_theme.dart';
import 'package:primecare_v4/shared/components/page_template.dart';

class AuditsScreen extends ConsumerWidget {
  const AuditsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return PageTemplate(
      title: 'Audits & Inspections',
      subtitle:
          'Schedule and track internal and external compliance audits, inspections, and regulatory visits.',
      headerTrailing: [
        ClinicalSearchTextField(
          hintText: 'Search audits by facility or auditor...',
        ),
        const SizedBox(width: 16),
        ClinicalGlassButton(
          onPressed: () {},
          label: 'Schedule Audit',
          icon: LucideIcons.calendarPlus,
          isPrimary: true,
        ),
      ],
      kpiCards: [
        KPICardData(
          title: 'Upcoming Audits',
          value: '4',
          icon: LucideIcons.calendarSearch,
          trend: 'Next 30 days',
          isUp: true,
          color: PrimeCareTheme.colors.royalPurple,
        ),
        KPICardData(
          title: 'Open Findings',
          value: '14',
          icon: LucideIcons.listTodo,
          trend: '-2 findings resolved',
          isUp: true,
        ),
        KPICardData(
          title: 'MOH Inspections',
          value: '1',
          icon: LucideIcons.building,
          trend: 'Unannounced received',
          isUp: false,
          color: PrimeCareTheme.colors.amberWarning,
        ),
      ],
      sidebarContent: [
        _buildFindingStatus(),
        const SizedBox(height: 24),
        _buildAuditorContacts(),
      ],
      mainContent: [_buildAuditSchedule()],
    );
  }

  Widget _buildFindingStatus() {
    return ClinicalGlassPanel(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                LucideIcons.listChecks,
                color: PrimeCareTheme.colors.navyIndigo,
                size: 20,
              ),
              const SizedBox(width: 8),
              Text(
                'Audit Findings Status',
                style: PrimeCareTheme.typography.h3,
              ),
            ],
          ),
          const SizedBox(height: 16),
          _buildFindingRow(
            'Critical / Major',
            '2',
            PrimeCareTheme.colors.coralRed,
          ),
          const SizedBox(height: 12),
          _buildFindingRow(
            'Moderate / Minor',
            '12',
            PrimeCareTheme.colors.amberWarning,
          ),
          const SizedBox(height: 12),
          _buildFindingRow(
            'Closed (YTD)',
            '85',
            PrimeCareTheme.colors.emeraldTeal,
          ),
        ],
      ),
    );
  }

  Widget _buildFindingRow(String label, String count, Color color) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Icon(LucideIcons.circle, size: 12, color: color),
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

  Widget _buildAuditorContacts() {
    return ClinicalGlassPanel(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                LucideIcons.contact,
                color: PrimeCareTheme.colors.navyIndigo,
                size: 20,
              ),
              const SizedBox(width: 8),
              Text(
                'Key External Auditors',
                style: PrimeCareTheme.typography.h3,
              ),
            ],
          ),
          const SizedBox(height: 16),
          Text(
            'Ministry of Health Inspectorate',
            style: PrimeCareTheme.typography.body.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            'J. Doe (Region 4)',
            style: PrimeCareTheme.typography.label.copyWith(
              color: PrimeCareTheme.colors.slateGray,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            'KPMG Financial Auditors',
            style: PrimeCareTheme.typography.body.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            'Tax & Compliance Division',
            style: PrimeCareTheme.typography.label.copyWith(
              color: PrimeCareTheme.colors.slateGray,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAuditSchedule() {
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
                  'Scheduled Audits & Inspections',
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
          _buildAuditItem(
            id: 'AUD-2026-114',
            title: 'Annual Infection Control Audit',
            type: 'Internal',
            facility: 'Oakville Campus',
            date: 'Nov 12-14, 2026',
            status: 'Scheduled',
          ),
          const Divider(height: 1),
          _buildAuditItem(
            id: 'AUD-2026-112',
            title: 'MOH Unannounced Inspection',
            type: 'External Framework',
            facility: 'Downtown Clinic',
            date: 'Oct 29 - Nov 01, 2026',
            status: 'In Progress',
          ),
          const Divider(height: 1),
          _buildAuditItem(
            id: 'AUD-2026-098',
            title: 'Q3 Financial & Billing Audit',
            type: 'External Financial',
            facility: 'Corporate HQ',
            date: 'Oct 15, 2026',
            status: 'Findings Review',
          ),
        ],
      ),
    );
  }

  Widget _buildAuditItem({
    required String id,
    required String title,
    required String type,
    required String facility,
    required String date,
    required String status,
  }) {
    final inProgress = status == 'In Progress';
    final statusColor = inProgress
        ? PrimeCareTheme.colors.amberWarning
        : PrimeCareTheme.colors.navyIndigo;

    return Padding(
      padding: const EdgeInsets.all(24),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: statusColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(
              inProgress ? LucideIcons.activity : LucideIcons.calendarCheck,
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
                    Text(type, style: PrimeCareTheme.typography.label),
                    const SizedBox(width: 16),
                    Icon(
                      LucideIcons.building,
                      size: 14,
                      color: PrimeCareTheme.colors.slateGray,
                    ),
                    const SizedBox(width: 4),
                    Text(facility, style: PrimeCareTheme.typography.label),
                  ],
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                date,
                style: PrimeCareTheme.typography.body.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 4),
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
                    color: inProgress
                        ? PrimeCareTheme.colors.brownSolid
                        : PrimeCareTheme.colors.navyIndigo,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 12),
              ClinicalGlassButton(
                onPressed: () {},
                label: 'View Details',
                icon: LucideIcons.arrowRight,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
