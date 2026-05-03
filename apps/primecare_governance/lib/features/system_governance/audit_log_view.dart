import 'package:primecare_ui/primecare_ui.dart';
import '../../core/governance/governance_provider.dart';

/// [View] - Audit Log Monitoring Console
/// Provides high-fidelity visibility into system-wide mutations and security events.
class AuditLogView extends ConsumerWidget {
  const AuditLogView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = context.theme;
    final state = ref.watch(governanceProvider);

    return ClinicalGlassPanel(
      title: 'governance.audit_log_viewer'.tr(),
      icon: Icons.history_edu_rounded,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildFilters(context, theme),
          const SizedBox(height: 24),
          _buildAuditTable(context, theme, state.recentEvents),
        ],
      ),
    );
  }

  Widget _buildFilters(BuildContext context, PrimeThemeData theme) {
    return Row(
      children: [
        Expanded(
          child: TextField(
            decoration: InputDecoration(
              hintText: 'Search audit events...',
              prefixIcon: const Icon(Icons.search),
              filled: true,
              fillColor: theme.colors.background.withValues(alpha: 0.5),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: theme.colors.borderLight),
              ),
            ),
          ),
        ),
        const SizedBox(width: 16),
        _buildFilterChip(context, 'Security', Icons.security_rounded, true),
        const SizedBox(width: 8),
        _buildFilterChip(context, 'Mutation', Icons.edit_note_rounded, false),
        const SizedBox(width: 8),
        _buildFilterChip(context, 'Access', Icons.vpn_key_rounded, false),
      ],
    );
  }

  Widget _buildFilterChip(BuildContext context, String label, IconData icon, bool selected) {
    final theme = context.theme;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: selected ? theme.colors.primary.withValues(alpha: 0.1) : Colors.transparent,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: selected ? theme.colors.primary : theme.colors.borderLight,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 16, color: selected ? theme.colors.primary : theme.colors.slateGray),
          const SizedBox(width: 8),
          Text(
            label,
            style: theme.typography.labelMedium.copyWith(
              color: selected ? theme.colors.primary : theme.colors.slateGray,
              fontWeight: selected ? FontWeight.bold : FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAuditTable(BuildContext context, PrimeThemeData theme, List<GovernanceEvent> events) {
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
          if (events.isEmpty)
            const Padding(
              padding: EdgeInsets.all(32.0),
              child: Center(child: Text('No events found')),
            )
          else
            ...events.map((event) => _buildAuditRow(context, theme, event)),
        ],
      ),
    );
  }

  Widget _buildTableHeader(BuildContext context, PrimeThemeData theme) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        children: [
          Expanded(flex: 2, child: Text('Timestamp', style: theme.typography.labelSmall.copyWith(color: theme.colors.slateGray))),
          Expanded(flex: 2, child: Text('Type', style: theme.typography.labelSmall.copyWith(color: theme.colors.slateGray))),
          Expanded(flex: 2, child: Text('Level', style: theme.typography.labelSmall.copyWith(color: theme.colors.slateGray))),
          Expanded(flex: 6, child: Text('Message', style: theme.typography.labelSmall.copyWith(color: theme.colors.slateGray))),
        ],
      ),
    );
  }

  Widget _buildAuditRow(
    BuildContext context,
    PrimeThemeData theme,
    GovernanceEvent event,
  ) {
    final statusColor = (event.level == GovernanceEventLevel.error || event.level == GovernanceEventLevel.critical)
        ? Colors.red 
        : (event.level == GovernanceEventLevel.warning ? Colors.orange : Colors.green);

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        children: [
          Expanded(flex: 2, child: Text(event.timestamp.toString().substring(11, 19), style: theme.typography.bodySmall)),
          Expanded(flex: 2, child: Text(event.type, style: theme.typography.bodySmall.copyWith(fontWeight: FontWeight.bold))),
          Expanded(
            flex: 2,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: statusColor.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                event.level.name.toUpperCase(),
                textAlign: TextAlign.center,
                style: theme.typography.labelSmall.copyWith(color: statusColor, fontSize: 10),
              ),
            ),
          ),
          Expanded(flex: 6, child: Text(event.message, style: theme.typography.bodySmall)),
        ],
      ),
    );
  }
}
