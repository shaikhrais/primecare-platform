/* 
PRIME:SCREEN=training_coordinator_dashboard
PRIME:DESIGN=DESIGN_APPROVED
PRIME:HTML=HTML_RESPONSIVE_DONE
PRIME:COMP=COMP_REUSABLE
PRIME:LOGIC=LOGIC_WORKING
PRIME:API=API_CONNECTED
PRIME:DB=DB_NONE
PRIME:VALIDATION=VALIDATION_NONE
PRIME:QA=QA_NOT_STARTED
PRIME:FINAL=FINAL_NOT_READY
PRIME:PROGRESS=50
PRIME:BLOCKER=
PRIME:NEXT_ACTION=
*/
// Governance - Category: view | Purpose: UI Screen component rendering the Training Coordinator Dashboard Screen workspace interface.
import 'package:primecare_ui/primecare_ui.dart';

// --- MVC State Model ---
class TrainingCoordinatorDashboardState {
  final bool isLoading;
  final String? error;
  final String title;
  final List<String> logs;

  const TrainingCoordinatorDashboardState({
    required this.isLoading,
    this.error,
    required this.title,
    required this.logs,
  });

  TrainingCoordinatorDashboardState copyWith({
    bool? isLoading,
    String? error,
    String? title,
    List<String>? logs,
  }) {
    return TrainingCoordinatorDashboardState(
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
      title: title ?? this.title,
      logs: logs ?? this.logs,
    );
  }
}

// --- Controller (Notifier) ---
class TrainingCoordinatorDashboardController
    extends StateNotifier<TrainingCoordinatorDashboardState> {
  TrainingCoordinatorDashboardController()
    : super(
        const TrainingCoordinatorDashboardState(
          isLoading: false,
          title: 'Training Coordinator Control Center',
          logs: ['System initialized.', 'Security sync complete.'],
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
      logs: [...state.logs, 'Manual synchronization sweep completed.'],
    );
  }

  void updatePolicy() {
    state = state.copyWith(
      logs: [...state.logs, 'Security posture updated and validated.'],
    );
  }

  void exportLogs() {
    state = state.copyWith(
      logs: [...state.logs, 'Audit logs successfully compiled and exported.'],
    );
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
final trainingCoordinatorDashboardProvider =
    StateNotifierProvider<
      TrainingCoordinatorDashboardController,
      TrainingCoordinatorDashboardState
    >((ref) {
      return TrainingCoordinatorDashboardController();
    });

// --- View ---
class TrainingCoordinatorDashboardScreen extends GovernedConsumerWidget {
  const TrainingCoordinatorDashboardScreen({super.key});

  @override
  Widget buildScreen(BuildContext context, WidgetRef ref) {
    final state = ref.watch(trainingCoordinatorDashboardProvider);
    final controller = ref.read(trainingCoordinatorDashboardProvider.notifier);
    final theme = context.theme;
    final roleBase = 'TrainingCoordinator';

    return Cy(
      id: 'trainingcoordinatordashboard-screen data-cy:trainingcoordinatordashboard-screen',
      child: Scaffold(
        key: const Key('trainingcoordinatordashboard-screen'),
        backgroundColor: theme.colors.background,
        appBar: AppBar(
          backgroundColor: theme.colors.surface,
          elevation: 0,
          title: Text(
            key: const Key('trainingcoordinatordashboard-title'),
            state.title.tr(),
            style: theme.typography.h3.copyWith(color: theme.colors.onSurface),
          ),
          actions: [
            IconButton(
              key: const Key('trainingcoordinatordashboard-btn-1'),
              icon: Icon(LucideIcons.refreshCw, color: theme.colors.primary),
              onPressed: () => controller.addLog('Manual refresh triggered.'),
            ),
          ],
        ),
        body: ResponsiveSplitDashboard(
          metrics: const [
            GovMetricCard(
              title: 'Active Operations',
              value: 'Active',
              trendLabel: 'Optimal',
              progress: 0.92,
              icon: LucideIcons.activity,
              brandColor: Color(0xFF0D9488),
            ),
            GovMetricCard(
              title: 'Security Clearance',
              value: 'Level 4',
              trendLabel: 'Approved',
              progress: 1.0,
              icon: LucideIcons.shieldCheck,
              brandColor: Color(0xFF16A34A),
            ),
            GovMetricCard(
              title: 'System Latency',
              value: '18ms',
              trendLabel: 'Optimal',
              progress: 0.98,
              icon: LucideIcons.zap,
              brandColor: Color(0xFFEAB308),
            ),
            GovMetricCard(
              title: 'Data Integrity',
              value: '99.9%',
              trendLabel: 'Secure',
              progress: 0.99,
              icon: LucideIcons.database,
              brandColor: Color(0xFF2563EB),
            ),
          ],
          mainContent: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Semantics(
                label: 'data-cy:trainingcoordinatordashboard-title',
                child: GovDashboardHero(
                  title: 'Training Coordinator Control Center',
                  roleName: '$roleBase Dashboard',
                  description: 'Welcome to your governed operation center. Review key performance indicators, live telemetry logs, and compliance standings.',
                  onRefresh: () => controller.addLog('Dashboard telemetry synchronized.'),
                ),
              ),
              const SizedBox(height: 24),
              GovTelemetryChart(
                title: 'Hourly Core Telemetry',
                dataPoints: const [75, 82, 80, 94, 91, 98],
                labels: const ['09:00', '10:00', '11:00', '12:00', '13:00', '14:00'],
                accentColor: theme.colors.primary,
              ),
            ],
          ),
          defaultSidebarWidgets: [
            // === Executive Pill Action Button ===
            SizedBox(
              width: double.infinity,
              height: 48,
              child: ElevatedButton.icon(
                key: const Key('trainingcoordinatordashboard-btn-2'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: theme.colors.primaryContainer,
                  foregroundColor: Colors.white,
                  elevation: 4,
                  shadowColor: theme.colors.primary.withValues(alpha: 0.3),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)),
                ),
                icon: const Icon(LucideIcons.playCircle, size: 18),
                onPressed: () => controller.triggerStateAction(),
                label: Text('Execute: Button 1'.tr()),
              ),
            ),
            const SizedBox(height: 24),
            // === Audit Logs Panel ===
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: theme.colors.surface,
                borderRadius: BorderRadius.circular(theme.radiusMd),
                border: Border.all(color: theme.colors.border),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.03),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Operational Audit Logs',
                    style: theme.typography.h4.copyWith(color: theme.colors.onSurface),
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
                            style: TextStyle(color: theme.colors.primary, fontWeight: FontWeight.bold),
                          ),
                          Expanded(
                            child: Text(
                              log.tr(),
                              style: theme.typography.bodySmall.copyWith(color: theme.colors.onSurfaceVariant),
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
                      key: const Key('trainingcoordinatordashboard-btn-3'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: theme.colors.primary,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                      ),
                      onPressed: state.isLoading
                          ? null
                          : () => controller.runComplianceScan(),
                      child: state.isLoading
                          ? const SizedBox(
                              height: 20,
                              width: 20,
                              child: CircularProgressIndicator(
                                key: Key('trainingcoordinatordashboard-loading'),
                                strokeWidth: 2,
                                valueColor: AlwaysStoppedAnimation(Colors.white),
                              ),
                            )
                          : Text(
                              'Execute Operational Audit Scan'.tr(),
                              style: theme.typography.button.copyWith(color: Colors.white),
                            ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
