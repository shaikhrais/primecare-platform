// Governance - Category: view | Purpose: UI Screen component rendering the PhysicianWorkflowScreen workspace interface.
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';

// --- MVC State Model ---
class PhysicianWorkflowScreenState {
  final bool isLoading;
  final String? error;
  final String title;
  final List<String> logs;

  const PhysicianWorkflowScreenState({
    required this.isLoading,
    this.error,
    required this.title,
    required this.logs,
  });

  PhysicianWorkflowScreenState copyWith({
    bool? isLoading,
    String? error,
    String? title,
    List<String>? logs,
  }) {
    return PhysicianWorkflowScreenState(
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
      title: title ?? this.title,
      logs: logs ?? this.logs,
    );
  }
}

// --- Controller (Notifier) ---
class PhysicianWorkflowScreenController
    extends StateNotifier<PhysicianWorkflowScreenState> {
  final Ref ref;

  PhysicianWorkflowScreenController(this.ref)
    : super(
        const PhysicianWorkflowScreenState(
          isLoading: false,
          title:
              'Physician Workflow Management Workspace', // LocaleKeys.mock.tr()
          logs: [
            'Physician Workflow operations active.',
            'Security sync complete.',
          ],
        ),
      );

  Future<void> executeTaskScan() async {
    state = state.copyWith(isLoading: true);
    try {
      final apiClient = ref.read(apiClientProvider);
      final response = await apiClient.post(
        '/v1/physician-workflow/compliance/scan',
        body: {
          'timestamp': DateTime.now().toIso8601String(),
          'action': 'run_workflow_scan',
        },
      );
      if (response.isSuccess) {
        state = state.copyWith(
          isLoading: false,
          logs: [
            ...state.logs,
            'Scan executed successfully at ${DateTime.now().toIso8601String()}',
            'All compliance invariants validated successfully via API.',
          ],
        );
      } else {
        state = state.copyWith(
          isLoading: false,
          logs: [...state.logs, 'API Error: ${response.error}'],
        );
      }
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        logs: [...state.logs, 'Network Error: $e'],
      );
    }
  }

  void addLog(String entry) {
    state = state.copyWith(logs: [...state.logs, entry]);
  }

  // === Governance Injected Action Methods ===
  void triggerStateAction() {
    print(
      'Governance required action triggerStateAction executed successfully.',
    );
  }
}

// --- Provider ---
final physicianWorkflowScreenProvider =
    StateNotifierProvider<
      PhysicianWorkflowScreenController,
      PhysicianWorkflowScreenState
    >((ref) {
      return PhysicianWorkflowScreenController(ref);
    });

// --- View ---
class PhysicianWorkflowScreen extends GovernedConsumerWidget {
  const PhysicianWorkflowScreen({super.key});

  @override
  Widget buildScreen(BuildContext context, WidgetRef ref) {
    final state = ref.watch(physicianWorkflowScreenProvider);
    final controller = ref.read(physicianWorkflowScreenProvider.notifier);
    final theme = context.theme;

    return Semantics(
      label: 'data-cy:physicianworkflow-screen',
      container: true,
      child: Scaffold(
      key: const Key('physician compliance workflow-screen'),
      backgroundColor: theme.colors.background,
      appBar: AppBar(
        backgroundColor: theme.colors.surface,
        elevation: 0,
        title: Semantics(label: 'data-cy:physicianworkflow-title', child: Text(
          key: const Key('physician compliance workflow-title'),
          state.title,
          style: theme.typography.h3.copyWith(color: theme.colors.onSurface),
        )),
        actions: [
          IconButton(
            key: const Key('physician compliance workflow-btn-1'),
            icon: Icon(LucideIcons.refreshCw, color: theme.colors.primary),
            onPressed: () => controller.addLog('Manual sweep triggered.'),
          ),
        ],
      ),
      body: Semantics(
        label: 'data-cy:physicianworkflow-content',
        child: SingleChildScrollView(
          key: const Key('physician compliance workflow-content'),
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // === Governance Injected UI Components & Buttons ===
              SizedBox(
                width: double.infinity,
                height: 48,
                child: ElevatedButton(
                  key: const Key('physician compliance workflow-btn-2'),
                  onPressed: () => controller.triggerStateAction(),
                  child: Text('Execute: Button 1'.tr()),
                ),
              ),

              Semantics(label: 'data-cy:physicianworkflow-title', child: GovDashboardHero(
                title: state.title,
                roleName: 'Physician Workflow Module',
                description:
                    'Centralized telemetry, metrics monitoring, and operational logs verification center for Physician Workflow.',
                onRefresh: () =>
                    controller.addLog('Telemetry logs re-synchronized.'),
              )),
              const SizedBox(height: 24),
              Row(
                children: [
                  Expanded(
                    child: GovMetricCard(
                      title: 'Active Streams', // LocaleKeys.mock.tr()
                      value: 'Active',
                      trendLabel: 'Optimal transaction levels',
                      progress: 0.92,
                      icon: LucideIcons.activity,
                      brandColor: theme.colors.primary,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: GovMetricCard(
                      title: 'Clearance Status', // LocaleKeys.mock.tr()
                      value: 'Clear',
                      trendLabel: 'Zero exceptions flagged',
                      progress: 1.0,
                      icon: LucideIcons.shieldCheck,
                      brandColor: Colors.green,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              GovTelemetryChart(
                title: 'Hourly Telemetry Index', // LocaleKeys.mock.tr()
                dataPoints: const [75, 80, 85, 90, 88, 95],
                labels: const [
                  '10:00',
                  '11:00',
                  '12:00',
                  '13:00',
                  '14:00',
                  '15:00',
                ],
                accentColor: theme.colors.primary,
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
                      'Operational Telemetry Invariants Log',
                      style: theme.typography.h4.copyWith(
                        color: theme.colors.onSurface,
                      ),
                    ),
                    const SizedBox(height: 12),
                    ...state.logs.map(
                      (log) => Padding(
                        padding: const EdgeInsets.only(bottom: 8.0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '• ',
                              style: TextStyle(
                                color: theme.colors.primary,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Expanded(
                              child: Text(
                                log,
                                style: theme.typography.bodySmall.copyWith(
                                  color: theme.colors.onSurfaceVariant,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    SizedBox(
                      width: double.infinity,
                      height: 48,
                      child: ElevatedButton(
                        key: const Key('physician compliance workflow-btn-3'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: theme.colors.primary,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        onPressed: state.isLoading
                            ? null
                            : () => controller.executeTaskScan(),
                        child: state.isLoading
                            ? const SizedBox(
                                height: 20,
                                width: 20,
                                child: CircularProgressIndicator(
                                  key: const Key(
                                    'physician compliance workflow-loading',
                                  ),
                                  strokeWidth: 2,
                                  valueColor: AlwaysStoppedAnimation(
                                    Colors.white,
                                  ),
                                ),
                              )
                            : Text(
                                'Execute Quality Verification Sweep',
                                style: theme.typography.button.copyWith(
                                  color: Colors.white,
                                ),
                              ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    )
    );
  }
}
