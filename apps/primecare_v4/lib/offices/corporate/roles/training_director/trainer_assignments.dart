import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:primecare_v4/design_system/clinical_glass.dart';
import 'package:primecare_v4/design_system/primecare_theme.dart';
import 'package:primecare_v4/shared/components/page_template.dart';

class TrainerAssignmentsScreen extends ConsumerWidget {
  const TrainerAssignmentsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return PageTemplate(
      title: 'Trainer Assignments',
      subtitle:
          'Manage and monitor all active trainers, schedules, and feedback.',
      headerTrailing: [
        ClinicalSearchTextField(hintText: 'Search trainers, sessions...'),
        const SizedBox(width: 16),
        ClinicalGlassButton(
          onPressed: () {},
          label: 'Assign Trainer',
          icon: LucideIcons.userPlus,
          isPrimary: true,
        ),
      ],
      kpiCards: [
        KPICardData(
          title: 'Active Trainers',
          value: '12',
          icon: LucideIcons.users,
          trend: 'Across 4 regions',
          isUp: true,
          color: PrimeCareTheme.colors.navyIndigo,
        ),
        KPICardData(
          title: 'Upcoming Sessions',
          value: '28',
          icon: LucideIcons.calendar,
          trend: 'Next 14 days',
          isUp: true,
          color: PrimeCareTheme.colors.emeraldTeal,
        ),
        KPICardData(
          title: 'Feedback Avg Score',
          value: '4.8/5.0',
          icon: LucideIcons.star,
          trend: '+0.1 from last month',
          isUp: true,
          color: PrimeCareTheme.colors.amberWarning,
        ),
      ],
      sidebarContent: [_buildTrainerProfiles()],
      mainContent: [_buildScheduleTimeline()],
    );
  }

  Widget _buildTrainerProfiles() {
    return ClinicalGlassPanel(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                LucideIcons.users,
                color: PrimeCareTheme.colors.navyIndigo,
                size: 20,
              ),
              const SizedBox(width: 8),
              Text('Top Rated Trainers', style: PrimeCareTheme.typography.h3),
            ],
          ),
          const SizedBox(height: 24),
          _buildTrainerRow('Sarah Jenkins', 'Clinical Compliance', '4.9'),
          const SizedBox(height: 16),
          _buildTrainerRow('Dr. Ahmad Ali', 'Advanced Procedures', '4.9'),
          const SizedBox(height: 16),
          _buildTrainerRow('Maria Sol', 'Patient Care (PSW)', '4.8'),
        ],
      ),
    );
  }

  Widget _buildTrainerRow(String name, String specialty, String score) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        CircleAvatar(
          backgroundColor: PrimeCareTheme.colors.emeraldTeal.withOpacity(0.2),
          radius: 20,
          child: Text(
            name[0],
            style: TextStyle(
              color: PrimeCareTheme.colors.emeraldTeal,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                name,
                style: PrimeCareTheme.typography.body.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(specialty, style: PrimeCareTheme.typography.label),
            ],
          ),
        ),
        Row(
          children: [
            Icon(
              LucideIcons.star,
              size: 14,
              color: PrimeCareTheme.colors.amberWarning,
            ),
            const SizedBox(width: 4),
            Text(
              score,
              style: PrimeCareTheme.typography.body.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildScheduleTimeline() {
    return ClinicalGlassPanel(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Upcoming Assignments', style: PrimeCareTheme.typography.h2),
              ClinicalGlassButton(
                onPressed: () {},
                label: 'View Calendar',
                icon: LucideIcons.calendar,
              ),
            ],
          ),
          const SizedBox(height: 24),
          _buildAssignmentEvent(
            date: 'Tomorrow, 09:00 AM',
            trainer: 'Sarah Jenkins',
            topic: 'Infection Control Fundamentals',
            location: 'Main Auditorium / Online',
            enrolled: 45,
          ),
          _buildAssignmentEvent(
            date: 'Nov 14, 02:00 PM',
            trainer: 'Maria Sol',
            topic: 'Patient Handling & Lifts',
            location: 'Sim Lab 2',
            enrolled: 12,
          ),
          _buildAssignmentEvent(
            date: 'Nov 16, 10:00 AM',
            trainer: 'Dr. Ahmad Ali',
            topic: 'Code Blue Protocol',
            location: 'Emergency Wing B',
            enrolled: 20,
            isLast: true,
          ),
        ],
      ),
    );
  }

  Widget _buildAssignmentEvent({
    required String date,
    required String trainer,
    required String topic,
    required String location,
    required int enrolled,
    bool isLast = false,
  }) {
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Column(
            children: [
              Container(
                width: 16,
                height: 16,
                decoration: BoxDecoration(
                  color: PrimeCareTheme.colors.emeraldTeal,
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.white, width: 3),
                ),
              ),
              if (!isLast)
                Expanded(
                  child: Container(
                    width: 2,
                    color: PrimeCareTheme.colors.emeraldTeal.withOpacity(0.3),
                  ),
                ),
            ],
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(bottom: 24),
              child: Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: PrimeCareTheme.colors.cloudGray.withOpacity(0.3),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(topic, style: PrimeCareTheme.typography.h3),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: PrimeCareTheme.colors.navyIndigo.withOpacity(
                              0.1,
                            ),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(
                            '$enrolled Enrolled',
                            style: PrimeCareTheme.typography.label.copyWith(
                              color: PrimeCareTheme.colors.navyIndigo,
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
                          size: 16,
                          color: PrimeCareTheme.colors.slateGray,
                        ),
                        const SizedBox(width: 6),
                        Text(trainer, style: PrimeCareTheme.typography.body),
                        const SizedBox(width: 20),
                        Icon(
                          LucideIcons.clock,
                          size: 16,
                          color: PrimeCareTheme.colors.slateGray,
                        ),
                        const SizedBox(width: 6),
                        Text(date, style: PrimeCareTheme.typography.body),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        Icon(
                          LucideIcons.mapPin,
                          size: 16,
                          color: PrimeCareTheme.colors.slateGray,
                        ),
                        const SizedBox(width: 6),
                        Text(location, style: PrimeCareTheme.typography.label),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
