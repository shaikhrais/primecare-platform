import 'package:primecare_ui/primecare_ui.dart';
import 'psw_dashboard_controller.dart';

class PswDashboardView extends ConsumerWidget {
  const PswDashboardView({super.key});

  // UI Constants
  static const String _titleKey = 'psw.dashboard.title';
  static const String _shiftStatusLabel = 'Active Shift Status';
  static const String _upcomingVisitsLabel = 'Upcoming Visits';
  static const String _pendingTasksLabel = 'Pending Tasks';
  static const String _shiftProgressLabel = 'Shift Progress';
  static const String _monthlyTasksLabel = 'Monthly Tasks';
  static const String _nextReviewLabel = 'Next Review';
  static const String _shiftActiveStatus = 'Shift Active';
  static const String _defaultPswName = 'PSW';
  static const String _avatarUrlBase = 'https://i.pravatar.cc/150?u=';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(pswDashboardControllerProvider);
    final auth = state.authState.asData?.value;

    return state.dashboardData.when(
      data: (PswDashboardData data) => _buildContent(context, ref, data, auth),
      loading: () => const DashboardLoadingWidget(),
      error: (err, stack) => DashboardErrorWidget(
        message: err.toString(),
        onRetry: () => ref.read(pswDashboardControllerProvider.notifier).refresh(),
      ),
    );
  }

  Widget _buildContent(BuildContext context, WidgetRef ref, PswDashboardData data, AuthState? auth) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildHeader(auth),
          const SizedBox(height: 24),
          const DashboardSectionHeader(title: _shiftStatusLabel),
          const SizedBox(height: 8),
          _buildShiftStatus(data),
          const SizedBox(height: 24),
          _buildQuickStats(data),
          const SizedBox(height: 24),
          const DashboardSectionHeader(title: _upcomingVisitsLabel),
          const SizedBox(height: 12),
          ...data.clients.map((client) => _buildClientCard(context, client)),
          const SizedBox(height: 24),
          const DashboardSectionHeader(title: _pendingTasksLabel),
          const SizedBox(height: 12),
          ...data.tasks.map((task) => _buildTaskItem(task)),
        ],
      ),
    );
  }

  Widget _buildHeader(AuthState? auth) {
    final userName = auth?.userName ?? _defaultPswName;
    final welcomeText = 'Welcome, $userName';
    final avatarUrl = '$_avatarUrlBase${auth?.userId ?? "psw"}';

    return Row(
      children: [
        CircleAvatar(
          radius: 30,
          backgroundImage: NetworkImage(avatarUrl),
        ),
        const SizedBox(width: 16),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              welcomeText,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
            ),
            const Text(
              _shiftActiveStatus,
              style: TextStyle(color: Colors.green, fontWeight: FontWeight.w500),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildShiftStatus(PswDashboardData data) {
    final progressValue = data.shiftProgress;
    final remainingTime = data.shiftDurationRemaining;

    return PrimeCareCard(
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(_shiftProgressLabel, style: TextStyle(color: Colors.white70)),
              Text(remainingTime, style: const TextStyle(color: Colors.white)),
            ],
          ),
          const SizedBox(height: 8),
          LinearProgressIndicator(
            value: progressValue,
            backgroundColor: Colors.white10,
            valueColor: const AlwaysStoppedAnimation<Color>(Colors.blue),
          ),
        ],
      ),
    );
  }

  Widget _buildQuickStats(PswDashboardData data) {
    return GridView.count(
      crossAxisCount: 2,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisSpacing: 16,
      mainAxisSpacing: 16,
      childAspectRatio: 1.5,
      children: [
        _buildStatCard(_monthlyTasksLabel, data.monthlyCompletedTasks.toString(), Icons.check_circle),
        _buildStatCard(_nextReviewLabel, data.nextReviewDate, Icons.event),
      ],
    );
  }

  Widget _buildStatCard(String label, String value, IconData icon) {
    return PrimeCareCard(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: Colors.blue),
          const SizedBox(height: 8),
          Text(value, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white)),
          Text(label, style: const TextStyle(fontSize: 12, color: Colors.white60)),
        ],
      ),
    );
  }

  Widget _buildClientCard(BuildContext context, PswClient client) {
    final name = client.name;
    final condition = client.condition;
    final location = client.location;
    final nextVisit = client.nextVisitTime;
    final status = client.status;

    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: PrimeCareCard(
        onTap: () {
          // Navigate to client profile
        },
        child: Row(
          children: [
            Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                color: Colors.blue.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Icon(Icons.person, color: Colors.blue),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(name, style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
                  Text(condition, style: const TextStyle(fontSize: 12, color: Colors.white60)),
                  Text(location, style: const TextStyle(fontSize: 12, color: Colors.white60)),
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(nextVisit, style: const TextStyle(color: Colors.blue, fontWeight: FontWeight.bold)),
                Text(status, style: const TextStyle(fontSize: 10, color: Colors.green)),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTaskItem(PswTask task) {
    final title = task.title;
    final description = task.description;
    final isCompleted = task.isCompleted;
    final isHighPriority = task.isHighPriority;

    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: PrimeCareCard(
        child: Row(
          children: [
            Checkbox(
              value: isCompleted, 
              onChanged: (v) {},
              side: const BorderSide(color: Colors.white30),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      decoration: isCompleted ? TextDecoration.lineThrough : null,
                    ),
                  ),
                  Text(description, style: const TextStyle(fontSize: 12, color: Colors.white60)),
                ],
              ),
            ),
            if (isHighPriority)
              const Icon(Icons.priority_high, color: Colors.red, size: 16),
          ],
        ),
      ),
    );
  }
}
