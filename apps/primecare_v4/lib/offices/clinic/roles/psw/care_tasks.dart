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
      subtitle:
          'Checklist of specific interventions required for each client visit.',
      kpiCards: [
        KPICardData(
          title: 'Tasks Pending',
          value: '8',
          icon: LucideIcons.listTodo,
          trend: 0.0,
          trendLabel: 'today',
        ),
        KPICardData(
          title: 'Completed',
          value: '14',
          icon: LucideIcons.checkCircle,
          trend: 0.0,
          trendLabel: 'so far',
        ),
      ],
      sidebarContent: [
        ClinicalGlassPanel(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Task Status', style: PrimeCareTheme.typography.h3),
              const SizedBox(height: 16),
              _buildFilterRow('To Do', 8, PrimeCareTheme.colors.coralBlush),
              _buildFilterRow(
                'Completed',
                14,
                PrimeCareTheme.colors.emeraldTeal,
              ),
              _buildFilterRow('Skipped', 1, PrimeCareTheme.colors.slateGray),
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
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Task List', style: PrimeCareTheme.typography.h2),
                  ElevatedButton.icon(
                    onPressed: () {},
                    icon: const Icon(LucideIcons.filter),
                    label: const Text('Filter by Client'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor:
                          PrimeCareTheme.colors.surfaceContainerHighest,
                      foregroundColor: PrimeCareTheme.colors.navyIndigo,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              _buildTaskCard(
                'Administer Medication Reminder',
                'Sonia Sotomayor',
                'To Do',
                PrimeCareTheme.colors.coralBlush,
              ),
              _buildTaskCard(
                'Assist with Ambulation',
                'Elena Kagan',
                'Completed',
                PrimeCareTheme.colors.emeraldTeal,
              ),
              _buildTaskCard(
                'Prepare Light Meal',
                'Sonia Sotomayor',
                'To Do',
                PrimeCareTheme.colors.coralBlush,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildFilterRow(String label, int count, Color color) {
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
                decoration: BoxDecoration(color: color, shape: BoxShape.circle),
              ),
              const SizedBox(width: 8),
              Text(label, style: PrimeCareTheme.typography.body),
            ],
          ),
          Text(
            count.toString(),
            style: PrimeCareTheme.typography.label.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTaskCard(
    String taskName,
    String clientName,
    String status,
    Color themeColor,
  ) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: PrimeCareTheme.colors.surfaceContainerHighest.withOpacity(0.3),
        borderRadius: BorderRadius.circular(16),
        border: Border(left: BorderSide(color: themeColor, width: 4)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(taskName, style: PrimeCareTheme.typography.h3),
              const SizedBox(height: 4),
              Text(
                clientName,
                style: PrimeCareTheme.typography.body.copyWith(
                  color: PrimeCareTheme.colors.slateGray,
                ),
              ),
            ],
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: themeColor.withOpacity(0.2),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              status,
              style: PrimeCareTheme.typography.label.copyWith(
                color: themeColor,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
