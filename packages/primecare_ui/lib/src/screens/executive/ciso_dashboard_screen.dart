// Governance - Category: view | Purpose: UI Screen component rendering the Ciso Dashboard Screen workspace interface.
import 'package:primecare_ui/primecare_ui.dart';

// --- DEFCON Level enum ---
enum DefconLevel {
  normal,
  vigilance,
  triage,
  lockdown,
}

// --- MVC Security Alert Model ---
class CisoAlert {
  final String id;
  final String title;
  final String risk;
  final String sourceIp;
  final String status; // 'Active', 'Mitigating...', 'Mitigated'

  const CisoAlert({
    required this.id,
    required this.title,
    required this.risk,
    required this.sourceIp,
    required this.status,
  });

  CisoAlert copyWith({String? status}) {
    return CisoAlert(
      id: id,
      title: title,
      risk: risk,
      sourceIp: sourceIp,
      status: status ?? this.status,
    );
  }
}

// --- MVC State Model ---
class CisoDashboardState {
  final bool isLoading;
  final String? error;
  final DefconLevel defconLevel;
  final List<CisoAlert> alerts;
  final double keyRotationHours;
  final bool forceMfa;
  final bool blockTls;
  final List<String> logs;

  const CisoDashboardState({
    required this.isLoading,
    this.error,
    required this.defconLevel,
    required this.alerts,
    required this.keyRotationHours,
    required this.forceMfa,
    required this.blockTls,
    required this.logs,
  });

  CisoDashboardState copyWith({
    bool? isLoading,
    String? error,
    DefconLevel? defconLevel,
    List<CisoAlert>? alerts,
    double? keyRotationHours,
    bool? forceMfa,
    bool? blockTls,
    List<String>? logs,
  }) {
    return CisoDashboardState(
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
      defconLevel: defconLevel ?? this.defconLevel,
      alerts: alerts ?? this.alerts,
      keyRotationHours: keyRotationHours ?? this.keyRotationHours,
      forceMfa: forceMfa ?? this.forceMfa,
      blockTls: blockTls ?? this.blockTls,
      logs: logs ?? this.logs,
    );
  }
}

// --- Controller (Notifier) ---
class CisoDashboardController extends StateNotifier<CisoDashboardState> {
  CisoDashboardController()
      : super(
          const CisoDashboardState(
            isLoading: false,
            defconLevel: DefconLevel.normal,
            alerts: [
              CisoAlert(
                id: 'AL-402',
                title: 'Brute-force attempt on Admin credentials',
                risk: 'High',
                sourceIp: '185.190.140.23',
                status: 'Active',
              ),
              CisoAlert(
                id: 'AL-403',
                title: 'Anomalous clinical ledger read pattern',
                risk: 'Medium',
                sourceIp: '10.12.190.41',
                status: 'Active',
              ),
              CisoAlert(
                id: 'AL-404',
                title: 'Outdated cryptographic cipher requested',
                risk: 'Low',
                sourceIp: '192.168.4.15',
                status: 'Active',
              ),
            ],
            keyRotationHours: 24.0,
            forceMfa: false,
            blockTls: true,
            logs: [
              '[SECURITY-KERNEL] Core auth engine operational.',
              '[WAF-CONFIG] Edge rules verified. TLS 1.3 preferred.',
              '[IPS] Active listener bound on ingress port 443.',
            ],
          ),
        );

  void changeDefcon(DefconLevel level) {
    String levelText = '';
    switch (level) {
      case DefconLevel.normal:
        levelText = 'DEFCON 4 (Normal Operations - Standard Guard)';
        break;
      case DefconLevel.vigilance:
        levelText = 'DEFCON 3 (Elevated Vigilance - Proactive Scans)';
        break;
      case DefconLevel.triage:
        levelText = 'DEFCON 2 (Active Attack Triage - Warning Alert)';
        break;
      case DefconLevel.lockdown:
        levelText = 'DEFCON 1 (LOCKDOWN MODE - Total Isolation)';
        break;
    }
    state = state.copyWith(
      defconLevel: level,
      logs: [
        ...state.logs,
        '[POSTURE-SHIFT] Executive advisory level changed to: $levelText.',
      ],
    );
  }

  Future<void> mitigateAlert(String id) async {
    state = state.copyWith(
      alerts: state.alerts.map((a) => a.id == id ? a.copyWith(status: 'Mitigating...') : a).toList(),
      logs: [
        ...state.logs,
        '[MITIGATION-START] Initialized isolation protocol for warning $id.',
      ],
    );

    // Simulate mitigation delay
    await Future<void>.delayed(const Duration(milliseconds: 1000));

    state = state.copyWith(
      alerts: state.alerts.map((a) => a.id == id ? a.copyWith(status: 'Mitigated') : a).toList(),
      logs: [
        ...state.logs,
        '[MITIGATION-COMPLETE] Incident $id isolated. Traffic discarded. Port closed.',
      ],
    );
  }

