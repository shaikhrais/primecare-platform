import 'package:primecare_ui/primecare_ui.dart';
import 'marketing_operations_controller.dart';
import 'marketing_operations_model.dart';

class MarketingOperationsView extends ConsumerWidget {
  const MarketingOperationsView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(marketingDashboardControllerProvider);

    return state.when(
      data: (result) => result.fold(
        (model) => _buildDashboard(context, model),
        (error) => DashboardErrorWidget(message: error.toString(), onRetry: () {}),
      ),
      loading: () => const DashboardLoadingWidget(),
      error: (e, s) => DashboardErrorWidget(message: e.toString(), onRetry: () {}),
    );
  }

  Widget _buildDashboard(BuildContext context, MarketingDashboardModel model) {
    return MasterLayout(
      child: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: PrimeCareResponsiveKpiGrid(metrics: model.metrics),
          ),
          const SliverPadding(padding: EdgeInsets.all(16)),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) => IntelligenceInsightCard(
                insight: model.insights[index],
              ),
              childCount: model.insights.length,
            ),
          ),
        ],
      ),
    );
  }
}
