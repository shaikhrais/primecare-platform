// Layer: 05_USER_INTERFACE
import 'package:primecare_ui/primecare_ui.dart';

/// High-fidelity Regional Manager Dashboard.
class RegionalManagerScreen extends ConsumerWidget {
  const RegionalManagerScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final adapterState = ref.watch(
      regionalManagerOntarioDashboardAdapterProvider,
    );

    return adapterState.whenResult(
      (RegionalManagerOntarioDashboardViewModel viewModel) =>
          _buildDashboard(context, viewModel),
      loading: () => const DashboardLoadingWidget(),
      error: (err, stack) => DashboardErrorWidget(
        message: 'Regional Telemetry Failure: $err',
        onRetry: () =>
            ref.refresh(regionalManagerOntarioDashboardAdapterProvider),
      ),
    );
  }

  Widget _buildDashboard(
    BuildContext context,
    RegionalManagerOntarioDashboardViewModel vm,
  ) {
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
                  _buildRegionalKPIs(vm),
                  const SizedBox(height: 32),
                  _buildSectionHeader('Franchise Performance Matrix'),
                  const SizedBox(height: 16),
                  _buildFranchiseGrid(vm),
                  const SizedBox(height: 32),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(flex: 2, child: _buildGrowthMap(vm)),
                      const SizedBox(width: 24),
                      Expanded(flex: 1, child: _buildRegionalAlerts(vm)),
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
          const Icon(Icons.map_outlined, color: Color(0xFF1E293B)),
          const SizedBox(width: 12),
          const Text(
            'Regional Oversight',
            style: TextStyle(
              color: Colors.black87,
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
        ],
      ),
      actions: [
        IconButton(
          onPressed: () {},
          icon: const Icon(Icons.notifications_none),
        ),
        const SizedBox(width: 12),
        ElevatedButton.icon(
          onPressed: () {},
          icon: const Icon(Icons.analytics_outlined),
          label: const Text('EXPANSION PLAN'),
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF1E293B),
            foregroundColor: Colors.white,
          ),
        ),
        const SizedBox(width: 24),
      ],
    );
  }

  Widget _buildRegionalKPIs(RegionalManagerOntarioDashboardViewModel vm) {
    return Wrap(
      spacing: 16,
      runSpacing: 16,
      children: vm.metrics.kpis.map((kpi) => _KpiCard(kpi: kpi)).toList(),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Text(
      title,
      style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
    );
  }

  Widget _buildFranchiseGrid(RegionalManagerOntarioDashboardViewModel vm) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
        childAspectRatio: 2.5,
      ),
      itemCount: 6,
      itemBuilder: (context, index) => _FranchiseCard(index: index),
    );
  }

  Widget _buildGrowthMap(RegionalManagerOntarioDashboardViewModel vm) {
    return _buildCard(
      title: 'Territory Growth Map',
      child: Container(
        height: 300,
        decoration: BoxDecoration(
          color: Colors.blueGrey[50],
          borderRadius: BorderRadius.circular(12),
        ),
        child: const Center(
          child: Icon(Icons.public, size: 64, color: Colors.blueGrey),
        ),
      ),
    );
  }

  Widget _buildRegionalAlerts(RegionalManagerOntarioDashboardViewModel vm) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: const Color(0xFFF1F5F9),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.orange.withValues(alpha: 0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(
            children: [
              Icon(Icons.warning_amber_rounded, color: Colors.orange, size: 20),
              SizedBox(width: 8),
              Text(
                'Operational Risks',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.orange,
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          _RiskTile(title: 'Hiring Gap: Toronto North', level: 'High'),
          _RiskTile(title: 'Compliance Audit: Ottawa', level: 'Medium'),
          _RiskTile(title: 'Margin Compression: London', level: 'Low'),
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

class _KpiCard extends StatelessWidget {
  final KpiMetric kpi;
  const _KpiCard({required this.kpi});

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
          Text(
            kpi.title,
            style: const TextStyle(color: Colors.black54, fontSize: 12),
          ),
          const SizedBox(height: 8),
          Text(
            kpi.value,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
          ),
        ],
      ),
    );
  }
}

class _FranchiseCard extends StatelessWidget {
  final int index;
  const _FranchiseCard({required this.index});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      child: Row(
        children: [
          const CircleAvatar(
            backgroundColor: Color(0xFF1E293B),
            child: Icon(Icons.business, color: Colors.white, size: 16),
          ),
          const SizedBox(width: 12),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Franchise #${100 + index}',
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              const Text(
                'Active • 98% CSAT',
                style: TextStyle(
                  color: Colors.green,
                  fontSize: 11,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _RiskTile extends StatelessWidget {
  final String title;
  final String level;
  const _RiskTile({required this.title, required this.level});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: Row(
        children: [
          const Icon(Icons.circle, size: 8, color: Colors.orange),
          const SizedBox(width: 12),
          Expanded(child: Text(title, style: const TextStyle(fontSize: 13))),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
            decoration: BoxDecoration(
              color: Colors.orange[50],
              borderRadius: BorderRadius.circular(4),
            ),
            child: Text(
              level,
              style: const TextStyle(
                color: Colors.orange,
                fontSize: 10,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
