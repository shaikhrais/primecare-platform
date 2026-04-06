import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:primecare_v4/design_system/clinical_glass.dart';
import 'package:primecare_v4/design_system/primecare_theme.dart';

class TodaysScheduleScreen extends ConsumerWidget {
  const TodaysScheduleScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Today\'s Schedule',
                      style: PrimeCareTheme.typography.heroTitle.copyWith(
                        color: PrimeCareTheme.colors.navyIndigo,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Your daily route and scheduled RN/RPN patient visits.',
                      style: PrimeCareTheme.typography.body.copyWith(
                        color: PrimeCareTheme.colors.slateGray,
                      ),
                    ),
                  ],
                ),
                ClinicalGlassPanel(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  child: Row(
                    children: [
                      Icon(LucideIcons.calendar, color: PrimeCareTheme.colors.emeraldTeal, size: 20),
                      const SizedBox(width: 8),
                      Text(
                        'Sep 24, 2026',
                        style: PrimeCareTheme.typography.label.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 32),
            _buildShiftItem(
              time: '08:30 AM - 09:30 AM',
              patientName: 'John Carmichael',
              address: '55 Main Street, Unit 2',
              tasks: ['Wound Care', 'Insulin Administration'],
              status: 'Completed',
            ),
            const SizedBox(height: 16),
            _buildShiftItem(
              time: '10:00 AM - 11:30 AM',
              patientName: 'Eleanor Vance',
              address: '142 Maplewood Dr',
              tasks: ['Catheter Maintenance', 'Vitals Check', 'Medication Refill'],
              status: 'In Progress',
            ),
            const SizedBox(height: 16),
            _buildShiftItem(
              time: '01:00 PM - 02:00 PM',
              patientName: 'Sylvia Plath',
              address: '89 Willow Creek',
              tasks: ['Palliative Care Check', 'Pain Assessment'],
              status: 'Upcoming',
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildShiftItem({
    required String time,
    required String patientName,
    required String address,
    required List<String> tasks,
    required String status,
  }) {
    final bool isInProgress = status == 'In Progress';
    final bool isCompleted = status == 'Completed';

    return ClinicalGlassPanel(
      padding: const EdgeInsets.all(24),
      border: Border.all(
        color: isInProgress ? PrimeCareTheme.colors.emeraldTeal.withOpacity(0.3) : PrimeCareTheme.colors.surfaceContainerHighest,
        width: 1,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(LucideIcons.clock, size: 16, color: PrimeCareTheme.colors.slateGray),
                  const SizedBox(width: 8),
                  Text(
                    time,
                    style: PrimeCareTheme.typography.label.copyWith(
                      fontWeight: FontWeight.bold,
                      color: PrimeCareTheme.colors.navyIndigo,
                    ),
                  ),
                ],
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                decoration: BoxDecoration(
                  color: isInProgress 
                      ? PrimeCareTheme.colors.emeraldTeal.withOpacity(0.1) 
                      : (isCompleted ? PrimeCareTheme.colors.navyIndigo.withOpacity(0.1) : PrimeCareTheme.colors.surfaceContainerHigh),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  status,
                  style: PrimeCareTheme.typography.label.copyWith(
                    color: isInProgress ? PrimeCareTheme.colors.emeraldTeal : (isCompleted ? PrimeCareTheme.colors.navyIndigo : PrimeCareTheme.colors.slateGray),
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CircleAvatar(
                radius: 24,
                backgroundColor: PrimeCareTheme.colors.navyIndigo.withOpacity(0.1),
                child: Text(
                  patientName.substring(0, 1),
                  style: TextStyle(color: PrimeCareTheme.colors.navyIndigo, fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      patientName,
                      style: PrimeCareTheme.typography.h3,
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        Icon(LucideIcons.mapPin, size: 14, color: PrimeCareTheme.colors.slateGray),
                        const SizedBox(width: 4),
                        Text(
                          address,
                          style: PrimeCareTheme.typography.body.copyWith(
                            color: PrimeCareTheme.colors.slateGray,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              ClinicalGlassButton(
                onPressed: () {},
                icon: LucideIcons.chevronRight,
                label: 'View Care Plan',
              ),
            ],
          ),
          const SizedBox(height: 16),
          Divider(color: PrimeCareTheme.colors.surfaceContainerHighest),
          const SizedBox(height: 16),
          Text(
            'Clinical Tasks',
            style: PrimeCareTheme.typography.label.copyWith(
              fontWeight: FontWeight.w600,
              color: PrimeCareTheme.colors.slateGray,
            ),
          ),
          const SizedBox(height: 8),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: tasks.map((t) => Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: PrimeCareTheme.colors.surfaceContainerLow,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                t,
                style: PrimeCareTheme.typography.label,
              ),
            )).toList(),
          ),
        ],
      ),
    );
  }
}
