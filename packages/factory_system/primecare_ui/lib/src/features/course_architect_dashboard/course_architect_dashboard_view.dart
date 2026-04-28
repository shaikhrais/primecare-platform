// PRIMECARE CONSOLIDATED FILE
import 'package:primecare_ui/src/features/features_controller.dart';
import 'package:primecare_ui/src/theme/primecare_theme.dart';
import 'package:primecare_ui/src/shared/primecare_adapters.dart'
    hide isOnlineProvider, ProviderTTL;

class CourseArchitectDashboardView extends ConsumerWidget {
  const CourseArchitectDashboardView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = context.theme;
    final state = ref.watch(courseArchitectAdapterProvider);

    return MasterLayout(
      child: state.when(
        data: (result) => result.fold(
          (viewModel) => _buildContent(context, theme, viewModel.metrics),
          (e) => DashboardErrorWidget(
            message: 'Governance Error: $e',
            onRetry: () => ref.refresh(courseArchitectAdapterProvider),
          ),
        ),
        loading: () => const DashboardLoadingWidget(),
        error: (e, st) => DashboardErrorWidget(
          message: 'Connection Error: $e',
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

class CourseArchitectDashboardIntent extends PrimeCareScreen {
  CourseArchitectDashboardIntent() : super(title: 'CourseArchitectDashboard');

  @override
  Widget build(BuildContext context) => const CourseArchitectDashboardView();
}
