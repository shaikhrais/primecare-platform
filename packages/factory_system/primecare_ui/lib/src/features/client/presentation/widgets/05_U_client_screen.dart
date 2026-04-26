// Layer: 05_USER_INTERFACE
import 'package:primecare_ui/primecare_ui.dart';

/// High-fidelity Client Care Portal.
class ClientScreen extends ConsumerWidget {
  const ClientScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final adapterState = ref.watch(clientDashboardAdapterProvider);

    return adapterState.whenResult(
      (viewModel) => _buildDashboard(context, viewModel),
      loading: () => const DashboardLoadingWidget(),
      error: (err, stack) => DashboardErrorWidget(
        message: 'Client Portal Hydration Failed: $err',
        onRetry: () => ref.refresh(clientDashboardAdapterProvider),
      ),
    );
  }

  Widget _buildDashboard(BuildContext context, ClientDashboardViewModel vm) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: CustomScrollView(
        slivers: [
          _buildAppBar(context),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildWelcomeSection(vm),
                  const SizedBox(height: 32),
                  _buildDailyWellness(vm),
                  const SizedBox(height: 32),
                  _buildUpcomingCare(vm),
                  const SizedBox(height: 32),
                  _buildQuickActions(vm),
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
      backgroundColor: const Color(0xFFF8FAFC),
      elevation: 0,
      title: const Text(
        'My Care Portal',
        style: TextStyle(color: Colors.black87, fontWeight: FontWeight.bold),
      ),
      actions: [
        CircleAvatar(
          backgroundColor: Colors.blue[100],
          child: const Icon(Icons.person, color: Colors.blue),
        ),
        const SizedBox(width: 24),
      ],
    );
  }

  Widget _buildWelcomeSection(ClientDashboardViewModel vm) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Good Morning,',
          style: TextStyle(fontSize: 16, color: Colors.black54),
        ),
        const Text(
          'Johnathan Doe',
          style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 16),
        Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.blue[50],
            borderRadius: BorderRadius.circular(16),
          ),
          child: Row(
            children: [
              const Icon(Icons.favorite, color: Colors.redAccent),
              const SizedBox(width: 16),
              const Expanded(
                child: Text(
                  'Your wellness score is up 12% this week. Keep it up!',
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    color: Colors.blue,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildDailyWellness(ClientDashboardViewModel vm) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Daily Wellness',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
        ),
        const SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _WellnessCard(
              label: 'Vitals',
              value: 'Normal',
              icon: Icons.monitor_heart,
              color: Colors.green,
            ),
            _WellnessCard(
              label: 'Sleep',
              value: '7.5h',
              icon: Icons.bedtime,
              color: Colors.indigo,
            ),
            _WellnessCard(
              label: 'Mood',
              value: 'Great',
              icon: Icons.sentiment_very_satisfied,
              color: Colors.orange,
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildUpcomingCare(ClientDashboardViewModel vm) {
    return _buildCard(
      title: LocaleKeys.dashboards_common_labels_upcoming_care_visits.tr(),
      child: Column(
        children: [
          _CareVisitTile(
            title: LocaleKeys.dashboards_common_labels_physical_therapy.tr(),
            time: 'Today, 2:00 PM',
            provider: 'Dr. Sarah Wilson',
          ),
          _CareVisitTile(
            title: LocaleKeys.dashboards_common_labels_medication_delivery.tr(),
            time: 'Tomorrow, 10:00 AM',
            provider: 'Pharmacy Express',
          ),
        ],
      ),
    );
  }

  Widget _buildQuickActions(ClientDashboardViewModel vm) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        _QuickAction(
          icon: Icons.chat_bubble_outline,
          label: 'Message Care Team',
        ),
        _QuickAction(icon: Icons.medication_outlined, label: 'Request Refill'),
        _QuickAction(icon: Icons.help_outline, label: 'Help Center'),
      ],
    );
  }

  Widget _buildCard({required String title, required Widget child}) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: const Color(0xFFF8FAFC),
        borderRadius: BorderRadius.circular(20),
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

class _WellnessCard extends StatelessWidget {
  final String label;
  final String value;
  final IconData icon;
  final Color color;

  const _WellnessCard({
    required this.label,
    required this.value,
    required this.icon,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      padding: const EdgeInsets.symmetric(vertical: 20),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: color.withValues(alpha: 0.1)),
      ),
      child: Column(
        children: [
          Icon(icon, color: color, size: 24),
          const SizedBox(height: 8),
          Text(
            label,
            style: const TextStyle(fontSize: 11, color: Colors.black54),
          ),
          Text(
            value,
            style: TextStyle(fontWeight: FontWeight.bold, color: color),
          ),
        ],
      ),
    );
  }
}

class _CareVisitTile extends StatelessWidget {
  final String title;
  final String time;
  final String provider;

  const _CareVisitTile({
    required this.title,
    required this.time,
    required this.provider,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Row(
        children: [
          Container(
            width: 4,
            height: 40,
            decoration: BoxDecoration(
              color: Colors.blue,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                Text(
                  '$time • $provider',
                  style: const TextStyle(color: Colors.black54, fontSize: 12),
                ),
              ],
            ),
          ),
          const Icon(Icons.chevron_right, color: Colors.black26),
        ],
      ),
    );
  }
}

class _QuickAction extends StatelessWidget {
  final IconData icon;
  final String label;

  const _QuickAction({required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.grey[50],
            shape: BoxShape.circle,
            border: Border.all(color: Colors.grey[100]!),
          ),
          child: Icon(icon, color: Colors.black87),
        ),
        const SizedBox(height: 8),
        Text(
          label,
          style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w500),
        ),
      ],
    );
  }
}
