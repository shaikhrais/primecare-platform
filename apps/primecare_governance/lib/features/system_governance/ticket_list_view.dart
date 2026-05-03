import 'package:primecare_ui/primecare_ui.dart';
import '../../core/governance/ticket_registry.dart';

class TicketListView extends StatelessWidget {
  const TicketListView({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    final tickets = TicketRegistry.tickets;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Active Correction Tickets',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            Chip(
              label: Text('${tickets.length} Total'),
              backgroundColor: theme.colors.primary.withValues(alpha: 0.1),
              labelStyle: TextStyle(color: theme.colors.primary),
            ),
          ],
        ),
        const SizedBox(height: 24),
        ListView.separated(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: tickets.length,
          separatorBuilder: (_, _) => const SizedBox(height: 12),
          itemBuilder: (context, index) {
            final ticket = tickets[index];
            return ClinicalGlassPanel(
              padding: const EdgeInsets.all(16),
              child: ListTile(
                leading: _getSeverityIcon(ticket.severity, theme),
                title: Text(ticket.id, style: const TextStyle(fontWeight: FontWeight.bold)),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 4),
                    Text('Screen: ${ticket.screenId}', style: TextStyle(color: theme.colors.primary)),
                    const SizedBox(height: 4),
                    Text(ticket.description),
                  ],
                ),
                trailing: _getStatusChip(ticket.status, theme),
              ),
            );
          },
        ),
      ],
    );
  }

  Widget _getSeverityIcon(String severity, PrimeThemeData theme) {
    switch (severity) {
      case 'critical':
        return CircleAvatar(backgroundColor: Colors.red.withValues(alpha: 0.2), child: const Icon(Icons.emergency_rounded, color: Colors.red));
      case 'major':
        return CircleAvatar(backgroundColor: Colors.orange.withValues(alpha: 0.2), child: const Icon(Icons.warning_rounded, color: Colors.orange));
      default:
        return CircleAvatar(backgroundColor: theme.colors.primary.withValues(alpha: 0.2), child: Icon(Icons.info_rounded, color: theme.colors.primary));
    }
  }

  Widget _getStatusChip(String status, PrimeThemeData theme) {
    Color color = theme.colors.slateGray;
    if (status == 'open') color = Colors.blue;
    if (status == 'in_progress') color = Colors.orange;
    if (status == 'verified') color = Colors.green;

    return Chip(
      label: Text(status.toUpperCase(), style: const TextStyle(fontSize: 10, color: Colors.white)),
      backgroundColor: color,
    );
  }
}
