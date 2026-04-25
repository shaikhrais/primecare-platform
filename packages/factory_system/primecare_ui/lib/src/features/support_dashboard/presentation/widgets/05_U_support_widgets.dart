// Layer: 05_UI_PRESENTATION
import 'package:primecare_ui/primecare_ui.dart';

/// A heatmap showing support ticket velocity and resolution efficiency.
class SupportVelocityHeatmap extends StatelessWidget {
  final AnalyticsChart chart;

  const SupportVelocityHeatmap({super.key, required this.chart});

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
                  Text('Ticket Velocity Index', style: theme.typography.h3),
                  Text(
                    'Real-time tracking of support volume and resolution speed',
                    style: theme.typography.labelMedium,
                  ),
                ],
              ),
              const Spacer(),
              PrimeCareStatusBadge(
                label: '98% RESOLUTION',
                type: BadgeType.success,
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

/// A grid tracking customer satisfaction and support performance metrics.
class SatisfactionMatrixGrid extends StatelessWidget {
  const SatisfactionMatrixGrid({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;

    return PrimeCareCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Satisfaction Matrix', style: theme.typography.h3),
          Text(
            'Enterprise-wide CSAT scores and feedback trends',
            style: theme.typography.labelMedium,
          ),
          SizedBox(height: theme.spacing.lg),
          PrimeCareDataTable<Map<String, String>>(
            columns: const ['Domain', 'CSAT', 'SLA', 'Status'],
            rows: [
              _buildRow('Billing', '4.9/5', '100%', 'SUCCESS'),
              _buildRow('Clinical', '4.8/5', '98%', 'SUCCESS'),
              _buildRow('Platform', '4.5/5', '95%', 'INFO'),
              _buildRow('Onboarding', '4.9/5', '100%', 'SUCCESS'),
            ],
          ),
        ],
      ),
    );
  }

  DataRow _buildRow(String domain, String csat, String sla, String status) {
    return DataRow(
      cells: [
        DataCell(Text(domain)),
        DataCell(
          Text(csat, style: const TextStyle(fontWeight: FontWeight.bold)),
        ),
        DataCell(Text(sla)),
        DataCell(
          PrimeCareStatusBadge(
            label: status,
            type: status == 'SUCCESS' ? BadgeType.success : BadgeType.info,
          ),
        ),
      ],
    );
  }
}

/// Support action hub for the Support Manager.
class SupportActionHub extends StatelessWidget {
  const SupportActionHub({super.key});

  @override
  Widget build(BuildContext context) {
    return PrimeCareQuickActionsGrid(
      actions: const [
        PrimeCareActionItem(
          title: 'Review Queue',
          icon: LucideIcons.list,
          route: '/support/queue',
        ),
        PrimeCareActionItem(
          title: 'Log Ticket',
          icon: LucideIcons.plusCircle,
          route: '/support/ticket/new',
        ),
        PrimeCareActionItem(
          title: 'CSAT Report',
          icon: LucideIcons.star,
          route: '/support/csat',
        ),
        PrimeCareActionItem(
          title: 'SLA Tracking',
          icon: LucideIcons.clock,
          route: '/support/sla',
        ),
      ],
    );
  }
}
