// Layer: 05_UI_PRESENTATION
import 'package:primecare_ui/primecare_ui.dart';

class ArchitecturePlanningDashboardScreen extends ConsumerWidget {
  const ArchitecturePlanningDashboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = context.theme;
    final state = ref.watch(architecturePlanningDashboardAdapterProvider);

    return MasterLayout(
      child: state.whenResult(
        (vm) => _buildContent(context, theme, vm, ref),
        onRetry: () =>
            ref.refresh(architecturePlanningDashboardAdapterProvider),
      ),
    );
  }

  Widget _buildContent(
    BuildContext context,
    PrimeCareThemeData theme,
    ArchitecturePlanningViewModel vm,
    WidgetRef ref,
  ) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(theme.spacing.lg),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Architecture Planning', style: theme.typography.h2),
          Text(
            'Governance & Infrastructure Integrity',
            style: theme.typography.bodyLarge,
          ),
          SizedBox(height: theme.spacing.xl),
          // Main Telemetry Area
          Expanded(
            flex: 2,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Architecture Planning', style: theme.typography.h2),
                Text(
                  'Governance & Infrastructure Integrity',
                  style: theme.typography.bodyLarge,
                ),
                SizedBox(height: theme.spacing.xl),
                PrimeCareResponsiveKpiGrid(metrics: vm.metrics),
                SizedBox(height: theme.spacing.xl),
                if (vm.metrics.charts.isNotEmpty)
                  PrimeCareCard(
                    title: vm.metrics.charts.first.title,
                    child: SizedBox(
                      height: 300,
                      child: PrimeCareLineChart(chart: vm.metrics.charts.first),
                    ),
                  ),
                SizedBox(height: theme.spacing.xl),
                PrimeCareCard(
                  title: 'Topology Verification Feed',
                  child: Column(
                    children: vm.metrics.recentActivity
                        .map(
                          (activity) => ListTile(
                            leading: Icon(
                              _getIconForActivity(activity.icon),
                              color: _getColorForActivity(
                                activity.color,
                                theme,
                              ),
                            ),
                            title: Text(
                              activity.title,
                              style: theme.typography.bodyLarge,
                            ),
                            subtitle: Text(activity.subtitle),
                            trailing: Text(activity.timestamp),
                          ),
                        )
                        .toList(),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(width: theme.spacing.xl),
          // Aura Intelligence Column
          Expanded(flex: 1, child: const SizedBox.shrink()),
        ],
      ),
    );
  }

  IconData _getIconForActivity(String icon) {
    switch (icon) {
      case 'shield-check':
        return Icons.verified_user_outlined;
      case 'alert-triangle':
        return Icons.warning_amber_rounded;
      default:
        return Icons.info_outline;
    }
  }

  Color _getColorForActivity(String color, PrimeCareThemeData theme) {
    switch (color) {
      case 'green':
        return theme.colors.success;
      case 'orange':
        return theme.colors.warning;
      default:
        return theme.colors.primary;
    }
  }
}
