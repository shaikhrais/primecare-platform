// Layer: 05_UI_PRESENTATION
import 'package:primecare_ui/primecare_ui.dart';

/// A card tracking lead engagement from community outreach events.
class EventEngagementCard extends StatelessWidget {
  final AnalyticsChart chart;

  const EventEngagementCard({super.key, required this.chart});

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;

    return PrimeCareCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Community Engagement', style: theme.typography.h3),
                  Text(
                    'Lead generation trends across localized events',
                    style: theme.typography.labelMedium,
                  ),
                ],
              ),
              const Spacer(),
              PrimeCareButton(
                label: 'CALENDAR',
                type: PrimeCareButtonType.text,
                onPressed: () {},
                icon: LucideIcons.calendar,
              ),
            ],
          ),
          SizedBox(height: theme.spacing.lg),
          SizedBox(height: 250, child: PrimeCareBarChart(chart: chart)),
        ],
      ),
    );
  }
}

/// A grid showing impact and lead conversion for specific community partners.
class CommunityImpactGrid extends StatelessWidget {
  const CommunityImpactGrid({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;

    return PrimeCareCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Local Impact Analytics', style: theme.typography.h3),
          Text(
            'Community partner performance and referral quality',
            style: theme.typography.labelMedium,
          ),
          SizedBox(height: theme.spacing.lg),
          PrimeCareDataTable<Map<String, String>>(
            columns: const ['Partner', 'Type', 'Leads', 'Conversion'],
            rows: [
              _buildRow('St. Marys Senior Center', 'Non-Profit', '24', '18%'),
              _buildRow('Westside Library', 'Public', '12', '8%'),
              _buildRow('Local Rotary Club', 'Social', '8', '25%'),
            ],
          ),
        ],
      ),
    );
  }

  DataRow _buildRow(
    String partner,
    String type,
    String leads,
    String conversion,
  ) {
    return DataRow(
      cells: [
        DataCell(Text(partner)),
        DataCell(Text(type)),
        DataCell(
          Text(leads, style: TextStyle(fontWeight: FontWeight.bold)),
        ),
        DataCell(PrimeCareStatusBadge(label: conversion, type: BadgeType.info)),
      ],
    );
  }
}

/// Quick action hub for Outreach Coordinators.
class OutreachActionHub extends StatelessWidget {
  OutreachActionHub({super.key});

  @override
  Widget build(BuildContext context) {
    return PrimeCareQuickActionsGrid(
      actions: [
        PrimeCareActionItem(
          title: LocaleKeys.dashboards_common_labels_schedule_event.tr(),
          icon: LucideIcons.calendarPlus,
          route: '/events/new',
        ),
        PrimeCareActionItem(
          title: LocaleKeys.dashboards_common_labels_log_lead.tr(),
          icon: LucideIcons.userPlus,
          route: '/leads/log',
        ),
        PrimeCareActionItem(
          title: LocaleKeys.dashboards_common_labels_impact_report.tr(),
          icon: LucideIcons.fileBarChart,
          route: '/reports/impact',
        ),
      ],
    );
  }
}
