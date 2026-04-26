// Layer: 05_UI_PRESENTATION
import 'package:primecare_ui/primecare_ui.dart';

class RegionalTicketLoadCard extends StatelessWidget {
  const RegionalTicketLoadCard({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    return PrimeCareCard(
      padding: EdgeInsets.all(theme.spacing.lg),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Regional Ticket Load', style: theme.typography.h4),
          SizedBox(height: theme.spacing.md),
          _buildQueueRow(context, 'Ontario North', 0.82, theme.colors.error),
          _buildQueueRow(context, 'BC Clinical', 0.54, theme.colors.warning),
          _buildQueueRow(
            context,
            'Alberta Support',
            0.31,
            theme.colors.success,
          ),
          _buildQueueRow(
            context,
            'Quebec Expansion',
            0.94,
            theme.colors.secondary,
          ),
        ],
      ),
    );
  }

  Widget _buildQueueRow(
    BuildContext context,
    String name,
    double load,
    Color color,
  ) {
    final theme = context.theme;
    return Padding(
      padding: EdgeInsets.symmetric(vertical: theme.spacing.xs),
      child: Column(
        children: [
          Row(
            children: [
              Text(
                name,
                style: theme.typography.bodyLarge.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
              const Spacer(),
              Text(
                '${(load * 100).toInt()}% Capacity',
                style: theme.typography.labelSmall,
              ),
            ],
          ),
          SizedBox(height: theme.spacing.xs),
          LinearProgressIndicator(
            value: load,
            backgroundColor: theme.colors.surfaceContainerHighest,
            color: color,
            minHeight: 8,
            borderRadius: BorderRadius.circular(4),
          ),
        ],
      ),
    );
  }
}

class SlaStatusCard extends StatelessWidget {
  const SlaStatusCard({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    return PrimeCareCard(
      padding: EdgeInsets.all(theme.spacing.lg),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('SLA Status (Last 24h)', style: theme.typography.h4),
          SizedBox(height: theme.spacing.md),
          _buildSlaItem(
            context,
            'First Response',
            '< 15m',
            LucideIcons.timer,
            theme.colors.success,
          ),
          const Divider(height: 24),
          _buildSlaItem(
            context,
            'Critical Resolution',
            '< 2h',
            LucideIcons.zap,
            theme.colors.warning,
          ),
          const Divider(height: 24),
          _buildSlaItem(
            context,
            'Standard Tickets',
            '< 24h',
            LucideIcons.checkCircle,
            theme.colors.success,
          ),
        ],
      ),
    );
  }

  Widget _buildSlaItem(
    BuildContext context,
    String title,
    String value,
    IconData icon,
    Color color,
  ) {
    final theme = context.theme;
    return Row(
      children: [
        PrimeCareIcon(icon, color: color, size: 20),
        SizedBox(width: theme.spacing.sm),
        Expanded(child: Text(title, style: theme.typography.bodyLarge)),
        Text(value, style: theme.typography.h4.copyWith(color: color)),
      ],
    );
  }
}

class LiveTicketQueueTable extends StatelessWidget {
  const LiveTicketQueueTable({super.key});

  @override
  Widget build(BuildContext context) {
    return PrimeCareDataTable<dynamic>(
      columns: const ['ID', 'Subject', 'User', 'Priority', 'SLA'],
      rows:
          [
                [
                  '#8421',
                  'Billing Error: Ontario North',
                  'Sarah Jenkins',
                  'Critical',
                  '12m left',
                ],
                [
                  '#8419',
                  'Login Loop in Mobile App',
                  'Robert Chen',
                  'High',
                  '45m left',
                ],
                [
                  '#8415',
                  'Franchise Portal Permissions',
                  'Mike Ross',
                  'Medium',
                  '4h left',
                ],
                [
                  '#8412',
                  'Documentation Sync Issue',
                  'Elena Gilbert',
                  'Low',
                  '1d left',
                ],
              ]
              .map(
                (row) => DataRow(
                  cells: row.map((cell) => DataCell(Text(cell))).toList(),
                ),
              )
              .toList(),
    );
  }
}
