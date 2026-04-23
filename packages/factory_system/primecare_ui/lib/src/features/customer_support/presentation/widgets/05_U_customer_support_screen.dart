// Layer: 05_USER_INTERFACE
import 'package:flutter_core/00_B_flutter_core.dart';

/// High-fidelity Customer Support Dashboard.
class CustomerSupportScreen extends ConsumerWidget {
  const CustomerSupportScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final adapterState = ref.watch(customerSupportDashboardAdapterProvider);

    return adapterState.when(
      data: (result) => result.fold(
        (viewModel) => _buildDashboard(context, viewModel),
        (error) => SystemRecoveryMode(
          error: error,
          onAttemptReset: () => ref.refresh(customerSupportDashboardAdapterProvider),
        ),
      ),
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (err, stack) => SystemRecoveryMode(
        error: err,
        stackTrace: stack,
        onAttemptReset: () => ref.refresh(customerSupportDashboardAdapterProvider),
      ),
    );
  }

  Widget _buildDashboard(BuildContext context, CustomerSupportDashboardViewModel vm) {
    return Scaffold(
      backgroundColor: const Color(0xFFF1F5F9),
      body: CustomScrollView(
        slivers: [
          _buildAppBar(context),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildSupportKPIs(vm),
                  const SizedBox(height: 32),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        flex: 2,
                        child: _buildTicketFlow(vm),
                      ),
                      const SizedBox(width: 24),
                      Expanded(
                        flex: 1,
                        child: _buildSupportIntelligence(vm),
                      ),
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
          const Icon(Icons.support_agent, color: Color(0xFF0F172A)),
          const SizedBox(width: 12),
          const Text(
            'Support Center',
            style: TextStyle(color: Colors.black87, fontWeight: FontWeight.bold, fontSize: 20),
          ),
        ],
      ),
      actions: [
        ElevatedButton.icon(
          onPressed: () {},
          icon: const Icon(Icons.add_task),
          label: const Text('CREATE TICKET'),
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF0F172A),
            foregroundColor: Colors.white,
          ),
        ),
        const SizedBox(width: 24),
      ],
    );
  }

  Widget _buildSupportKPIs(CustomerSupportDashboardViewModel vm) {
    return Wrap(
      spacing: 16,
      runSpacing: 16,
      children: vm.metrics.kpis.map((kpi) => _StatCard(kpi: kpi)).toList(),
    );
  }

  Widget _buildTicketFlow(CustomerSupportDashboardViewModel vm) {
    return _buildCard(
      title: 'Real-time Ticket Velocity',
      child: Container(
        height: 300,
        decoration: BoxDecoration(
          color: Colors.blue[50]?.withValues(alpha: 0.5),
          borderRadius: BorderRadius.circular(12),
        ),
        child: const Center(child: Icon(Icons.bubble_chart, size: 64, color: Colors.blue)),
      ),
    );
  }

  Widget _buildSupportIntelligence(CustomerSupportDashboardViewModel vm) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: const Color(0xFF1E293B),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(
            children: [
              Icon(Icons.auto_awesome, color: Colors.blueAccent, size: 20),
              SizedBox(width: 8),
              Text('Resolution AI', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
            ],
          ),
          const SizedBox(height: 20),
          ...vm.insights.map((insight) => Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: Text(
              insight.summary,
              style: TextStyle(color: Colors.white.withValues(alpha: 0.8), fontSize: 13),
            ),
          )),
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
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
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
      width: 200,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(kpi.title, style: const TextStyle(color: Colors.black54, fontSize: 12)),
          const SizedBox(height: 8),
          Text(kpi.value, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 24)),
        ],
      ),
    );
  }
}

