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
      title: 'Today\'s Clinical Schedule',
      subtitle: 'Your assigned patient interactions and procedures for the day.',
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
          title: 'Missed',
          value: '0',
          icon: LucideIcons.alertTriangle,
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
              Text('Schedule Filters', style: PrimeCareTheme.typography.h3),
              const SizedBox(height: 16),
              _buildFilterRow('Medication Pass', 6, PrimeCareTheme.colors.navyIndigo),
              _buildFilterRow('Wound Care', 3, PrimeCareTheme.colors.emeraldTeal),
              _buildFilterRow('Vitals / Routine', 5, PrimeCareTheme.colors.lavenderLustre),
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
                   Text('Upcoming Events', style: PrimeCareTheme.typography.h2),
                   OutlinedButton.icon(
                    onPressed: () {},
                    icon: const Icon(LucideIcons.printer),
                    label: const Text('Print Schedule'),
                  ),
                 ],
               ),
               const SizedBox(height: 24),
               _buildScheduleItem(
                 '14:00',
                 'Maria Garcia',
                 'Wound Care - Dressing Change',
                 'Room 201-A',
                 PrimeCareTheme.colors.emeraldTeal,
                 'Next'
               ),
               _buildScheduleItem(
                 '15:00',
                 'John Smith',
                 'Medication Pass - PRN Review',
                 'Room 204-B',
                 PrimeCareTheme.colors.navyIndigo,
                 'Scheduled'
               ),
                _buildScheduleItem(
                 '16:30',
                 'Eleanor Rigby',
                 'Vitals - Comprehensive Check',
                 'Room 205-A',
                 PrimeCareTheme.colors.lavenderLustre,
                 'Scheduled'
               ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildFilterRow(String label, int count, Color color) {
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
                decoration: BoxDecoration(
                  color: color,
                  shape: BoxShape.circle,
                ),
              ),
              const SizedBox(width: 8),
              Text(label, style: PrimeCareTheme.typography.body),
            ],
          ),
          Text(count.toString(), style: PrimeCareTheme.typography.label.copyWith(fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }

  Widget _buildScheduleItem(String time, String clientName, String task, String location, Color themeColor, String status) {
     return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: PrimeCareTheme.colors.surfaceContainerHighest.withOpacity(0.3),
        borderRadius: BorderRadius.circular(16),
        border: Border(left: BorderSide(color: themeColor, width: 4)),
      ),
      child: Row(
        children: [
           SizedBox(
             width: 60,
             child: Text(time, style: PrimeCareTheme.typography.h3.copyWith(color: themeColor)),
           ),
           Container(
             width: 1,
             height: 40,
             color: PrimeCareTheme.colors.slateGray.withOpacity(0.3),
             margin: const EdgeInsets.symmetric(horizontal: 16),
           ),
           Expanded(
             child: Column(
               crossAxisAlignment: CrossAxisAlignment.start,
               children: [
                  Text(clientName, style: PrimeCareTheme.typography.h3),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      Text(task, style: PrimeCareTheme.typography.body),
                      const SizedBox(width: 8),
                      Text('•', style: TextStyle(color: PrimeCareTheme.colors.slateGray)),
                      const SizedBox(width: 8),
                      Text(location, style: PrimeCareTheme.typography.body.copyWith(color: PrimeCareTheme.colors.slateGray)),
                    ],
                  )
               ],
             )
           ),
           Container(
             padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
             decoration: BoxDecoration(
               color: status == 'Next' ? themeColor.withOpacity(0.1) : PrimeCareTheme.colors.slateGray.withOpacity(0.1),
               borderRadius: BorderRadius.circular(20),
             ),
             child: Text(status, style: PrimeCareTheme.typography.label.copyWith(
               color: status == 'Next' ? themeColor : PrimeCareTheme.colors.slateGray,
               fontWeight: FontWeight.bold
             )),
           )
        ],
      )
     );
  }
}
