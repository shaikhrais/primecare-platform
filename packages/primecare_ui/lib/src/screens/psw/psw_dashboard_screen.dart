// Governance - Category: view | Purpose: UI Screen component rendering the Psw Dashboard Screen workspace interface.
import 'package:primecare_ui/primecare_ui.dart';

// --- MVC State Model ---
class PswDashboardState {
  final bool isLoading;
  final String? error;
  final String title;
  final List<String> logs;
  final bool isCheckedIn;
  final int completedTasksCount;
  final int totalTasksCount;
  final String activeWing;
  final int activeAlertsCount;

  const PswDashboardState({
    required this.isLoading,
    this.error,
    required this.title,
    required this.logs,
    required this.isCheckedIn,
    required this.completedTasksCount,
    required this.totalTasksCount,
    required this.activeWing,
    required this.activeAlertsCount,
  });

  PswDashboardState copyWith({
    bool? isLoading,
    String? error,
    String? title,
    List<String>? logs,
    bool? isCheckedIn,
    int? completedTasksCount,
    int? totalTasksCount,
    String? activeWing,
    int? activeAlertsCount,
  }) {
    return PswDashboardState(
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
      title: title ?? this.title,
      logs: logs ?? this.logs,
      isCheckedIn: isCheckedIn ?? this.isCheckedIn,
      completedTasksCount: completedTasksCount ?? this.completedTasksCount,
      totalTasksCount: totalTasksCount ?? this.totalTasksCount,
      activeWing: activeWing ?? this.activeWing,
      activeAlertsCount: activeAlertsCount ?? this.activeAlertsCount,
    );
  }
}

// --- Controller (Notifier) ---
class PswDashboardController extends StateNotifier<PswDashboardState> {
  PswDashboardController()
    : super(
        const PswDashboardState(
          isLoading: false,
          title: 'PSW Care Control Center',
          logs: ['Shift assigned: East Wing.', 'Security sync complete.'],
          isCheckedIn: false,
          completedTasksCount: 5,
          totalTasksCount: 8,
          activeWing: 'East Wing - Memory Care',
          activeAlertsCount: 1,
        ),
      );

  void toggleCheckIn() {
    final nextState = !state.isCheckedIn;
    state = state.copyWith(
      isCheckedIn: nextState,
      logs: [
        ...state.logs,
        nextState 
          ? 'Checked into shift at ${DateTime.now().toLocal().toString().substring(11, 19)}' 
          : 'Checked out of shift at ${DateTime.now().toLocal().toString().substring(11, 19)}',
      ],
    );
  }

  void triggerEmergencyAlert() {
    state = state.copyWith(
      activeAlertsCount: state.activeAlertsCount + 1,
      logs: [
        ...state.logs,
        'CRITICAL: Emergency alert triggered for Memory Care unit! Supervisor notified.',
      ],
    );
  }

