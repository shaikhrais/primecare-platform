// Layer: 05_USER_INTERFACE
import 'package:primecare_ui/primecare_ui.dart';

/// High-fidelity Compliance & Regulatory Dashboard.
class ComplianceManagerScreen extends ConsumerWidget {
  const ComplianceManagerScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final adapterState = ref.watch(complianceManagerDashboardAdapterProvider);

    return adapterState.whenResult(
      (viewModel) => _buildDashboard(context, viewModel),
      loading: () => const DashboardLoadingWidget(),
      error: (err, stack) => DashboardErrorWidget(
        message: 'Compliance Hydration Failed: $err',
        onRetry: () => ref.refresh(complianceManagerDashboardAdapterProvider),
      ),
    );
  }

  Widget _buildDashboard(
    BuildContext context,
    ComplianceManagerDashboardViewModel vm,
  ) {
    return Scaffold(
      backgroundColor: const Color(0xFFF0F2F5),
      body: CustomScrollView(
        slivers: [
          _buildAppBar(context),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildKpiRow(vm),
                  const SizedBox(height: 32),
                  _buildSectionHeader('Critical Regulatory Alerts'),
                  const SizedBox(height: 16),
                  _buildAlertsList(vm),
                  const SizedBox(height: 32),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(flex: 2, child: _buildAuditTimeline(vm)),
                      const SizedBox(width: 24),
                      Expanded(flex: 1, child: _buildComplianceInsights(vm)),
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

  Widget _buildAppBar(BuildContext context) {
    return SliverAppBar(
      floating: true,
      pinned: true,
      expandedHeight: 80,
      backgroundColor: Colors.white,
      elevation: 0,
      title: Row(
        children: [
          const Icon(Icons.verified_user, color: Color(0xFF6A1B9A)),
          const SizedBox(width: 12),
          const Text(
            'Compliance & Regulatory',
            style: TextStyle(
              color: Colors.black87,
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
        ],
      ),
      actions: [
        ElevatedButton.icon(
          onPressed: () {},
          icon: const Icon(Icons.add_chart, size: 16),
          label: const Text('NEW AUDIT'),
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF6A1B9A),
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        ),
        const SizedBox(width: 24),
      ],
    );
  }

  Widget _buildKpiRow(ComplianceManagerDashboardViewModel vm) {
    return Wrap(
      spacing: 16,
      runSpacing: 16,
      children: vm.metrics.kpis.map((kpi) => _KpiCard(kpi: kpi)).toList(),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Text(
      title,
      style: const TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 18,
        color: Colors.black87,
      ),
    );
  }

  Widget _buildAlertsList(ComplianceManagerDashboardViewModel vm) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.red.withValues(alpha: 0.2)),
      ),
      child: ListView.separated(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: vm.metrics.insights.length,
        separatorBuilder: (_, __) => const Divider(height: 1),
        itemBuilder: (context, index) {
          final insight = vm.metrics.insights[index];
          return ListTile(
            leading: Icon(Icons.warning_amber_rounded, color: Colors.red[700]),
            title: Text(
              insight.title,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            subtitle: Text(insight.summary),
            trailing: const Icon(Icons.chevron_right),
          );
        },
      ),
    );
  }

  Widget _buildAuditTimeline(ComplianceManagerDashboardViewModel vm) {
    return _buildCard(
      title: 'Audit & Review Timeline',
      child: Container(
        height: 300,
        decoration: BoxDecoration(
          color: Colors.grey[50],
          borderRadius: BorderRadius.circular(12),
        ),
        child: const Center(
          child: Icon(Icons.timeline, size: 48, color: Colors.black12),
        ),
      ),
    );
  }

  Widget _buildComplianceInsights(ComplianceManagerDashboardViewModel vm) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF4A148C), Color(0xFF6A1B9A)],
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
                'Quality Insights',
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

  Widget _buildCard({required String title, required Widget child}) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.02),
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
          const SizedBox(height: 24),
          child,
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
                    ? Icons.arrow_upward
                    : Icons.arrow_downward,
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
          const Icon(Icons.verified, color: Colors.white, size: 16),
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
