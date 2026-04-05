import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../office/components/glass_surface.dart';
import '../../../../office/components/kpi_stat_card.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../providers/dashboard_providers.dart';

class TicketsView extends ConsumerWidget {
  const TicketsView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final metricsAsync = ref.watch(dashboardMetricsProvider);

    return metricsAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, stack) => Center(child: Text('Error: $err')),
        data: (metrics) => SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // TICKET TRIAGE SUMMARY
              Row(
                children: [
                  Expanded(child: KpiStatCard(title: 'Active Tickets', value: '142', icon: Icons.support_agent, iconColor: Colors.teal, subtitle: '8 High Priority')),
                  const SizedBox(width: 16),
                  Expanded(child: KpiStatCard(title: 'Escalations', value: '3', icon: Icons.warning_amber, iconColor: Colors.red, subtitle: 'Awaiting Action')),
                  const SizedBox(width: 16),
                  Expanded(child: KpiStatCard(title: 'Satisfaction', value: '98%', icon: Icons.stars, iconColor: Colors.orange, subtitle: 'Q3 Average')),
                ],
              ),

              const SizedBox(height: 32),

              // TICKET QUEUE
              Text('Incident Triage Queue', style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold, fontFamily: 'Outfit')),
              const SizedBox(height: 16),
              GlassSurface(
                padding: const EdgeInsets.all(0),
                child: Column(
                  children: [
                    _buildTicketItem(context, 'TCK-2041', 'Arthur Dent', 'Medication Delivery Delay', 'URGENT', '12m ago', Colors.red),
                    const Divider(height: 1, thickness: 0.1, color: Colors.blueGrey),
                    _buildTicketItem(context, 'TCK-2042', 'Ford Prefect', 'Billing inquiry: Extra hour', 'PENDING', '2h ago', Colors.orange),
                    const Divider(height: 1, thickness: 0.1, color: Colors.blueGrey),
                    _buildTicketItem(context, 'TCK-2043', 'Tricia McMillan', 'Access to Health Portal', 'OPEN', '5h ago', Colors.teal),
                  ],
                ),
              ),

              const SizedBox(height: 32),

              // ACTION TEMPLATES
              Text('Resolution Quick-Actions', style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold, fontFamily: 'Outfit')),
              const SizedBox(height: 16),
              Wrap(
                spacing: 12,
                runSpacing: 12,
                children: [
                  _buildActionChip(Icons.email_outlined, 'Send Resolution Email'),
                  _buildActionChip(Icons.phone_outlined, 'Initiate Call-back'),
                  _buildActionChip(Icons.escalator_warning_outlined, 'Escalate to Clinical'),
                  _buildActionChip(Icons.history_edu_outlined, 'Clinical Note Sync'),
                ],
              ),
              const SizedBox(height: 32),
            ],
          ),
        ),
      );
  }

  Widget _buildTicketItem(BuildContext context, String id, String user, String subject, String status, String time, Color statusColor) {
    return ListTile(key: const Key('data-status-id=support-customer-tickets-action-1'), onTap: () => ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Viewing ticket $id'))),
      contentPadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
      leading: CircleAvatar(
        backgroundColor: statusColor.withValues(alpha: 0.1),
        child: Text(id.substring(4), style: TextStyle(color: statusColor, fontWeight: FontWeight.bold, fontSize: 12)),
      ),
      title: Row(
        children: [
          Text(user, style: const TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(width: 8),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
            decoration: BoxDecoration(color: statusColor.withValues(alpha: 0.1), borderRadius: BorderRadius.circular(4)),
            child: Text(status, style: TextStyle(color: statusColor, fontWeight: FontWeight.bold, fontSize: 9)),
          ),
        ],
      ),
      subtitle: Text(subject, style: const TextStyle(color: Colors.blueGrey, fontSize: 13)),
      trailing: Text(time, style: const TextStyle(color: Colors.blueGrey, fontSize: 12)),
    );
  }

  Widget _buildActionChip(IconData icon, String label) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.5),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.blueGrey.withValues(alpha: 0.05)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 18, color: AppTheme.primary),
          const SizedBox(width: 12),
          Text(label, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 13)),
        ],
      ),
    );
  }
}
