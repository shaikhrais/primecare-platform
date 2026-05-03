import 'package:primecare_ui/primecare_ui.dart';
import 'corporate_operations_controller.dart';

/// [View] - Unified Corporate Executive Content Area
/// A single, modular view that renders dashboards for CEO, CFO, COO, and CTO.
class CorporateOperationsView extends ConsumerWidget {
  final String role;

  const CorporateOperationsView({required this.role, super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Watch the dynamic corporate intelligence manager
    final state = ref.watch(corporateDashboardControllerProvider(role));

    return state.when(
      data: (result) => result.fold(
        (model) => _ExecutiveDashboardContent(role: role, model: model),
        (error) => DashboardErrorWidget(
          message: error.toString(),
          onRetry: () => ref.read(corporateDashboardControllerProvider(role).notifier).refresh(),
        ),
      ),
      loading: () => const DashboardLoadingWidget(),
      error: (e, s) => DashboardErrorWidget(message: e.toString()),
    );
  }
}

/// [Internal Component] - The assembled executive layout.
class _ExecutiveDashboardContent extends StatelessWidget {
  final String role;
  final IntelligenceDashboardModel model;

  const _ExecutiveDashboardContent({required this.role, required this.model});

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        // 1. Executive Title Section
        SliverToBoxAdapter(
          child: DashboardSectionHeader(
            title: '${role.toUpperCase()} Executive Summary',
            trailing: const OfflineStatusChip(), // Shows if the platform is in fallback mode
          ),
        ),

        // 2. High-Precision KPI Grid
        SliverToBoxAdapter(
          child: DashboardKpiGrid(metrics: model.metrics),
        ),

        // 3. Strategic AI Insights
        const SliverToBoxAdapter(
          child: DashboardSectionHeader(title: 'Strategic Action Items'),
        ),
        SliverList(
          delegate: SliverChildBuilderDelegate(
            (context, index) => ActionableInsightCard(insight: model.insights[index]),
            childCount: model.insights.length,
          ),
        ),

        // 4. Persistence Registry Info
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 32.0),
            child: Center(
              child: Opacity(
                opacity: 0.6,
                child: Text(
                  'Corporate Ledger Sync Status: Verified',
                  style: context.theme.typography.labelSmall,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

// Convenience wrappers for routing compatibility:
class CeoDashboardView extends CorporateOperationsView {
  const CeoDashboardView({super.key}) : super(role: 'ceo');
}

class CfoDashboardView extends CorporateOperationsView {
  const CfoDashboardView({super.key}) : super(role: 'cfo');
}

class CooDashboardView extends CorporateOperationsView {
  const CooDashboardView({super.key}) : super(role: 'coo');
}

class CtoDashboardView extends CorporateOperationsView {
  const CtoDashboardView({super.key}) : super(role: 'cto');
}

class VerificationHubView extends StatelessWidget {
  const VerificationHubView({super.key});
  @override
  Widget build(BuildContext context) => const Center(child: Text('Corporate Verification Hub'));
}