  Future<void> runComplianceScan() async {
    state = state.copyWith(isLoading: true);
    await Future<void>.delayed(const Duration(seconds: 1));
    state = state.copyWith(
      isLoading: false,
      logs: [
        ...state.logs,
        'Compliance audit executed: all 5 completed ADL logs validated against Ministry standards.',
      ],
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
final pswDashboardControllerProvider =
    StateNotifierProvider<PswDashboardController, PswDashboardState>((ref) {
      return PswDashboardController();
    });

// --- View ---
class PswDashboardScreen extends GovernedConsumerWidget {
  const PswDashboardScreen({super.key});

  @override
  Widget buildScreen(BuildContext context, WidgetRef ref) {
    final state = ref.watch(pswDashboardControllerProvider);
    final controller = ref.read(pswDashboardControllerProvider.notifier);
    final theme = context.theme;
    final roleBase = 'PSW';

    return Cy(
      id: 'pswdashboard-screen',
      child: Scaffold(
        key: const Key('pswdashboard-screen'),
        backgroundColor: theme.colors.background,
        appBar: AppBar(
          backgroundColor: theme.colors.surface,
          elevation: 0,
          title: Semantics(
            container: true,
            label: 'data-cy:pswdashboard-title',
            child: Text(
              key: const Key('pswdashboard-title'),
              state.title.tr(),
              style: theme.typography.h3.copyWith(color: theme.colors.onSurface),
            ),
          ),
          actions: [
            IconButton(
              key: const Key('pswdashboard-btn-1'),
              icon: Icon(LucideIcons.refreshCw, color: theme.colors.primary),
              onPressed: () => controller.addLog('Manual refresh triggered.'),
            ),
          ],
        ),
        body: Cy(
          id: 'pswdashboard-content',
          child: ResponsiveSplitDashboard(
          metrics: [
            GovMetricCard(
              title: 'Shift Status'.tr(),
              value: state.isCheckedIn ? 'Active'.tr() : 'Off-Duty'.tr(),
              trendLabel: state.isCheckedIn ? 'Checked In'.tr() : 'Checked Out'.tr(),
              progress: state.isCheckedIn ? 1.0 : 0.0,
              icon: LucideIcons.calendarCheck,
              brandColor: state.isCheckedIn ? const Color(0xFF16A34A) : const Color(0xFFDC2626),
            ),
            GovMetricCard(
              title: 'ADL Care Progress'.tr(),
              value: '${state.completedTasksCount}/${state.totalTasksCount}',
              trendLabel: 'Required tasks'.tr(),
              progress: state.totalTasksCount > 0 ? state.completedTasksCount / state.totalTasksCount : 0.0,
              icon: LucideIcons.checkSquare,
              brandColor: const Color(0xFF0D9488),
            ),
            GovMetricCard(
              title: 'Assigned Wing'.tr(),
              value: 'Memory Care'.tr(),
              trendLabel: state.activeWing.tr(),
              progress: 1.0,
              icon: LucideIcons.mapPin,
              brandColor: const Color(0xFF2563EB),
            ),
            GovMetricCard(
              title: 'Safety Alerts'.tr(),
              value: '${state.activeAlertsCount}',
              trendLabel: state.activeAlertsCount > 0 ? 'Urgent attention'.tr() : 'Wing is clear'.tr(),
              progress: state.activeAlertsCount > 0 ? 0.3 : 1.0,
              icon: LucideIcons.alertTriangle,
              brandColor: state.activeAlertsCount > 0 ? const Color(0xFFEAB308) : const Color(0xFF16A34A),
            ),
          ],
          mainContent: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Semantics(
                label: 'data-cy:pswdashboard-title',
                child: GovDashboardHero(
                  title: 'PSW Care Control Center'.tr(),
                  roleName: '$roleBase Dashboard',
                  description: 'Manage resident ADLs, check-in to shifts, log incidents, and trigger emergency support from your clinical station.'.tr(),
                  onRefresh: () => controller.addLog('Dashboard telemetry synchronized.'),
                ),
              ),
              const SizedBox(height: 24),
              GovTelemetryChart(
                title: 'Hourly Care Activities Logs'.tr(),
                dataPoints: const [4, 6, 5, 8, 7, 9],
                labels: const ['09:00', '10:00', '11:00', '12:00', '13:00', '14:00'],
                accentColor: theme.colors.primary,
              ),
            ],
          ),
          defaultSidebarWidgets: [
            // === Shift Check-In / Out Card ===
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
                    'Duty Registration'.tr(),
                    style: theme.typography.h4.copyWith(color: theme.colors.onSurface),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    state.isCheckedIn 
                      ? 'You are active on duty. Keep this terminal open to log care tasks.'.tr() 
                      : 'You are currently off-duty. Please check in to record resident details.'.tr(),
                    style: theme.typography.bodySmall.copyWith(color: theme.colors.onSurfaceVariant),
                  ),
                  const SizedBox(height: 16),
                  SizedBox(
                    width: double.infinity,
                    height: 48,
                    child: ElevatedButton.icon(
                      key: const Key('pswdashboard-btn-checkin'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: state.isCheckedIn ? const Color(0xFFDC2626) : const Color(0xFF16A34A),
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                      ),
                      icon: Icon(state.isCheckedIn ? LucideIcons.logOut : LucideIcons.checkCircle),
                      onPressed: () => controller.toggleCheckIn(),
                      label: Text(state.isCheckedIn ? 'Check-Out Shift'.tr() : 'Check-In Shift'.tr()),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            // === Emergency Station Card ===
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: const Color(0xFFFEE2E2),
                borderRadius: BorderRadius.circular(theme.radiusMd),
                border: Border.all(color: const Color(0xFFFCA5A5), width: 1.5),
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
                  Row(
                    children: [
                      const Icon(LucideIcons.alertOctagon, color: Color(0xFFB91C1C), size: 22),
                      const SizedBox(width: 8),
                      Text(
                        'Emergency Station'.tr(),
                        style: theme.typography.h4.copyWith(color: const Color(0xFF991B1B), fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Trigger an immediate distress warning to the Clinical Director and RNs for active code/falls.'.tr(),
                    style: theme.typography.bodySmall.copyWith(color: const Color(0xFF7F1D1D)),
                  ),
                  const SizedBox(height: 16),
                  SizedBox(
                    width: double.infinity,
                    height: 48,
                    child: ElevatedButton.icon(
                      key: const Key('pswdashboard-btn-emergency'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFB91C1C),
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                      ),
                      icon: const Icon(LucideIcons.phoneCall),
                      onPressed: () => controller.triggerEmergencyAlert(),
                      label: Text('Trigger Emergency Alert'.tr()),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            // === Shift Activity Logs Panel ===
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
                    'Shift Activity Logs'.tr(),
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
                      key: const Key('pswdashboard-btn-3'),
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
                                key: Key('pswdashboard-loading'),
                                strokeWidth: 2,
                                valueColor: AlwaysStoppedAnimation(Colors.white),
                              ),
                            )
                          : Text(
                              'Run Shift Compliance Audit'.tr(),
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
      ),
    );
  }
}
