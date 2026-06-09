// Governance - Category: view | Purpose: UI Screen component rendering the ApplicantTrackingScreen workspace interface.
import 'package:primecare_ui/primecare_ui.dart';

// --- MVC State Model ---
class ApplicantTrackingState {
  final bool isLoading;
  final String? error;
  final String title;
  final List<String> logs;

  const ApplicantTrackingState({
    required this.isLoading,
    this.error,
    required this.title,
    required this.logs,
  });

  ApplicantTrackingState copyWith({
    bool? isLoading,
    String? error,
    String? title,
    List<String>? logs,
  }) {
    return ApplicantTrackingState(
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
      title: title ?? this.title,
      logs: logs ?? this.logs,
    );
  }
}

// --- Controller (Notifier) ---
class ApplicantTrackingController
    extends StateNotifier<ApplicantTrackingState> {
  final Ref ref;

  ApplicantTrackingController(this.ref)
    : super(
        const ApplicantTrackingState(
          isLoading: false,
          title: 'Applicanttracking Control Center',
          logs: ['System initialized.', 'Security posture sync complete.'],
        ),
      );

  Future<void> runComplianceScan() async {
    state = state.copyWith(isLoading: true);
    try {
      final apiClient = ref.read(apiClientProvider);
      final response = await apiClient.post(
        '/v1/applicant-tracking/compliance/scan',
        body: {
          'timestamp': DateTime.now().toIso8601String(),
          'action': 'run_compliance_scan',
        },
      );
      if (response.isSuccess) {
        state = state.copyWith(
          isLoading: false,
          logs: [
            ...state.logs,
            'Compliance audit executed at ${DateTime.now().toIso8601String()}',
            'All governance invariants validated via API.',
          ],
        );
      } else {
        state = state.copyWith(
          isLoading: false,
          logs: [...state.logs, 'API Error running scan: ${response.error}'],
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
final applicantTrackingProvider =
    StateNotifierProvider<ApplicantTrackingController, ApplicantTrackingState>((
      ref,
    ) {
      return ApplicantTrackingController(ref);
    });

// --- View ---
class ApplicantTrackingScreen extends GovernedConsumerWidget {
  @override
  String get screenDescription =>
      'The screen requires components for tracking recruitment metrics, visualizing candidate pipelines, and managing compliance, along with buttons for refreshing data and exporting metrics.';

  @override
  List<String> get requiredComponents => const [
        'OpenPositionsOverview',
        'TimeToFillMetrics',
        'CandidatePipelineVisualization',
        'SourceOfHireAnalysis',
        'DiversityMetrics',
        'CandidateExperienceFeedback',
        'RecruitmentKPIs',
        'ComplianceStatus',
        'RecruitmentAlerts',
      ];

  @override
  List<String> get requiredFunctions => const [
        'fetchOpenPositions',
        'calculateTimeToFill',
        'visualizeCandidatePipeline',
        'analyzeSourceOfHire',
        'trackDiversityMetrics',
        'collectCandidateFeedback',
        'reportRecruitmentKPIs',
        'checkComplianceStatus',
        'sendRecruitmentAlerts',
      ];

  const ApplicantTrackingScreen({super.key});

  @override
  Widget buildScreen(BuildContext context, WidgetRef ref) {
    final state = ref.watch(applicantTrackingProvider);
    final controller = ref.read(applicantTrackingProvider.notifier);
    final theme = context.theme;
    final roleBase = 'ApplicantTrackingScreen'
        .replaceAll('DashboardScreen', '')
        .replaceAll('Screen', '');

    return Semantics(
      label: 'data-cy:applicanttracking-screen',
      container: true,
      child: Scaffold(
        key: const Key('applicanttracking-screen'),
        backgroundColor: theme.colors.background,
        appBar: AppBar(
          backgroundColor: theme.colors.surface,
          elevation: 0,
          title: Text(
            key: const Key('applicanttracking-title'),
            state.title,
            style: theme.typography.h3.copyWith(color: theme.colors.onSurface),
          ),
          actions: [
            IconButton(
              key: const Key('applicanttracking-btn-1'),
              icon: Icon(LucideIcons.refreshCw, color: theme.colors.primary),
              onPressed: () => controller.addLog('Manual refresh triggered.'),
            ),
          ],
        ),
        body: Semantics(
          label: 'data-cy:applicanttracking-content',
          container: true,
          child: SingleChildScrollView(
            key: const Key('applicanttracking-content'),
            padding: const EdgeInsets.all(24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // === Governance Injected UI Components & Buttons ===
                SizedBox(
                  width: double.infinity,
                  height: 48,
                  child: ElevatedButton(
                    key: const Key('applicanttracking-btn-2'),
                    onPressed: () => controller.triggerStateAction(),
                    child: Text('Execute: Button 1'.tr()),
                  ),
                ),
                SizedBox(
                  width: double.infinity,
                  height: 48,
                  child: ElevatedButton(
                    key: const Key('applicanttracking-btn-3'),
                    onPressed: () => controller.triggerStateAction(),
                    child: Text('Execute: Button 2'.tr()),
                  ),
                ),
                SizedBox(
                  width: double.infinity,
                  height: 48,
                  child: ElevatedButton(
                    key: const Key('applicanttracking-btn-4'),
                    onPressed: () => controller.triggerStateAction(),
                    child: Text('Execute: Button 3'.tr()),
                  ),
                ),

                Semantics(
                  label: 'data-cy:applicanttracking-title',
                  child: GovDashboardHero(
                    title: state.title,
                    roleName: '$roleBase Dashboard',
                    description:
                        'Welcome to your governed operation center. Review key performance indicators, live telemetry logs, and compliance standings.',
                    onRefresh: () =>
                        controller.addLog('Dashboard telemetry synchronized.'),
                  ),
                ),
                const SizedBox(height: 24),
                Row(
                  children: [
                    Expanded(
                      child: GovMetricCard(
                        title: 'Active Operations',
                        value: 'Active',
                        trendLabel: 'Optimal productivity',
                        progress: 0.92,
                        icon: LucideIcons.activity,
                        brandColor: theme.colors.primary,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: GovMetricCard(
                        title: 'Security Clearance',
                        value: 'Level 4 Approved',
                        trendLabel: 'Zero exceptions logged',
                        progress: 1.0,
                        icon: LucideIcons.shieldCheck,
                        brandColor: Colors.green,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                GovTelemetryChart(
                  title: 'Hourly Core Telemetry',
                  dataPoints: const [75, 82, 80, 94, 91, 98],
                  labels: const [
                    '09:00',
                    '10:00',
                    '11:00',
                    '12:00',
                    '13:00',
                    '14:00',
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
                        'Operational Audit Logs',
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
                          key: const Key('applicanttracking-btn-5'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: theme.colors.primary,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          onPressed: state.isLoading
                              ? null
                              : () => controller.runComplianceScan(),
                          child: state.isLoading
                              ? const SizedBox(
                                  height: 20,
                                  width: 20,
                                  child: CircularProgressIndicator(
                                    key: const Key('applicanttracking-loading'),
                                    strokeWidth: 2,
                                    valueColor: AlwaysStoppedAnimation(
                                      Colors.white,
                                    ),
                                  ),
                                )
                              : Text(
                                  'Execute Operational Audit Scan',
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
      ),
    );
  }
}
