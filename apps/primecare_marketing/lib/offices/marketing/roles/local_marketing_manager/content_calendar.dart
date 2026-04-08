import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:primecare_v4/design_system/clinical_glass.dart';
import 'package:primecare_v4/design_system/primecare_theme.dart';

class LocalContentCalendarScreen extends ConsumerStatefulWidget {
  const LocalContentCalendarScreen({super.key});

  @override
  ConsumerState<LocalContentCalendarScreen> createState() =>
      _LocalContentCalendarScreenState();
}

class _LocalContentCalendarScreenState
    extends ConsumerState<LocalContentCalendarScreen> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(32.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildHeader(),
          const SizedBox(height: 32),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(flex: 2, child: _buildCalendarView()),
              const SizedBox(width: 32),
              Expanded(flex: 1, child: _buildUpcomingActionItems()),
            ],
          ),
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
            Text(
              'Content Calendar',
              style: PrimeCareTheme.typography.heroTitle.copyWith(
                color: PrimeCareTheme.colors.navyIndigo,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Schedule and manage local social posts, emails, and events.',
              style: PrimeCareTheme.typography.body.copyWith(
                color: PrimeCareTheme.colors.slateGray,
              ),
            ),
          ],
        ),
        Row(
          children: [
            ClinicalGlassButton(
              onPressed: () {},
              icon: LucideIcons.filter,
              label: 'Filter',
            ),
            const SizedBox(width: 16),
            ClinicalGlassButton(
              onPressed: () {},
              icon: LucideIcons.plus,
              label: 'Schedule Content',
              isActive: true,
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildCalendarView() {
    return ClinicalGlassPanel(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'October 2026',
                style: PrimeCareTheme.typography.h2.copyWith(
                  color: PrimeCareTheme.colors.navyIndigo,
                ),
              ),
              Row(
                children: [
                  IconButton(
                    icon: Icon(
                      LucideIcons.chevronLeft,
                      color: PrimeCareTheme.colors.slateGray,
                    ),
                    onPressed: () {},
                  ),
                  IconButton(
                    icon: Icon(
                      LucideIcons.chevronRight,
                      color: PrimeCareTheme.colors.slateGray,
                    ),
                    onPressed: () {},
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 24),
          // Simplified tabular calendar for display purposes
          Table(
            border: TableBorder.all(
              color: PrimeCareTheme.colors.surfaceContainerHighest,
              width: 1,
              borderRadius: BorderRadius.circular(12),
            ),
            children: [
              TableRow(
                decoration: BoxDecoration(
                  color: PrimeCareTheme.colors.surfaceContainerLow,
                ),
                children: ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun']
                    .map(
                      (d) => Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Center(
                          child: Text(
                            d,
                            style: PrimeCareTheme.typography.label.copyWith(
                              color: PrimeCareTheme.colors.slateGray,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    )
                    .toList(),
              ),
              _buildCalendarWeek(
                ['28', '29', '30', '1', '2', '3', '4'],
                activeDays: {
                  '1': ['Social Post'],
                  '3': ['Email Blast'],
                },
              ),
              _buildCalendarWeek(
                ['5', '6', '7', '8', '9', '10', '11'],
                activeDays: {
                  '7': ['Local Event', 'Social Promo'],
                },
              ),
              _buildCalendarWeek(
                ['12', '13', '14', '15', '16', '17', '18'],
                activeDays: {
                  '14': ['Newsletter'],
                },
              ),
              _buildCalendarWeek(
                ['19', '20', '21', '22', '23', '24', '25'],
                activeDays: {
                  '20': ['Webinar', 'Post'],
                },
              ),
              _buildCalendarWeek(
                ['26', '27', '28', '29', '30', '31', '1'],
                activeDays: {
                  '31': ['Halloween Campaign'],
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  TableRow _buildCalendarWeek(
    List<String> days, {
    required Map<String, List<String>> activeDays,
  }) {
    return TableRow(
      children: days.map((d) {
        final hasEvents = activeDays.containsKey(d);
        final events = activeDays[d] ?? [];
        return Container(
          height: 100,
          padding: const EdgeInsets.all(8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                d,
                style: PrimeCareTheme.typography.label.copyWith(
                  color: PrimeCareTheme.colors.navyIndigo,
                  fontWeight: hasEvents ? FontWeight.bold : FontWeight.normal,
                ),
              ),
              if (hasEvents)
                ...events
                    .map(
                      (e) => Container(
                        margin: const EdgeInsets.only(top: 4),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 4,
                          vertical: 2,
                        ),
                        decoration: BoxDecoration(
                          color: PrimeCareTheme.colors.emeraldTeal.withValues(
                            alpha: 0.1,
                          ),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text(
                          e,
                          style: TextStyle(
                            fontSize: 10,
                            color: PrimeCareTheme.colors.emeraldTeal,
                            fontWeight: FontWeight.w600,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    )
                    .toList(),
            ],
          ),
        );
      }).toList(),
    );
  }

  Widget _buildUpcomingActionItems() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Action Required',
          style: PrimeCareTheme.typography.h3.copyWith(
            color: PrimeCareTheme.colors.navyIndigo,
          ),
        ),
        const SizedBox(height: 16),
        _buildActionItem(
          title: 'Review Fall Newsletter Copy',
          type: 'Email',
          due: 'Tomorrow, 5:00 PM',
          status: 'Pending Approval',
        ),
        const SizedBox(height: 12),
        _buildActionItem(
          title: 'Confirm Event Venue',
          type: 'Event',
          due: 'Oct 7, 12:00 PM',
          status: 'Needs Action',
          isUrgent: true,
        ),
        const SizedBox(height: 12),
        _buildActionItem(
          title: 'Approve Social Graphics',
          type: 'Social',
          due: 'Oct 10, 9:00 AM',
          status: 'Review Docs',
        ),
        const SizedBox(height: 32),
        Text(
          'Upcoming Scheduled',
          style: PrimeCareTheme.typography.h3.copyWith(
            color: PrimeCareTheme.colors.navyIndigo,
          ),
        ),
        const SizedBox(height: 16),
        _buildActionItem(
          title: 'Flu Shot Reminder',
          type: 'Social Post',
          due: 'Oct 1',
          status: 'Scheduled',
          isCompleted: true,
        ),
        const SizedBox(height: 12),
        _buildActionItem(
          title: 'Monthly Provider Highlight',
          type: 'Blog/Email',
          due: 'Oct 3',
          status: 'Drafting',
        ),
      ],
    );
  }

  Widget _buildActionItem({
    required String title,
    required String type,
    required String due,
    required String status,
    bool isUrgent = false,
    bool isCompleted = false,
  }) {
    Color accentColor = isCompleted
        ? PrimeCareTheme.colors.slateGray
        : isUrgent
        ? PrimeCareTheme.colors.coralRed
        : PrimeCareTheme.colors.emeraldTeal;

    return ClinicalGlassPanel(
      padding: const EdgeInsets.all(16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: accentColor.withValues(alpha: 0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(
              isCompleted
                  ? LucideIcons.checkCircle
                  : isUrgent
                  ? LucideIcons.alertCircle
                  : LucideIcons.clock,
              size: 20,
              color: accentColor,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      title,
                      style: PrimeCareTheme.typography.h4.copyWith(
                        color: isCompleted
                            ? PrimeCareTheme.colors.slateGray
                            : PrimeCareTheme.colors.navyIndigo,
                      ),
                    ),
                    Text(
                      status,
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.bold,
                        color: accentColor,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    Text(
                      type,
                      style: PrimeCareTheme.typography.label.copyWith(
                        color: PrimeCareTheme.colors.slateGray,
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 8.0),
                      child: Text('•', style: TextStyle(color: Colors.grey)),
                    ),
                    Text(
                      'Due: $due',
                      style: PrimeCareTheme.typography.label.copyWith(
                        color: PrimeCareTheme.colors.slateGray,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
