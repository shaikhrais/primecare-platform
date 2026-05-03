import 'package:primecare_ui/primecare_ui.dart';
import 'governance_operations_controller.dart';

/// [View] - The Governance Operations Content Area
/// Uses high-precision classes for all visual elements.
class GovernanceOperationsView extends ConsumerWidget {
  const GovernanceOperationsView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Watch the unified intelligence manager (role-based)
    final state = ref.watch(governanceDashboardControllerProvider);

    return state.when(
      data: (result) => result.fold(
        (data) => _DashboardContent(model: data),
        (error) => DashboardErrorWidget(
          message: error.toString(),
          onRetry: () => ref.read(governanceDashboardControllerProvider.notifier).refresh(),
        ),
      ),
      loading: () => const DashboardLoadingWidget(),
      error: (e, s) => DashboardErrorWidget(message: e.toString()),
    );
  }
}

/// [Internal Component] - The assembled dashboard layout.
/// Strictly follows OOP principles by separating layout from logic.
class _DashboardContent extends StatelessWidget {
  final IntelligenceDashboardModel model;

  const _DashboardContent({required this.model});

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;

    return CustomScrollView(
      slivers: [
        // 0. System Integrity Manifest (Lifetime Variables)
        const SliverToBoxAdapter(
          child: SystemIntegrityManifest(),
        ),
        const SliverToBoxAdapter(
          child: SizedBox(height: 24),
        ),
        // 1. KPI Precision Grid
        const SliverToBoxAdapter(
          child: DashboardSectionHeader(title: 'Compliance Metrics'),
        ),
        SliverToBoxAdapter(
          child: DashboardKpiGrid(metrics: model.metrics),
        ),

        // 2. Actionable Insights Section
        const SliverToBoxAdapter(
          child: DashboardSectionHeader(title: 'AI Insights & Remediation'),
        ),
        SliverList(
          delegate: SliverChildBuilderDelegate(
            (context, index) => ActionableInsightCard(insight: model.insights[index]),
            childCount: model.insights.length,
          ),
        ),

        // 3. Footer / Update Info
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 24.0),
            child: Center(
              child: Text(
                'Last Intelligence Sync: ${model.lastUpdated.hour}:${model.lastUpdated.minute}',
                style: theme.typography.labelSmall.copyWith(color: theme.colors.slateGray),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
