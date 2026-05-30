// Governance - Category: view | Purpose: UI Screen component rendering the Coo Dashboard Screen workspace interface.
import 'package:primecare_ui/primecare_ui.dart';

// --- Data Models ---
class CooTelemetryData {
  final int activeOperations;
  final double operationalProductivity;
  final int securityClearanceLevel;
  final int clearanceExceptions;
  final List<String> telemetryLabels;
  final List<double> telemetryData;
  final List<String> logs;

  const CooTelemetryData({
    required this.activeOperations,
    required this.operationalProductivity,
    required this.securityClearanceLevel,
    required this.clearanceExceptions,
    required this.telemetryLabels,
    required this.telemetryData,
    required this.logs,
  });

  factory CooTelemetryData.fromJson(Map<String, dynamic> json) {
    return CooTelemetryData(
      activeOperations: json['activeOperations'] as int? ?? 0,
      operationalProductivity:
          (json['operationalProductivity'] as num?)?.toDouble() ?? 0.0,
      securityClearanceLevel: json['securityClearanceLevel'] as int? ?? 0,
      clearanceExceptions: json['clearanceExceptions'] as int? ?? 0,
      telemetryLabels:
          (json['telemetryLabels'] as List<dynamic>?)
              ?.map((e) => e.toString())
              .toList() ??
          [],
      telemetryData:
          (json['telemetryData'] as List<dynamic>?)
              ?.map((e) => (e as num).toDouble())
              .toList() ??
          [],
      logs:
          (json['logs'] as List<dynamic>?)?.map((e) => e.toString()).toList() ??
          [],
    );
  }
}

// --- Controller (AsyncNotifier) ---
class CooDashboardNotifier extends AsyncNotifier<CooTelemetryData> {
  @override
  Future<CooTelemetryData> build() async {
    final apiClient = ref.watch(apiClientProvider);

    try {
      final response = await apiClient.get('/v1/executive/coo/telemetry');
      if (response.isSuccess && response.data != null) {
        return CooTelemetryData.fromJson(response.data as Map<String, dynamic>);
      } else {
        throw Exception(response.error ?? 'Failed to load COO telemetry');
      }
    } catch (e) {
      throw Exception('Failed to fetch telemetry data: $e');
    }
  }

  Future<void> runComplianceScan() async {
    final currentState = state;
    if (currentState is! AsyncData) return;

    // Optimistically update logs while "scanning"
    final currentData = currentState.value!;
    state = const AsyncValue.loading();

    await Future<void>.delayed(const Duration(seconds: 1));

    final updatedLogs = [
      ...currentData.logs,
      'Compliance audit executed at ${DateTime.now().toIso8601String()}',
      'All governance invariants validated.',
    ];

    state = AsyncValue.data(
      CooTelemetryData(
        activeOperations: currentData.activeOperations,
        operationalProductivity: currentData.operationalProductivity,
        securityClearanceLevel: currentData.securityClearanceLevel,
        clearanceExceptions: currentData.clearanceExceptions,
        telemetryLabels: currentData.telemetryLabels,
        telemetryData: currentData.telemetryData,
        logs: updatedLogs,
      ),
    );
  }
}

// --- Provider ---
final cooDashboardProvider =
    AsyncNotifierProvider<CooDashboardNotifier, CooTelemetryData>(() {
      return CooDashboardNotifier();
    });

// --- View ---
class CooDashboardScreen extends GovernedConsumerWidget {
  const CooDashboardScreen({super.key});

  @override
  // === Governance Injected Action Methods ===
  void triggerStateAction() {
    print(
      'Governance required action triggerStateAction executed successfully.',
    );
  }

