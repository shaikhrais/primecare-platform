import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:primecare_v4/design_system/primecare_theme.dart';
import 'package:primecare_v4/design_system/clinical_glass.dart';
import 'package:primecare_v4/shared/components/page_template.dart';

class TodaysScheduleScreen extends ConsumerWidget {
  const TodaysScheduleScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return PageTemplate(
      title: 'Today\'s Schedule',
      subtitle: 'Manage and prioritize your daily clinical visits.',
      kpiCards: [
        KPICardData(
          title: 'Total Visits',
          value: '6',
          icon: LucideIcons.calendar,
          trend: 0.0,
          trendLabel: 'scheduled for today',
        ),
        KPICardData(
          title: 'Completed',
          value: '2',
          icon: LucideIcons.checkCircle,
          trend: 33.3,
          trendLabel: 'progress',
        ),
        KPICardData(
          title: 'High Priority',
          value: '1',
          icon: LucideIcons.alertCircle,
          trend: 0.0,
          trendLabel: 'requires immediate attention',
        ),
      ],
      sidebarContent: [
        ClinicalGlassPanel(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Schedule Overview', style: PrimeCareTheme.typography.h3),
              const SizedBox(height: 16),
              _buildOverviewRow(
                'Morning Block',
                '2 / 3 completed',
                PrimeCareTheme.colors.emeraldTeal,
              ),
              _buildOverviewRow(
                'Afternoon Block',
                '0 / 2 completed',
                PrimeCareTheme.colors.coralRed,
              ),
              _buildOverviewRow(
                'Evening Block',
                '0 / 1 completed',
                PrimeCareTheme.colors.slateGray,
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
              Text('Upcoming Visits', style: PrimeCareTheme.typography.h2),
              const SizedBox(height: 24),
              _buildVisitCard(
                '11:00 AM - 12:00 PM',
                'Eleanor Rigby',
                'Wound dressing change (left hip), pain assessment, mobility check.',
                PrimeCareTheme.colors.navyIndigo,
                'In Progress',
              ),
              _buildVisitCard(
                '1:00 PM - 2:00 PM',
                'John Smith',
                'Medication reconciliation, vital signs, diabetic foot check.',
                PrimeCareTheme.colors.coralRed,
                'Next Visit',
              ),
              _buildVisitCard(
                '3:00 PM - 4:00 PM',
                'Maria Garcia',
                'Routine assessment, blood pressure monitoring, education on new meds.',
                PrimeCareTheme.colors.slateGray,
                'Scheduled',
              ),
              const SizedBox(height: 32),
              Text('Completed Visits', style: PrimeCareTheme.typography.h3),
              const SizedBox(height: 16),
              _buildVisitCard(
                '8:00 AM - 9:00 AM',
                'William Davis',
                'Morning vitals, insulin administration, breakfast assistance check.',
                PrimeCareTheme.colors.emeraldTeal,
                'Completed',
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildOverviewRow(String label, String status, Color color) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Container(
                width: 12,
                height: 12,
                decoration: BoxDecoration(color: color, shape: BoxShape.circle),
              ),
              const SizedBox(width: 8),
              Text(label, style: PrimeCareTheme.typography.body),
            ],
          ),
          Text(status, style: PrimeCareTheme.typography.label),
        ],
      ),
    );
  }

  Widget _buildVisitCard(
    String time,
    String clientName,
    String reason,
    Color statusColor,
    String statusLabel,
  ) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: PrimeCareTheme.colors.surfaceContainerHighest.withOpacity(0.3),
        borderRadius: BorderRadius.circular(16),
        border: Border(left: BorderSide(color: statusColor, width: 4)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                time,
                style: PrimeCareTheme.typography.label.copyWith(
                  color: PrimeCareTheme.colors.navyIndigo,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  color: statusColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Text(
                  statusLabel,
                  style: PrimeCareTheme.typography.label.copyWith(
                    color: statusColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(clientName, style: PrimeCareTheme.typography.h3),
          const SizedBox(height: 8),
          Text(reason, style: PrimeCareTheme.typography.body),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextButton(
                onPressed: () {},
                style: TextButton.styleFrom(
                  foregroundColor: PrimeCareTheme.colors.navyIndigo,
                ),
                child: const Text('View Client Profile'),
              ),
              const SizedBox(width: 8),
              ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: PrimeCareTheme.colors.navyIndigo,
                  foregroundColor: Colors.white,
                ),
                child: const Text('Start Visit'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
