// Layer: 05_USER_INTERFACE
import 'package:flutter_core/00_B_flutter_core.dart';

/// High-fidelity Family Member Portal.
class FamilyMemberScreen extends ConsumerWidget {
  const FamilyMemberScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final adapterState = ref.watch(familyDashboardAdapterProvider);

    return adapterState.when(
      data: (result) => result.fold(
        (viewModel) => _buildDashboard(context, viewModel),
        (error) => SystemRecoveryMode(
          error: error,
          onAttemptReset: () => ref.refresh(familyDashboardAdapterProvider),
        ),
      ),
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (err, stack) => SystemRecoveryMode(
        error: err,
        stackTrace: stack,
        onAttemptReset: () => ref.refresh(familyDashboardAdapterProvider),
      ),
    );
  }

  Widget _buildDashboard(BuildContext context, FamilyDashboardViewModel vm) {
    return Scaffold(
      backgroundColor: const Color(0xFFFAFAFA),
      body: CustomScrollView(
        slivers: [
          _buildAppBar(context),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildCareRecipientSummary(vm),
                  const SizedBox(height: 32),
                  _buildDailyActivity(vm),
                  const SizedBox(height: 32),
                  _buildCareTeam(vm),
                  const SizedBox(height: 32),
                  _buildActionCenter(vm),
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
      title: const Text(
        'Family Connection',
        style: TextStyle(color: Color(0xFF4338CA), fontWeight: FontWeight.bold),
      ),
      actions: [
        IconButton(onPressed: () {}, icon: const Icon(Icons.notifications_active_outlined, color: Color(0xFF4338CA))),
        const SizedBox(width: 24),
      ],
    );
  }

  Widget _buildCareRecipientSummary(FamilyDashboardViewModel vm) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: const LinearGradient(colors: [Color(0xFF4F46E5), Color(0xFF4338CA)]),
        borderRadius: BorderRadius.circular(24),
      ),
      child: Row(
        children: [
          CircleAvatar(radius: 30, backgroundColor: Colors.white24, child: const Icon(Icons.person, color: Colors.white, size: 32)),
          const SizedBox(width: 20),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Johnathan Doe', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20)),
                Text('Active Care Phase • Stable', style: TextStyle(color: Colors.white.withValues(alpha: 0.8), fontSize: 14)),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(color: Colors.white.withValues(alpha: 0.15), borderRadius: BorderRadius.circular(12)),
            child: const Icon(Icons.favorite, color: Colors.white),
          ),
        ],
      ),
    );
  }

  Widget _buildDailyActivity(FamilyDashboardViewModel vm) {
    return _buildCard(
      title: 'Today\'s Activity',
      child: Column(
        children: [
          _ActivityItem(icon: Icons.check_circle, text: 'Morning Medication Administered', time: '8:00 AM', color: Colors.green),
          _ActivityItem(icon: Icons.directions_walk, text: 'Completed 15-minute therapy walk', time: '10:30 AM', color: Colors.blue),
          _ActivityItem(icon: Icons.restaurant, text: 'Lunch: Balanced Nutritional Meal', time: '12:30 PM', color: Colors.orange),
        ],
      ),
    );
  }

  Widget _buildCareTeam(FamilyDashboardViewModel vm) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('On-Duty Care Team', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
        const SizedBox(height: 16),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              _TeamMemberCard(name: 'Nurse Ratched', role: 'Primary RN', active: true),
              const SizedBox(width: 12),
              _TeamMemberCard(name: 'Dr. House', role: 'Supervising MD', active: false),
              const SizedBox(width: 12),
              _TeamMemberCard(name: 'Sam Wilson', role: 'Physiotherapist', active: true),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildActionCenter(FamilyDashboardViewModel vm) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _CircleAction(icon: Icons.chat_bubble_outline, label: 'Message'),
        _CircleAction(icon: Icons.videocam_outlined, label: 'Video Call'),
        _CircleAction(icon: Icons.payment_outlined, label: 'Billing'),
        _CircleAction(icon: Icons.history_outlined, label: 'Records'),
      ],
    );
  }

  Widget _buildCard({required String title, required Widget child}) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20), border: Border.all(color: const Color(0xFFF1F5F9))),
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

class _ActivityItem extends StatelessWidget {
  final IconData icon;
  final String text;
  final String time;
  final Color color;

  const _ActivityItem({required this.icon, required this.text, required this.time, required this.color});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: color, size: 20),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(text, style: const TextStyle(fontWeight: FontWeight.w500)),
                Text(time, style: const TextStyle(color: Colors.black38, fontSize: 12)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _TeamMemberCard extends StatelessWidget {
  final String name;
  final String role;
  final bool active;

  const _TeamMemberCard({required this.name, required this.role, required this.active});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16), border: Border.all(color: const Color(0xFFF1F5F9))),
      child: Row(
        children: [
          CircleAvatar(backgroundColor: Colors.indigo[50], child: Text(name[0])),
          const SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(name, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
              Text(role, style: const TextStyle(color: Colors.black54, fontSize: 11)),
              if (active) const Text('• ON DUTY', style: TextStyle(color: Colors.green, fontSize: 9, fontWeight: FontWeight.bold)),
            ],
          ),
        ],
      ),
    );
  }
}

class _CircleAction extends StatelessWidget {
  final IconData icon;
  final String label;

  const _CircleAction({required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(color: const Color(0xFFEEF2FF), shape: BoxShape.circle),
          child: Icon(icon, color: const Color(0xFF4338CA)),
        ),
        const SizedBox(height: 8),
        Text(label, style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w500)),
      ],
    );
  }
}

