import 'package:flutter/material.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'franchise_operations_controller.dart';

class FranchiseOperationsView extends ConsumerWidget {
  const FranchiseOperationsView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(franchiseDashboardControllerProvider);

    return state.when(
      data: (result) => result.fold(
        (model) => _buildDashboard(context, model),
        (error) => ErrorStateView(error: error.toString()),
      ),
      loading: () => const LoadingStateView(),
      error: (e, s) => ErrorStateView(error: e.toString()),
    );
  }

  Widget _buildDashboard(BuildContext context, dynamic model) {
    return DashboardScaffold(
      title: 'Franchise Operations',
      isOffline: model.isOfflineFallback,
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: MetricsRibbon(metrics: model.metrics),
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
