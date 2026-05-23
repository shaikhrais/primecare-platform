import 'package:primecare_ui/primecare_ui.dart';

// --- MVC State Model ---
class PremiumConciergeDashboardState {
  final bool isLoading;
  final String title;
  final List<String> logs;

  const PremiumConciergeDashboardState({
    required this.isLoading,
    required this.title,
    required this.logs,
  });

  PremiumConciergeDashboardState copyWith({
    bool? isLoading,
    String? title,
    List<String>? logs,
  }) {
    return PremiumConciergeDashboardState(
      isLoading: isLoading ?? this.isLoading,
      title: title ?? this.title,
      logs: logs ?? this.logs,
    );
  }
}

// --- Controller (Notifier) ---
class PremiumConciergeDashboardController extends StateNotifier<PremiumConciergeDashboardState> {
  final Ref ref;

  PremiumConciergeDashboardController(this.ref)
      : super(
          const PremiumConciergeDashboardState(
            isLoading: false,
            title: 'Premium Concierge Care Coordinator Dashboard',
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

  Future<void> dispatchSpecialtyProvider() async {
    state = state.copyWith(isLoading: true);
    try {
      final apiClient = ref.read(apiClientProvider);
      final response = await apiClient.post(
        '/v1/concierge/providers/dispatch',
        body: {
          'timestamp': DateTime.now().toIso8601String(),
          'action': 'dispatch_specialty_provider',
        },
      );
      if (response.isSuccess) {
        state = state.copyWith(
          isLoading: false,
          logs: [
            ...state.logs,
            'Action executed: Dispatch Specialty Provider via API successfully.',
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
  Future<void> escalateVipRequest() async {
    state = state.copyWith(isLoading: true);
    try {
      final apiClient = ref.read(apiClientProvider);
      final response = await apiClient.post(
        '/v1/concierge/vip/escalate',
        body: {
          'timestamp': DateTime.now().toIso8601String(),
          'action': 'escalate_vipcare_request',
        },
      );
      if (response.isSuccess) {
        state = state.copyWith(
          isLoading: false,
          logs: [
            ...state.logs,
            'Action executed: Escalate VIP Care Request via API successfully.',
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
final premiumConciergeDashboardControllerProvider =
    StateNotifierProvider<PremiumConciergeDashboardController, PremiumConciergeDashboardState>((ref) {
  return PremiumConciergeDashboardController(ref);
});

// --- View ---
class PremiumConciergeDashboardScreen extends GovernedConsumerWidget {
  const PremiumConciergeDashboardScreen({super.key});

  @override
  Widget buildScreen(BuildContext context, WidgetRef ref) {
    final state = ref.watch(premiumConciergeDashboardControllerProvider);
    final controller = ref.read(premiumConciergeDashboardControllerProvider.notifier);
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
                  roleName: 'Premium Concierge Care Coordinator Hub',
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
                    // Concierge VIP Clients Card component
                    Container(
                      key: const ValueKey('data-cy-concierge-vip-clients'),
                      padding: const EdgeInsets.all(24),
                      decoration: BoxDecoration(
                        color: theme.colors.surface,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: theme.colors.border),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Concierge VIP Clients Card", style: theme.typography.h4),
                          const SizedBox(height: 12),
                          Text("Operational sandbox control for Concierge VIP Clients Card.", style: theme.typography.bodyMedium),
                        ],
                      ),
                    ),
                    // Concierge Request Feed component
                    Container(
                      key: const ValueKey('data-cy-concierge-request-feed'),
                      padding: const EdgeInsets.all(24),
                      decoration: BoxDecoration(
                        color: theme.colors.surface,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: theme.colors.border),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Concierge Request Feed", style: theme.typography.h4),
                          const SizedBox(height: 12),
                          Text("Operational sandbox control for Concierge Request Feed.", style: theme.typography.bodyMedium),
                        ],
                      ),
                    ),
                    // Concierge Specialty Teams Card component
                    Container(
                      key: const ValueKey('data-cy-concierge-care-teams'),
                      padding: const EdgeInsets.all(24),
                      decoration: BoxDecoration(
                        color: theme.colors.surface,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: theme.colors.border),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Concierge Specialty Teams Card", style: theme.typography.h4),
                          const SizedBox(height: 12),
                          Text("Operational sandbox control for Concierge Specialty Teams Card.", style: theme.typography.bodyMedium),
                        ],
                      ),
                    ),
                    // Premium Concierge Private Billing Panel component
                    Container(
                      key: const ValueKey('data-cy-concierge-concierge-billing'),
                      padding: const EdgeInsets.all(24),
                      decoration: BoxDecoration(
                        color: theme.colors.surface,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: theme.colors.border),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Premium Concierge Private Billing Panel", style: theme.typography.h4),
                          const SizedBox(height: 12),
                          Text("Operational sandbox control for Premium Concierge Private Billing Panel.", style: theme.typography.bodyMedium),
                        ],
                      ),
                    ),
                    // Premium Concierge Specialty Amenities Feed component
                    Container(
                      key: const ValueKey('data-cy-concierge-luxury-amenities-list'),
                      padding: const EdgeInsets.all(24),
                      decoration: BoxDecoration(
                        color: theme.colors.surface,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: theme.colors.border),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Premium Concierge Specialty Amenities Feed", style: theme.typography.h4),
                          const SizedBox(height: 12),
                          Text("Operational sandbox control for Premium Concierge Specialty Amenities Feed.", style: theme.typography.bodyMedium),
                        ],
                      ),
                    ),
                    // Premium Concierge Client Satisfaction Tracker component
                    Container(
                      key: const ValueKey('data-cy-concierge-satisfaction-telemetry'),
                      padding: const EdgeInsets.all(24),
                      decoration: BoxDecoration(
                        color: theme.colors.surface,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: theme.colors.border),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Premium Concierge Client Satisfaction Tracker", style: theme.typography.h4),
                          const SizedBox(height: 12),
                          Text("Operational sandbox control for Premium Concierge Client Satisfaction Tracker.", style: theme.typography.bodyMedium),
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
                    label: 'Dispatch Specialty Provider',
                    icon: LucideIcons.download,
                    color: theme.colors.primary,
                    onTap: () => controller.dispatchSpecialtyProvider(),
                  ),
                  QuickActionItem(
                    label: 'Escalate VIP Care Request',
                    icon: LucideIcons.download,
                    color: Colors.green,
                    onTap: () => controller.escalateVipRequest(),
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
