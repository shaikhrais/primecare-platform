import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:primecare_v4/design_system/primecare_theme.dart';
import 'package:primecare_v4/design_system/clinical_glass.dart';
import 'package:primecare_v4/shared/components/page_template.dart';

class PswDashboard extends ConsumerWidget {
  const PswDashboard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return PageTemplate(
      title: 'PSW Daily Care Portal',
      subtitle: 'Coordinating daily living support and specialized home care cycles.',
      kpiCards: [
        KPICardData(
          title: 'Upcoming Visits',
          value: '4',
          icon: LucideIcons.calendarClock,
          trend: 0.0,
          trendLabel: 'today',
        ),
        KPICardData(
          title: 'Hours Logged',
          value: '3.5',
          icon: LucideIcons.timer,
          trend: 0.0,
          trendLabel: 'this shift',
        ),
        KPICardData(
          title: 'Pending Logs',
          value: '2',
          icon: LucideIcons.fileText,
          trend: 0.0,
          trendLabel: 'action needed',
        ),
      ],
      sidebarContent: [
        ClinicalGlassPanel(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text('Quick Actions', style: PrimeCareTheme.typography.h3),
              const SizedBox(height: 16),
              ElevatedButton.icon(
                onPressed: () {},
                icon: const Icon(LucideIcons.playCircle),
                label: const Text('Clock In (Next Visit)'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: PrimeCareTheme.colors.emeraldTeal,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
              ),
              const SizedBox(height: 12),
              OutlinedButton.icon(
                onPressed: () {},
                icon: const Icon(LucideIcons.map),
                label: const Text('View Route Map'),
                style: OutlinedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
              ),
              const SizedBox(height: 12),
              OutlinedButton.icon(
                onPressed: () {},
                icon: const Icon(LucideIcons.alertTriangle),
                label: const Text('Report Incident'),
                style: OutlinedButton.styleFrom(
                  foregroundColor: PrimeCareTheme.colors.brickRed,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
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
              Text('Today\'s Schedule', style: PrimeCareTheme.typography.h2),
              const SizedBox(height: 24),
              _buildScheduleItem(
                '09:00 AM - 11:00 AM',
                'Morning Care & ADLs',
                'Sonia Sotomayor • 123 Main St',
                'Completed',
                PrimeCareTheme.colors.slateGray,
              ),
              _buildScheduleItem(
                '11:30 AM - 01:00 PM',
                'Lunch Prep & Med Check',
                'Thurgood Marshall • 456 Oak Ave',
                'In Progress',
                PrimeCareTheme.colors.emeraldTeal,
              ),
              _buildScheduleItem(
                '02:00 PM - 05:00 PM',
                'Afternoon Companionship',
                'Elena Kagan • 789 Pine Ln',
                'Upcoming',
                PrimeCareTheme.colors.navyIndigo,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildScheduleItem(
    String time,
    String task,
    String patientInfo,
    String status,
    Color themeColor,
  ) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: status == 'Completed'
            ? PrimeCareTheme.colors.surfaceContainerHighest.withOpacity(0.1)
            : PrimeCareTheme.colors.surfaceContainerHighest.withOpacity(0.5),
        borderRadius: BorderRadius.circular(16),
        border: Border(left: BorderSide(color: themeColor, width: 4)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 120,
            child: Text(
              time,
              style: PrimeCareTheme.typography.h3.copyWith(fontSize: 14),
            ),
          ),
          Container(
            width: 2,
            height: 48,
            color: PrimeCareTheme.colors.surfaceContainerHighest,
            margin: const EdgeInsets.symmetric(horizontal: 16),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  task,
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
                      LucideIcons.user,
                      size: 14,
                      color: PrimeCareTheme.colors.slateGray,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      patientInfo,
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
              color: themeColor.withOpacity(0.1),
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
