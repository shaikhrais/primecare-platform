import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:primecare_v4/design_system/clinical_glass.dart';
import 'package:primecare_v4/design_system/primecare_theme.dart';

class CommunityFollowUpsScreen extends ConsumerStatefulWidget {
  const CommunityFollowUpsScreen({super.key});

  @override
  ConsumerState<CommunityFollowUpsScreen> createState() =>
      _CommunityFollowUpsScreenState();
}

class _CommunityFollowUpsScreenState
    extends ConsumerState<CommunityFollowUpsScreen> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(32.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildHeader(),
          const SizedBox(height: 32),
          _buildKPIs(),
          const SizedBox(height: 32),
          _buildKanbanBoard(),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  LucideIcons.listTodo,
                  color: PrimeCareTheme.colors.navyIndigo,
                  size: 28,
                ),
                const SizedBox(width: 12),
                Text(
                  'Follow-Up Tasks',
                  style: PrimeCareTheme.typography.heroTitle.copyWith(
                    color: PrimeCareTheme.colors.navyIndigo,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              'Manage outreach activities, contact reminders, and partnership milestones.',
              style: PrimeCareTheme.typography.body.copyWith(
                color: PrimeCareTheme.colors.slateGray,
              ),
            ),
          ],
        ),
        ClinicalGlassButton(
          onPressed: () {},
          icon: LucideIcons.plus,
          label: 'New Follow-Up',
          isActive: true,
        ),
      ],
    );
  }

  Widget _buildKPIs() {
    return Row(
      children: [
        Expanded(
          child: _buildMetricCard(
            title: 'Pending Tasks',
            value: '42',
            icon: LucideIcons.calendarCheck,
            trend: '+5 this week',
          ),
        ),
        const SizedBox(width: 24),
        Expanded(
          child: _buildMetricCard(
            title: 'Overdue Items',
            value: '6',
            icon: LucideIcons.alertTriangle,
            trend: 'Requires immediate action',
            isWarning: true,
          ),
        ),
        const SizedBox(width: 24),
        Expanded(
          child: _buildMetricCard(
            title: 'Completed (MTD)',
            value: '28',
            icon: LucideIcons.checkCircle2,
            trend: '+12% vs prior month',
            isPositive: true,
          ),
        ),
      ],
    );
  }

  Widget _buildMetricCard({
    required String title,
    required String value,
    required IconData icon,
    required String trend,
    bool isWarning = false,
    bool isPositive = false,
  }) {
    Color trendColor = PrimeCareTheme.colors.slateGray;
    Color iconColor = PrimeCareTheme.colors.navyIndigo;

    if (isWarning) {
      trendColor = Colors.amber.shade700;
      iconColor = Colors.amber.shade700;
    } else if (isPositive) {
      trendColor = PrimeCareTheme.colors.emeraldTeal;
    }

    return ClinicalGlassPanel(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: PrimeCareTheme.typography.label.copyWith(
                  color: PrimeCareTheme.colors.slateGray,
                ),
              ),
              Icon(icon, color: iconColor, size: 20),
            ],
          ),
          const SizedBox(height: 16),
          Text(
            value,
            style: PrimeCareTheme.typography.h1.copyWith(
              color: PrimeCareTheme.colors.navyIndigo,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            trend,
            style: PrimeCareTheme.typography.label.copyWith(
              color: trendColor,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildKanbanBoard() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: _buildKanbanColumn('To Do', [
            {
              'title': 'Send post-event survey',
              'contact': 'Dr. Sarah Jenkins',
              'priority': 'High',
              'dueDate': 'Today',
              'isOverdue': false,
            },
            {
              'title': 'Review partnership contract',
              'contact': 'Emily Chen',
              'priority': 'High',
              'dueDate': 'Oct 30',
              'isOverdue': false,
            },
            {
              'title': 'Schedule quarterly check-in',
              'contact': 'Robert Garcia',
              'priority': 'Low',
              'dueDate': 'Nov 5',
              'isOverdue': false,
            },
            {
              'title': 'Mail holiday cards',
              'contact': 'All VIP Referrals',
              'priority': 'Medium',
              'dueDate': 'Dec 1',
              'isOverdue': false,
            },
          ]),
        ),
        const SizedBox(width: 24),
        Expanded(
          child: _buildKanbanColumn('In Progress', [
            {
              'title': 'Draft proposal for health fair',
              'contact': 'David Kim',
              'priority': 'High',
              'dueDate': 'Oct 28',
              'isOverdue': false,
            },
            {
              'title': 'Finalize brochure design',
              'contact': 'Marketing Team',
              'priority': 'Medium',
              'dueDate': 'Yesterday',
              'isOverdue': true,
            },
          ]),
        ),
        const SizedBox(width: 24),
        Expanded(
          child: _buildKanbanColumn('Done (This Week)', [
            {
              'title': 'Call to confirm attendance',
              'contact': 'Alice Reynolds',
              'priority': 'Low',
              'dueDate': 'Completed Oct 25',
              'isOverdue': false,
            },
            {
              'title': 'Send introductory email',
              'contact': 'Michael Thompson',
              'priority': 'Medium',
              'dueDate': 'Completed Oct 24',
              'isOverdue': false,
            },
            {
              'title': 'Update shared calendar',
              'contact': 'Internal Team',
              'priority': 'High',
              'dueDate': 'Completed Oct 23',
              'isOverdue': false,
            },
          ]),
        ),
      ],
    );
  }

  Widget _buildKanbanColumn(String title, List<Map<String, dynamic>> tasks) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: PrimeCareTheme.typography.h3.copyWith(
                color: PrimeCareTheme.colors.navyIndigo,
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              decoration: BoxDecoration(
                color: PrimeCareTheme.colors.surfaceContainerLow,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: PrimeCareTheme.colors.surfaceContainerHighest,
                ),
              ),
              child: Text(
                tasks.length.toString(),
                style: PrimeCareTheme.typography.label.copyWith(
                  color: PrimeCareTheme.colors.navyIndigo,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        ...tasks.map((task) => _buildTaskCard(task)),
      ],
    );
  }

  Widget _buildTaskCard(Map<String, dynamic> task) {
    Color priorityColor;
    switch (task['priority']) {
      case 'High':
        priorityColor = PrimeCareTheme.colors.coralRed;
        break;
      case 'Medium':
        priorityColor = Colors.amber.shade700;
        break;
      case 'Low':
      default:
        priorityColor = PrimeCareTheme.colors.emeraldTeal;
        break;
    }

    final isOverdue = task['isOverdue'] as bool;
    final dueDateColor = isOverdue
        ? PrimeCareTheme.colors.coralRed
        : PrimeCareTheme.colors.slateGray;

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      child: ClinicalGlassPanel(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Text(
                    task['title'],
                    style: PrimeCareTheme.typography.h4.copyWith(
                      color: PrimeCareTheme.colors.navyIndigo,
                      fontSize: 13,
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(left: 12),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 2,
                  ),
                  decoration: BoxDecoration(
                    color: priorityColor.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text(
                    task['priority'],
                    style: PrimeCareTheme.typography.label.copyWith(
                      color: priorityColor,
                      fontSize: 9,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Icon(
                  LucideIcons.user,
                  size: 14,
                  color: PrimeCareTheme.colors.slateGray,
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    task['contact'],
                    style: PrimeCareTheme.typography.body.copyWith(
                      color: PrimeCareTheme.colors.slateGray,
                      fontWeight: FontWeight.bold,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Icon(LucideIcons.calendar, size: 14, color: dueDateColor),
                const SizedBox(width: 8),
                Text(
                  task['dueDate'],
                  style: PrimeCareTheme.typography.label.copyWith(
                    color: dueDateColor,
                    fontWeight: isOverdue ? FontWeight.bold : FontWeight.normal,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
