import 'package:primecare_ui/primecare_ui.dart';
import 'bizdev_operations_model.dart';
import 'bizdev_operations_controller.dart';

class BizDevOperationsView extends ConsumerWidget {
  const BizDevOperationsView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(bizDevDashboardControllerProvider);

    return state.when(
      data: (result) => result.fold(
        (model) => _buildDashboard(context, model),
        (error) => DashboardErrorWidget(message: error.toString(), onRetry: () => ref.refresh(bizDevDashboardControllerProvider)),
      ),
      loading: () => const DashboardLoadingWidget(),
      error: (e, s) => DashboardErrorWidget(message: e.toString(), onRetry: () => ref.refresh(bizDevDashboardControllerProvider)),
    );
  }

  Widget _buildDashboard(BuildContext context, BizDevDashboardModel model) {
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
