// Layer: 05_USER_INTERFACE
import 'package:primecare_ui/primecare_ui.dart';

/// High-fidelity Clinical Director Dashboard.
class ClinicalDirectorScreen extends ConsumerWidget {
  const ClinicalDirectorScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final adapterState = ref.watch(clinicDashboardAdapterProvider);

    return adapterState.whenResult(
      (viewModel) => _buildDashboard(context, viewModel),
      loading: () => const DashboardLoadingWidget(),
      error: (err, stack) => DashboardErrorWidget(
        message: 'Clinical Operations Hydration Failed: $err',
        onRetry: () => ref.refresh(clinicDashboardAdapterProvider),
      ),
    );
  }

  Widget _buildDashboard(BuildContext context, ClinicDashboardViewModel vm) {
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
                  _buildMetricGrid(vm),
                  const SizedBox(height: 32),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(flex: 2, child: _buildPatientOutcomes(vm)),
                      const SizedBox(width: 24),
                      Expanded(flex: 1, child: _buildClinicalInsights(vm)),
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
          const Icon(Icons.medical_services_outlined, color: Color(0xFF0D9488)),
          const SizedBox(width: 12),
          const Text(
            'Clinical Operations',
            style: TextStyle(
              color: Colors.black87,
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
        ],
      ),
      actions: [
        TextButton.icon(
          onPressed: () {},
          icon: const Icon(Icons.file_download_outlined),
          label: const Text('REPORTS'),
        ),
        const SizedBox(width: 12),
        ElevatedButton.icon(
          onPressed: () {},
          icon: const Icon(Icons.add_task),
          label: const Text('QUICK REVIEW'),
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF0D9488),
            foregroundColor: Colors.white,
          ),
        ),
        const SizedBox(width: 24),
      ],
    );
  }

  Widget _buildMetricGrid(ClinicDashboardViewModel vm) {
    return Wrap(
      spacing: 16,
      runSpacing: 16,
      children: vm.metrics.kpis.map((kpi) => _MetricCard(kpi: kpi)).toList(),
    );
  }

  Widget _buildPatientOutcomes(ClinicDashboardViewModel vm) {
    return _buildCard(
      title: 'Patient Outcome Trends',
      child: Container(
        height: 300,
        decoration: BoxDecoration(
          color: Colors.teal[50]?.withValues(alpha: 0.3),
          borderRadius: BorderRadius.circular(12),
        ),
        child: const Center(
          child: Icon(Icons.show_chart, size: 64, color: Colors.teal),
        ),
      ),
    );
  }

  Widget _buildClinicalInsights(ClinicDashboardViewModel vm) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: const Color(0xFF134E4A),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(
            children: [
              Icon(Icons.tips_and_updates, color: Colors.yellow, size: 20),
              SizedBox(width: 8),
              Text(
                'Clinical AI Insights',
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
                insight.summary,
                style: TextStyle(
                  color: Colors.white.withValues(alpha: 0.8),
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

class _MetricCard extends StatelessWidget {
  final KpiMetric kpi;
  const _MetricCard({required this.kpi});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 220,
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
          if (kpi.trend != null) ...[
            const SizedBox(height: 4),
            Text(
              kpi.trend!,
              style: const TextStyle(
                color: Colors.teal,
                fontWeight: FontWeight.bold,
                fontSize: 11,
              ),
            ),
          ],
        ],
      ),
    );
  }
}
