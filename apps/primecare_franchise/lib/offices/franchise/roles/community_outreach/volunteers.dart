import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:primecare_v4/design_system/clinical_glass.dart';
import 'package:primecare_v4/design_system/primecare_theme.dart';

class CommunityVolunteersScreen extends ConsumerStatefulWidget {
  const CommunityVolunteersScreen({super.key});

  @override
  ConsumerState<CommunityVolunteersScreen> createState() =>
      _CommunityVolunteersScreenState();
}

class _CommunityVolunteersScreenState
    extends ConsumerState<CommunityVolunteersScreen> {
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
              Expanded(flex: 3, child: _buildVolunteersTable()),
              const SizedBox(width: 32),
              Expanded(flex: 1, child: _buildUpcomingShifts()),
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
                  LucideIcons.heartHandshake,
                  color: PrimeCareTheme.colors.navyIndigo,
                  size: 28,
                ),
                const SizedBox(width: 12),
                Text(
                  'Volunteer Management',
                  style: PrimeCareTheme.typography.heroTitle.copyWith(
                    color: PrimeCareTheme.colors.navyIndigo,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              'Coordinate the volunteer network and track shift assignments.',
              style: PrimeCareTheme.typography.body.copyWith(
                color: PrimeCareTheme.colors.slateGray,
              ),
            ),
          ],
        ),
        ClinicalGlassButton(
          onPressed: () {},
          icon: LucideIcons.userPlus,
          label: 'Register Volunteer',
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
            title: 'Total Volunteers',
            value: '342',
            icon: LucideIcons.users,
            trend: '+12 this month',
            isPositive: true,
          ),
        ),
        const SizedBox(width: 24),
        Expanded(
          child: _buildMetricCard(
            title: 'Active Assignments',
            value: '45',
            icon: LucideIcons.briefcase,
            trend: 'Currently filled roles',
            isNeutral: true,
          ),
        ),
        const SizedBox(width: 24),
        Expanded(
          child: _buildMetricCard(
            title: 'Hours Logged (MTD)',
            value: '1,250',
            icon: LucideIcons.clock,
            trend: '+150 vs last month',
            isPositive: true,
          ),
        ),
        const SizedBox(width: 24),
        Expanded(
          child: _buildMetricCard(
            title: 'Pending Applications',
            value: '8',
            icon: LucideIcons.fileClock,
            trend: 'Requires review',
            isWarning: true,
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
    bool isNeutral = false,
  }) {
    Color trendColor = PrimeCareTheme.colors.slateGray;
    Color iconColor = PrimeCareTheme.colors.navyIndigo;

    if (isWarning) {
      trendColor = Colors.amber.shade700;
      iconColor = Colors.amber.shade700;
    } else if (isPositive) {
      trendColor = PrimeCareTheme.colors.emeraldTeal;
      iconColor = PrimeCareTheme.colors.emeraldTeal;
    } else if (isNeutral) {
      trendColor = PrimeCareTheme.colors.navyIndigo;
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

  Widget _buildVolunteersTable() {
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
                  'Active Volunteers',
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
                        'Search volunteers...',
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
                    'VOLUNTEER',
                    style: PrimeCareTheme.typography.label.copyWith(
                      fontSize: 11,
                      color: PrimeCareTheme.colors.slateGray,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: Text(
                    'CURRENT ASSIGNMENT',
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
                    'ROLE TYPE',
                    style: PrimeCareTheme.typography.label.copyWith(
                      fontSize: 11,
                      color: PrimeCareTheme.colors.slateGray,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Text(
                    'HOURS (YTD)',
                    textAlign: TextAlign.right,
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
          ..._buildVolunteerRows(),
        ],
      ),
    );
  }

  List<Widget> _buildVolunteerRows() {
    final volunteers = [
      {
        'name': 'Sarah Jenkins',
        'email': 'sarah@example.com',
        'assignment': 'Senior Companion Program',
        'role': 'Companion',
        'hours': '145',
        'status': 'Active',
      },
      {
        'name': 'Marcus Chen',
        'email': 'marcus@example.com',
        'assignment': 'Health Fair Registration',
        'role': 'Admin',
        'hours': '82',
        'status': 'Active',
      },
      {
        'name': 'Emily Davis',
        'email': 'emily@example.com',
        'assignment': 'Food Drive Coordinator',
        'role': 'Lead',
        'hours': '12',
        'status': 'Active',
      },
      {
        'name': 'David Kim',
        'email': 'david@example.com',
        'assignment': 'Youth Mentorship',
        'role': 'Mentor',
        'hours': '45',
        'status': 'On Leave',
      },
      {
        'name': 'Anna Patel',
        'email': 'anna@example.com',
        'assignment': 'None',
        'role': 'Floater',
        'hours': '4',
        'status': 'Inactive',
      },
    ];

    return volunteers.asMap().entries.map((entry) {
      final volunteer = entry.value;
      final int index = entry.key;

      Color statusColor;
      switch (volunteer['status']) {
        case 'Active':
          statusColor = PrimeCareTheme.colors.emeraldTeal;
          break;
        case 'On Leave':
          statusColor = Colors.amber.shade700;
          break;
        case 'Inactive':
          statusColor = PrimeCareTheme.colors.slateGray;
          break;
        default:
          statusColor = PrimeCareTheme.colors.navyIndigo;
      }

      return Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
            child: Row(
              children: [
                Expanded(
                  flex: 3,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        volunteer['name']!,
                        style: PrimeCareTheme.typography.body.copyWith(
                          color: PrimeCareTheme.colors.navyIndigo,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        volunteer['email']!,
                        style: PrimeCareTheme.typography.label.copyWith(
                          color: PrimeCareTheme.colors.slateGray,
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: Text(
                    volunteer['assignment']!,
                    style: PrimeCareTheme.typography.body.copyWith(
                      color: PrimeCareTheme.colors.slateGray,
                    ),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: PrimeCareTheme.colors.surfaceContainerHighest,
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Text(
                      volunteer['role']!,
                      style: PrimeCareTheme.typography.label.copyWith(
                        color: PrimeCareTheme.colors.navyIndigo,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Text(
                    volunteer['hours']!,
                    textAlign: TextAlign.right,
                    style: PrimeCareTheme.typography.body.copyWith(
                      color: PrimeCareTheme.colors.navyIndigo,
                      fontWeight: FontWeight.bold,
                    ),
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
                        volunteer['status']!,
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
          if (index < volunteers.length - 1)
            Divider(
              height: 1,
              color: PrimeCareTheme.colors.surfaceContainerHighest,
            ),
        ],
      );
    }).toList();
  }

  Widget _buildUpcomingShifts() {
    return ClinicalGlassPanel(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Upcoming Shifts',
                style: PrimeCareTheme.typography.h3.copyWith(
                  color: PrimeCareTheme.colors.navyIndigo,
                ),
              ),
              Icon(
                LucideIcons.calendar,
                color: PrimeCareTheme.colors.slateGray,
                size: 20,
              ),
            ],
          ),
          const SizedBox(height: 24),
          _buildShiftItem(
            'Today, 1:00 PM',
            'Senior Center Reading Session',
            '2 Slots Open',
            PrimeCareTheme.colors.emeraldTeal,
          ),
          const SizedBox(height: 16),
          _buildShiftItem(
            'Tomorrow, 9:00 AM',
            'Food Bank Support',
            'Filled',
            PrimeCareTheme.colors.slateGray,
          ),
          const SizedBox(height: 16),
          _buildShiftItem(
            'Oct 30, 10:00 AM',
            'Fall Festival Setup',
            '5 Slots Open',
            Colors.amber.shade600,
          ),
          const SizedBox(height: 24),
          SizedBox(
            width: double.infinity,
            child: ClinicalGlassButton(
              onPressed: () {},
              icon: LucideIcons.calendarClock,
              label: 'Manage Schedule',
              isActive: true,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildShiftItem(
    String time,
    String title,
    String availability,
    Color statusColor,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: PrimeCareTheme.typography.body.copyWith(
                color: PrimeCareTheme.colors.navyIndigo,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        const SizedBox(height: 4),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              time,
              style: PrimeCareTheme.typography.label.copyWith(
                color: PrimeCareTheme.colors.slateGray,
              ),
            ),
            Text(
              availability,
              style: PrimeCareTheme.typography.label.copyWith(
                color: statusColor,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
