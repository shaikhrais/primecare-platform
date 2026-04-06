import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:primecare_v4/design_system/clinical_glass.dart';
import 'package:primecare_v4/design_system/primecare_theme.dart';
import 'package:primecare_v4/shared/components/page_template.dart';

class TodaysScheduleScreen extends ConsumerWidget {
  const TodaysScheduleScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return PageTemplate(
      title: 'Today\'s Schedule',
      subtitle: 'Manage appointments, shift duties, patient rounds, and handoffs.',
      headerTrailing: [
        ClinicalGlassButton(
          onPressed: () {},
          label: 'Request Coverage',
          icon: LucideIcons.userMinus,
        ),
        const SizedBox(width: 16),
        ClinicalGlassButton(
          onPressed: () {},
          label: 'Create Block',
          icon: LucideIcons.calendarPlus,
          isPrimary: true,
        ),
      ],
      kpiCards: [
        MetricCardData(
          title: 'Total Appointments',
          value: '8',
          icon: LucideIcons.calendar,
          trend: 'Expected workload',
          isUp: true,
        ),
        MetricCardData(
          title: 'Upcoming',
          value: '3',
          icon: LucideIcons.clock,
          trend: 'Next 3 hours',
          isUp: false,
        ),
        MetricCardData(
          title: 'Handoffs Pending',
          value: '1',
          icon: LucideIcons.arrowRightLeft,
          trend: 'Shift end at 4:00 PM',
          isUp: false,
          color: PrimeCareTheme.colors.amberWarning,
        ),
      ],
      sidebarContent: [
        _buildShiftDetails(),
      ],
      mainContent: [
        _buildScheduleTimeline(),
      ],
    );
  }

  Widget _buildShiftDetails() {
    return ClinicalGlassPanel(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(LucideIcons.user, color: PrimeCareTheme.colors.navyIndigo, size: 20),
              const SizedBox(width: 8),
              Text('Shift Information', style: PrimeCareTheme.typography.h3),
            ],
          ),
          const SizedBox(height: 16),
          ListTile(
            contentPadding: EdgeInsets.zero,
            leading: Icon(LucideIcons.clock, color: PrimeCareTheme.colors.slateGray),
            title: Text('08:00 AM - 04:00 PM', style: PrimeCareTheme.typography.body.copyWith(fontWeight: FontWeight.bold)),
            subtitle: Text('Day Shift', style: PrimeCareTheme.typography.label),
          ),
          ListTile(
            contentPadding: EdgeInsets.zero,
            leading: Icon(LucideIcons.mapPin, color: PrimeCareTheme.colors.slateGray),
            title: Text('East Wing, Unit B', style: PrimeCareTheme.typography.body.copyWith(fontWeight: FontWeight.bold)),
            subtitle: Text('Primary Assignment', style: PrimeCareTheme.typography.label),
          ),
          const SizedBox(height: 16),
          ClinicalGlassButton(
            onPressed: () {},
            label: 'Start Handoff Procedure',
            icon: LucideIcons.arrowRight,
          ),
        ],
      ),
    );
  }

  Widget _buildScheduleTimeline() {
    return ClinicalGlassPanel(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(24),
            child: Text('Timeline', style: PrimeCareTheme.typography.h2),
          ),
          const Divider(height: 1),
          _buildTimelineItem(
            time: '08:00 AM',
            title: 'Morning Handoff',
            description: 'Received report from night shift charge nurse.',
            isCompleted: true,
          ),
          _buildTimelineItem(
            time: '09:00 AM',
            title: 'Patient Rounds',
            description: 'Assessments and morning vitals for East Wing.',
            isCompleted: true,
          ),
          _buildTimelineItem(
            time: '11:00 AM',
            title: 'Wound Care',
            description: 'Dressing change for Marcus Aurelius (Room 102B).',
            isCompleted: true,
          ),
          _buildTimelineItem(
            time: '01:00 PM',
            title: 'Medication Administration',
            description: 'Afternoon scheduled medications.',
            isCurrent: true,
          ),
          _buildTimelineItem(
            time: '02:30 PM',
            title: 'Multidisciplinary Team Meeting',
            description: 'Discuss care plan for newly admitted patient.',
          ),
          _buildTimelineItem(
            time: '03:30 PM',
            title: 'End of Shift Charting',
            description: 'Finalize nursing notes and assessments.',
          ),
        ],
      ),
    );
  }

  Widget _buildTimelineItem({
    required String time,
    required String title,
    required String description,
    bool isCompleted = false,
    bool isCurrent = false,
  }) {
    final statusColor = isCompleted
        ? PrimeCareTheme.colors.emeraldTeal
        : (isCurrent ? PrimeCareTheme.colors.royalPurple : PrimeCareTheme.colors.slateGray);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 80,
            child: Text(
              time,
              style: PrimeCareTheme.typography.body.copyWith(
                fontWeight: FontWeight.bold,
                color: isCompleted ? PrimeCareTheme.colors.slateGray : PrimeCareTheme.colors.navyIndigo,
              ),
            ),
          ),
          Column(
            children: [
              Container(
                width: 16,
                height: 16,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: isCompleted || isCurrent ? statusColor : Colors.transparent,
                  border: Border.all(color: statusColor, width: 2),
                ),
              ),
              if (!isCompleted && !isCurrent) // Simulate timeline line for future items
                Container(
                  width: 2,
                  height: 60,
                  color: PrimeCareTheme.colors.surfaceContainerHighest,
                ),
            ],
          ),
          const SizedBox(width: 24),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: PrimeCareTheme.typography.h3.copyWith(
                    color: isCompleted ? PrimeCareTheme.colors.slateGray : PrimeCareTheme.colors.navyIndigo,
                    decoration: isCompleted ? TextDecoration.lineThrough : null,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  description,
                  style: PrimeCareTheme.typography.body.copyWith(
                    color: PrimeCareTheme.colors.slateGray,
                  ),
                ),
                if (isCurrent)
                  Padding(
                     padding: const EdgeInsets.only(top: 16),
                     child: ClinicalGlassButton(
                       onPressed: () {},
                       label: 'Join / Start',
                       icon: LucideIcons.playCircle,
                       isPrimary: true,
                     ),
                  )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
