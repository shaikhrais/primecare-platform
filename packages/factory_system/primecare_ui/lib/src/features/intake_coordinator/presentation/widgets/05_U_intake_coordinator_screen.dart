// Layer: 05_USER_INTERFACE
import 'package:primecare_ui/primecare_ui.dart';

/// High-fidelity Intake Coordinator Dashboard.
class IntakeCoordinatorScreen extends ConsumerWidget {
  const IntakeCoordinatorScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final adapterState = ref.watch(intakeDashboardAdapterProvider);

    return adapterState.whenResult(
      (viewModel) => _buildDashboard(context, viewModel),
      loading: () => const DashboardLoadingWidget(),
      error: (err, stack) => DashboardErrorWidget(
        message: 'Intake Telemetry Exception: $err',
        onRetry: () => ref.refresh(intakeDashboardAdapterProvider),
      ),
    );
  }

  Widget _buildDashboard(BuildContext context, IntakeDashboardViewModel vm) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      body: CustomScrollView(
        slivers: [
          _buildAppBar(context),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildPipelineStats(vm),
                  const SizedBox(height: 32),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(flex: 2, child: _buildRecentApplications(vm)),
                      const SizedBox(width: 24),
                      Expanded(flex: 1, child: _buildIntakeIntelligence(vm)),
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
          const Icon(Icons.assignment_ind, color: Color(0xFF0284C7)),
          const SizedBox(width: 12),
          const Text(
            'Intake Hub',
            style: TextStyle(
              color: Colors.black87,
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
        ],
      ),
      actions: [
        OutlinedButton.icon(
          onPressed: () {},
          icon: const Icon(Icons.filter_list),
          label: const Text('FILTER'),
          style: OutlinedButton.styleFrom(
            side: const BorderSide(color: Color(0xFFE2E8F0)),
            foregroundColor: Colors.black54,
          ),
        ),
        const SizedBox(width: 12),
        ElevatedButton.icon(
          onPressed: () {},
          icon: const Icon(Icons.add),
          label: const Text('NEW CANDIDATE'),
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF0284C7),
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

  Widget _buildPipelineStats(IntakeDashboardViewModel vm) {
    return Wrap(
      spacing: 16,
      runSpacing: 16,
      children: vm.metrics.kpis.map((kpi) => _StatCard(kpi: kpi)).toList(),
    );
  }

  Widget _buildRecentApplications(IntakeDashboardViewModel vm) {
    return _buildCard(
      title: 'Active Intake Pipeline',
      child: Column(
        children: [
          _ApplicationTile(
            name: 'Sarah Connor',
            status: 'Verification',
            time: '2h ago',
          ),
          _ApplicationTile(
            name: 'James Smith',
            status: 'Eligibility Check',
            time: '4h ago',
          ),
          _ApplicationTile(
            name: 'Maria Garcia',
            status: 'Document Pending',
            time: '1d ago',
          ),
        ],
      ),
    );
  }

  Widget _buildIntakeIntelligence(IntakeDashboardViewModel vm) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: const Color(0xFF0F172A),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(
            children: [
              Icon(Icons.auto_awesome, color: Colors.blueAccent, size: 18),
              SizedBox(width: 8),
              Text(
                'Pipeline AI',
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
              padding: const EdgeInsets.only(bottom: 16),
              child: Text(
                insight.summary,
                style: TextStyle(
                  color: Colors.white.withValues(alpha: 0.7),
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
        border: Border.all(color: const Color(0xFFE2E8F0)),
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
        border: Border.all(color: const Color(0xFFE2E8F0)),
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
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
          ),
        ],
      ),
    );
  }
}

class _ApplicationTile extends StatelessWidget {
  final String name;
  final String status;
  final String time;

  const _ApplicationTile({
    required this.name,
    required this.status,
    required this.time,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: Row(
        children: [
          CircleAvatar(backgroundColor: Colors.blue[50], child: Text(name[0])),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(name, style: const TextStyle(fontWeight: FontWeight.bold)),
                Text(
                  status,
                  style: const TextStyle(color: Colors.black54, fontSize: 12),
                ),
              ],
            ),
          ),
          Text(
            time,
            style: const TextStyle(color: Colors.black38, fontSize: 11),
          ),
        ],
      ),
    );
  }
}
