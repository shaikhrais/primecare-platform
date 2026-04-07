import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:primecare_v4/design_system/clinical_glass.dart';
import 'package:primecare_v4/design_system/primecare_theme.dart';
import 'package:primecare_v4/shared/components/page_template.dart';

class TrainingComplianceScreen extends ConsumerWidget {
  const TrainingComplianceScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return PageTemplate(
      title: 'Training & Education Compliance',
      subtitle:
          'Monitor completion rates for mandatory staff onboarding, annual refreshers, and protocol updates.',
      headerTrailing: [
        ClinicalSearchTextField(hintText: 'Search modules or staff...'),
        const SizedBox(width: 16),
        ClinicalGlassButton(
          onPressed: () {},
          label: 'Export Dashboard',
          icon: LucideIcons.download,
        ),
      ],
      kpiCards: [
        MetricCardData(
          title: 'Organization Overall',
          value: '91.4%',
          icon: LucideIcons.award,
          trend: 'Target: 95%',
          isUp: false,
          color: PrimeCareTheme.colors.amberWarning,
        ),
        MetricCardData(
          title: 'Overdue Staff',
          value: '42',
          icon: LucideIcons.userX,
          trend: 'Across 6 facilities',
          isUp: false,
          color: PrimeCareTheme.colors.coralRed,
        ),
        MetricCardData(
          title: 'Modules Completed',
          value: '1,240',
          icon: LucideIcons.checkSquare,
          trend: 'This quarter',
          isUp: true,
          color: PrimeCareTheme.colors.emeraldTeal,
        ),
      ],
      sidebarContent: [
        _buildDepartmentCompliance(),
        const SizedBox(height: 24),
        _buildCriticalModules(),
      ],
      mainContent: [_buildTrainingList()],
    );
  }

  Widget _buildDepartmentCompliance() {
    return ClinicalGlassPanel(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                LucideIcons.building,
                color: PrimeCareTheme.colors.navyIndigo,
                size: 20,
              ),
              const SizedBox(width: 8),
              Text('By Department', style: PrimeCareTheme.typography.h3),
            ],
          ),
          const SizedBox(height: 16),
          _buildDeptRow('Nursing (RN/RPN)', 94.2),
          const SizedBox(height: 12),
          _buildDeptRow('Personal Support (PSW)', 88.5),
          const SizedBox(height: 12),
          _buildDeptRow('Physicians', 82.1),
          const SizedBox(height: 12),
          _buildDeptRow('Admin & Operations', 98.9),
        ],
      ),
    );
  }

  Widget _buildDeptRow(String dept, double percentage) {
    final color = percentage >= 95
        ? PrimeCareTheme.colors.emeraldTeal
        : percentage >= 90
        ? PrimeCareTheme.colors.amberWarning
        : PrimeCareTheme.colors.coralRed;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(dept, style: PrimeCareTheme.typography.body),
        Text(
          '$percentage%',
          style: PrimeCareTheme.typography.body.copyWith(
            color: color,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  Widget _buildCriticalModules() {
    return ClinicalGlassPanel(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                LucideIcons.bookOpen,
                color: PrimeCareTheme.colors.navyIndigo,
                size: 20,
              ),
              const SizedBox(width: 8),
              Text(
                'Low Completion Modules',
                style: PrimeCareTheme.typography.h3,
              ),
            ],
          ),
          const SizedBox(height: 16),
          _buildModuleMini('Cybersecurity 2026', '62%'),
          const SizedBox(height: 8),
          _buildModuleMini('Updated Fall Protocols', '78%'),
          const SizedBox(height: 8),
          _buildModuleMini('WHMIS Refresh', '81%'),
        ],
      ),
    );
  }

  Widget _buildModuleMini(String module, String rate) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Text(
            module,
            style: PrimeCareTheme.typography.label,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        Text(
          rate,
          style: PrimeCareTheme.typography.label.copyWith(
            color: PrimeCareTheme.colors.coralRed,
          ),
        ),
      ],
    );
  }

  Widget _buildTrainingList() {
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
                  'Mandatory Modules Tracking',
                  style: PrimeCareTheme.typography.h2,
                ),
                ClinicalGlassButton(
                  onPressed: () {},
                  label: 'Send Mass Reminder',
                  icon: LucideIcons.bellRing,
                ),
              ],
            ),
          ),
          const Divider(height: 1),
          _buildModuleRow(
            module: 'Annual HIPAA / Privacy Training',
            audience: 'All Staff',
            deadline: 'Dec 31, 2026',
            completionRate: 92.5,
            pendingCount: 45,
          ),
          const Divider(height: 1),
          _buildModuleRow(
            module: 'Advanced Infection Control 2.0',
            audience: 'Clinical Staff Only',
            deadline: 'Nov 15, 2026',
            completionRate: 75.0,
            pendingCount: 120,
          ),
          const Divider(height: 1),
          _buildModuleRow(
            module: 'Workplace Violence Prevention',
            audience: 'All Staff',
            deadline: 'Oct 01, 2026 (Past Due)',
            completionRate: 98.2,
            pendingCount: 11,
          ),
        ],
      ),
    );
  }

  Widget _buildModuleRow({
    required String module,
    required String audience,
    required String deadline,
    required double completionRate,
    required int pendingCount,
  }) {
    final isOverdue = deadline.contains('Past Due');
    final color = isOverdue
        ? PrimeCareTheme.colors.coralRed
        : PrimeCareTheme.colors.navyIndigo;

    return Padding(
      padding: const EdgeInsets.all(24),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(LucideIcons.bookOpenCheck, color: color, size: 20),
          ),
          const SizedBox(width: 20),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(module, style: PrimeCareTheme.typography.h3),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Icon(
                      LucideIcons.users,
                      size: 14,
                      color: PrimeCareTheme.colors.slateGray,
                    ),
                    const SizedBox(width: 4),
                    Text(audience, style: PrimeCareTheme.typography.label),
                    const SizedBox(width: 16),
                    Icon(
                      LucideIcons.calendar,
                      size: 14,
                      color: isOverdue
                          ? PrimeCareTheme.colors.coralRed
                          : PrimeCareTheme.colors.slateGray,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      deadline,
                      style: PrimeCareTheme.typography.label.copyWith(
                        color: isOverdue
                            ? PrimeCareTheme.colors.coralRed
                            : PrimeCareTheme.colors.slateGray,
                        fontWeight: isOverdue
                            ? FontWeight.bold
                            : FontWeight.normal,
                      ),
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
                '$completionRate%',
                style: PrimeCareTheme.typography.h3.copyWith(
                  color: completionRate < 80
                      ? PrimeCareTheme.colors.coralRed
                      : PrimeCareTheme.colors.emeraldTeal,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                '$pendingCount Staff Pending',
                style: PrimeCareTheme.typography.label.copyWith(
                  color: PrimeCareTheme.colors.slateGray,
                ),
              ),
              const SizedBox(height: 12),
              ClinicalGlassButton(
                onPressed: () {},
                label: 'View List',
                icon: LucideIcons.list,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
