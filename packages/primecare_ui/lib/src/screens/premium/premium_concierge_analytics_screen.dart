// Governance - Category: view | Purpose: UI Screen component rendering the PremiumConciergeAnalyticsScreen workspace interface.
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';

// --- MVC State Model ---
class PremiumConciergeAnalyticsState {
  final bool isLoading;
  final String? error;
  final String title;
  final List<String> logs;

  const PremiumConciergeAnalyticsState({
    required this.isLoading,
    this.error,
    required this.title,
    required this.logs,
  });

  PremiumConciergeAnalyticsState copyWith({
    bool? isLoading,
    String? error,
    String? title,
    List<String>? logs,
  }) {
    return PremiumConciergeAnalyticsState(
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
      title: title ?? this.title,
      logs: logs ?? this.logs,
    );
  }
}

// --- Controller (Notifier) ---
class PremiumConciergeAnalyticsController
    extends StateNotifier<PremiumConciergeAnalyticsState> {
  final Ref ref;

  PremiumConciergeAnalyticsController(this.ref)
    : super(
        const PremiumConciergeAnalyticsState(
          isLoading: false,
          title: 'Premium Concierge Analytics', // LocaleKeys.mock.tr()
          logs: [
            'Concierge monitor running.',
            'Allied analytics synchronization successful.',
          ],
        ),
      );

  Future<void> runAnalyticsScan() async {
    state = state.copyWith(isLoading: true);
    try {
      final apiClient = ref.read(apiClientProvider);
      final response = await apiClient.post(
        '/v1/premium-concierge-analytics/compliance/scan',
        body: {
          'timestamp': DateTime.now().toIso8601String(),
          'action': 'run_analytics_scan',
        },
      );
      if (response.isSuccess) {
        state = state.copyWith(
          isLoading: false,
          logs: [
            ...state.logs,
            'Premium concierge analytics scan done at ${DateTime.now().toIso8601String()}',
            'All metrics computed and stored in registry.',
          ],
        );
      } else {
        state = state.copyWith(
          isLoading: false,
          logs: [
            ...state.logs,
            'Analytics calculation error: ${response.error}',
          ],
        );
      }
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        logs: [...state.logs, 'Network Error resolving analytics: $e'],
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
final premiumConciergeAnalyticsProvider =
    StateNotifierProvider<
      PremiumConciergeAnalyticsController,
      PremiumConciergeAnalyticsState
    >((ref) {
      return PremiumConciergeAnalyticsController(ref);
    });

// --- View ---
class PremiumConciergeAnalyticsScreen extends GovernedConsumerWidget {
  const PremiumConciergeAnalyticsScreen({super.key});

  @override
  Widget buildScreen(BuildContext context, WidgetRef ref) {
    final state = ref.watch(premiumConciergeAnalyticsProvider);
    final controller = ref.read(premiumConciergeAnalyticsProvider.notifier);
    final theme = context.theme;
    final roleBase = 'PremiumConciergeAnalyticsScreen'
        .replaceAll('DashboardScreen', '')
        .replaceAll('Screen', '');

    return Scaffold(
      key: const Key('premium concierge care coordinator analytics-screen'),
      backgroundColor: theme.colors.background,
      appBar: AppBar(
        backgroundColor: theme.colors.surface,
        elevation: 0,
        title: Text(
          key: const Key('premium concierge care coordinator analytics-title'),
          state.title,
          style: theme.typography.h3.copyWith(color: theme.colors.onSurface),
        ),
        actions: [
          IconButton(
            key: const Key(
              'premium concierge care coordinator analytics-btn-1',
            ),
            icon: Icon(LucideIcons.refreshCw, color: theme.colors.primary),
            onPressed: () =>
                controller.addLog('Manual analytics recalculation.'),
          ),
        ],
      ),
      body: Semantics(
        label: 'data-cy:premium concierge care coordinator analytics-screen',
        child: SingleChildScrollView(
          key: const Key(
            'premium concierge care coordinator analytics-content',
          ),
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // === Governance Injected UI Components & Buttons ===
              SizedBox(
                width: double.infinity,
                height: 48,
                child: ElevatedButton(
                  key: const Key(
                    'premium concierge care coordinator analytics-btn-2',
                  ),
                  onPressed: () => controller.triggerStateAction(),
                  child: Text('Execute: Button 1'.tr()),
                ),
              ),

              GovDashboardHero(
                title: state.title,
                roleName: '$roleBase Dashboard',
                description:
                    'Centralized telemetry, metric charts, and operations log analysis for the Premium Concierge Care Coordinator Analytics segment.',
                onRefresh: () =>
                    controller.addLog('Premium concierge stats updated.'),
              ),
              const SizedBox(height: 24),
              Row(
                children: [
                  Expanded(
                    child: GovMetricCard(
                      title: 'Concierge Score', // LocaleKeys.mock.tr()
                      value: '99.8% Quality',
                      trendLabel: 'Excellent satisfaction standard',
                      progress: 0.998,
                      icon: LucideIcons.star,
                      brandColor: theme.colors.primary,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: GovMetricCard(
                      title: 'Capacity Utilization', // LocaleKeys.mock.tr()
                      value: '84% Booked',
                      trendLabel: 'Balanced scheduling distribution',
                      progress: 0.84,
                      icon: LucideIcons.calendar,
                      brandColor: Colors.blue,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              GovTelemetryChart(
                title:
                    'Concierge Care Coordinator Performance Index', // LocaleKeys.mock.tr()
                dataPoints: const [94, 96, 95, 99, 98, 100],
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
                      'Operational Concierge Audit Ledger',
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
                        key: const Key(
                          'premium concierge care coordinator analytics-btn-3',
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: theme.colors.primary,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        onPressed: state.isLoading
                            ? null
                            : () => controller.runAnalyticsScan(),
                        child: state.isLoading
                            ? const SizedBox(
                                height: 20,
                                width: 20,
                                child: CircularProgressIndicator(
                                  key: const Key(
                                    'premium concierge care coordinator analytics-loading',
                                  ),
                                  strokeWidth: 2,
                                  valueColor: AlwaysStoppedAnimation(
                                    Colors.white,
                                  ),
                                ),
                              )
                            : Text(
                                'Execute Concierge Data Telemetry Verification Scan',
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
    );
  }
}
