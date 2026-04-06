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
                      'Today\'s Appointments',
                      style: PrimeCareTheme.typography.heroTitle.copyWith(
                        color: PrimeCareTheme.colors.navyIndigo,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Your clinical massage therapy schedule for today.',
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
            _buildAppointmentItem(
              time: '09:00 AM - 10:00 AM (60 Min)',
              patientName: 'Emma Watson',
              focus: 'Deep Tissue - Lower Back',
              status: 'Completed',
              room: 'Room A',
            ),
            const SizedBox(height: 16),
            _buildAppointmentItem(
              time: '10:30 AM - 11:15 AM (45 Min)',
              patientName: 'Liam Chen',
              focus: 'Swedish / Relaxation',
              status: 'In Progress',
              room: 'Room B',
            ),
            const SizedBox(height: 16),
            _buildAppointmentItem(
              time: '01:00 PM - 02:30 PM (90 Min)',
              patientName: 'Sophia Ramirez',
              focus: 'Sports Therapy - Rotator Cuff',
              status: 'Upcoming',
              room: 'Room A',
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAppointmentItem({
    required String time,
    required String patientName,
    required String focus,
    required String status,
    required String room,
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
                          room,
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
                icon: LucideIcons.fileText,
                label: 'View Chart',
              ),
            ],
          ),
          const SizedBox(height: 16),
          Divider(color: PrimeCareTheme.colors.surfaceContainerHighest),
          const SizedBox(height: 16),
          Text(
            'Treatment Focus',
            style: PrimeCareTheme.typography.label.copyWith(
              fontWeight: FontWeight.w600,
              color: PrimeCareTheme.colors.slateGray,
            ),
          ),
          const SizedBox(height: 8),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: PrimeCareTheme.colors.surfaceContainerLow,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              focus,
              style: PrimeCareTheme.typography.label,
            ),
          ),
        ],
      ),
    );
  }
}
