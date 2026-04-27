// Layer: 05_USER_INTERFACE
import 'package:primecare_ui/primecare_ui.dart';

/// High-fidelity Revenue Cycle Management Dashboard for Billing Administrators.
class BillingAdminScreen extends ConsumerWidget {
  const BillingAdminScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final adapterState = ref.watch(billingAdminDashboardAdapterProvider);

    return adapterState.whenResult(
      (viewModel) => _buildDashboard(context, viewModel),
      loading: () => const DashboardLoadingWidget(),
      error: (err, stack) => DashboardErrorWidget(
        message: 'Revenue Hydration Failed: $err',
        onRetry: () => ref.refresh(billingAdminDashboardAdapterProvider),
      ),
    );
  }

  Widget _buildDashboard(
    BuildContext context,
    BillingAdminDashboardViewModel vm,
  ) {
    final theme = context.theme;
    return Scaffold(
      backgroundColor: theme.colors.background,
      body: CustomScrollView(
        slivers: [
          _buildAppBar(context, vm),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildKpiRow(vm),
                  const SizedBox(height: 32),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(flex: 2, child: _buildMainCharts(vm)),
                      const SizedBox(width: 24),
                      Expanded(flex: 1, child: _buildSidePanel(vm)),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAppBar(BuildContext context, BillingAdminDashboardViewModel vm) {
    final theme = context.theme;
    return SliverAppBar(
      floating: true,
      pinned: true,
      expandedHeight: 80,
      backgroundColor: theme.colors.surface,
      elevation: 0,
      title: Row(
        children: [
          PrimeCareIcon(
            Icons.account_balance_wallet,
            color: theme.colors.primary,
          ),
          SizedBox(width: 12),
          Text(
            'Revenue Cycle Management',
            style: theme.typography.h3.copyWith(color: theme.colors.onSurface),
          ),
        ],
      ),
      actions: [
        IconButton(
          icon: const Icon(Icons.file_upload, color: Colors.black54),
          onPressed: () {},
          tooltip: 'Upload 837 Claims',
        ),
        IconButton(
          icon: const Icon(Icons.download, color: Colors.black54),
          onPressed: () {},
          tooltip: 'Download 835 ERAs',
        ),
        SizedBox(width: 24),
      ],
    );
  }

  Widget _buildKpiRow(BillingAdminDashboardViewModel vm) {
    return Wrap(
      spacing: 16,
      runSpacing: 16,
      children: vm.metrics.kpis.map((kpi) => _KpiCard(kpi: kpi)).toList(),
    );
  }

  Widget _buildMainCharts(BillingAdminDashboardViewModel vm) {
    return Column(
      children: [
        _buildChartCard(
          title: LocaleKeys.dashboards_common_labels_claims_aging_status.tr(),
          subtitle: LocaleKeys
              .dashboards_common_labels_distribution_of_outstanding_balances_by_days
              .tr(),
          child: Container(
            height: 300,
            decoration: BoxDecoration(
              color: Colors.grey[50],
              borderRadius: BorderRadius.circular(12),
            ),
            child: Center(
              child: Icon(Icons.bar_chart, size: 48, color: Colors.black12),
            ),
          ),
        ),
        SizedBox(height: 24),
        _buildChartCard(
          title: LocaleKeys.dashboards_common_labels_revenue_forecasting.tr(),
          subtitle: LocaleKeys
              .dashboards_common_labels_ai_driven_projections_for_next_90_days
              .tr(),
          child: Container(
            height: 300,
            decoration: BoxDecoration(
              color: Colors.grey[50],
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Center(
              child: Icon(Icons.show_chart, size: 48, color: Colors.black12),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSidePanel(BillingAdminDashboardViewModel vm) {
    return Column(
      children: [
        _buildIntelligenceInsights(vm),
        const SizedBox(height: 24),
        _buildRecentActivity(vm),
      ],
    );
  }

  Widget _buildChartCard({
    required String title,
    required String subtitle,
    required Widget child,
  }) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.03),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
          ),
          const SizedBox(height: 4),
          Text(
            subtitle,
            style: const TextStyle(color: Colors.black54, fontSize: 12),
          ),
          const SizedBox(height: 24),
          child,
        ],
      ),
    );
  }

  Widget _buildIntelligenceInsights(BillingAdminDashboardViewModel vm) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF0D47A1), Color(0xFF1976D2)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.auto_awesome, color: Colors.white, size: 20),
              const SizedBox(width: 8),
              const Text(
                'Intelligence Insights',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          ...vm.metrics.insights.map(
            (insight) => _InsightTile(insight: insight),
          ),
        ],
      ),
    );
  }

  Widget _buildRecentActivity(BillingAdminDashboardViewModel vm) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Recent Activity',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          const SizedBox(height: 16),
          ...vm.metrics.recentActivity.map(
            (activity) => _ActivityTile(activity: activity),
          ),
        ],
      ),
    );
  }
}

class _KpiCard extends StatelessWidget {
  final KpiMetric kpi;
  const _KpiCard({required this.kpi});

  @override
  Widget build(BuildContext context) {
    final statusColor = _getStatusColor(kpi.status);
    return Container(
      width: 240,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey[200]!),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            kpi.title,
            style: const TextStyle(color: Colors.black54, fontSize: 12),
          ),
          const SizedBox(height: 8),
          Text(
            kpi.value,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Icon(
                kpi.trend?.contains('+') ?? true
                    ? Icons.trending_up
                    : Icons.trending_down,
                size: 14,
                color: statusColor,
              ),
              const SizedBox(width: 4),
              Text(
                kpi.trend ?? '',
                style: TextStyle(
                  color: statusColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                ),
              ),
              const Spacer(),
              Text(
                kpi.subtitle ?? '',
                style: const TextStyle(color: Colors.black38, fontSize: 10),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'positive':
        return Colors.green[600]!;
      case 'negative':
        return Colors.red[600]!;
      case 'warning':
        return Colors.orange[600]!;
      default:
        return Colors.blue[600]!;
    }
  }
}

class _InsightTile extends StatelessWidget {
  final DashboardInsight insight;
  const _InsightTile({required this.insight});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(4),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.1),
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.info_outline,
              color: Colors.white,
              size: 14,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  insight.title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                  ),
                ),
                Text(
                  insight.summary,
                  style: TextStyle(
                    color: Colors.white.withValues(alpha: 0.8),
                    fontSize: 11,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _ActivityTile extends StatelessWidget {
  final DashboardActivity activity;
  const _ActivityTile({required this.activity});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Container(
            width: 32,
            height: 32,
            decoration: BoxDecoration(
              color: _parseColor(activity.color).withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(
              Icons.history,
              color: _parseColor(activity.color),
              size: 16,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  activity.title,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                  ),
                ),
                Text(
                  activity.subtitle,
                  style: const TextStyle(color: Colors.black54, fontSize: 11),
                ),
              ],
            ),
          ),
          Text(
            activity.timestamp,
            style: const TextStyle(color: Colors.black38, fontSize: 10),
          ),
        ],
      ),
    );
  }

  Color _parseColor(String colorStr) {
    try {
      return Color(int.parse(colorStr.replaceFirst('#', '0xFF')));
    } catch (_) {
      return Colors.blue;
    }
  }
}
