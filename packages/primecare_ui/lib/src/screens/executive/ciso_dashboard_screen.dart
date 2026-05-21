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

    // Derived theme styling from DEFCON level
    Color defconColor;
    Color defconBg;
    String defconTitle;
    String defconDescription;
    IconData defconIcon;

    switch (state.defconLevel) {
      case DefconLevel.normal:
        defconColor = const Color(0xFF10B981); // Emerald Green
        defconBg = const Color(0xFF065F46).withValues(alpha: 0.1);
        defconTitle = 'DEFCON 4: STANDARD SECURITY';
        defconDescription = 'Organizational security systems functioning normally. Standard threat monitoring sweeps are active.';
        defconIcon = LucideIcons.shieldCheck;
        break;
      case DefconLevel.vigilance:
        defconColor = const Color(0xFF6366F1); // Royal Indigo
        defconBg = const Color(0xFF3730A3).withValues(alpha: 0.1);
        defconTitle = 'DEFCON 3: ELEVATED VIGILANCE';
        defconDescription = 'Enhanced threat intelligence scanning. All security analysts have been notified of elevated port scans.';
        defconIcon = LucideIcons.activity;
        break;
      case DefconLevel.triage:
        defconColor = const Color(0xFFF59E0B); // Curated Amber
        defconBg = const Color(0xFF92400E).withValues(alpha: 0.1);
        defconTitle = 'DEFCON 2: ACTIVE THREAT TRIAGE';
        defconDescription = 'Critical anomalies detected. Automated defense scripts are executing. Firewall ingress rate-limiting active.';
        defconIcon = LucideIcons.shieldAlert;
        break;
      case DefconLevel.lockdown:
        defconColor = const Color(0xFFEF4444); // Crimson Red
        defconBg = const Color(0xFF991B1B).withValues(alpha: 0.1);
        defconTitle = 'DEFCON 1: INTRUSION LOCKDOWN';
        defconDescription = 'IMMEDIATE EMERGENCY ACTIONS APPLIED. Access tokens suspended. External gateways quarantined. CFO credentials locked.';
        defconIcon = LucideIcons.skull;
        break;
    }

    // Interactive fleet telemetry simulation
    final activeAlertCount = state.alerts.where((a) => a.status != 'Mitigated').length;
    final mitigationScore = state.alerts.isEmpty
        ? 1.0
        : (state.alerts.length - activeAlertCount) / state.alerts.length;

    return Scaffold(
      backgroundColor: theme.colors.background,
      appBar: AppBar(
        backgroundColor: theme.colors.surface,
        elevation: 0,
        title: Row(
          children: [
            Icon(LucideIcons.shieldCheck, color: theme.colors.primary, size: 24),
            const SizedBox(width: 8),
            Text(
              'CISO Command Center',
              style: theme.typography.h3.copyWith(color: theme.colors.onSurface),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: Icon(LucideIcons.refreshCw, color: theme.colors.primary),
            onPressed: () {
              controller.addLog('[TELEMETRY] Manual synchronization sweep triggered by user.');
            },
          ),
        ],
      ),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1800),
          child: ResponsiveSplitDashboard(
            metrics: [
              GovMetricCard(
                title: 'Active Cyber Threats', // .tr() LocaleKeys.
                value: '$activeAlertCount Anomalies', // .tr() LocaleKeys.
                trendLabel: activeAlertCount == 0 ? 'Optimal Status' : 'Threats pending isolation', // .tr() LocaleKeys.
                progress: mitigationScore,
                icon: LucideIcons.shieldAlert,
                brandColor: defconColor,
              ),
              GovMetricCard(
                title: 'Firewall Efficacy', // .tr() LocaleKeys.
                value: state.blockTls ? '99.98% Secured' : '96.42% Weak Cipher', // .tr() LocaleKeys.
                trendLabel: state.blockTls ? 'TLS legacy traffic blocked' : 'Legacy fallback active', // .tr() LocaleKeys.
                progress: state.blockTls ? 0.99 : 0.85,
                icon: LucideIcons.activity,
                brandColor: state.blockTls ? const Color(0xFF10B981) : const Color(0xFFF59E0B),
              ),
            ],
            mainContent: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // --- CISO Title Hero Section ---
                GovDashboardHero(
                  title: 'Chief Information Security Officer', // .tr() LocaleKeys.
                  roleName: 'CISO Command HUD', // .tr() LocaleKeys.
                  description: 'Configure and enforce enterprise-grade security policies, quarantine suspicious assets, and rotate master cryptography credentials.', // .tr() LocaleKeys.
                  onRefresh: () => controller.addLog('[HUD-SYNC] Refreshing global vulnerability scorecards.'), // .tr() LocaleKeys.
                ),
                const SizedBox(height: 24),

                // --- DEFCON Interactive Control Panel ---
                Container(
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
                        'Threat Posture Advisory Level', // .tr() LocaleKeys.
                        style: theme.typography.h4.copyWith(color: theme.colors.onSurface),
                      ),
                      const SizedBox(height: 16),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: DefconLevel.values.map((level) {
                          final isSelected = state.defconLevel == level;
                          Color btnColor;
                          String btnLabel;

                          switch (level) {
                            case DefconLevel.normal:
                              btnColor = const Color(0xFF10B981);
                              btnLabel = 'DEFCON 4'; // .tr() LocaleKeys.
                              break;
                            case DefconLevel.vigilance:
                              btnColor = const Color(0xFF6366F1);
                              btnLabel = 'DEFCON 3'; // .tr() LocaleKeys.
                              break;
                            case DefconLevel.triage:
                              btnColor = const Color(0xFFF59E0B);
                              btnLabel = 'DEFCON 2'; // .tr() LocaleKeys.
                              break;
                            case DefconLevel.lockdown:
                              btnColor = const Color(0xFFEF4444);
                              btnLabel = 'DEFCON 1'; // .tr() LocaleKeys.
                              break;
                          }

                          return Expanded(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 4.0),
                              child: InkWell(
                                onTap: () => controller.changeDefcon(level),
                                borderRadius: BorderRadius.circular(8),
                                child: AnimatedContainer(
                                  duration: const Duration(milliseconds: 200),
                                  padding: const EdgeInsets.symmetric(vertical: 12),
                                  decoration: BoxDecoration(
                                    color: isSelected ? btnColor : theme.colors.surface,
                                    borderRadius: BorderRadius.circular(8),
                                    border: Border.all(
                                      color: isSelected ? btnColor : theme.colors.border,
                                      width: 1.5,
                                    ),
                                  ),
                                  alignment: Alignment.center,
                                  child: Text(
                                    btnLabel,
                                    style: theme.typography.button.copyWith(
                                      color: isSelected ? Colors.white : theme.colors.onSurfaceVariant,
                                      fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                      const SizedBox(height: 20),
                      // Render Dynamic Security Status HUD based on level
                      AnimatedContainer(
                        duration: const Duration(milliseconds: 300),
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: defconBg,
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: defconColor.withValues(alpha: 0.3)),
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Icon(defconIcon, color: defconColor, size: 28),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    defconTitle,
                                    style: theme.typography.h4.copyWith(color: defconColor, fontWeight: FontWeight.bold),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    defconDescription,
                                    style: theme.typography.bodySmall.copyWith(color: theme.colors.onSurface),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),

                // --- Real-time Security Invariant Triage Panel ---
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: theme.colors.surface,
                    borderRadius: BorderRadius.circular(theme.radiusMd),
                    border: Border.all(color: theme.colors.border),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Live Ingress Threat Mitigation Panel', // .tr() LocaleKeys.
                            style: theme.typography.h4.copyWith(color: theme.colors.onSurface),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                            decoration: BoxDecoration(
                              color: activeAlertCount == 0
                                  ? const Color(0xFF065F46).withValues(alpha: 0.1)
                                  : const Color(0xFF991B1B).withValues(alpha: 0.1),
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: Text(
                              activeAlertCount == 0 ? 'SECURE' : '$activeAlertCount PENDING', // .tr() LocaleKeys.
                              style: theme.typography.bodySmall.copyWith(
                                color: activeAlertCount == 0 ? const Color(0xFF10B981) : const Color(0xFFEF4444),
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      if (state.alerts.isEmpty)
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 24.0),
                          child: Center(
                            child: Text(
                              'No anomalies detected in the network firewall.', // .tr() LocaleKeys.
                              style: theme.typography.bodyLarge.copyWith(color: theme.colors.onSurfaceVariant),
                            ),
                          ),
                        )
                      else
                        ...state.alerts.map((alert) {
                          final isMitigated = alert.status == 'Mitigated';
                          final isMitigating = alert.status == 'Mitigating...';

                          Color alertColor;
                          switch (alert.risk) {
                            case 'High':
                              alertColor = const Color(0xFFEF4444);
                              break;
                            case 'Medium':
                              alertColor = const Color(0xFFF59E0B);
                              break;
                            default:
                              alertColor = const Color(0xFF6366F1);
                          }

                          return Container(
                            margin: const EdgeInsets.only(bottom: 12),
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: theme.colors.background,
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(
                                color: isMitigated ? theme.colors.border : alertColor.withValues(alpha: 0.3),
                              ),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          Container(
                                            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                                            decoration: BoxDecoration(
                                              color: alertColor.withValues(alpha: 0.1),
                                              borderRadius: BorderRadius.circular(4),
                                            ),
                                            child: Text(
                                              '${alert.risk} Risk', // .tr() LocaleKeys.
                                              style: theme.typography.bodySmall.copyWith(
                                                color: alertColor,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 10,
                                              ),
                                            ),
                                          ),
                                          const SizedBox(width: 8),
                                          Text(
                                            alert.id,
                                            style: theme.typography.bodySmall.copyWith(
                                              color: theme.colors.onSurfaceVariant,
                                              fontFamily: 'monospace',
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 6),
                                      Text(
                                        alert.title,
                                        style: theme.typography.bodyLarge.copyWith(
                                          color: isMitigated ? theme.colors.onSurfaceVariant : theme.colors.onSurface,
                                          decoration: isMitigated ? TextDecoration.lineThrough : null,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      const SizedBox(height: 4),
                                      Text(
                                        'Origin Address: ${alert.sourceIp}', // .tr() LocaleKeys.
                                        style: theme.typography.bodySmall.copyWith(
                                          color: theme.colors.onSurfaceVariant,
                                          fontSize: 11,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(width: 12),
                                SizedBox(
                                  height: 36,
                                  child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: isMitigated
                                          ? theme.colors.surface
                                          : isMitigating
                                              ? theme.colors.border
                                              : alertColor,
                                      foregroundColor: isMitigated ? theme.colors.onSurfaceVariant : Colors.white,
                                      elevation: 0,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(6),
                                        side: isMitigated ? BorderSide(color: theme.colors.border) : BorderSide.none,
                                      ),
                                    ),
                                    onPressed: (isMitigated || isMitigating)
                                        ? null
                                        : () => controller.mitigateAlert(alert.id),
                                    child: isMitigating
                                        ? const SizedBox(
                                            height: 14,
                                            width: 14,
                                            child: CircularProgressIndicator(
                                              strokeWidth: 2,
                                              valueColor: AlwaysStoppedAnimation(Colors.grey),
                                            ),
                                          )
                                        : Text(
                                            isMitigated ? 'Quarantined' : 'Mitigate', // .tr() LocaleKeys.
                                            style: theme.typography.button.copyWith(
                                              color: isMitigated ? theme.colors.onSurfaceVariant : Colors.white,
                                              fontSize: 12,
                                            ),
                                          ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        }).toList(),
                    ],
                  ),
                ),
              ],
            ),
            defaultSidebarWidgets: [
              QuickActionsPanel(
                title: 'Quick Actions', // .tr() LocaleKeys.
                actions: [
                  QuickActionItem(
                    label: 'Sync Posture', // .tr() LocaleKeys.
                    icon: LucideIcons.refreshCw,
                    color: theme.colors.primary,
                    onTap: state.isLoading ? () {} : () => controller.syncPosture(),
                  ),
                  QuickActionItem(
                    label: 'Clear Log Consoles', // .tr() LocaleKeys.
                    icon: LucideIcons.trash2,
                    color: Colors.red,
                    onTap: () => controller.clearLogs(),
                  ),
                ],
              ),
              const SizedBox(height: 24),

              // --- Cryptographic Key Rotation Hub ---
              Container(
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
                      'Cryptographic Key Management Hub', // .tr() LocaleKeys.
                      style: theme.typography.h4.copyWith(color: theme.colors.onSurface),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      'Rotate operational signing keys and adjust automated credential lifetimes.', // .tr() LocaleKeys.
                      style: theme.typography.bodySmall.copyWith(color: theme.colors.onSurfaceVariant),
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Enforce hardware key (FIDO2) authorization', // .tr() LocaleKeys.
                                style: theme.typography.bodyLarge.copyWith(color: theme.colors.onSurface),
                              ),
                              Text(
                                'Revoke access for software-based authenticators.', // .tr() LocaleKeys.
                                style: theme.typography.bodySmall.copyWith(color: theme.colors.onSurfaceVariant),
                              ),
                            ],
                          ),
                        ),
                        Switch(
                          activeThumbColor: theme.colors.primary,
                          value: state.forceMfa,
                          onChanged: (val) => controller.toggleForceMfa(val),
                        ),
                      ],
                    ),
                    const Divider(height: 24),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Restrict legacy TLS versions', // .tr() LocaleKeys.
                                style: theme.typography.bodyLarge.copyWith(color: theme.colors.onSurface),
                              ),
                              Text(
                                'Block handshake downgrades below TLS 1.2.', // .tr() LocaleKeys.
                                style: theme.typography.bodySmall.copyWith(color: theme.colors.onSurfaceVariant),
                              ),
                            ],
                          ),
                        ),
                        Switch(
                          activeThumbColor: theme.colors.primary,
                          value: state.blockTls,
                          onChanged: (val) => controller.toggleBlockTls(val),
                        ),
                      ],
                    ),
                    const Divider(height: 24),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Credential Lifetime Duration:', // .tr() LocaleKeys.
                          style: theme.typography.bodyLarge.copyWith(color: theme.colors.onSurface),
                        ),
                        Text(
                          '${state.keyRotationHours.toInt()} Hours', // .tr() LocaleKeys.
                          style: theme.typography.h4.copyWith(color: theme.colors.primary, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    Slider(
                      activeColor: theme.colors.primary,
                      inactiveColor: theme.colors.border,
                      min: 4,
                      max: 168,
                      divisions: 41,
                      value: state.keyRotationHours,
                      onChanged: (val) => controller.updateRotationHours(val),
                      onChangeEnd: (val) {
                        controller.addLog('[POLICY] Rotation cycle set to ${val.toInt()} hours.');
                      },
                    ),
                    const SizedBox(height: 16),
                    SizedBox(
                      width: double.infinity,
                      height: 48,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: theme.colors.primary,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        onPressed: state.isLoading ? null : () => controller.rotateKeys(),
                        child: state.isLoading
                            ? const SizedBox(
                                height: 20,
                                width: 20,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                  valueColor: AlwaysStoppedAnimation(Colors.white),
                                ),
                              )
                            : Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Icon(LucideIcons.lock, color: Colors.white, size: 18),
                                  const SizedBox(width: 8),
                                  Text(
                                    'Rotate Active Master Secrets Now', // .tr() LocaleKeys.
                                    style: theme.typography.button.copyWith(color: Colors.white),
                                  ),
                                ],
                              ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),

              // --- Monospace Retro Security Log Console ---
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: const Color(0xFF0F172A), // Premium Dark Slate
                  borderRadius: BorderRadius.circular(theme.radiusMd),
                  border: Border.all(color: const Color(0xFF1E293B)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            const Icon(LucideIcons.terminal, color: Color(0xFF38BDF8), size: 20),
                            const SizedBox(width: 8),
                            Text(
                              'Cryptographic & Ingress Audit Trails', // .tr() LocaleKeys.
                              style: theme.typography.h4.copyWith(color: const Color(0xFFF8FAFC)),
                            ),
                          ],
                        ),
                        IconButton(
                          icon: const Icon(LucideIcons.trash2, color: Color(0xFF64748B), size: 18),
                          onPressed: () => controller.clearLogs(),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Container(
                      height: 180,
                      width: double.infinity,
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: const Color(0xFF020617),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: ListView.builder(
                        itemCount: state.logs.length,
                        itemBuilder: (context, idx) {
                          final log = state.logs[idx];
                          Color logColor = const Color(0xFFCBD5E1); // slate-300
                          if (log.contains('[POSTURE-SHIFT]')) {
                            logColor = const Color(0xFFF472B6); // pink-400
                          } else if (log.contains('[MITIGATION-START]')) {
                            logColor = const Color(0xFFFBBF24); // amber-400
                          } else if (log.contains('[MITIGATION-COMPLETE]')) {
                            logColor = const Color(0xFF34D399); // emerald-400
                          } else if (log.contains('[KEY-ROTATE]')) {
                            logColor = const Color(0xFF60A5FA); // blue-400
                          } else if (log.contains('[CYPHER-WARN]')) {
                            logColor = const Color(0xFFFB923C); // orange-400
                          }

                          return Padding(
                            padding: const EdgeInsets.only(bottom: 6.0),
                            child: Text(
                              log,
                              style: const TextStyle(
                                fontFamily: 'monospace',
                                fontSize: 12,
                                color: Color(0xFFCBD5E1),
                              ).copyWith(color: logColor),
                            ),
                          );
                        },
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
