import 'package:primecare_ui/primecare_ui.dart';
import 'system_monitoring_controller.dart';
import 'system_monitoring_model.dart';

class SystemMonitoringView extends GovernedConsumerWidget {
  const SystemMonitoringView({super.key});

  @override
  Widget buildScreen(BuildContext context, WidgetRef ref) {
    final theme = context.theme;
    final state = ref.watch(systemMonitoringControllerProvider);

    return Container(
      color: theme.colors.surfaceContainerLowest,
      child: _buildBody(context, ref, state, theme),
    );
  }

  Widget _buildBody(
    BuildContext context,
    WidgetRef ref,
    SystemMonitoringState state,
    PrimeThemeData theme,
  ) {
    if (state.isLoading) {
      return const EmptyState(
        title: 'Initializing Audit...',
        subtitle:
            'Synchronizing system telemetry with the governance registry.',
        icon: LucideIcons.loader2,
      );
    }

    if (state.error != null) {
      return EmptyState(
        title: 'Monitoring Sync Failed',
        subtitle: state.error!,
        icon: LucideIcons.cloudOff,
        actionLabel: 'Retry Connection',
        onAction: () => ref
            .read(systemMonitoringControllerProvider.notifier)
            .refreshMetrics(),
      );
    }

    if (state.metrics == null) {
      return const EmptyState(
        title: 'No Telemetry Data',
        subtitle:
            'Platform metrics are currently unavailable or being recalibrated.',
        icon: LucideIcons.activity,
      );
    }

    return SingleChildScrollView(
      padding: const EdgeInsets.all(32.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: theme.colors.primary.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(theme.radiusLg),
                ),
                child: Icon(
                  LucideIcons.activity,
                  color: theme.colors.primary,
                  size: 32,
                ),
              ),
              const SizedBox(width: 16),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Governance Monitoring', style: theme.typography.h1),
                  Text(
                    'Real-time audit of platform implementation status',
                    style: theme.typography.bodyLarge.copyWith(
                      color: theme.colors.onSurfaceVariant,
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 48),

          // Status Cards
          Row(
            children: [
              Expanded(
                child: _buildStatusSummaryCard(
                  theme,
                  'Implemented',
                  '142',
                  LucideIcons.checkCircle,
                  Colors.green,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: _buildStatusSummaryCard(
                  theme,
                  'Declared',
                  '85',
                  LucideIcons.fileSearch,
                  Colors.blue,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: _buildStatusSummaryCard(
                  theme,
                  'Not Implemented',
                  '22',
                  LucideIcons.xCircle,
                  Colors.red,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: _buildStatusSummaryCard(
                  theme,
                  'Stubbed',
                  '12',
                  LucideIcons.hammer,
                  Colors.orange,
                ),
              ),
            ],
          ),

          const SizedBox(height: 48),
          Text('Recent Implementation Activity', style: theme.typography.h2),
          const SizedBox(height: 16),
          Container(
            decoration: BoxDecoration(
              color: theme.colors.surface,
              borderRadius: BorderRadius.circular(theme.radiusLg),
              border: Border.all(color: theme.colors.outlineVariant),
            ),
            child: Column(
              children: [
                _buildActivityRow(
                  theme,
                  'SCREEN_CARE_PLAN',
                  'Care Angel',
                  'IMPLEMENTED',
                  '2 hours ago',
                  Colors.green,
                ),
                Divider(height: 1, color: theme.colors.outlineVariant),
                _buildActivityRow(
                  theme,
                  'SCREEN_BILLING_SUMMARY',
                  'Finance',
                  'STUBBED',
                  '5 hours ago',
                  Colors.orange,
                ),
                Divider(height: 1, color: theme.colors.outlineVariant),
                _buildActivityRow(
                  theme,
                  'SCREEN_PATIENT_VITALS',
                  'Doctor',
                  'IMPLEMENTED',
                  '1 day ago',
                  Colors.green,
                ),
                Divider(height: 1, color: theme.colors.outlineVariant),
                _buildActivityRow(
                  theme,
                  'SCREEN_PHARMACY_INTEGRATION',
                  'Compliance',
                  'DECLARED',
                  '2 days ago',
                  Colors.blue,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatusSummaryCard(
    PrimeThemeData theme,
    String label,
    String value,
    IconData icon,
    Color color,
  ) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: theme.colors.surface,
        borderRadius: BorderRadius.circular(theme.radiusLg),
        border: Border.all(color: theme.colors.outlineVariant),
        boxShadow: theme.shadowsSurface1,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: color, size: 28),
          const SizedBox(height: 16),
          Text(value, style: theme.typography.h1.copyWith(color: color)),
          const SizedBox(height: 4),
          Text(
            label,
            style: theme.typography.bodyMedium.copyWith(
              color: theme.colors.onSurfaceVariant,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActivityRow(
    PrimeThemeData theme,
    String screenId,
    String role,
    String status,
    String time,
    Color statusColor,
  ) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Row(
        children: [
          Container(
            width: 8,
            height: 40,
            decoration: BoxDecoration(
              color: statusColor,
              borderRadius: BorderRadius.circular(4),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  screenId,
                  style: theme.typography.bodyLarge.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  role,
                  style: theme.typography.bodySmall.copyWith(
                    color: theme.colors.onSurfaceVariant,
                  ),
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                status,
                style: theme.typography.bodySmall.copyWith(
                  color: statusColor,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 0.5,
                ),
              ),
              Text(
                time,
                style: theme.typography.bodySmall.copyWith(
                  color: theme.colors.onSurfaceVariant,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