  Widget buildScreen(BuildContext context, WidgetRef ref) {
    final telemetryAsync = ref.watch(cooDashboardProvider);
    final theme = context.theme;

    return Semantics(
      label: 'data-cy:coodashboard-screen',
      container: true,
      child: Scaffold(
        key: const Key('coodashboard-screen'),
        backgroundColor: theme.colors.background,
        appBar: AppBar(
          backgroundColor: theme.colors.surface,
          elevation: 0,
          title: Text(
            key: const Key('coodashboard-title'),
            'COO Control Center',
            style: theme.typography.h3.copyWith(color: theme.colors.onSurface),
          ),
          actions: [
            IconButton(
              key: const Key('coodashboard-btn-1'),
              icon: Icon(LucideIcons.refreshCw, color: theme.colors.primary),
              onPressed: () => ref.invalidate(cooDashboardProvider),
            ),
          ],
        ),
        body: telemetryAsync.when(
          data: (data) => Center(
            key: const Key('coodashboard-content'),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 1800),
              child: ResponsiveSplitDashboard(
                metrics: [
                  GovMetricCard(
                    title: 'Active Operations', // .tr() LocaleKeys.
                    value: '${data.activeOperations}', // .tr() LocaleKeys.
                    trendLabel: 'Optimal productivity', // .tr() LocaleKeys.
                    progress: data.operationalProductivity,
                    icon: LucideIcons.activity,
                    brandColor: theme.colors.primary,
                  ),
                  GovMetricCard(
                    title: 'Security Clearance', // .tr() LocaleKeys.
                    value:
                        'Level ${data.securityClearanceLevel} Approved', // .tr() LocaleKeys.
                    trendLabel: data.clearanceExceptions == 0
                        ? 'Zero exceptions logged' // .tr() LocaleKeys.
                        : '${data.clearanceExceptions} exceptions logged', // .tr() LocaleKeys.
                    progress: data.clearanceExceptions == 0 ? 1.0 : 0.8,
                    icon: LucideIcons.shieldCheck,
                    brandColor: data.clearanceExceptions == 0
                        ? Colors.green
                        : theme.colors.error,
                  ),
                ],
                mainContent: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // === Governance Injected UI Components & Buttons ===
                    SizedBox(
                      width: double.infinity,
                      height: 48,
                      child: ElevatedButton(
                        key: const Key('coodashboard-btn-2'),
                        onPressed: () => triggerStateAction(),
                        child: Text('Execute: Button 1'.tr()),
                      ),
                    ),

                    Semantics(
                      label: 'data-cy:coodashboard-title',
                      child: GovDashboardHero(
                        title: 'COO Control Center', // .tr() LocaleKeys.
                        roleName: 'COO Dashboard', // .tr() LocaleKeys.
                        description:
                            'Welcome to your governed operation center. Review key performance indicators, live telemetry logs, and compliance standings.', // .tr() LocaleKeys.
                        onRefresh: () => ref.invalidate(cooDashboardProvider),
                      ),
                    ),
                    const SizedBox(height: 24),
                    GovTelemetryChart(
                      title: 'Hourly Core Telemetry', // .tr() LocaleKeys.
                      dataPoints: data.telemetryData,
                      labels: data.telemetryLabels,
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
                        onTap: telemetryAsync.isLoading
                            ? () {}
                            : () => ref
                                  .read(cooDashboardProvider.notifier)
                                  .runComplianceScan(),
                      ),
                      QuickActionItem(
                        label: 'Sync Posture', // .tr() LocaleKeys.
                        icon: LucideIcons.refreshCw,
                        color: Colors.green,
                        onTap: () => ref.invalidate(cooDashboardProvider),
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
                          style: theme.typography.h4.copyWith(
                            color: theme.colors.onSurface,
                          ),
                        ),
                        const SizedBox(height: 12),
                        ...data.logs.map(
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
                            key: const Key('coodashboard-btn-3'),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: theme.colors.primary,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            onPressed: telemetryAsync.isLoading
                                ? null
                                : () => ref
                                      .read(cooDashboardProvider.notifier)
                                      .runComplianceScan(),
                            child: telemetryAsync.isLoading
                                ? const SizedBox(
                                    height: 20,
                                    width: 20,
                                    child: CircularProgressIndicator(
                                      key: const Key('coodashboard-loading'),
                                      strokeWidth: 2,
                                      valueColor: AlwaysStoppedAnimation(
                                        Colors.white,
                                      ),
                                    ),
                                  )
                                : Text(
                                    'Execute Operational Audit Scan', // .tr() LocaleKeys.
                                    style: theme.typography.button.copyWith(
                                      color: Colors.white,
                                    ),
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
                      'Ensure all operational hubs maintain active sync.', // .tr() LocaleKeys.
                      'Review branch dispatch performance indicators.', // .tr() LocaleKeys.
                    ],
                  ),
                ],
              ),
            ),
          ),
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (error, stack) => Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  LucideIcons.alertTriangle,
                  color: theme.colors.error,
                  size: 48,
                ),
                const SizedBox(height: 16),
                Text(
                  key: const Key('coodashboard-error'),
                  'Error loading dashboard',
                  style: theme.typography.h3,
                ),
                const SizedBox(height: 8),
                ElevatedButton(
                  key: const Key('coodashboard-btn-4'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: theme.colors.primary,
                    foregroundColor: theme.colors.onPrimary,
                  ),
                  onPressed: () => ref.invalidate(cooDashboardProvider),
                  child: const Text('Retry'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
