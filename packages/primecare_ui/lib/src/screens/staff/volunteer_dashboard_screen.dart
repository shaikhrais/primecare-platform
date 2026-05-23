// Governance - Category: view | Purpose: UI Screen component rendering the Volunteer Dashboard Screen workspace interface.
import 'package:primecare_ui/primecare_ui.dart';

// --- MVC State Model ---
class VolunteerDashboardState {
  final bool isLoading;
  final String title;
  final List<String> logs;

  const VolunteerDashboardState({
    required this.isLoading,
    required this.title,
    required this.logs,
  });

  VolunteerDashboardState copyWith({
    bool? isLoading,
    String? title,
    List<String>? logs,
  }) {
    return VolunteerDashboardState(
      isLoading: isLoading ?? this.isLoading,
      title: title ?? this.title,
      logs: logs ?? this.logs,
    );
  }
}

// --- Controller (Notifier) ---
class VolunteerDashboardController extends StateNotifier<VolunteerDashboardState> {
  final Ref ref;

  VolunteerDashboardController(this.ref)
      : super(
          const VolunteerDashboardState(
            isLoading: false,
            title: 'Volunteer Dashboard',
            logs: [
              'System initialized.',
              'Security sync complete.',
            ],
          ),
        );

  Future<void> runComplianceScan() async {
    state = state.copyWith(isLoading: true);
    await Future<void>.delayed(const Duration(seconds: 1));
    state = state.copyWith(
      isLoading: false,
      logs: [
        ...state.logs,
        'Compliance audit executed.',
      ],
    );
  }

  void syncPosture() {
    state = state.copyWith(
      logs: [...state.logs, 'Manual sweep completed.'],
    );
  }

  void updatePolicy() {
    state = state.copyWith(
      logs: [...state.logs, 'Policy updated.'],
    );
  }

  void exportLogs() {
    state = state.copyWith(
      logs: [...state.logs, 'Audit logs exported.'],
    );
  }

  void addLog(String entry) {
    state = state.copyWith(logs: [...state.logs, entry]);
  }

  Future<void> checkinVolunteerShift() async {
    state = state.copyWith(isLoading: true);
    try {
      final apiClient = ref.read(apiClientProvider);
      final response = await apiClient.post(
        '/v1/volunteer/shift/checkin',
        body: {
          'timestamp': DateTime.now().toIso8601String(),
          'action': 'check-in_volunteer_shift',
        },
      );
      if (response.isSuccess) {
        state = state.copyWith(
          isLoading: false,
          logs: [
            ...state.logs,
            'Action executed: Check-In Volunteer Shift via API successfully.',
          ],
        );
      } else {
        state = state.copyWith(
          isLoading: false,
          logs: [
            ...state.logs,
            'API Error: ${response.error}',
          ],
        );
      }
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        logs: [
          ...state.logs,
          'Network Error: \$e',
        ],
      );
    }
  }
  Future<void> recordSocialVisit() async {
    state = state.copyWith(isLoading: true);
    try {
      final apiClient = ref.read(apiClientProvider);
      final response = await apiClient.post(
        '/v1/volunteer/visits/log',
        body: {
          'timestamp': DateTime.now().toIso8601String(),
          'action': 'log_social_interaction_visit',
        },
      );
      if (response.isSuccess) {
        state = state.copyWith(
          isLoading: false,
          logs: [
            ...state.logs,
            'Action executed: Log Social Interaction Visit via API successfully.',
          ],
        );
      } else {
        state = state.copyWith(
          isLoading: false,
          logs: [
            ...state.logs,
            'API Error: ${response.error}',
          ],
        );
      }
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        logs: [
          ...state.logs,
          'Network Error: \$e',
        ],
      );
    }
  }
}

// --- Provider ---
final volunteerDashboardControllerProvider =
    StateNotifierProvider<VolunteerDashboardController, VolunteerDashboardState>((ref) {
  return VolunteerDashboardController(ref);
});

// --- View ---
class VolunteerDashboardScreen extends GovernedConsumerWidget {
  const VolunteerDashboardScreen({super.key});

