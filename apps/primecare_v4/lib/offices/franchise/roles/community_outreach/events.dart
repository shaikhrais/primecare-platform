import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:primecare_v4/design_system/clinical_glass.dart';
import 'package:primecare_v4/design_system/primecare_theme.dart';

class CommunityEventsScreen extends ConsumerStatefulWidget {
  const CommunityEventsScreen({super.key});

  @override
  ConsumerState<CommunityEventsScreen> createState() =>
      _CommunityEventsScreenState();
}

class _CommunityEventsScreenState extends ConsumerState<CommunityEventsScreen> {
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
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(flex: 3, child: _buildLogisticsTable()),
              const SizedBox(width: 32),
              Expanded(flex: 1, child: _buildUpcomingEventsList()),
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
            Row(
              children: [
                Icon(
                  LucideIcons.calendarHeart,
                  color: PrimeCareTheme.colors.navyIndigo,
                  size: 28,
                ),
                const SizedBox(width: 12),
                Text(
                  'Community Events',
                  style: PrimeCareTheme.typography.heroTitle.copyWith(
                    color: PrimeCareTheme.colors.navyIndigo,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              'Manage outreach events, health fairs, seminars, and attendee logistics.',
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
              icon: LucideIcons.calendar,
              label: 'View Calendar',
            ),
            const SizedBox(width: 16),
            ClinicalGlassButton(
              onPressed: () {},
              icon: LucideIcons.plus,
              label: 'Create Event',
              isActive: true, // Primary action
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildKPIs() {
    return Row(
      children: [
        Expanded(
          child: _buildMetricCard(
            title: 'Events This Month',
            value: '8',
            icon: LucideIcons.calendarSearch,
            subtext: '3 remaining',
          ),
        ),
        const SizedBox(width: 24),
        Expanded(
          child: _buildMetricCard(
            title: 'Total RSVPs (Upcoming)',
            value: '245',
            icon: LucideIcons.users,
            subtext: '+42 since yesterday',
            isPositive: true,
          ),
        ),
        const SizedBox(width: 24),
        Expanded(
          child: _buildMetricCard(
            title: 'Waitlist',
            value: '12',
            icon: LucideIcons.userPlus,
            subtext: 'Requires capacity check',
            isWarning: true,
          ),
        ),
        const SizedBox(width: 24),
        Expanded(
          child: _buildMetricCard(
            title: 'Avg Attendance Rate',
            value: '85%',
            icon: LucideIcons.checkSquare,
            subtext: 'Based on last 6 months',
          ),
        ),
      ],
    );
  }

  Widget _buildMetricCard({
    required String title,
    required String value,
    required IconData icon,
    required String subtext,
    bool isWarning = false,
    bool isPositive = false,
  }) {
    Color iconColor = PrimeCareTheme.colors.navyIndigo;
    Color subtextColor = PrimeCareTheme.colors.slateGray;

    if (isWarning) {
      iconColor = Colors.amber.shade700;
      subtextColor = Colors.amber.shade700;
    } else if (isPositive) {
      subtextColor = PrimeCareTheme.colors.emeraldTeal;
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
            subtext,
            style: PrimeCareTheme.typography.label.copyWith(
              color: subtextColor,
              fontWeight: (isWarning || isPositive)
                  ? FontWeight.bold
                  : FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLogisticsTable() {
    return ClinicalGlassPanel(
      padding: EdgeInsets.zero,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(24.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Event Logistics & Attendance',
                  style: PrimeCareTheme.typography.h3.copyWith(
                    color: PrimeCareTheme.colors.navyIndigo,
                  ),
                ),
                Container(
                  width: 250,
                  decoration: BoxDecoration(
                    color: PrimeCareTheme.colors.surfaceContainerLow,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: PrimeCareTheme.colors.surfaceContainerHighest,
                    ),
                  ),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 12,
                  ),
                  child: Row(
                    children: [
                      Icon(
                        LucideIcons.search,
                        size: 18,
                        color: PrimeCareTheme.colors.slateGray,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        'Search events...',
                        style: PrimeCareTheme.typography.body.copyWith(
                          color: PrimeCareTheme.colors.slateGray,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
            color: PrimeCareTheme.colors.surfaceContainerLow,
            child: Row(
              children: [
                Expanded(
                  flex: 3,
                  child: Text(
                    'EVENT NAME',
                    style: PrimeCareTheme.typography.label.copyWith(
                      fontSize: 11,
                      color: PrimeCareTheme.colors.slateGray,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Text(
                    'DATE & TIME',
                    style: PrimeCareTheme.typography.label.copyWith(
                      fontSize: 11,
                      color: PrimeCareTheme.colors.slateGray,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Text(
                    'TYPE',
                    style: PrimeCareTheme.typography.label.copyWith(
                      fontSize: 11,
                      color: PrimeCareTheme.colors.slateGray,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Text(
                    'RSVPS',
                    style: PrimeCareTheme.typography.label.copyWith(
                      fontSize: 11,
                      color: PrimeCareTheme.colors.slateGray,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Text(
                    'CAPACITY',
                    style: PrimeCareTheme.typography.label.copyWith(
                      fontSize: 11,
                      color: PrimeCareTheme.colors.slateGray,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(
                  width: 80,
                  child: Text(
                    'STATUS',
                    textAlign: TextAlign.center,
                    style: PrimeCareTheme.typography.label.copyWith(
                      fontSize: 11,
                      color: PrimeCareTheme.colors.slateGray,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
          ..._buildLogisticsRows(),
        ],
      ),
    );
  }

  List<Widget> _buildLogisticsRows() {
    final events = [
      {
        'name': 'Senior Wellness Fair 2026',
        'date': 'Oct 30, 9:00 AM',
        'type': 'Health Fair',
        'rsvps': '145',
        'capacity': '150',
        'status': 'Upcoming',
      },
      {
        'name': 'Fall Prevention Seminar',
        'date': 'Nov 5, 2:00 PM',
        'type': 'Seminar',
        'rsvps': '42',
        'capacity': '50',
        'status': 'Upcoming',
      },
      {
        'name': 'Community Hub Launch',
        'date': 'Nov 12, 10:00 AM',
        'type': 'Networking',
        'rsvps': '58',
        'capacity': '50',
        'status': 'Full',
      },
      {
        'name': 'Dementia Care Workshop',
        'date': 'Nov 18, 1:00 PM',
        'type': 'Workshop',
        'rsvps': '15',
        'capacity': '30',
        'status': 'Upcoming',
      },
      {
        'name': 'October Blood Drive',
        'date': 'Oct 15, 8:00 AM',
        'type': 'Health Fair',
        'rsvps': '80',
        'capacity': '100',
        'status': 'Complete',
      },
      {
        'name': 'Caregiver Support Group',
        'date': 'Oct 10, 6:00 PM',
        'type': 'Support',
        'rsvps': '22',
        'capacity': '25',
        'status': 'Complete',
      },
    ];

    return events.asMap().entries.map((entry) {
      final event = entry.value;
      final int index = entry.key;

      Color statusColor;
      switch (event['status']) {
        case 'Upcoming':
          statusColor = PrimeCareTheme.colors.navyIndigo;
          break;
        case 'Full':
          statusColor = Colors.amber.shade700;
          break;
        case 'Complete':
          statusColor = PrimeCareTheme.colors.emeraldTeal;
          break;
        default:
          statusColor = PrimeCareTheme.colors.slateGray;
      }

      int rsvps = int.parse(event['rsvps']!);
      int capacity = int.parse(event['capacity']!);
      double pct = rsvps / capacity;
      Color capacityColor = pct >= 1.0
          ? PrimeCareTheme.colors.coralRed
          : (pct > 0.8
                ? Colors.amber.shade700
                : PrimeCareTheme.colors.emeraldTeal);

      return Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
            child: Row(
              children: [
                Expanded(
                  flex: 3,
                  child: Text(
                    event['name']!,
                    style: PrimeCareTheme.typography.body.copyWith(
                      color: PrimeCareTheme.colors.navyIndigo,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Text(
                    event['date']!,
                    style: PrimeCareTheme.typography.body.copyWith(
                      color: PrimeCareTheme.colors.slateGray,
                    ),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Text(
                    event['type']!,
                    style: PrimeCareTheme.typography.body.copyWith(
                      color: PrimeCareTheme.colors.slateGray,
                    ),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Row(
                    children: [
                      Text(
                        event['rsvps']!,
                        style: PrimeCareTheme.typography.h4.copyWith(
                          color: PrimeCareTheme.colors.navyIndigo,
                        ),
                      ),
                      if (event['status'] == 'Full') ...[
                        const SizedBox(width: 8),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 6,
                            vertical: 2,
                          ),
                          decoration: BoxDecoration(
                            color: PrimeCareTheme.colors.coralRed.withValues(
                              alpha: 0.1,
                            ),
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Text(
                            '+Waitlist',
                            style: PrimeCareTheme.typography.label.copyWith(
                              color: PrimeCareTheme.colors.coralRed,
                              fontSize: 9,
                            ),
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Row(
                    children: [
                      Expanded(
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(4),
                          child: LinearProgressIndicator(
                            value: pct > 1.0 ? 1.0 : pct,
                            backgroundColor:
                                PrimeCareTheme.colors.surfaceContainerHighest,
                            valueColor: AlwaysStoppedAnimation<Color>(
                              capacityColor,
                            ),
                            minHeight: 6,
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        '${(pct * 100).toInt()}%',
                        style: PrimeCareTheme.typography.label.copyWith(
                          color: PrimeCareTheme.colors.slateGray,
                          fontSize: 10,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  width: 80,
                  child: Align(
                    alignment: Alignment.center,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: statusColor.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        event['status']!,
                        style: PrimeCareTheme.typography.label.copyWith(
                          color: statusColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          if (index < events.length - 1)
            Divider(
              height: 1,
              color: PrimeCareTheme.colors.surfaceContainerHighest,
            ),
        ],
      );
    }).toList();
  }

  Widget _buildUpcomingEventsList() {
    return ClinicalGlassPanel(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Upcoming Schedule',
                style: PrimeCareTheme.typography.h3.copyWith(
                  color: PrimeCareTheme.colors.navyIndigo,
                ),
              ),
              Icon(
                LucideIcons.listEnd,
                color: PrimeCareTheme.colors.slateGray,
                size: 20,
              ),
            ],
          ),
          const SizedBox(height: 24),
          _buildScheduleItem(
            '30',
            'OCT',
            'Senior Wellness Fair',
            'Community Center',
            true,
          ),
          const SizedBox(height: 16),
          _buildScheduleItem(
            '05',
            'NOV',
            'Fall Prevention',
            'Library Annex',
            false,
          ),
          const SizedBox(height: 16),
          _buildScheduleItem(
            '12',
            'NOV',
            'Community Hub Launch',
            'Main Office',
            false,
          ),
          const SizedBox(height: 24),
          SizedBox(
            width: double.infinity,
            child: ClinicalGlassButton(
              onPressed: () {},
              icon: LucideIcons.arrowRight,
              label: 'View Full Calendar',
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildScheduleItem(
    String day,
    String month,
    String title,
    String location,
    bool isSoon,
  ) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: PrimeCareTheme.colors.surfaceContainerLow,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: PrimeCareTheme.colors.surfaceContainerHighest,
        ),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
              color: isSoon
                  ? PrimeCareTheme.colors.navyIndigo
                  : Colors.transparent,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                color: isSoon
                    ? PrimeCareTheme.colors.navyIndigo
                    : PrimeCareTheme.colors.surfaceContainerHighest,
              ),
            ),
            child: Column(
              children: [
                Text(
                  day,
                  style: PrimeCareTheme.typography.h3.copyWith(
                    color: isSoon
                        ? Colors.white
                        : PrimeCareTheme.colors.navyIndigo,
                  ),
                ),
                Text(
                  month,
                  style: PrimeCareTheme.typography.label.copyWith(
                    color: isSoon
                        ? Colors.white70
                        : PrimeCareTheme.colors.slateGray,
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: PrimeCareTheme.typography.body.copyWith(
                    color: PrimeCareTheme.colors.navyIndigo,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    Icon(
                      LucideIcons.mapPin,
                      size: 12,
                      color: PrimeCareTheme.colors.slateGray,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      location,
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
