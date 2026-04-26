// Layer: 05_USER_INTERFACE
import 'package:primecare_ui/primecare_ui.dart';

/// High-fidelity Scheduler Hub Dashboard for Resource Coordinators.
class SchedulerScreen extends ConsumerWidget {
  const SchedulerScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final adapterState = ref.watch(schedulerDashboardAdapterProvider);

    return adapterState.whenResult(
      (SchedulerDashboardViewModel viewModel) =>
          _buildDashboard(context, viewModel),
      loading: () => const DashboardLoadingWidget(),
      error: (Object err, StackTrace stack) => DashboardErrorWidget(
        message: 'Scheduler Hydration Failed: $err',
        onRetry: () => ref.refresh(schedulerDashboardAdapterProvider),
      ),
    );
  }

  Widget _buildDashboard(BuildContext context, SchedulerDashboardViewModel vm) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F7F9),
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
                      Expanded(flex: 2, child: _buildMainCalendar(vm)),
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

  Widget _buildAppBar(BuildContext context, SchedulerDashboardViewModel vm) {
    return SliverAppBar(
      floating: true,
      pinned: true,
      expandedHeight: 80,
      backgroundColor: Colors.white,
      elevation: 0,
      title: Row(
        children: [
          const Icon(Icons.calendar_today, color: Color(0xFF2E7D32)),
          const SizedBox(width: 12),
          const Text(
            'Scheduler Hub',
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
          icon: const Icon(Icons.group_add, color: Colors.black54),
          onPressed: () {},
          tooltip: 'Mass Assign Staff',
        ),
        IconButton(
          icon: const Icon(Icons.notifications_active, color: Colors.black54),
          onPressed: () {},
          tooltip: 'Coverage Alerts',
        ),
        SizedBox(width: 24),
      ],
    );
  }

  Widget _buildKpiRow(SchedulerDashboardViewModel vm) {
    return Wrap(
      spacing: 16,
      runSpacing: 16,
      children: vm.metrics.kpis.map((kpi) => _KpiCard(kpi: kpi)).toList(),
    );
  }

  Widget _buildMainCalendar(SchedulerDashboardViewModel vm) {
    return Column(
      children: [
        _buildSectionCard(
          title: LocaleKeys.dashboards_common_labels_shift_coverage_optimization
              .tr(),
          subtitle: LocaleKeys
              .dashboards_common_labels_real_time_staffing_density_across_service_regions
              .tr(),
          child: Container(
            height: 400,
            decoration: BoxDecoration(
              color: Colors.grey[50],
              borderRadius: BorderRadius.circular(12),
            ),
            child: Center(
              child: Icon(Icons.view_quilt, size: 48, color: Colors.black12),
            ),
          ),
        ),
        SizedBox(height: 24),
        _buildSectionCard(
          title: LocaleKeys
              .dashboards_common_labels_pending_fulfillment_requests
              .tr(),
          subtitle: LocaleKeys
              .dashboards_common_labels_critical_shifts_requiring_immediate_assignment
              .tr(),
          child: ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: 3,
            itemBuilder: (context, index) => ListTile(
              leading: CircleAvatar(
                backgroundColor: Colors.redAccent,
                child: Icon(Icons.warning, color: Colors.white, size: 16),
              ),
              title: Text(
                LocaleKeys
                    .dashboards_common_labels_rn_shift___region___index___1
                    .tr(),
              ),
              subtitle: Text(LocaleKeys
                    .dashboards_common_labels_priority__high___gap__2_hours
                    .tr(),
              ),
              trailing: TextButton(
                onPressed: () {},
                child: Text(LocaleKeys.dashboards_common_labels_assign.tr(),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSidePanel(SchedulerDashboardViewModel vm) {
    return Column(
      children: [
        _buildStaffingIntelligence(vm),
        const SizedBox(height: 24),
        _buildRecentActivity(vm),
      ],
    );
  }

  Widget _buildSectionCard({
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

  Widget _buildStaffingIntelligence(SchedulerDashboardViewModel vm) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF2E7D32), Color(0xFF43A047)],
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
              const Icon(Icons.psychology, color: Colors.white, size: 20),
              const SizedBox(width: 8),
              const Text(
                'Staffing Intelligence',
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

  Widget _buildRecentActivity(SchedulerDashboardViewModel vm) {
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
            'Scheduling Logs',
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
          const Icon(Icons.lightbulb_outline, color: Colors.white, size: 16),
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
                  insight.description,
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
            width: 8,
            height: 8,
            decoration: BoxDecoration(
              color: _parseColor(activity.color),
              shape: BoxShape.circle,
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
