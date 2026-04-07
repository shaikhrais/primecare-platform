import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:primecare_v4/design_system/clinical_glass.dart';
import 'package:primecare_v4/design_system/primecare_theme.dart';
import 'package:primecare_v4/shared/components/page_template.dart';

class ComplianceTrainingScreen extends ConsumerWidget {
  const ComplianceTrainingScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return PageTemplate(
      title: 'Mandatory Compliance Training',
      subtitle:
          'Monitor staff engagement with regulatory, safety, and corporate compliance training modules.',
      headerTrailing: [
        ClinicalSearchTextField(
          hintText: 'Search modules or staff tracking...',
        ),
        const SizedBox(width: 16),
        ClinicalGlassButton(
          onPressed: () {},
          label: 'Export MOH Report',
          icon: LucideIcons.fileOutput,
          isPrimary: true,
        ),
      ],
      kpiCards: [
        MetricCardData(
          title: 'Organization Compliance',
          value: '94.2%',
          icon: LucideIcons.shieldCheck,
          trend: 'Target: >95%',
          isUp: false,
          color: PrimeCareTheme.colors.amberWarning,
        ),
        MetricCardData(
          title: 'Modules Past Due',
          value: '18',
          icon: LucideIcons.clock,
          trend: 'Across 12 staff members',
          isUp: false,
          color: PrimeCareTheme.colors.coralRed,
        ),
        MetricCardData(
          title: 'New Hires Onboarding',
          value: '45',
          icon: LucideIcons.users,
          trend: 'Average completion: 14 days',
          isUp: true,
        ),
      ],
      sidebarContent: [
        _buildDepartmentBreakdown(),
        const SizedBox(height: 24),
        _buildTrainingPriorities(),
      ],
      mainContent: [_buildComplianceModuleList()],
    );
  }

  Widget _buildDepartmentBreakdown() {
    return ClinicalGlassPanel(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                LucideIcons.barChart2,
                color: PrimeCareTheme.colors.navyIndigo,
                size: 20,
              ),
              const SizedBox(width: 8),
              Text('By Department', style: PrimeCareTheme.typography.h3),
            ],
          ),
          const SizedBox(height: 16),
          _buildDeptRow('Nursing (RN/RPN)', 96.5),
          const SizedBox(height: 12),
          _buildDeptRow('Support Workers (PSW)', 88.2),
          const SizedBox(height: 12),
          _buildDeptRow('Physicians', 84.0),
          const SizedBox(height: 12),
          _buildDeptRow('Administration', 99.1),
        ],
      ),
    );
  }

  Widget _buildDeptRow(String name, double percentage) {
    Color color = percentage >= 95
        ? PrimeCareTheme.colors.emeraldTeal
        : percentage >= 90
        ? PrimeCareTheme.colors.amberWarning
        : PrimeCareTheme.colors.coralRed;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(name, style: PrimeCareTheme.typography.body),
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

  Widget _buildTrainingPriorities() {
    return ClinicalGlassPanel(
      padding: const EdgeInsets.all(24),
      border: Border.all(
        color: PrimeCareTheme.colors.coralRed.withOpacity(0.3),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                LucideIcons.alertOctagon,
                color: PrimeCareTheme.colors.coralRed,
                size: 20,
              ),
              const SizedBox(width: 8),
              Text('Requires Attention', style: PrimeCareTheme.typography.h3),
            ],
          ),
          const SizedBox(height: 16),
          Text(
            'Workplace Violence Prev.',
            style: PrimeCareTheme.typography.body.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            '82% (Target: 100%)',
            style: PrimeCareTheme.typography.label.copyWith(
              color: PrimeCareTheme.colors.coralRed,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            'Cybersecurity Fundamentals',
            style: PrimeCareTheme.typography.body.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            '74% (Target: 100%)',
            style: PrimeCareTheme.typography.label.copyWith(
              color: PrimeCareTheme.colors.coralRed,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildComplianceModuleList() {
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
                  'Core Compliance Modules',
                  style: PrimeCareTheme.typography.h2,
                ),
                ClinicalGlassButton(
                  onPressed: () {},
                  label: 'Send Reminders',
                  icon: LucideIcons.bellRing,
                ),
              ],
            ),
          ),
          const Divider(height: 1),
          _buildModuleItem(
            title: 'Annual HIPAA & Privacy',
            audience: 'All Staff',
            frequency: 'Annual',
            completionRate: 98.5,
            status: 'On Track',
          ),
          const Divider(height: 1),
          _buildModuleItem(
            title: 'Infection Control (IPAC) Base',
            audience: 'Clinical & Support',
            frequency: 'Annual',
            completionRate: 95.0,
            status: 'On Track',
          ),
          const Divider(height: 1),
          _buildModuleItem(
            title: 'Workplace Violence Prevention',
            audience: 'All Staff',
            frequency: 'Bi-Annual',
            completionRate: 82.0,
            status: 'Behind Target',
          ),
        ],
      ),
    );
  }

  Widget _buildModuleItem({
    required String title,
    required String audience,
    required String frequency,
    required double completionRate,
    required String status,
  }) {
    final isOnTrack = status == 'On Track';
    final statusColor = isOnTrack
        ? PrimeCareTheme.colors.emeraldTeal
        : PrimeCareTheme.colors.coralRed;

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
              isOnTrack ? LucideIcons.checkSquare : LucideIcons.alertTriangle,
              color: statusColor,
              size: 20,
            ),
          ),
          const SizedBox(width: 20),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: PrimeCareTheme.typography.h3),
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
                      LucideIcons.repeat,
                      size: 14,
                      color: PrimeCareTheme.colors.slateGray,
                    ),
                    const SizedBox(width: 4),
                    Text(frequency, style: PrimeCareTheme.typography.label),
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
                  color: statusColor,
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
                    color: isOnTrack
                        ? PrimeCareTheme.colors.navyIndigo
                        : PrimeCareTheme.colors.coralRed,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
