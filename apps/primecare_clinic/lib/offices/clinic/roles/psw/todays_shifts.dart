import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:primecare_v4/design_system/primecare_theme.dart';
import 'package:primecare_v4/design_system/clinical_glass.dart';
import 'package:primecare_v4/shared/components/page_template.dart';

class PswTodaysShiftsScreen extends ConsumerWidget {
  const PswTodaysShiftsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return PageTemplate(
      title: 'Today\'s Shifts',
      subtitle: 'Overview of your scheduled hours and locations for the day.',
      kpiCards: [
        KPICardData(
          title: 'Scheduled Hours',
          value: '7.5',
          icon: LucideIcons.clock,
          trend: 0.0,
          trendLabel: 'today',
        ),
        KPICardData(
          title: 'Total Visits',
          value: '4',
          icon: LucideIcons.mapPin,
          trend: 0.0,
          trendLabel: 'today',
        ),
      ],
      sidebarContent: [
        ClinicalGlassPanel(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Shift Info', style: PrimeCareTheme.typography.h3),
              const SizedBox(height: 16),
              Row(
                children: [
                  Icon(
                    LucideIcons.calendar,
                    size: 20,
                    color: PrimeCareTheme.colors.navyIndigo,
                  ),
                  const SizedBox(width: 8),
                  Text('May 14, 2024', style: PrimeCareTheme.typography.body),
                ],
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  Icon(
                    LucideIcons.car,
                    size: 20,
                    color: PrimeCareTheme.colors.emeraldTeal,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    'Est. Drive: 45 min',
                    style: PrimeCareTheme.typography.body,
                  ),
                ],
              ),
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
                  Text('Shift Timeline', style: PrimeCareTheme.typography.h2),
                  ElevatedButton.icon(
                    onPressed: () {},
                    icon: const Icon(LucideIcons.map),
                    label: const Text('View Route Map'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: PrimeCareTheme.colors.navyIndigo,
                      foregroundColor: Colors.white,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              _buildShiftItem(
                '09:00 AM - 11:00 AM',
                'Sonia Sotomayor',
                'Home Visit • 123 Main St',
                'Completed',
                PrimeCareTheme.colors.slateGray,
              ),
              _buildShiftItem(
                '11:30 AM - 01:00 PM',
                'Thurgood Marshall',
                'Home Visit • 456 Oak Ave',
                'In Progress',
                PrimeCareTheme.colors.emeraldTeal,
              ),
              _buildShiftItem(
                '02:00 PM - 05:00 PM',
                'Elena Kagan',
                'Home Visit • 789 Pine Ln',
                'Upcoming',
                PrimeCareTheme.colors.navyIndigo,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildShiftItem(
    String time,
    String client,
    String location,
    String status,
    Color themeColor,
  ) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: status == 'Completed'
            ? PrimeCareTheme.colors.surfaceContainerHighest.withOpacity(0.1)
            : PrimeCareTheme.colors.surfaceContainerHighest.withOpacity(0.3),
        borderRadius: BorderRadius.circular(16),
        border: Border(left: BorderSide(color: themeColor, width: 4)),
      ),
      child: Row(
        children: [
          SizedBox(
            width: 140,
            child: Text(
              time,
              style: PrimeCareTheme.typography.h3.copyWith(fontSize: 14),
            ),
          ),
          Container(
            width: 2,
            height: 40,
            color: PrimeCareTheme.colors.surfaceContainerHighest,
            margin: const EdgeInsets.symmetric(horizontal: 16),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  client,
                  style: PrimeCareTheme.typography.h3.copyWith(
                    color: status == 'Completed'
                        ? PrimeCareTheme.colors.slateGray
                        : PrimeCareTheme.colors.textPrimary,
                  ),
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    Icon(
                      LucideIcons.mapPin,
                      size: 14,
                      color: PrimeCareTheme.colors.slateGray,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      location,
                      style: PrimeCareTheme.typography.body.copyWith(
                        color: PrimeCareTheme.colors.slateGray,
                      ),
                    ),
                  ],
                ),
              ],
            ),
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
