import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:primecare_v4/design_system/primecare_theme.dart';
import 'package:primecare_v4/design_system/clinical_glass.dart';
import 'package:primecare_v4/shared/components/page_template.dart';

class RmtTodaysScheduleScreen extends ConsumerWidget {
  const RmtTodaysScheduleScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return PageTemplate(
      title: 'Daily Schedule',
      subtitle: 'View and manage today\'s appointments and availability.',
      kpiCards: [
        KPICardData(
          title: 'Total Appointments',
          value: '6',
          icon: LucideIcons.calendar,
          trend: 0.0,
          trendLabel: 'today',
        ),
        KPICardData(
          title: 'Completed',
          value: '2',
          icon: LucideIcons.checkCircle,
          trend: 0.0,
          trendLabel: 'so far',
        ),
      ],
      sidebarContent: [
        ClinicalGlassPanel(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Status', style: PrimeCareTheme.typography.h3),
              const SizedBox(height: 16),
              _buildFilterRow('Completed', 2, PrimeCareTheme.colors.slateGray),
              _buildFilterRow('Upcoming', 4, PrimeCareTheme.colors.navyIndigo),
              _buildFilterRow('No Show', 0, PrimeCareTheme.colors.coralBlush),
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
                  Text('Schedule List', style: PrimeCareTheme.typography.h2),
                  ElevatedButton.icon(
                    onPressed: () {},
                    icon: const Icon(LucideIcons.calendarPlus),
                    label: const Text('Book Appointment'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: PrimeCareTheme.colors.navyIndigo,
                      foregroundColor: Colors.white,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              _buildScheduleItem(
                '09:00 AM',
                '10:00 AM',
                'Sarah Connor',
                '60 Min Initial Assessment',
                'Completed',
                PrimeCareTheme.colors.slateGray,
              ),
              _buildScheduleItem(
                '10:15 AM',
                '11:15 AM',
                'Tricia McMillan',
                '60 Min Massage Therapy',
                'Completed',
                PrimeCareTheme.colors.slateGray,
              ),
              _buildScheduleItem(
                '11:30 AM',
                '12:30 PM',
                'Isaac Newton',
                '60 Min Massage Therapy',
                'Upcoming',
                PrimeCareTheme.colors.navyIndigo,
              ),
              _buildScheduleItem(
                '01:30 PM',
                '02:30 PM',
                'Maria Garcia',
                '60 Min Massage Therapy',
                'Upcoming',
                PrimeCareTheme.colors.navyIndigo,
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
                decoration: BoxDecoration(color: color, shape: BoxShape.circle),
              ),
              const SizedBox(width: 8),
              Text(label, style: PrimeCareTheme.typography.body),
            ],
          ),
          Text(
            count.toString(),
            style: PrimeCareTheme.typography.label.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildScheduleItem(
    String start,
    String end,
    String client,
    String type,
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
            width: 100,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(start, style: PrimeCareTheme.typography.h3),
                Text(
                  end,
                  style: PrimeCareTheme.typography.label.copyWith(
                    color: PrimeCareTheme.colors.slateGray,
                  ),
                ),
              ],
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
                Text(
                  type,
                  style: PrimeCareTheme.typography.body.copyWith(
                    color: status == 'Completed'
                        ? PrimeCareTheme.colors.slateGray
                        : PrimeCareTheme.colors.textPrimary,
                  ),
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
