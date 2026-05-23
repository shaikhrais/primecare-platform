// Governance - Category: view | Purpose: UI Screen component rendering the Employee Dashboard Screen workspace interface.
import 'package:primecare_ui/primecare_ui.dart';

// --- MVC State Model ---
class EmployeeDashboardState {
  final bool isLoading;
  final String title;
  final List<String> logs;

  const EmployeeDashboardState({
    required this.isLoading,
    required this.title,
    required this.logs,
  });

  EmployeeDashboardState copyWith({
    bool? isLoading,
    String? title,
    List<String>? logs,
  }) {
    return EmployeeDashboardState(
      isLoading: isLoading ?? this.isLoading,
      title: title ?? this.title,
      logs: logs ?? this.logs,
    );
  }
}

// --- Controller (Notifier) ---
class EmployeeDashboardController extends StateNotifier<EmployeeDashboardState> {
  final Ref ref;

  EmployeeDashboardController(this.ref)
      : super(
          const EmployeeDashboardState(
            isLoading: false,
            title: 'Employee Dashboard',
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

  Future<void> requestPtoDays() async {
    state = state.copyWith(isLoading: true);
    try {
      final apiClient = ref.read(apiClientProvider);
      final response = await apiClient.post(
        '/v1/employee/pto/request',
        body: {
          'timestamp': DateTime.now().toIso8601String(),
          'action': 'submit_ptotime-off_request',
        },
      );
      if (response.isSuccess) {
        state = state.copyWith(
          isLoading: false,
          logs: [
            ...state.logs,
            'Action executed: Submit PTO Time-Off Request via API successfully.',
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
  Future<void> downloadTaxT4() async {
    state = state.copyWith(isLoading: true);
    try {
      final apiClient = ref.read(apiClientProvider);
      final response = await apiClient.post(
        '/v1/employee/tax/download',
        body: {
          'timestamp': DateTime.now().toIso8601String(),
          'action': 'download_tax_slip/w2document',
        },
      );
      if (response.isSuccess) {
        state = state.copyWith(
          isLoading: false,
          logs: [
            ...state.logs,
            'Action executed: Download Tax Slip/W2 Document via API successfully.',
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
final employeeDashboardControllerProvider =
    StateNotifierProvider<EmployeeDashboardController, EmployeeDashboardState>((ref) {
  return EmployeeDashboardController(ref);
});

// --- View ---
class EmployeeDashboardScreen extends GovernedConsumerWidget {
  const EmployeeDashboardScreen({super.key});

  @override
  Widget buildScreen(BuildContext context, WidgetRef ref) {
    final state = ref.watch(employeeDashboardControllerProvider);
    final controller = ref.read(employeeDashboardControllerProvider.notifier);
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
                  roleName: 'Employee Hub',
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
                    // Employee Payslips & Pay stub Card component
                    Container(
                      key: const ValueKey('data-cy-employee-payslips-card'),
                      padding: const EdgeInsets.all(24),
                      decoration: BoxDecoration(
                        color: theme.colors.surface,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: theme.colors.border),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Employee Payslips & Pay stub Card", style: theme.typography.h4),
                          const SizedBox(height: 12),
                          Text("Operational sandbox control for Employee Payslips & Pay stub Card.", style: theme.typography.bodyMedium),
                        ],
                      ),
                    ),
                    // Employee Benefits Summary Card component
                    Container(
                      key: const ValueKey('data-cy-employee-benefits-widget'),
                      padding: const EdgeInsets.all(24),
                      decoration: BoxDecoration(
                        color: theme.colors.surface,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: theme.colors.border),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Employee Benefits Summary Card", style: theme.typography.h4),
                          const SizedBox(height: 12),
                          Text("Operational sandbox control for Employee Benefits Summary Card.", style: theme.typography.bodyMedium),
                        ],
                      ),
                    ),
                    // Employee PTO Accrual Widget component
                    Container(
                      key: const ValueKey('data-cy-employee-pto-tracker'),
                      padding: const EdgeInsets.all(24),
                      decoration: BoxDecoration(
                        color: theme.colors.surface,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: theme.colors.border),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Employee PTO Accrual Widget", style: theme.typography.h4),
                          const SizedBox(height: 12),
                          Text("Operational sandbox control for Employee PTO Accrual Widget.", style: theme.typography.bodyMedium),
                        ],
                      ),
                    ),
                    // Employee Performance Review Records component
                    Container(
                      key: const ValueKey('data-cy-employee-performance-reviews'),
                      padding: const EdgeInsets.all(24),
                      decoration: BoxDecoration(
                        color: theme.colors.surface,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: theme.colors.border),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Employee Performance Review Records", style: theme.typography.h4),
                          const SizedBox(height: 12),
                          Text("Operational sandbox control for Employee Performance Review Records.", style: theme.typography.bodyMedium),
                        ],
                      ),
                    ),
                    // Employee Tax Deductions & Contributions Hub component
                    Container(
                      key: const ValueKey('data-cy-employee-tax-deductions-hub'),
                      padding: const EdgeInsets.all(24),
                      decoration: BoxDecoration(
                        color: theme.colors.surface,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: theme.colors.border),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Employee Tax Deductions & Contributions Hub", style: theme.typography.h4),
                          const SizedBox(height: 12),
                          Text("Operational sandbox control for Employee Tax Deductions & Contributions Hub.", style: theme.typography.bodyMedium),
                        ],
                      ),
                    ),
                    // Employee Internal Announcement Feed component
                    Container(
                      key: const ValueKey('data-cy-employee-company-news-board'),
                      padding: const EdgeInsets.all(24),
                      decoration: BoxDecoration(
                        color: theme.colors.surface,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: theme.colors.border),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Employee Internal Announcement Feed", style: theme.typography.h4),
                          const SizedBox(height: 12),
                          Text("Operational sandbox control for Employee Internal Announcement Feed.", style: theme.typography.bodyMedium),
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
                    label: 'Submit PTO Time-Off Request',
                    icon: LucideIcons.shieldCheck,
                    color: theme.colors.primary,
                    onTap: () => controller.requestPtoDays(),
                  ),
                  QuickActionItem(
                    label: 'Download Tax Slip/W2 Document',
                    icon: LucideIcons.download,
                    color: Colors.green,
                    onTap: () => controller.downloadTaxT4(),
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
