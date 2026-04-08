import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:primecare_v4/design_system/primecare_theme.dart';
import 'package:primecare_v4/design_system/clinical_glass.dart';
import 'package:primecare_v4/shared/components/page_template.dart';

class RpnTodaysScheduleScreen extends ConsumerWidget {
  const RpnTodaysScheduleScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return PageTemplate(
      title: 'Today\'s Schedule',
      subtitle: 'Shift 08:00 - 20:00',
      kpiCards: [
        KPICardData(
          title: 'Total Appointments',
          value: '14',
          icon: LucideIcons.calendar,
          trend: 0.0,
          trendLabel: 'scheduled',
        ),
        KPICardData(
          title: 'Completed',
          value: '8',
          icon: LucideIcons.checkSquare,
          trend: 1.0,
          trendLabel: 'on track',
        ),
        KPICardData(
          title: 'Upcoming',
          value: '6',
          icon: LucideIcons.clock,
          trend: 0.0,
          trendLabel: 'remaining',
        ),
      ],
      sidebarContent: [
        ClinicalGlassPanel(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Schedule Overview', style: PrimeCareTheme.typography.h3),
              const SizedBox(height: 24),
              _buildFilterRow(
                'Medication Round',
                6,
                PrimeCareTheme.colors.primary,
              ),
              _buildFilterRow('Wound Care', 3, PrimeCareTheme.colors.secondary),
              _buildFilterRow(
                'Morning Assessment',
                5,
                PrimeCareTheme.colors.tertiary,
              ),
            ],
          ),
        ),
      ],
      mainContent: [
        ClinicalGlassPanel(
          padding: const EdgeInsets.all(32),
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
                        'Shift Timeline',
                        style: PrimeCareTheme.typography.h2,
                      ),
                      Text(
                        'Your clinical timeline flowing through the day.',
                        style: PrimeCareTheme.typography.body.copyWith(
                          color: PrimeCareTheme.colors.onSurfaceVariant,
                        ),
                      ),
                    ],
                  ),
                  Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          PrimeCareTheme.colors.primary,
                          PrimeCareTheme.colors.primaryContainer,
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.circular(24),
                    ),
                    child: ElevatedButton.icon(
                      onPressed: () {},
                      icon: const Icon(
                        LucideIcons.printer,
                        color: Colors.white,
                      ),
                      label: const Text(
                        'Export Timeline',
                        style: TextStyle(color: Colors.white),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.transparent,
                        shadowColor: Colors.transparent,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 12,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 48),
              _buildScheduleItem(
                time: '08:00',
                clientName: 'Morning Assessment',
                task: 'Initial comprehensive checks and vitals.',
                location: 'Room 204',
                themeColor: PrimeCareTheme.colors.tertiary,
                status: 'Completed',
                isFirst: true,
              ),
              _buildScheduleItem(
                time: '10:00',
                clientName: 'Medication Round',
                task: 'Administer morning medications as per PRN.',
                location: 'Wing B',
                themeColor: PrimeCareTheme.colors.primary,
                status: 'Completed',
              ),
              _buildScheduleItem(
                time: '12:30',
                clientName: 'Shift Break',
                task: 'Mandatory rest period.',
                location: 'Staff Lounge',
                themeColor: PrimeCareTheme.colors.secondary,
                status: 'Upcoming',
              ),
              _buildScheduleItem(
                time: '13:30',
                clientName: 'Post-Op Vitals',
                task: 'Monitor post-surgery vitals and surgical site.',
                location: 'Room 312',
                themeColor: PrimeCareTheme.colors.primary,
                status: 'Upcoming',
              ),
              _buildScheduleItem(
                time: '15:00',
                clientName: 'Rounds with Dr. Thorne',
                task: 'Discuss patient progress and care plans.',
                location: 'Nurse Station',
                themeColor: PrimeCareTheme.colors.secondary,
                status: 'Upcoming',
                isLast: true,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildFilterRow(String label, int count, Color color) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Container(
                width: 10,
                height: 10,
                decoration: BoxDecoration(
                  color: color.withOpacity(0.2),
                  shape: BoxShape.circle,
                  border: Border.all(color: color, width: 2),
                ),
              ),
              const SizedBox(width: 12),
              Text(label, style: PrimeCareTheme.typography.body),
            ],
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(
              color: PrimeCareTheme.colors.surfaceContainerHighest,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              count.toString(),
              style: PrimeCareTheme.typography.label.copyWith(
                color: PrimeCareTheme.colors.onSurface,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildScheduleItem({
    required String time,
    required String clientName,
    required String task,
    required String location,
    required Color themeColor,
    required String status,
    bool isFirst = false,
    bool isLast = false,
  }) {
    final bool isCompleted = status == 'Completed';
    final Color itemColor = isCompleted
        ? PrimeCareTheme.colors.onSurfaceVariant
        : themeColor;

    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Timeline column
          SizedBox(
            width: 80,
            child: Column(
              children: [
                Text(
                  time,
                  style: PrimeCareTheme.typography.h3.copyWith(
                    color: isCompleted
                        ? PrimeCareTheme.colors.onSurfaceVariant
                        : PrimeCareTheme.colors.onSurface,
                  ),
                ),
                const SizedBox(height: 8),
                Expanded(
                  child: isLast
                      ? const SizedBox()
                      : Container(
                          width: 2,
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [
                                itemColor.withOpacity(0.5),
                                itemColor.withOpacity(0.1),
                              ],
                            ),
                          ),
                        ),
                ),
              ],
            ),
          ),
          // Point indicator
          Column(
            children: [
              const SizedBox(height: 6),
              Container(
                width: 16,
                height: 16,
                decoration: BoxDecoration(
                  color: PrimeCareTheme.colors.surface,
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: isCompleted
                        ? PrimeCareTheme.colors.onSurfaceVariant
                        : themeColor,
                    width: 4,
                  ),
                ),
              ),
              Expanded(
                child: isLast
                    ? const SizedBox()
                    : Container(width: 2, color: Colors.transparent),
              ),
            ],
          ),
          const SizedBox(width: 24),
          // Card Content
          Expanded(
            child: Container(
              margin: const EdgeInsets.only(bottom: 32),
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: PrimeCareTheme.colors.surfaceContainerLowest,
                borderRadius: BorderRadius.circular(24),
                boxShadow: [
                  BoxShadow(
                    color: itemColor.withOpacity(0.05),
                    blurRadius: 24,
                    offset: const Offset(0, 12),
                  ),
                ],
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          clientName,
                          style: PrimeCareTheme.typography.h3.copyWith(
                            color: isCompleted
                                ? PrimeCareTheme.colors.onSurfaceVariant
                                : PrimeCareTheme.colors.onSurface,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          task,
                          style: PrimeCareTheme.typography.body.copyWith(
                            color: PrimeCareTheme.colors.onSurfaceVariant,
                            height: 1.5,
                          ),
                        ),
                        const SizedBox(height: 16),
                        Row(
                          children: [
                            Icon(
                              LucideIcons.mapPin,
                              size: 16,
                              color: PrimeCareTheme.colors.outline,
                            ),
                            const SizedBox(width: 8),
                            Text(
                              location,
                              style: PrimeCareTheme.typography.label.copyWith(
                                color: PrimeCareTheme.colors.outline,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 8,
                    ),
                    decoration: BoxDecoration(
                      color: isCompleted
                          ? PrimeCareTheme.colors.tertiary.withOpacity(0.1)
                          : PrimeCareTheme.colors.surfaceBright,
                      borderRadius: BorderRadius.circular(24),
                      border: Border.all(
                        color: isCompleted
                            ? PrimeCareTheme.colors.tertiary.withOpacity(0.3)
                            : PrimeCareTheme.colors.outlineVariant.withOpacity(
                                0.3,
                              ),
                      ),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        if (isCompleted) ...[
                          Icon(
                            LucideIcons.checkCircle,
                            size: 14,
                            color: PrimeCareTheme.colors.tertiary,
                          ),
                          const SizedBox(width: 6),
                        ] else ...[
                          Icon(
                            LucideIcons.clock,
                            size: 14,
                            color: PrimeCareTheme.colors.onSurface,
                          ),
                          const SizedBox(width: 6),
                        ],
                        Text(
                          status,
                          style: PrimeCareTheme.typography.label.copyWith(
                            color: isCompleted
                                ? PrimeCareTheme.colors.tertiary
                                : PrimeCareTheme.colors.onSurface,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
