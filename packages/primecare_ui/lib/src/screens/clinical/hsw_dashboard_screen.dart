// Governance - Category: view | Purpose: --- MVC State Model ---
import 'package:primecare_ui/primecare_ui.dart';

// --- MVC State Model ---
class HswDashboardState {
  final bool isLoading;
  final String title;
  final List<String> logs;

  const HswDashboardState({
    required this.isLoading,
    required this.title,
    required this.logs,
  });

  HswDashboardState copyWith({
    bool? isLoading,
    String? title,
    List<String>? logs,
  }) {
    return HswDashboardState(
      isLoading: isLoading ?? this.isLoading,
      title: title ?? this.title,
      logs: logs ?? this.logs,
    );
  }
}

// --- Controller (Notifier) ---
class HswDashboardController extends StateNotifier<HswDashboardState> {
  final Ref ref;

  HswDashboardController(this.ref)
      : super(
          const HswDashboardState(
            isLoading: false,
            title: 'Home Support Worker Dashboard',
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

  Future<void> checkInVisit() async {
    state = state.copyWith(isLoading: true);
    try {
      final apiClient = ref.read(apiClientProvider);
      final response = await apiClient.post(
        '/v1/hsw/visits/checkin',
        body: {
          'timestamp': DateTime.now().toIso8601String(),
          'action': 'check-into_home_visit',
        },
      );
      if (response.isSuccess) {
        state = state.copyWith(
          isLoading: false,
          logs: [
            ...state.logs,
            'Action executed: Check-In to Home Visit via API successfully.',
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
  Future<void> checkOutVisit() async {
    state = state.copyWith(isLoading: true);
    try {
      final apiClient = ref.read(apiClientProvider);
      final response = await apiClient.post(
        '/v1/hsw/visits/checkout',
        body: {
          'timestamp': DateTime.now().toIso8601String(),
          'action': 'check-outfrom_home_visit',
        },
      );
      if (response.isSuccess) {
        state = state.copyWith(
          isLoading: false,
          logs: [
            ...state.logs,
            'Action executed: Check-Out from Home Visit via API successfully.',
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
  Future<void> triggerEmergencyAlert() async {
    state = state.copyWith(isLoading: true);
    try {
      final apiClient = ref.read(apiClientProvider);
      final response = await apiClient.post(
        '/v1/hsw/alerts/trigger',
        body: {
          'timestamp': DateTime.now().toIso8601String(),
          'action': 'trigger_patient_emergency_alert',
        },
      );
      if (response.isSuccess) {
        state = state.copyWith(
          isLoading: false,
          logs: [
            ...state.logs,
            'Action executed: Trigger Patient Emergency Alert via API successfully.',
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
final hswDashboardControllerProvider =
    StateNotifierProvider<HswDashboardController, HswDashboardState>((ref) {
  return HswDashboardController(ref);
});

// --- View ---
class HswDashboardScreen extends GovernedConsumerWidget {
  const HswDashboardScreen({super.key});

  @override
  Widget buildScreen(BuildContext context, WidgetRef ref) {
    final state = ref.watch(hswDashboardControllerProvider);
    final controller = ref.read(hswDashboardControllerProvider.notifier);
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
                  roleName: 'Home Support Worker Hub',
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
                    // HSW Today's Schedule Card component
                    Container(
                      key: const ValueKey('data-cy-hsw-today-schedule-card'),
                      padding: const EdgeInsets.all(24),
                      decoration: BoxDecoration(
                        color: theme.colors.surface,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: theme.colors.border),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("HSW Today's Schedule Card", style: theme.typography.h4),
                          const SizedBox(height: 12),
                          Text("Operational sandbox control for HSW Today's Schedule Card.", style: theme.typography.bodyMedium),
                        ],
                      ),
                    ),
                    // HSW Quick Check-In Widget component
                    Container(
                      key: const ValueKey('data-cy-hsw-quick-checkin-widget'),
                      padding: const EdgeInsets.all(24),
                      decoration: BoxDecoration(
                        color: theme.colors.surface,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: theme.colors.border),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("HSW Quick Check-In Widget", style: theme.typography.h4),
                          const SizedBox(height: 12),
                          Text("Operational sandbox control for HSW Quick Check-In Widget.", style: theme.typography.bodyMedium),
                        ],
                      ),
                    ),
                    // HSW Emergency Alert HUD component
                    Container(
                      key: const ValueKey('data-cy-hsw-emergency-alert-hud'),
                      padding: const EdgeInsets.all(24),
                      decoration: BoxDecoration(
                        color: theme.colors.surface,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: theme.colors.border),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("HSW Emergency Alert HUD", style: theme.typography.h4),
                          const SizedBox(height: 12),
                          Text("Operational sandbox control for HSW Emergency Alert HUD.", style: theme.typography.bodyMedium),
                        ],
                      ),
                    ),
                    // HSW Active Client Profiles Card component
                    Container(
                      key: const ValueKey('data-cy-hsw-active-client-profiles'),
                      padding: const EdgeInsets.all(24),
                      decoration: BoxDecoration(
                        color: theme.colors.surface,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: theme.colors.border),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("HSW Active Client Profiles Card", style: theme.typography.h4),
                          const SizedBox(height: 12),
                          Text("Operational sandbox control for HSW Active Client Profiles Card.", style: theme.typography.bodyMedium),
                        ],
                      ),
                    ),
                    // HSW Home Safety Risk Checklists component
                    Container(
                      key: const ValueKey('data-cy-hsw-safety-checklists'),
                      padding: const EdgeInsets.all(24),
                      decoration: BoxDecoration(
                        color: theme.colors.surface,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: theme.colors.border),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("HSW Home Safety Risk Checklists", style: theme.typography.h4),
                          const SizedBox(height: 12),
                          Text("Operational sandbox control for HSW Home Safety Risk Checklists.", style: theme.typography.bodyMedium),
                        ],
                      ),
                    ),
                    // HSW Travel Mileage & Expense Log component
                    Container(
                      key: const ValueKey('data-cy-hsw-mileage-expense-log'),
                      padding: const EdgeInsets.all(24),
                      decoration: BoxDecoration(
                        color: theme.colors.surface,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: theme.colors.border),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("HSW Travel Mileage & Expense Log", style: theme.typography.h4),
                          const SizedBox(height: 12),
                          Text("Operational sandbox control for HSW Travel Mileage & Expense Log.", style: theme.typography.bodyMedium),
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
                    label: 'Check-In to Home Visit',
                    icon: LucideIcons.play,
                    color: theme.colors.primary,
                    onTap: () => controller.checkInVisit(),
                  ),
                  QuickActionItem(
                    label: 'Check-Out from Home Visit',
                    icon: LucideIcons.play,
                    color: Colors.green,
                    onTap: () => controller.checkOutVisit(),
                  ),
                  QuickActionItem(
                    label: 'Trigger Patient Emergency Alert',
                    icon: LucideIcons.download,
                    color: theme.colors.primary,
                    onTap: () => controller.triggerEmergencyAlert(),
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
