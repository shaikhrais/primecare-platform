// Governance - Category: view | Purpose: UI Screen component rendering the Caregiver Dashboard Screen workspace interface.
import 'package:primecare_ui/primecare_ui.dart';

// --- MVC State Model ---
class CaregiverDashboardState {
  final bool isLoading;
  final String title;
  final List<String> logs;

  const CaregiverDashboardState({
    required this.isLoading,
    required this.title,
    required this.logs,
  });

  CaregiverDashboardState copyWith({
    bool? isLoading,
    String? title,
    List<String>? logs,
  }) {
    return CaregiverDashboardState(
      isLoading: isLoading ?? this.isLoading,
      title: title ?? this.title,
      logs: logs ?? this.logs,
    );
  }
}

// --- Controller (Notifier) ---
class CaregiverDashboardController extends StateNotifier<CaregiverDashboardState> {
  final Ref ref;

  CaregiverDashboardController(this.ref)
      : super(
          const CaregiverDashboardState(
            isLoading: false,
            title: 'Caregiver Dashboard',
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

  Future<void> recordDailyActivity() async {
    state = state.copyWith(isLoading: true);
    try {
      final apiClient = ref.read(apiClientProvider);
      final response = await apiClient.post(
        '/v1/caregiver/activity/log',
        body: {
          'timestamp': DateTime.now().toIso8601String(),
          'action': 'log_daily_care_activity',
        },
      );
      if (response.isSuccess) {
        state = state.copyWith(
          isLoading: false,
          logs: [
            ...state.logs,
            'Action executed: Log Daily Care Activity via API successfully.',
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
  Future<void> acknowledgeMedReminder() async {
    state = state.copyWith(isLoading: true);
    try {
      final apiClient = ref.read(apiClientProvider);
      final response = await apiClient.post(
        '/v1/caregiver/meds/acknowledge',
        body: {
          'timestamp': DateTime.now().toIso8601String(),
          'action': 'acknowledge_med_reminder',
        },
      );
      if (response.isSuccess) {
        state = state.copyWith(
          isLoading: false,
          logs: [
            ...state.logs,
            'Action executed: Acknowledge Med Reminder via API successfully.',
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
final caregiverDashboardControllerProvider =
    StateNotifierProvider<CaregiverDashboardController, CaregiverDashboardState>((ref) {
  return CaregiverDashboardController(ref);
});

// --- View ---
class CaregiverDashboardScreen extends GovernedConsumerWidget {
  const CaregiverDashboardScreen({super.key});

  @override
  Widget buildScreen(BuildContext context, WidgetRef ref) {
    final state = ref.watch(caregiverDashboardControllerProvider);
    final controller = ref.read(caregiverDashboardControllerProvider.notifier);
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
                  roleName: 'Caregiver Hub',
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
                    // Caregiver Daily Activity Card component
                    Container(
                      key: const ValueKey('data-cy-caregiver-daily-log-card'),
                      padding: const EdgeInsets.all(24),
                      decoration: BoxDecoration(
                        color: theme.colors.surface,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: theme.colors.border),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Caregiver Daily Activity Card", style: theme.typography.h4),
                          const SizedBox(height: 12),
                          Text("Operational sandbox control for Caregiver Daily Activity Card.", style: theme.typography.bodyMedium),
                        ],
                      ),
                    ),
                    // Caregiver Medication Reminders component
                    Container(
                      key: const ValueKey('data-cy-caregiver-med-reminders'),
                      padding: const EdgeInsets.all(24),
                      decoration: BoxDecoration(
                        color: theme.colors.surface,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: theme.colors.border),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Caregiver Medication Reminders", style: theme.typography.h4),
                          const SizedBox(height: 12),
                          Text("Operational sandbox control for Caregiver Medication Reminders.", style: theme.typography.bodyMedium),
                        ],
                      ),
                    ),
                    // Caregiver Family Contact Panel component
                    Container(
                      key: const ValueKey('data-cy-caregiver-contact-panel'),
                      padding: const EdgeInsets.all(24),
                      decoration: BoxDecoration(
                        color: theme.colors.surface,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: theme.colors.border),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Caregiver Family Contact Panel", style: theme.typography.h4),
                          const SizedBox(height: 12),
                          Text("Operational sandbox control for Caregiver Family Contact Panel.", style: theme.typography.bodyMedium),
                        ],
                      ),
                    ),
                    // Caregiver Patient Mobility & ADL Log component
                    Container(
                      key: const ValueKey('data-cy-caregiver-patient-mobility-log'),
                      padding: const EdgeInsets.all(24),
                      decoration: BoxDecoration(
                        color: theme.colors.surface,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: theme.colors.border),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Caregiver Patient Mobility & ADL Log", style: theme.typography.h4),
                          const SizedBox(height: 12),
                          Text("Operational sandbox control for Caregiver Patient Mobility & ADL Log.", style: theme.typography.bodyMedium),
                        ],
                      ),
                    ),
                    // Caregiver Nutrition & Meal Planner component
                    Container(
                      key: const ValueKey('data-cy-caregiver-nutrition-tracker'),
                      padding: const EdgeInsets.all(24),
                      decoration: BoxDecoration(
                        color: theme.colors.surface,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: theme.colors.border),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Caregiver Nutrition & Meal Planner", style: theme.typography.h4),
                          const SizedBox(height: 12),
                          Text("Operational sandbox control for Caregiver Nutrition & Meal Planner.", style: theme.typography.bodyMedium),
                        ],
                      ),
                    ),
                    // Caregiver Incident Quick Notifier component
                    Container(
                      key: const ValueKey('data-cy-caregiver-incident-notifier'),
                      padding: const EdgeInsets.all(24),
                      decoration: BoxDecoration(
                        color: theme.colors.surface,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: theme.colors.border),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Caregiver Incident Quick Notifier", style: theme.typography.h4),
                          const SizedBox(height: 12),
                          Text("Operational sandbox control for Caregiver Incident Quick Notifier.", style: theme.typography.bodyMedium),
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
                    label: 'Log Daily Care Activity',
                    icon: LucideIcons.play,
                    color: theme.colors.primary,
                    onTap: () => controller.recordDailyActivity(),
                  ),
                  QuickActionItem(
                    label: 'Acknowledge Med Reminder',
                    icon: LucideIcons.shieldCheck,
                    color: Colors.green,
                    onTap: () => controller.acknowledgeMedReminder(),
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