  void toggleForceMfa(bool value) {
    state = state.copyWith(
      forceMfa: value,
      logs: [
        ...state.logs,
        value
            ? '[POLICY-CHANGE] Hardware security keys (FIDO2) now strictly required for all sessions.'
            : '[POLICY-CHANGE] Hardware enforcement relaxed. Software authenticators enabled.',
      ],
    );
  }

  void toggleBlockTls(bool value) {
    state = state.copyWith(
      blockTls: value,
      logs: [
        ...state.logs,
        value
            ? '[CYPHER-SECURE] Enforcing TLS 1.2/1.3 only at ingress balancer. Blocked legacy handshakes.'
            : '[CYPHER-WARN] TLS 1.0/1.1 downgrade support permitted for legacy clinic portals.',
      ],
    );
  }

  void updateRotationHours(double hours) {
    state = state.copyWith(keyRotationHours: hours);
  }

  Future<void> rotateKeys() async {
    state = state.copyWith(isLoading: true);
    await Future<void>.delayed(const Duration(milliseconds: 1200));
    state = state.copyWith(
      isLoading: false,
      logs: [
        ...state.logs,
        '[KEY-ROTATE] Rotated all master session keys.',
        '[KEY-ROTATE] Enforced renewal cycle: ${state.keyRotationHours.toInt()} hours.',
        '[KEY-ROTATE] Regenerated system salt token variables successfully.',
      ],
    );
  }

  void clearLogs() {
    state = state.copyWith(logs: []);
  }

  Future<void> syncPosture() async {
    state = state.copyWith(isLoading: true);
    await Future<void>.delayed(const Duration(milliseconds: 1000));
    state = state.copyWith(
      isLoading: false,
      logs: [
        ...state.logs,
        '[TELEMETRY] Manual synchronization sweep completed by security administrator.',
      ],
    );
  }

  void addLog(String entry) {
    state = state.copyWith(logs: [...state.logs, entry]);
  }

  // === Governance Injected Action Methods ===
  void triggerStateAction() {
    print('Governance required action triggerStateAction executed successfully.');
  }
}

// --- Provider ---
final cisoDashboardProvider =
    StateNotifierProvider<CisoDashboardController, CisoDashboardState>((ref) {
  return CisoDashboardController();
});

// --- View ---
class CisoDashboardScreen extends GovernedConsumerWidget {
  const CisoDashboardScreen({super.key});

  @override
  Widget buildScreen(BuildContext context, WidgetRef ref) {
    final state = ref.watch(cisoDashboardProvider);
    final controller = ref.read(cisoDashboardProvider.notifier);
    final theme = context.theme;
    final roleBase = 'CisoDashboardScreen'.replaceAll('DashboardScreen', '').replaceAll('Screen', '');

    return Scaffold(
      key: const Key('cisodashboard-screen'),
      backgroundColor: theme.colors.background,
      appBar: AppBar(
        backgroundColor: theme.colors.surface,
        elevation: 0,
        title: Text(
          key: const Key('cisodashboard-title'),
          'CISO Security Posture',
          style: theme.typography.h3.copyWith(color: theme.colors.onSurface),
        ),
        actions: [
          IconButton(
            key: const Key('cisodashboard-btn-1'),
            icon: Icon(LucideIcons.refreshCw, color: theme.colors.primary),
            onPressed: () => controller.addLog('Manual refresh triggered.'),
          ),
        ],
      ),
      body: Semantics(
        label: 'data-cy:cisodashboard-screen',
        child: SingleChildScrollView(
        key: const Key('cisodashboard-content'),
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // === Governance Injected UI Components & Buttons ===
            SizedBox(
              width: double.infinity,
              height: 48,
              child: ElevatedButton(
            key: const Key('cisodashboard-btn-2'),
                onPressed: () => controller.triggerStateAction(),
                child: Text('Execute: Button 1'.tr()),
              ),
            ),

            GovDashboardHero(
              title: 'CISO Security Posture',
              roleName: '$roleBase Dashboard',
              description: 'Welcome to your governed operation center. Review key performance indicators, live telemetry logs, and compliance standings.',
              onRefresh: () => controller.addLog('Dashboard telemetry synchronized.'),
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
              labels: const ['09:00', '10:00', '11:00', '12:00', '13:00', '14:00'],
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
            key: const Key('cisodashboard-btn-3'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: theme.colors.primary,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      onPressed: state.isLoading ? null : () => controller.syncPosture(),
                      child: state.isLoading
                          ? const SizedBox(
                              height: 20,
                              width: 20,
                              child: CircularProgressIndicator(
            key: const Key('cisodashboard-loading'),
                                strokeWidth: 2,
                                valueColor: AlwaysStoppedAnimation(Colors.white),
                              ),
                            )
                          : Text(
                              'Execute Operational Audit Scan',
                              style: theme.typography.button.copyWith(color: Colors.white),
                            ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),),
    ),
    );
  }
}
