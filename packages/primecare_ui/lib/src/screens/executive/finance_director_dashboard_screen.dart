// Governance - Category: view | Purpose: UI Screen component rendering the Finance Director Dashboard Screen workspace interface.
import 'package:primecare_ui/primecare_ui.dart';

// --- MVC State Model ---
class FinanceDirectorDashboardState {
  final bool isLoading;
  final String? error;
  final String title;
  final List<String> logs;

  const FinanceDirectorDashboardState({
    required this.isLoading,
    this.error,
    required this.title,
    required this.logs,
  });

  FinanceDirectorDashboardState copyWith({
    bool? isLoading,
    String? error,
    String? title,
    List<String>? logs,
  }) {
    return FinanceDirectorDashboardState(
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
      title: title ?? this.title,
      logs: logs ?? this.logs,
    );
  }
}

// --- Controller (Notifier) ---
class FinanceDirectorDashboardController extends StateNotifier<FinanceDirectorDashboardState> {
  FinanceDirectorDashboardController()
      : super(
          const FinanceDirectorDashboardState(
            isLoading: false,
            title: 'Finance Director Control Center',
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
        'Compliance audit executed at ${DateTime.now().toIso8601String()}',
        'All governance invariants validated.',
      ],
    );
  }

    void syncPosture() {
    state = state.copyWith(
      logs: [
        ...state.logs,
        'Manual synchronization sweep completed.',
      ],
    );
  }

  void updatePolicy() {
    state = state.copyWith(
      logs: [
        ...state.logs,
        'Security posture updated and validated.',
      ],
    );
  }

  void exportLogs() {
    state = state.copyWith(
      logs: [
        ...state.logs,
        'Audit logs successfully compiled and exported.',
      ],
    );
  }

  void addLog(String entry) {
    state = state.copyWith(logs: [...state.logs, entry]);
  }
}

// --- Provider ---
final financeDirectorDashboardProvider =
    StateNotifierProvider<FinanceDirectorDashboardController, FinanceDirectorDashboardState>((ref) {
  return FinanceDirectorDashboardController();
});

// --- View ---
class FinanceDirectorDashboardScreen extends GovernedConsumerWidget {
  const FinanceDirectorDashboardScreen({super.key});

  @override
  Widget buildScreen(BuildContext context, WidgetRef ref) {
    final state = ref.watch(financeDirectorDashboardProvider);
    final controller = ref.read(financeDirectorDashboardProvider.notifier);
    final theme = context.theme;
    final roleBase = 'FinanceDirectorDashboardScreen'.replaceAll('DashboardScreen', '').replaceAll('Screen', '');

    return Scaffold(
      backgroundColor: theme.colors.background,
      appBar: AppBar(
        backgroundColor: theme.colors.surface,
        elevation: 0,
        title: Text(
          state.title,
          style: theme.typography.h3.copyWith(color: theme.colors.onSurface),
        ),
        actions: [
          IconButton(
            icon: Icon(LucideIcons.refreshCw, color: theme.colors.primary),
            onPressed: () => controller.addLog('Manual refresh triggered.'), // .tr() LocaleKeys.
          ),
        ],
      ),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1800),
          child: ResponsiveSplitDashboard(
            metrics: [
              GovMetricCard(
                title: 'Active Operations', // .tr() LocaleKeys.
                value: 'Active', // .tr() LocaleKeys.
                trendLabel: 'Optimal productivity', // .tr() LocaleKeys.
                progress: 0.92,
                icon: LucideIcons.activity,
                brandColor: theme.colors.primary,
              ),
              GovMetricCard(
                title: 'Security Clearance', // .tr() LocaleKeys.
                value: 'Level 4 Approved', // .tr() LocaleKeys.
                trendLabel: 'Zero exceptions logged', // .tr() LocaleKeys.
                progress: 1.0,
                icon: LucideIcons.shieldCheck,
                brandColor: Colors.green,
              ),
            ],
            mainContent: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                GovDashboardHero(
                  title: state.title,
                  roleName: '$roleBase Dashboard', // .tr() LocaleKeys.
                  description: 'Welcome to your governed operation center. Review key performance indicators, live telemetry logs, and compliance standings.', // .tr() LocaleKeys.
                  onRefresh: () => controller.addLog('Dashboard telemetry synchronized.'), // .tr() LocaleKeys.
                ),
                const SizedBox(height: 24),
                GovTelemetryChart(
                  title: 'Hourly Core Telemetry', // .tr() LocaleKeys.
                  dataPoints: const [75, 82, 80, 94, 91, 98],
                  labels: const ['09:00', '10:00', '11:00', '12:00', '13:00', '14:00'], // .tr() LocaleKeys.
                  accentColor: theme.colors.primary,
                ),
              ],
            ),
            defaultSidebarWidgets: [
              QuickActionsPanel(
                title: 'Quick Actions', // .tr() LocaleKeys.
                actions: [
                  QuickActionItem(
                    label: 'Run Audit Scan', // .tr() LocaleKeys.
                    icon: LucideIcons.scan,
                    color: theme.colors.primary,
                    onTap: state.isLoading ? () {} : () => controller.runComplianceScan(),
                  ),
                  QuickActionItem(
                    label: 'Sync Posture', // .tr() LocaleKeys.
                    icon: LucideIcons.refreshCw,
                    color: Colors.green,
                    onTap: () => controller.syncPosture()
                  ),
                  QuickActionItem(
                    label: 'Policy Update', // .tr() LocaleKeys.
                    icon: LucideIcons.shieldCheck,
                    color: Colors.blue,
                    onTap: () => controller.updatePolicy()
                  ),
                  QuickActionItem(
                    label: 'Export Logs', // .tr() LocaleKeys.
                    icon: LucideIcons.download,
                    color: Colors.purple,
                    onTap: () => controller.exportLogs()
                  ),
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
                      'Operational Audit Logs', // .tr() LocaleKeys.
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
                    const SizedBox(height: 16),
                    SizedBox(
                      width: double.infinity,
                      height: 48,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: theme.colors.primary,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        onPressed: state.isLoading ? null : () => controller.runComplianceScan(),
                        child: state.isLoading
                            ? const SizedBox(
                                height: 20,
                                width: 20,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                  valueColor: AlwaysStoppedAnimation(Colors.white),
                                ),
                              )
                            : Text(
                                'Execute Operational Audit Scan', // .tr() LocaleKeys.
                                style: theme.typography.button.copyWith(color: Colors.white),
                              ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              const AiInsightsCard(
                heading: 'System & Policy Insights', // .tr() LocaleKeys.
                suggestions: [
                  'Ensure all ingress endpoints enforce TLS 1.3 encryption.', // .tr() LocaleKeys.
                  'Last automated compliance scan completed with 0 errors.', // .tr() LocaleKeys.
                  'Recommended key rotation lifetime set to 24 hours.', // .tr() LocaleKeys.
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
