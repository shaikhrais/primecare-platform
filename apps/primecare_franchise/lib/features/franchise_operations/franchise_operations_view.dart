import 'package:primecare_ui/primecare_ui.dart';
import 'franchise_operations_controller.dart';

/// [View] - The Franchise Operations Content Area
class FranchiseOperationsView extends ConsumerWidget {
  const FranchiseOperationsView({super.key});

  @override
  Widget build(BuildContext context) {
    return const _FranchiseContentWrapper();
  }
}

class _FranchiseContentWrapper extends ConsumerWidget {
  const _FranchiseContentWrapper();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(franchiseDashboardControllerProvider('franchise'));

    return state.when(
      data: (result) => result.fold(
        (model) => _FranchiseDashboardContent(model: model),
        (error) => DashboardErrorWidget(
          message: error.toString(),
          onRetry: () => ref.read(franchiseDashboardControllerProvider('franchise').notifier).refresh(),
        ),
      ),
      loading: () => const DashboardLoadingWidget(),
      error: (e, s) => DashboardErrorWidget(message: e.toString()),
    );
  }
}

class _FranchiseDashboardContent extends StatelessWidget {
  final IntelligenceDashboardModel model;

  const _FranchiseDashboardContent({required this.model});

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        const SliverToBoxAdapter(
          child: DashboardSectionHeader(title: 'Clinic Performance Metrics'),
        ),
        SliverToBoxAdapter(
          child: DashboardKpiGrid(metrics: model.metrics),
        ),
        const SliverToBoxAdapter(
          child: DashboardSectionHeader(title: 'Operational Insights'),
        ),
        SliverList(
          delegate: SliverChildBuilderDelegate(
            (context, index) => ActionableInsightCard(insight: model.insights[index]),
            childCount: model.insights.length,
          ),
        ),
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 32.0),
            child: Center(
              child: PrimeCareChip(
                label: 'System Status: Optimal',
                color: context.theme.colors.success,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
