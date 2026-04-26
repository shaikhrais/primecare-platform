// Layer: 05_UI_PRESENTATION
import 'package:primecare_ui/primecare_ui.dart';

class CourseArchitectDashboardScreen extends ConsumerWidget {
  const CourseArchitectDashboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = context.theme;
    final state = ref.watch(courseArchitectAdapterProvider);

    return MasterLayout(
      child: state.whenResult(
        (viewModel) => _buildContent(context, theme, viewModel.metrics),
        loading: () => const DashboardLoadingWidget(),
        error: (Object e, StackTrace st) => DashboardErrorWidget(
          message: 'Governance Exception: $e',
          onRetry: () => ref.refresh(courseArchitectAdapterProvider),
        ),
      ),
    );
  }

  Widget _buildContent(
    BuildContext context,
    PrimeCareThemeData theme,
    DashboardMetrics metrics,
  ) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(theme.spacing.lg),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Course Architect Command Center', style: theme.typography.h2),
          SizedBox(height: theme.spacing.xl),
          PrimeCareResponsiveKpiGrid(metrics: metrics),
          SizedBox(height: theme.spacing.xl),
          PrimeCareCard(
            padding: EdgeInsets.all(theme.spacing.xl),
            child: Center(
              child: Text(
                LocaleKeys.dashboards_common_labels_operational_insights.tr(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
