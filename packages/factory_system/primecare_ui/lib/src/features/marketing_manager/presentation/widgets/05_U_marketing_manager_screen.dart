// Layer: 05_USER_INTERFACE
import 'package:primecare_ui/primecare_ui.dart';

/// High-fidelity Marketing Manager Dashboard.
class MarketingManagerScreen extends ConsumerWidget {
  const MarketingManagerScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final adapterState = ref.watch(headOfMarketingDashboardAdapterProvider);

    return adapterState.whenResult(
      (HeadOfMarketingDashboardViewModel viewModel) =>
          _buildDashboard(context, viewModel),
      loading: () => const DashboardLoadingWidget(),
      error: (err, stack) => DashboardErrorWidget(
        message: 'Marketing Intelligence Failure: $err',
        onRetry: () => ref.refresh(headOfMarketingDashboardAdapterProvider),
      ),
    );
  }

  Widget _buildDashboard(
    BuildContext context,
    HeadOfMarketingDashboardViewModel vm,
  ) {
    return Scaffold(
      backgroundColor: const Color(0xFFFDF2F8),
      body: CustomScrollView(
        slivers: [
          _buildAppBar(context),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildMarketingStats(vm),
                  const SizedBox(height: 32),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(flex: 2, child: _buildCampaignFunnel(vm)),
                      const SizedBox(width: 24),
                      Expanded(flex: 1, child: _buildMarketingIntelligence(context, vm)),
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
          const Icon(Icons.campaign_outlined, color: Color(0xFFBE185D)),
          const SizedBox(width: 12),
          const Text(
            'Growth & Branding',
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
          icon: const Icon(Icons.add),
          label: const Text('NEW CAMPAIGN'),
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFFBE185D),
            foregroundColor: Colors.white,
          ),
        ),
        const SizedBox(width: 24),
      ],
    );
  }

  Widget _buildMarketingStats(HeadOfMarketingDashboardViewModel vm) {
    return Wrap(
      spacing: 16,
      runSpacing: 16,
      children: vm.metrics.kpis.map((kpi) => _StatCard(kpi: kpi)).toList(),
    );
  }

  Widget _buildCampaignFunnel(HeadOfMarketingDashboardViewModel vm) {
    return _buildCard(
      title: 'Campaign Conversion Funnel',
      child: Column(
        children: [
          _FunnelStage(
            label: 'Awareness',
            value: '1.2M',
            percentage: 100,
            color: Colors.pink[100]!,
          ),
          _FunnelStage(
            label: 'Interest',
            value: '450K',
            percentage: 37,
            color: Colors.pink[200]!,
          ),
          _FunnelStage(
            label: 'Consideration',
            value: '120K',
            percentage: 10,
            color: Colors.pink[400]!,
          ),
          _FunnelStage(
            label: 'Conversion',
            value: '12.5K',
            percentage: 1,
            color: Colors.pink[700]!,
          ),
        ],
      ),
    );
  }

  Widget _buildMarketingIntelligence(BuildContext context, HeadOfMarketingDashboardViewModel vm) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF831843), Color(0xFFBE185D)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(
            children: [
              Icon(Icons.auto_graph, color: Colors.white, size: 20),
              SizedBox(width: 8),
              Text(
                'Brand Intelligence',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          ...vm.insights.map(
            (insight) => Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: Text(
                insight.summary.translate(context),
                style: TextStyle(
                  color: Colors.white.withValues(alpha: 0.9),
                  fontSize: 13,
                ),
              ),
            ),
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
            color: Colors.pink.withValues(alpha: 0.05),
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

class _StatCard extends StatelessWidget {
  final KpiMetric kpi;
  const _StatCard({required this.kpi});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 220,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.pink[50]!),
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
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 24,
              color: Color(0xFF831843),
            ),
          ),
        ],
      ),
    );
  }
}

class _FunnelStage extends StatelessWidget {
  final String label;
  final String value;
  final double percentage;
  final Color color;

  const _FunnelStage({
    required this.label,
    required this.value,
    required this.percentage,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                label,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 13,
                ),
              ),
              Text(
                value,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 13,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Container(
            height: 12,
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.grey[100],
              borderRadius: BorderRadius.circular(6),
            ),
            child: FractionallySizedBox(
              alignment: Alignment.centerLeft,
              widthFactor: percentage / 100,
              child: Container(
                decoration: BoxDecoration(
                  color: color,
                  borderRadius: BorderRadius.circular(6),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
