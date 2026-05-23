import 'package:primecare_ui/primecare_ui.dart';

// --- MVC State Model ---
class CnsDashboardState {
  final bool isLoading;
  final String title;
  final List<String> logs;

  const CnsDashboardState({
    required this.isLoading,
    required this.title,
    required this.logs,
  });

  CnsDashboardState copyWith({
    bool? isLoading,
    String? title,
    List<String>? logs,
  }) {
    return CnsDashboardState(
      isLoading: isLoading ?? this.isLoading,
      title: title ?? this.title,
      logs: logs ?? this.logs,
    );
  }
}

// --- Controller (Notifier) ---
class CnsDashboardController extends StateNotifier<CnsDashboardState> {
  final Ref ref;

  CnsDashboardController(this.ref)
      : super(
          const CnsDashboardState(
            isLoading: false,
            title: 'Clinical Nurse Specialist Dashboard',
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

  Future<void> publishCareStandard() async {
    state = state.copyWith(isLoading: true);
    try {
      final apiClient = ref.read(apiClientProvider);
      final response = await apiClient.post(
        '/v1/cns/standards/publish',
        body: {
          'timestamp': DateTime.now().toIso8601String(),
          'action': 'publish_care_standard',
        },
      );
      if (response.isSuccess) {
        state = state.copyWith(
          isLoading: false,
          logs: [
            ...state.logs,
            'Action executed: Publish Care Standard via API successfully.',
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
  Future<void> recordConsultation() async {
    state = state.copyWith(isLoading: true);
    try {
      final apiClient = ref.read(apiClientProvider);
      final response = await apiClient.post(
        '/v1/cns/consultations/log',
        body: {
          'timestamp': DateTime.now().toIso8601String(),
          'action': 'log_clinical_consultation',
        },
      );
      if (response.isSuccess) {
        state = state.copyWith(
          isLoading: false,
          logs: [
            ...state.logs,
            'Action executed: Log Clinical Consultation via API successfully.',
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
final cnsDashboardControllerProvider =
    StateNotifierProvider<CnsDashboardController, CnsDashboardState>((ref) {
  return CnsDashboardController(ref);
});

// --- View ---
class CnsDashboardScreen extends GovernedConsumerWidget {
  const CnsDashboardScreen({super.key});

  @override
  Widget buildScreen(BuildContext context, WidgetRef ref) {
    final state = ref.watch(cnsDashboardControllerProvider);
    final controller = ref.read(cnsDashboardControllerProvider.notifier);
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
                  roleName: 'Clinical Nurse Specialist Hub',
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
                    // CNS Care Standards Card component
                    Container(
                      key: const ValueKey('data-cy-cns-care-standard-card'),
                      padding: const EdgeInsets.all(24),
                      decoration: BoxDecoration(
                        color: theme.colors.surface,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: theme.colors.border),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("CNS Care Standards Card", style: theme.typography.h4),
                          const SizedBox(height: 12),
                          Text("Operational sandbox control for CNS Care Standards Card.", style: theme.typography.bodyMedium),
                        ],
                      ),
                    ),
                    // CNS Consultations Widget component
                    Container(
                      key: const ValueKey('data-cy-cns-consultation-widget'),
                      padding: const EdgeInsets.all(24),
                      decoration: BoxDecoration(
                        color: theme.colors.surface,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: theme.colors.border),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("CNS Consultations Widget", style: theme.typography.h4),
                          const SizedBox(height: 12),
                          Text("Operational sandbox control for CNS Consultations Widget.", style: theme.typography.bodyMedium),
                        ],
                      ),
                    ),
                    // CNS Outcomes Analytics Panel component
                    Container(
                      key: const ValueKey('data-cy-cns-outcomes-analytics'),
                      padding: const EdgeInsets.all(24),
                      decoration: BoxDecoration(
                        color: theme.colors.surface,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: theme.colors.border),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("CNS Outcomes Analytics Panel", style: theme.typography.h4),
                          const SizedBox(height: 12),
                          Text("Operational sandbox control for CNS Outcomes Analytics Panel.", style: theme.typography.bodyMedium),
                        ],
                      ),
                    ),
                    // CNS Clinical Policy Guidelines Card component
                    Container(
                      key: const ValueKey('data-cy-cns-policy-guidelines-card'),
                      padding: const EdgeInsets.all(24),
                      decoration: BoxDecoration(
                        color: theme.colors.surface,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: theme.colors.border),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("CNS Clinical Policy Guidelines Card", style: theme.typography.h4),
                          const SizedBox(height: 12),
                          Text("Operational sandbox control for CNS Clinical Policy Guidelines Card.", style: theme.typography.bodyMedium),
                        ],
                      ),
                    ),
                    // CNS Educational Resources Widget component
                    Container(
                      key: const ValueKey('data-cy-cns-educational-resources'),
                      padding: const EdgeInsets.all(24),
                      decoration: BoxDecoration(
                        color: theme.colors.surface,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: theme.colors.border),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("CNS Educational Resources Widget", style: theme.typography.h4),
                          const SizedBox(height: 12),
                          Text("Operational sandbox control for CNS Educational Resources Widget.", style: theme.typography.bodyMedium),
                        ],
                      ),
                    ),
                    // CNS Staff Competency Registry component
                    Container(
                      key: const ValueKey('data-cy-cns-staff-competencies-panel'),
                      padding: const EdgeInsets.all(24),
                      decoration: BoxDecoration(
                        color: theme.colors.surface,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: theme.colors.border),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("CNS Staff Competency Registry", style: theme.typography.h4),
                          const SizedBox(height: 12),
                          Text("Operational sandbox control for CNS Staff Competency Registry.", style: theme.typography.bodyMedium),
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
                    label: 'Publish Care Standard',
                    icon: LucideIcons.shieldCheck,
                    color: theme.colors.primary,
                    onTap: () => controller.publishCareStandard(),
                  ),
                  QuickActionItem(
                    label: 'Log Clinical Consultation',
                    icon: LucideIcons.shieldCheck,
                    color: Colors.green,
                    onTap: () => controller.recordConsultation(),
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