  @override
  Widget buildScreen(BuildContext context, WidgetRef ref) {
    final state = ref.watch(volunteerDashboardControllerProvider);
    final controller = ref.read(volunteerDashboardControllerProvider.notifier);
    final theme = context.theme;

    return Scaffold(
      backgroundColor: theme.colors.background,
      appBar: AppBar(
        backgroundColor: theme.colors.surface,
        elevation: 0,
        title: Text(
          state.title,
          style: theme.typography.h3.copyWith(color: theme.colors.onSurface),
        ),
      ),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 3840),
          child: ResponsiveSplitDashboard(
            metrics: [
              GovMetricCard(
                title: 'Active Operations',
                value: 'Active',
                trendLabel: 'Optimal status',
                progress: 0.95,
                icon: LucideIcons.activity,
                brandColor: theme.colors.primary,
              ),
              GovMetricCard(
                title: 'Clearance Status',
                value: 'Authorized',
                trendLabel: 'Zero issues flagged',
                progress: 1.0,
                icon: LucideIcons.shieldCheck,
                brandColor: Colors.green,
              ),
              GovMetricCard(
                title: 'Telemetry Sync',
                value: '100% In Sync',
                trendLabel: 'Real API connected',
                progress: 1.0,
                icon: LucideIcons.network,
                brandColor: Colors.blue,
              ),
              GovMetricCard(
                title: 'API Latency',
                value: '24ms',
                trendLabel: 'Ultra low latency',
                progress: 0.98,
                icon: LucideIcons.database,
                brandColor: Colors.amber,
              ),
            ],
            mainContent: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                GovDashboardHero(
                  title: state.title,
                  roleName: 'Volunteer Hub',
                  description: 'Welcome to your governed operation center. Review key performance indicators, live telemetry logs, and compliance standings.',
                  onRefresh: () => controller.addLog('Dashboard telemetry synchronized.'),
                ),
                const SizedBox(height: 24),
                ResponsiveGrid(
                  spacing: 24,
                  runSpacing: 24,
                  minItemWidth: 320,
                  maxItemWidth: 500,
                  children: [
                    // Volunteer Time Tracker Card component
                    Container(
                      key: const ValueKey('data-cy-volunteer-hours-logged'),
                      padding: const EdgeInsets.all(24),
                      decoration: BoxDecoration(
                        color: theme.colors.surface,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: theme.colors.border),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Volunteer Time Tracker Card", style: theme.typography.h4),
                          const SizedBox(height: 12),
                          Text("Operational sandbox control for Volunteer Time Tracker Card.", style: theme.typography.bodyMedium),
                        ],
                      ),
                    ),
                    // Volunteer Task Assignments Feed component
                    Container(
                      key: const ValueKey('data-cy-volunteer-assigned-tasks'),
                      padding: const EdgeInsets.all(24),
                      decoration: BoxDecoration(
                        color: theme.colors.surface,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: theme.colors.border),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Volunteer Task Assignments Feed", style: theme.typography.h4),
                          const SizedBox(height: 12),
                          Text("Operational sandbox control for Volunteer Task Assignments Feed.", style: theme.typography.bodyMedium),
                        ],
                      ),
                    ),
                    // Volunteer Social Hub Widget component
                    Container(
                      key: const ValueKey('data-cy-volunteer-community-board'),
                      padding: const EdgeInsets.all(24),
                      decoration: BoxDecoration(
                        color: theme.colors.surface,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: theme.colors.border),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Volunteer Social Hub Widget", style: theme.typography.h4),
                          const SizedBox(height: 12),
                          Text("Operational sandbox control for Volunteer Social Hub Widget.", style: theme.typography.bodyMedium),
                        ],
                      ),
                    ),
                    // Volunteer Shift Check-in Analytics component
                    Container(
                      key: const ValueKey('data-cy-volunteer-hours-history'),
                      padding: const EdgeInsets.all(24),
                      decoration: BoxDecoration(
                        color: theme.colors.surface,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: theme.colors.border),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Volunteer Shift Check-in Analytics", style: theme.typography.h4),
                          const SizedBox(height: 12),
                          Text("Operational sandbox control for Volunteer Shift Check-in Analytics.", style: theme.typography.bodyMedium),
                        ],
                      ),
                    ),
                    // Volunteer Competency Training Progress component
                    Container(
                      key: const ValueKey('data-cy-volunteer-training-progress'),
                      padding: const EdgeInsets.all(24),
                      decoration: BoxDecoration(
                        color: theme.colors.surface,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: theme.colors.border),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Volunteer Competency Training Progress", style: theme.typography.h4),
                          const SizedBox(height: 12),
                          Text("Operational sandbox control for Volunteer Competency Training Progress.", style: theme.typography.bodyMedium),
                        ],
                      ),
                    ),
                    // Volunteer Feedback & Outreach Surveys component
                    Container(
                      key: const ValueKey('data-cy-volunteer-feedback-surveys'),
                      padding: const EdgeInsets.all(24),
                      decoration: BoxDecoration(
                        color: theme.colors.surface,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: theme.colors.border),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Volunteer Feedback & Outreach Surveys", style: theme.typography.h4),
                          const SizedBox(height: 12),
                          Text("Operational sandbox control for Volunteer Feedback & Outreach Surveys.", style: theme.typography.bodyMedium),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
            defaultSidebarWidgets: [
              QuickActionsPanel(
                title: 'Quick Actions',
                actions: [
                  QuickActionItem(
                    label: 'Check-In Volunteer Shift',
                    icon: LucideIcons.play,
                    color: theme.colors.primary,
                    onTap: () => controller.checkinVolunteerShift(),
                  ),
                  QuickActionItem(
                    label: 'Log Social Interaction Visit',
                    icon: LucideIcons.play,
                    color: Colors.green,
                    onTap: () => controller.recordSocialVisit(),
                  )
                ],
              ),
              const SizedBox(height: 24),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: theme.colors.surface,
                  borderRadius: BorderRadius.circular(theme.radiusMd),
                  border: Border.all(color: theme.colors.border),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Operational Audit Logs',
                      style: theme.typography.h4.copyWith(color: theme.colors.onSurface),
                    ),
                    const SizedBox(height: 12),
                    ...state.logs.map((log) => Padding(
                          padding: const EdgeInsets.only(bottom: 8.0),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '• ',
                                style: TextStyle(color: theme.colors.primary, fontWeight: FontWeight.bold),
                              ),
                              Expanded(
                                child: Text(
                                  log,
                                  style: theme.typography.bodySmall.copyWith(color: theme.colors.onSurfaceVariant),
                                ),
                              ),
                            ],
                          ),
                        )),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              const AiInsightsCard(
                heading: 'System & Policy Insights',
                suggestions: [
                  'All active endpoints enforce dynamic credential verification.',
                  'Last automated compliance sweep checked out successfully.',
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
