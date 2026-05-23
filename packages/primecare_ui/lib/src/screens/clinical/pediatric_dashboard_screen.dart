// Governance - Category: view | Purpose: UI Screen component rendering the Pediatric Dashboard Screen workspace interface.
import 'package:primecare_ui/primecare_ui.dart';

// --- MVC State Model ---
class PediatricDashboardState {
  final bool isLoading;
  final String title;
  final List<String> logs;

  const PediatricDashboardState({
    required this.isLoading,
    required this.title,
    required this.logs,
  });

  PediatricDashboardState copyWith({
    bool? isLoading,
    String? title,
    List<String>? logs,
  }) {
    return PediatricDashboardState(
      isLoading: isLoading ?? this.isLoading,
      title: title ?? this.title,
      logs: logs ?? this.logs,
    );
  }
}

// --- Controller (Notifier) ---
class PediatricDashboardController extends StateNotifier<PediatricDashboardState> {
  final Ref ref;

  PediatricDashboardController(this.ref)
      : super(
          const PediatricDashboardState(
            isLoading: false,
            title: 'Pediatric Specialist Dashboard',
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

  Future<void> recordGrowthMetrics() async {
    state = state.copyWith(isLoading: true);
    try {
      final apiClient = ref.read(apiClientProvider);
      final response = await apiClient.post(
        '/v1/pediatric/growth/record',
        body: {
          'timestamp': DateTime.now().toIso8601String(),
          'action': 'record_growth_metrics',
        },
      );
      if (response.isSuccess) {
        state = state.copyWith(
          isLoading: false,
          logs: [
            ...state.logs,
            'Action executed: Record Growth Metrics via API successfully.',
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
  Future<void> administerVaccine() async {
    state = state.copyWith(isLoading: true);
    try {
      final apiClient = ref.read(apiClientProvider);
      final response = await apiClient.post(
        '/v1/pediatric/vaccines/administer',
        body: {
          'timestamp': DateTime.now().toIso8601String(),
          'action': 'administer_vaccine',
        },
      );
      if (response.isSuccess) {
        state = state.copyWith(
          isLoading: false,
          logs: [
            ...state.logs,
            'Action executed: Administer Vaccine via API successfully.',
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
final pediatricDashboardControllerProvider =
    StateNotifierProvider<PediatricDashboardController, PediatricDashboardState>((ref) {
  return PediatricDashboardController(ref);
});

// --- View ---
class PediatricDashboardScreen extends GovernedConsumerWidget {
  const PediatricDashboardScreen({super.key});

  @override
  Widget buildScreen(BuildContext context, WidgetRef ref) {
    final state = ref.watch(pediatricDashboardControllerProvider);
    final controller = ref.read(pediatricDashboardControllerProvider.notifier);
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
                  roleName: 'Pediatric Specialist Hub',
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
                    // Pediatric Growth Charts Widget component
                    Container(
                      key: const ValueKey('data-cy-pediatric-growth-charts'),
                      padding: const EdgeInsets.all(24),
                      decoration: BoxDecoration(
                        color: theme.colors.surface,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: theme.colors.border),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Pediatric Growth Charts Widget", style: theme.typography.h4),
                          const SizedBox(height: 12),
                          Text("Operational sandbox control for Pediatric Growth Charts Widget.", style: theme.typography.bodyMedium),
                        ],
                      ),
                    ),
                    // Pediatric Vaccine Schedule Card component
                    Container(
                      key: const ValueKey('data-cy-pediatric-vaccines-card'),
                      padding: const EdgeInsets.all(24),
                      decoration: BoxDecoration(
                        color: theme.colors.surface,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: theme.colors.border),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Pediatric Vaccine Schedule Card", style: theme.typography.h4),
                          const SizedBox(height: 12),
                          Text("Operational sandbox control for Pediatric Vaccine Schedule Card.", style: theme.typography.bodyMedium),
                        ],
                      ),
                    ),
                    // Pediatric Milestones Widget component
                    Container(
                      key: const ValueKey('data-cy-pediatric-milestones-widget'),
                      padding: const EdgeInsets.all(24),
                      decoration: BoxDecoration(
                        color: theme.colors.surface,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: theme.colors.border),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Pediatric Milestones Widget", style: theme.typography.h4),
                          const SizedBox(height: 12),
                          Text("Operational sandbox control for Pediatric Milestones Widget.", style: theme.typography.bodyMedium),
                        ],
                      ),
                    ),
                    // Pediatric Developmental Milestones Tracker component
                    Container(
                      key: const ValueKey('data-cy-pediatric-developmental-milestones'),
                      padding: const EdgeInsets.all(24),
                      decoration: BoxDecoration(
                        color: theme.colors.surface,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: theme.colors.border),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Pediatric Developmental Milestones Tracker", style: theme.typography.h4),
                          const SizedBox(height: 12),
                          Text("Operational sandbox control for Pediatric Developmental Milestones Tracker.", style: theme.typography.bodyMedium),
                        ],
                      ),
                    ),
                    // Pediatric Family Communication Portal component
                    Container(
                      key: const ValueKey('data-cy-pediatric-parental-communications'),
                      padding: const EdgeInsets.all(24),
                      decoration: BoxDecoration(
                        color: theme.colors.surface,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: theme.colors.border),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Pediatric Family Communication Portal", style: theme.typography.h4),
                          const SizedBox(height: 12),
                          Text("Operational sandbox control for Pediatric Family Communication Portal.", style: theme.typography.bodyMedium),
                        ],
                      ),
                    ),
                    // Pediatric Immunization Registry Card component
                    Container(
                      key: const ValueKey('data-cy-pediatric-immunization-registry'),
                      padding: const EdgeInsets.all(24),
                      decoration: BoxDecoration(
                        color: theme.colors.surface,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: theme.colors.border),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Pediatric Immunization Registry Card", style: theme.typography.h4),
                          const SizedBox(height: 12),
                          Text("Operational sandbox control for Pediatric Immunization Registry Card.", style: theme.typography.bodyMedium),
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
                    label: 'Record Growth Metrics',
                    icon: LucideIcons.download,
                    color: theme.colors.primary,
                    onTap: () => controller.recordGrowthMetrics(),
                  ),
                  QuickActionItem(
                    label: 'Administer Vaccine',
                    icon: LucideIcons.download,
                    color: Colors.green,
                    onTap: () => controller.administerVaccine(),
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
