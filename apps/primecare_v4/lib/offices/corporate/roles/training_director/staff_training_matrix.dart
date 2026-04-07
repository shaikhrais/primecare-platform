import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:primecare_v4/design_system/clinical_glass.dart';
import 'package:primecare_v4/design_system/primecare_theme.dart';
import 'package:primecare_v4/shared/components/page_template.dart';

class StaffTrainingMatrixScreen extends ConsumerWidget {
  const StaffTrainingMatrixScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return PageTemplate(
      title: 'Staff Training Matrix',
      subtitle:
          'Comprehensive overview of staff training status and compliance.',
      headerTrailing: [
        ClinicalSearchTextField(hintText: 'Search staff or courses...'),
        const SizedBox(width: 16),
        ClinicalGlassButton(
          onPressed: () {},
          label: 'Export Matrix',
          icon: LucideIcons.download,
          isPrimary: true,
        ),
      ],
      kpiCards: [
        KPICardData(
          title: 'Overall Compliance',
          value: '94%',
          icon: LucideIcons.checkCircle,
          trend: '+2.4%',
          isUp: true,
          color: PrimeCareTheme.colors.emeraldTeal,
        ),
        KPICardData(
          title: 'Pending Certs',
          value: '18',
          icon: LucideIcons.clock,
          trend: 'Across 5 departments',
          isUp: true,
          color: PrimeCareTheme.colors.amberWarning,
        ),
        KPICardData(
          title: 'Upcoming Renewals',
          value: '42',
          icon: LucideIcons.calendar,
          trend: 'Next 30 days',
          isUp: false,
          color: PrimeCareTheme.colors.navyIndigo,
        ),
        KPICardData(
          title: 'Overdue',
          value: '5',
          icon: LucideIcons.alertTriangle,
          trend: 'Critical action required',
          isUp: false,
          color: PrimeCareTheme.colors.coralRed,
        ),
      ],
      sidebarContent: [
        _buildFiltersPanel(),
        const SizedBox(height: 24),
        _buildDepartmentCompliance(),
      ],
      mainContent: [_buildMatrixTable()],
    );
  }

  Widget _buildFiltersPanel() {
    return ClinicalGlassPanel(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                LucideIcons.filter,
                color: PrimeCareTheme.colors.navyIndigo,
                size: 20,
              ),
              const SizedBox(width: 8),
              Text('Filters', style: PrimeCareTheme.typography.h3),
            ],
          ),
          const SizedBox(height: 16),
          _buildFilterDropdown('By Department'),
          const SizedBox(height: 12),
          _buildFilterDropdown('By Role'),
          const SizedBox(height: 12),
          _buildFilterDropdown('By Status'),
        ],
      ),
    );
  }

  Widget _buildFilterDropdown(String label) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: PrimeCareTheme.colors.cloudGray.withOpacity(0.5),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: PrimeCareTheme.typography.body),
          Icon(
            LucideIcons.chevronDown,
            size: 16,
            color: PrimeCareTheme.colors.slateGray,
          ),
        ],
      ),
    );
  }

  Widget _buildDepartmentCompliance() {
    return ClinicalGlassPanel(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Compliance by Dept', style: PrimeCareTheme.typography.h3),
          const SizedBox(height: 16),
          _buildDeptRow('Nursing (RN)', 98),
          const SizedBox(height: 12),
          _buildDeptRow('Personal Care (PSW)', 85),
          const SizedBox(height: 12),
          _buildDeptRow('Administration', 100),
        ],
      ),
    );
  }

  Widget _buildDeptRow(String name, int score) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(name, style: PrimeCareTheme.typography.body),
            Text(
              '$score%',
              style: PrimeCareTheme.typography.label.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        LinearProgressIndicator(
          value: score / 100,
          backgroundColor: PrimeCareTheme.colors.cloudGray,
          valueColor: AlwaysStoppedAnimation<Color>(
            score >= 90
                ? PrimeCareTheme.colors.emeraldTeal
                : PrimeCareTheme.colors.amberWarning,
          ),
          minHeight: 6,
          borderRadius: BorderRadius.circular(4),
        ),
      ],
    );
  }

  Widget _buildMatrixTable() {
    return ClinicalGlassPanel(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.all(24),
            child: Text(
              'Staff Matrix Records',
              style: PrimeCareTheme.typography.h2,
            ),
          ),
          const SizedBox(height: 16),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: DataTable(
              headingTextStyle: PrimeCareTheme.typography.h3,
              dataTextStyle: PrimeCareTheme.typography.body,
              horizontalMargin: 24,
              columnSpacing: 48,
              columns: const [
                DataColumn(label: Text('Employee')),
                DataColumn(label: Text('Role')),
                DataColumn(label: Text('Department')),
                DataColumn(label: Text('Status')),
                DataColumn(label: Text('Actions')),
              ],
              rows: [
                _buildDataRow(
                  'Sarah Jenkins',
                  'RN',
                  'Nursing',
                  'Compliant',
                  PrimeCareTheme.colors.emeraldTeal,
                ),
                _buildDataRow(
                  'Michael Chen',
                  'PSW',
                  'Care',
                  'Expiring Soon',
                  PrimeCareTheme.colors.amberWarning,
                ),
                _buildDataRow(
                  'Emily Thorne',
                  'Admin',
                  'HR',
                  'Non-Compliant',
                  PrimeCareTheme.colors.coralRed,
                ),
                _buildDataRow(
                  'David Kim',
                  'CNA',
                  'Care',
                  'Compliant',
                  PrimeCareTheme.colors.emeraldTeal,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  DataRow _buildDataRow(
    String name,
    String role,
    String dept,
    String status,
    Color statusColor,
  ) {
    return DataRow(
      cells: [
        DataCell(
          Text(name, style: const TextStyle(fontWeight: FontWeight.bold)),
        ),
        DataCell(Text(role)),
        DataCell(Text(dept)),
        DataCell(
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: statusColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              status,
              style: PrimeCareTheme.typography.label.copyWith(
                color: statusColor,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        DataCell(
          ClinicalGlassButton(
            onPressed: () {},
            label: 'View',
            icon: LucideIcons.chevronRight,
          ),
        ),
      ],
    );
  }
}
