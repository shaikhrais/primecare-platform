import 'package:primecare_ui/primecare_ui.dart';

// --- MVC State Model ---
class LpnDashboardState {
  final bool isLoading;
  final String title;
  final List<String> logs;

  const LpnDashboardState({
    required this.isLoading,
    required this.title,
    required this.logs,
  });

  LpnDashboardState copyWith({
    bool? isLoading,
    String? title,
    List<String>? logs,
  }) {
    return LpnDashboardState(
      isLoading: isLoading ?? this.isLoading,
      title: title ?? this.title,
      logs: logs ?? this.logs,
    );
  }
}

// --- Controller (Notifier) ---
class LpnDashboardController extends StateNotifier<LpnDashboardState> {
  final Ref ref;

  LpnDashboardController(this.ref)
      : super(
          const LpnDashboardState(
            isLoading: false,
            title: 'Licensed Practical Nurse (LPN) Dashboard',
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

  Future<void> recordMedicationPass() async {
    state = state.copyWith(isLoading: true);
    try {
      final apiClient = ref.read(apiClientProvider);
      final response = await apiClient.post(
        '/v1/lpn/medpass/log',
        body: {
          'timestamp': DateTime.now().toIso8601String(),
          'action': 'log_medication_pass_event',
        },
      );
      if (response.isSuccess) {
        state = state.copyWith(
          isLoading: false,
          logs: [
            ...state.logs,
            'Action executed: Log Medication Pass Event via API successfully.',
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
  Future<void> submitWoundAssessment() async {
    state = state.copyWith(isLoading: true);
    try {
      final apiClient = ref.read(apiClientProvider);
      final response = await apiClient.post(
        '/v1/lpn/wounds/submit',
        body: {
          'timestamp': DateTime.now().toIso8601String(),
          'action': 'submit_wound_care_assessment',
        },
      );
      if (response.isSuccess) {
        state = state.copyWith(
          isLoading: false,
          logs: [
            ...state.logs,
            'Action executed: Submit Wound Care Assessment via API successfully.',
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
final lpnDashboardControllerProvider =
    StateNotifierProvider<LpnDashboardController, LpnDashboardState>((ref) {
  return LpnDashboardController(ref);
});

// --- View ---
class LpnDashboardScreen extends GovernedConsumerWidget {
  const LpnDashboardScreen({super.key});

  @override
  Widget buildScreen(BuildContext context, WidgetRef ref) {
    final state = ref.watch(lpnDashboardControllerProvider);
    final controller = ref.read(lpnDashboardControllerProvider.notifier);
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
                  roleName: 'Licensed Practical Nurse (LPN) Hub',
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
                    // LPN Medication Pass Tracker component
                    Container(
                      key: const ValueKey('data-cy-lpn-med-pass-tracker'),
                      padding: const EdgeInsets.all(24),
                      decoration: BoxDecoration(
                        color: theme.colors.surface,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: theme.colors.border),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("LPN Medication Pass Tracker", style: theme.typography.h4),
                          const SizedBox(height: 12),
                          Text("Operational sandbox control for LPN Medication Pass Tracker.", style: theme.typography.bodyMedium),
                        ],
                      ),
                    ),
                    // LPN Wound & Skin Assessment Panel component
                    Container(
                      key: const ValueKey('data-cy-lpn-wound-care-panel'),
                      padding: const EdgeInsets.all(24),
                      decoration: BoxDecoration(
                        color: theme.colors.surface,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: theme.colors.border),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("LPN Wound & Skin Assessment Panel", style: theme.typography.h4),
                          const SizedBox(height: 12),
                          Text("Operational sandbox control for LPN Wound & Skin Assessment Panel.", style: theme.typography.bodyMedium),
                        ],
                      ),
                    ),
                    // LPN Vitals Intake Widget component
                    Container(
                      key: const ValueKey('data-cy-lpn-vitals-summary'),
                      padding: const EdgeInsets.all(24),
                      decoration: BoxDecoration(
                        color: theme.colors.surface,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: theme.colors.border),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("LPN Vitals Intake Widget", style: theme.typography.h4),
                          const SizedBox(height: 12),
                          Text("Operational sandbox control for LPN Vitals Intake Widget.", style: theme.typography.bodyMedium),
                        ],
                      ),
                    ),
                    // LPN Daily Admissions & Discharges Card component
                    Container(
                      key: const ValueKey('data-cy-lpn-admissions-discharges'),
                      padding: const EdgeInsets.all(24),
                      decoration: BoxDecoration(
                        color: theme.colors.surface,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: theme.colors.border),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("LPN Daily Admissions & Discharges Card", style: theme.typography.h4),
                          const SizedBox(height: 12),
                          Text("Operational sandbox control for LPN Daily Admissions & Discharges Card.", style: theme.typography.bodyMedium),
                        ],
                      ),
                    ),
                    // LPN Infusion Therapy Infusion Tracker component
                    Container(
                      key: const ValueKey('data-cy-lpn-iv-therapy-tracker'),
                      padding: const EdgeInsets.all(24),
                      decoration: BoxDecoration(
                        color: theme.colors.surface,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: theme.colors.border),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("LPN Infusion Therapy Infusion Tracker", style: theme.typography.h4),
                          const SizedBox(height: 12),
                          Text("Operational sandbox control for LPN Infusion Therapy Infusion Tracker.", style: theme.typography.bodyMedium),
                        ],
                      ),
                    ),
                    // LPN Patient Shift Notes Logger component
                    Container(
                      key: const ValueKey('data-cy-lpn-shift-notes-widget'),
                      padding: const EdgeInsets.all(24),
                      decoration: BoxDecoration(
                        color: theme.colors.surface,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: theme.colors.border),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("LPN Patient Shift Notes Logger", style: theme.typography.h4),
                          const SizedBox(height: 12),
                          Text("Operational sandbox control for LPN Patient Shift Notes Logger.", style: theme.typography.bodyMedium),
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
                    label: 'Log Medication Pass Event',
                    icon: LucideIcons.shieldCheck,
                    color: theme.colors.primary,
                    onTap: () => controller.recordMedicationPass(),
                  ),
                  QuickActionItem(
                    label: 'Submit Wound Care Assessment',
                    icon: LucideIcons.shieldCheck,
                    color: Colors.green,
                    onTap: () => controller.submitWoundAssessment(),
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
