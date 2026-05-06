import 'package:primecare_ui/primecare_ui.dart';
import '../../core/governance/governance_provider.dart';
import '../../core/governance/ticket_registry.dart';
import '../../core/governance/correction_ticket.dart';

/// [View] - Correction Ticket Center
/// Centralized console for managing and remediating architectural drift and platform tickets.
class CorrectionTicketCenterView extends ConsumerWidget {
  const CorrectionTicketCenterView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = context.theme;
    final state = ref.watch(governanceProvider);

    return ClinicalGlassPanel(
      title: 'governance.ticket_center'.tr(),
      icon: Icons.confirmation_number_rounded,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildTicketStats(context, state),
          const SizedBox(height: 24),
          _buildTicketList(context, theme, ref),
        ],
      ),
    );
  }

  Widget _buildTicketStats(BuildContext context, GovernanceState state) {
    return Row(
      children: [
        _buildStatCard(context, 'Total Tickets', '${state.totalTickets}', Colors.blue),
        const SizedBox(width: 16),
        _buildStatCard(context, 'Open Drift', '${state.openTickets}', Colors.orange),
        const SizedBox(width: 16),
        _buildStatCard(context, 'Resolved', '${state.totalTickets - state.openTickets}', Colors.green),
      ],
    );
  }

  Widget _buildStatCard(BuildContext context, String label, String value, Color color) {
    final theme = context.theme;
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: color.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: color.withValues(alpha: 0.3)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(label, style: theme.typography.bodySmall.copyWith(color: color)),
            const SizedBox(height: 4),
            Text(
              value,
              style: theme.typography.titleLarge.copyWith(
                color: color,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTicketList(BuildContext context, PrimeThemeData theme, WidgetRef ref) {
    final tickets = TicketRegistry.tickets;

    return Container(
      decoration: BoxDecoration(
        color: theme.colors.background.withValues(alpha: 0.3),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: theme.colors.borderLight),
      ),
      child: Column(
        children: [
          _buildTableHeader(context, theme),
          const Divider(height: 1),
          if (tickets.isEmpty)
            const Padding(
              padding: EdgeInsets.all(32.0),
              child: Center(child: Text('No active correction tickets')),
            )
          else
            ...tickets.map((ticket) => _buildTicketRow(context, theme, ref, ticket)),
        ],
      ),
    );
  }

  Widget _buildTableHeader(BuildContext context, PrimeThemeData theme) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        children: [
          Expanded(flex: 2, child: Text('ID', style: theme.typography.bodySmall.copyWith(color: theme.colors.onSurfaceVariant))),
          Expanded(flex: 5, child: Text('Description', style: theme.typography.bodySmall.copyWith(color: theme.colors.onSurfaceVariant))),
          Expanded(flex: 2, child: Text('Severity', style: theme.typography.bodySmall.copyWith(color: theme.colors.onSurfaceVariant))),
          Expanded(flex: 2, child: Text('Status', style: theme.typography.bodySmall.copyWith(color: theme.colors.onSurfaceVariant))),
          Expanded(flex: 2, child: Text('Action', style: theme.typography.bodySmall.copyWith(color: theme.colors.onSurfaceVariant))),
        ],
      ),
    );
  }

  Widget _buildTicketRow(
    BuildContext context,
    PrimeThemeData theme,
    WidgetRef ref,
    CorrectionTicket ticket,
  ) {
    final priorityColor = _getPriorityColor(ticket.severity);
    final isResolved = ticket.status == 'verified' || ticket.status == 'closed';

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        children: [
          Expanded(flex: 2, child: Text(ticket.id, style: theme.typography.bodySmall.copyWith(fontWeight: FontWeight.bold))),
          Expanded(flex: 5, child: Text(ticket.description, style: theme.typography.bodySmall)),
          Expanded(
            flex: 2,
            child: Text(
              ticket.severity.toUpperCase(),
              style: theme.typography.bodySmall.copyWith(color: priorityColor, fontWeight: FontWeight.bold, fontSize: 10),
            ),
          ),
          Expanded(
            flex: 2,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: (isResolved ? Colors.green : Colors.orange).withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                ticket.status,
                textAlign: TextAlign.center,
                style: theme.typography.bodySmall.copyWith(
                  color: isResolved ? Colors.green : Colors.orange,
                  fontSize: 10,
                ),
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: isResolved
                ? const Icon(Icons.check_circle_rounded, color: Colors.green, size: 20)
                : TextButton(
                    onPressed: () {
                      ref.read(governanceProvider.notifier).runRemediation();
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Remediating ${ticket.id}...')),
                      );
                    },
                    child: Text('governance.remediate'.tr(), style: const TextStyle(fontSize: 12)),
                  ),
          ),
        ],
      ),
    );
  }

  Color _getPriorityColor(String priority) {
    switch (priority.toLowerCase()) {
      case 'critical':
        return Colors.red;
      case 'major':
        return Colors.orange;
      case 'minor':
        return Colors.blue;
      default:
        return Colors.grey;
    }
  }
}
