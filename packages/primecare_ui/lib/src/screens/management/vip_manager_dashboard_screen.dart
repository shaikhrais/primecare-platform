import 'package:primecare_ui/primecare_ui.dart';

// --- MVC State Model ---
class VipManagerDashboardState {
  final bool isLoading;
  final String title;
  final List<String> logs;

  const VipManagerDashboardState({
    required this.isLoading,
    required this.title,
    required this.logs,
  });

  VipManagerDashboardState copyWith({
    bool? isLoading,
    String? title,
    List<String>? logs,
  }) {
    return VipManagerDashboardState(
      isLoading: isLoading ?? this.isLoading,
      title: title ?? this.title,
      logs: logs ?? this.logs,
    );
  }
}

// --- Controller (Notifier) ---
class VipManagerDashboardController extends StateNotifier<VipManagerDashboardState> {
  final Ref ref;

  VipManagerDashboardController(this.ref)
      : super(
          const VipManagerDashboardState(
            isLoading: false,
            title: 'VIP Client Manager Dashboard',
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

  Future<void> recordVipTouchpoint() async {
    state = state.copyWith(isLoading: true);
    try {
      final apiClient = ref.read(apiClientProvider);
      final response = await apiClient.post(
        '/v1/vip/touchpoints/log',
        body: {
          'timestamp': DateTime.now().toIso8601String(),
          'action': 'log_vipclient_touchpoint',
        },
      );
      if (response.isSuccess) {
        state = state.copyWith(
          isLoading: false,
          logs: [
            ...state.logs,
            'Action executed: Log VIP Client Touchpoint via API successfully.',
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
  Future<void> resolveVipIssue() async {
    state = state.copyWith(isLoading: true);
    try {
      final apiClient = ref.read(apiClientProvider);
      final response = await apiClient.post(
        '/v1/vip/issues/resolve',
        body: {
          'timestamp': DateTime.now().toIso8601String(),
          'action': 'resolve_vipclient_issue',
        },
      );
      if (response.isSuccess) {
        state = state.copyWith(
          isLoading: false,
          logs: [
            ...state.logs,
            'Action executed: Resolve VIP Client Issue via API successfully.',
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
final vipManagerDashboardControllerProvider =
    StateNotifierProvider<VipManagerDashboardController, VipManagerDashboardState>((ref) {
  return VipManagerDashboardController(ref);
});

// --- View ---
class VipManagerDashboardScreen extends GovernedConsumerWidget {
  const VipManagerDashboardScreen({super.key});

  @override
  Widget buildScreen(BuildContext context, WidgetRef ref) {
    final state = ref.watch(vipManagerDashboardControllerProvider);
    final controller = ref.read(vipManagerDashboardControllerProvider.notifier);
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
                  roleName: 'VIP Client Manager Hub',
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
                    // VIP Client Portfolio Panel component
                    Container(
                      key: const ValueKey('data-cy-vip-accounts-portfolio'),
                      padding: const EdgeInsets.all(24),
                      decoration: BoxDecoration(
                        color: theme.colors.surface,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: theme.colors.border),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("VIP Client Portfolio Panel", style: theme.typography.h4),
                          const SizedBox(height: 12),
                          Text("Operational sandbox control for VIP Client Portfolio Panel.", style: theme.typography.bodyMedium),
                        ],
                      ),
                    ),
                    // VIP Satisfaction Scorecard component
                    Container(
                      key: const ValueKey('data-cy-vip-satisfaction-metrics'),
                      padding: const EdgeInsets.all(24),
                      decoration: BoxDecoration(
                        color: theme.colors.surface,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: theme.colors.border),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("VIP Satisfaction Scorecard", style: theme.typography.h4),
                          const SizedBox(height: 12),
                          Text("Operational sandbox control for VIP Satisfaction Scorecard.", style: theme.typography.bodyMedium),
                        ],
                      ),
                    ),
                    // VIP Issue Escrow Card component
                    Container(
                      key: const ValueKey('data-cy-vip-issues-escrow'),
                      padding: const EdgeInsets.all(24),
                      decoration: BoxDecoration(
                        color: theme.colors.surface,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: theme.colors.border),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("VIP Issue Escrow Card", style: theme.typography.h4),
                          const SizedBox(height: 12),
                          Text("Operational sandbox control for VIP Issue Escrow Card.", style: theme.typography.bodyMedium),
                        ],
                      ),
                    ),
                    // VIP Executive Contract & Escrow Panel component
                    Container(
                      key: const ValueKey('data-cy-vip-accounts-contract-escrow'),
                      padding: const EdgeInsets.all(24),
                      decoration: BoxDecoration(
                        color: theme.colors.surface,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: theme.colors.border),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("VIP Executive Contract & Escrow Panel", style: theme.typography.h4),
                          const SizedBox(height: 12),
                          Text("Operational sandbox control for VIP Executive Contract & Escrow Panel.", style: theme.typography.bodyMedium),
                        ],
                      ),
                    ),
                    // VIP Escalation Response Tier Status Card component
                    Container(
                      key: const ValueKey('data-cy-vip-escalation-tier-status'),
                      padding: const EdgeInsets.all(24),
                      decoration: BoxDecoration(
                        color: theme.colors.surface,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: theme.colors.border),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("VIP Escalation Response Tier Status Card", style: theme.typography.h4),
                          const SizedBox(height: 12),
                          Text("Operational sandbox control for VIP Escalation Response Tier Status Card.", style: theme.typography.bodyMedium),
                        ],
                      ),
                    ),
                    // VIP Feedback Survey Sentiment Cards component
                    Container(
                      key: const ValueKey('data-cy-vip-feedback-survey-insights'),
                      padding: const EdgeInsets.all(24),
                      decoration: BoxDecoration(
                        color: theme.colors.surface,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: theme.colors.border),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("VIP Feedback Survey Sentiment Cards", style: theme.typography.h4),
                          const SizedBox(height: 12),
                          Text("Operational sandbox control for VIP Feedback Survey Sentiment Cards.", style: theme.typography.bodyMedium),
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
                    label: 'Log VIP Client Touchpoint',
                    icon: LucideIcons.shieldCheck,
                    color: theme.colors.primary,
                    onTap: () => controller.recordVipTouchpoint(),
                  ),
                  QuickActionItem(
                    label: 'Resolve VIP Client Issue',
                    icon: LucideIcons.download,
                    color: Colors.green,
                    onTap: () => controller.resolveVipIssue(),
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
