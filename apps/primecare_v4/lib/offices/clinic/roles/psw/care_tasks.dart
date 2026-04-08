import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:primecare_v4/design_system/primecare_theme.dart';
import 'package:primecare_v4/design_system/clinical_glass.dart';
import 'package:primecare_v4/shared/components/page_template.dart';

class PswCareTasksScreen extends ConsumerWidget {
  const PswCareTasksScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return PageTemplate(
      title: 'Care Tasks',
      subtitle: 'Manage and execute clinical tasks for your shift.',
      kpiCards: [
        KPICardData(
          title: 'Pending Tasks',
          value: '7',
          icon: LucideIcons.listTodo,
          trend: 0.0,
          trendLabel: 'action required',
        ),
        KPICardData(
          title: 'Critical Tasks',
          value: '2',
          icon: LucideIcons.alertTriangle,
          trend: 0.0,
          trendLabel: 'high priority',
        ),
      ],
      mainContent: [
        ClinicalGlassPanel(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Prioritized Task List',
                style: PrimeCareTheme.typography.h2,
              ),
              const SizedBox(height: 24),
              _buildTaskCard(
                'Administer Morning Meds',
                'Thurgood Marshall',
                '09:00 AM',
                'Critical',
                PrimeCareTheme.colors.brickRed,
                false,
              ),
              _buildTaskCard(
                'Collect Vitals (BP, HR, Temp)',
                'Thurgood Marshall',
                '09:30 AM',
                'Standard',
                PrimeCareTheme.colors.navyIndigo,
                false,
              ),
              _buildTaskCard(
                'Wound Dressing Change',
                'Sonia Sotomayor',
                '11:00 AM',
                'High',
                PrimeCareTheme.colors.amberWarning,
                false,
              ),
              _buildTaskCard(
                'Light Housekeeping',
                'Elena Kagan',
                '02:00 PM',
                'Standard',
                PrimeCareTheme.colors.slateGray,
                false,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildTaskCard(
    String taskName,
    String patientName,
    String timeInfo,
    String priority,
    Color priorityColor,
    bool isCompleted,
  ) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: PrimeCareTheme.colors.surfaceContainerHighest.withOpacity(0.3),
        borderRadius: BorderRadius.circular(16),
        border: Border(left: BorderSide(color: priorityColor, width: 4)),
      ),
      child: Row(
        children: [
          Checkbox(
            value: isCompleted,
            activeColor: PrimeCareTheme.colors.emeraldTeal,
            onChanged: (bool? value) {},
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  taskName,
                  style: PrimeCareTheme.typography.h3.copyWith(
                    decoration: isCompleted ? TextDecoration.lineThrough : null,
                  ),
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    Icon(
                      LucideIcons.user,
                      size: 14,
                      color: PrimeCareTheme.colors.slateGray,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      patientName,
                      style: PrimeCareTheme.typography.body.copyWith(
                        color: PrimeCareTheme.colors.slateGray,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Icon(
                      LucideIcons.clock,
                      size: 14,
                      color: PrimeCareTheme.colors.slateGray,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      timeInfo,
                      style: PrimeCareTheme.typography.body.copyWith(
                        color: PrimeCareTheme.colors.slateGray,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: priorityColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              priority,
              style: PrimeCareTheme.typography.label.copyWith(
                color: priorityColor,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
