import 'package:primecare_ui/primecare_ui.dart';

// --- State Model ---
class ComplianceHubState {
  final bool isScanning;
  final double complianceScore;
  final List<String> scanLogs;
  final List<ComplianceAlert> alerts;

  const ComplianceHubState({
    required this.isScanning,
    required this.complianceScore,
    required this.scanLogs,
    required this.alerts,
  });

  ComplianceHubState copyWith({
    bool? isScanning,
    double? complianceScore,
    List<String>? scanLogs,
    List<ComplianceAlert>? alerts,
  }) {
    return ComplianceHubState(
      isScanning: isScanning ?? this.isScanning,
      complianceScore: complianceScore ?? this.complianceScore,
      scanLogs: scanLogs ?? this.scanLogs,
      alerts: alerts ?? this.alerts,
    );
  }
}

class ComplianceAlert {
  final String id;
  final String title;
  final String description;
  final String severity; // High, Medium, Low
  final DateTime timestamp;

  const ComplianceAlert({
    required this.id,
    required this.title,
    required this.description,
    required this.severity,
    required this.timestamp,
  });
}

// --- Controller (Notifier) ---
class ComplianceHubController extends StateNotifier<ComplianceHubState> {
  ComplianceHubController()
      : super(
          ComplianceHubState(
            isScanning: false,
            complianceScore: 94.8,
            scanLogs: const [
              'System security baseline sync: OK',
              'HIPAA clinical isolation rules: Verified',
              'Access monitoring agent: Active',
            ],
            alerts: [
              ComplianceAlert(
                id: '1',
                title: 'Stale Policy Revision Due',
                description: 'Clinical Medication Admin SOP is overdue for its annual structural audit.',
                severity: 'Medium',
                timestamp: DateTime.now().subtract(const Duration(hours: 3)),
              ),
              ComplianceAlert(
                id: '2',
                title: 'High Severity: Missing Training Signoff',
                description: 'Three newly onboarded clinical staff members are missing training signatures for HIPAA privacy controls.',
                severity: 'High',
                timestamp: DateTime.now().subtract(const Duration(hours: 5)),
              ),
            ],
          ),
        );

  Future<void> runTelemetryScan() async {
    state = state.copyWith(isScanning: true);
    await Future<void>.delayed(const Duration(milliseconds: 1200));
    
    final finalLogs = [
      ...state.scanLogs,
      'Scan triggered: ${DateTime.now().toLocal().toString()}',
      'Checking access control signatures...',
      'Validating database backup rotation telemetry...',
      'Syncing system audits with regional offices... SUCCESS',
    ];

    state = state.copyWith(
      isScanning: false,
      complianceScore: 96.2,
      scanLogs: finalLogs,
    );
  }

  void resolveAlert(String id) {
    final updatedAlerts = state.alerts.where((alert) => alert.id != id).toList();
    state = state.copyWith(
      alerts: updatedAlerts,
      complianceScore: updatedAlerts.isEmpty ? 99.5 : 97.4,
    );
  }
}

// --- Provider ---
final complianceHubProvider =
    StateNotifierProvider<ComplianceHubController, ComplianceHubState>((ref) {
  return ComplianceHubController();
});

// --- View ---
class ComplianceHub extends GovernedConsumerWidget {
  const ComplianceHub({super.key});

  @override
  Widget buildScreen(BuildContext context, WidgetRef ref) {
    final state = ref.watch(complianceHubProvider);
    final controller = ref.read(complianceHubProvider.notifier);
    final theme = context.theme;

    return Scaffold(
      backgroundColor: theme.colors.background,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GovDashboardHero(
              title: 'Compliance Hub',
              roleName: 'Compliance Manager Portal',
              description: 'Centralized security dashboard. Oversee live audit logs, track policy reviews, assess operational risks, and run platform scans.',
              onRefresh: () => controller.runTelemetryScan(),
            ),
            const SizedBox(height: 24),
            Row(
              children: [
                Expanded(
                  child: GovMetricCard(
                    title: 'Global Compliance Standing',
                    value: '${state.complianceScore}%',
                    trendLabel: 'Increased from 94.8% baseline',
                    progress: state.complianceScore / 100,
                    icon: LucideIcons.shieldCheck,
                    brandColor: state.complianceScore >= 95 ? Colors.green : theme.colors.primary,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: GovMetricCard(
                    title: 'Active Compliance Issues',
                    value: '${state.alerts.length} Pending',
                    trendLabel: state.alerts.isEmpty ? 'All metrics clear!' : 'Requires immediate reviews',
                    progress: state.alerts.isEmpty ? 1.0 : 0.5,
                    icon: LucideIcons.alertTriangle,
                    brandColor: state.alerts.any((a) => a.severity == 'High') ? Colors.red : Colors.orange,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
            GovTelemetryChart(
              title: 'Compliance Trend Metrics',
              dataPoints: const [90, 92, 91, 93, 94.8, 96.2],
              labels: const ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Current'],
              accentColor: theme.colors.primary,
            ),
            const SizedBox(height: 24),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 3,
                  child: Container(
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
                              'Actionable Security Alerts',
                              style: theme.typography.h4.copyWith(color: theme.colors.onSurface),
                            ),
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                              decoration: BoxDecoration(
                                color: state.alerts.isEmpty ? Colors.green.withOpacity(0.1) : Colors.red.withOpacity(0.1),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Text(
                                state.alerts.isEmpty ? 'Clear' : '${state.alerts.length} Warnings',
                                style: theme.typography.labelSmall.copyWith(
                                  color: state.alerts.isEmpty ? Colors.green : Colors.red,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        if (state.alerts.isEmpty)
                          Padding(
                            padding: const EdgeInsets.all(24.0),
                            child: Center(
                              child: Text(
                                'No critical security alerts are active.',
                                style: theme.typography.bodyMedium.copyWith(color: theme.colors.onSurfaceVariant),
                              ),
                            ),
                          )
                        else
                          ...state.alerts.map((alert) {
                            final isHigh = alert.severity == 'High';
                            return Container(
                              margin: const EdgeInsets.only(bottom: 12),
                              padding: const EdgeInsets.all(16),
                              decoration: BoxDecoration(
                                color: theme.colors.background,
                                borderRadius: BorderRadius.circular(theme.radiusSm),
                                border: Border.all(
                                  color: isHigh ? Colors.red.withOpacity(0.3) : theme.colors.border,
                                ),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Expanded(
                                        child: Text(
                                          alert.title,
                                          style: theme.typography.bodyMedium.copyWith(
                                            fontWeight: FontWeight.bold,
                                            color: isHigh ? Colors.red : theme.colors.onSurface,
                                          ),
                                        ),
                                      ),
                                      IconButton(
                                        icon: const Icon(LucideIcons.checkSquare, size: 20),
                                        onPressed: () => controller.resolveAlert(alert.id),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 6),
                                  Text(
                                    alert.description,
                                    style: theme.typography.bodySmall.copyWith(color: theme.colors.onSurfaceVariant),
                                  ),
                                ],
                              ),
                            );
                          }),
                      ],
                    ),
                  ),
                ),
                const SizedBox(width: 24),
                Expanded(
                  flex: 2,
                  child: Container(
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
                          'Live Scan Log Telemetry',
                          style: theme.typography.h4.copyWith(color: theme.colors.onSurface),
                        ),
                        const SizedBox(height: 12),
                        Container(
                          height: 200,
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: theme.colors.background,
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(color: theme.colors.border),
                          ),
                          child: ListView.builder(
                            itemCount: state.scanLogs.length,
                            itemBuilder: (context, index) {
                              final log = state.scanLogs[index];
                              return Padding(
                                padding: const EdgeInsets.only(bottom: 6.0),
                                child: Text(
                                  '> $log',
                                  style: const TextStyle(
                                    fontFamily: 'monospace',
                                    fontSize: 12,
                                    color: Colors.greenAccent,
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                        const SizedBox(height: 16),
                        SizedBox(
                          width: double.infinity,
                          height: 44,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: theme.colors.primary,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8)),
                            ),
                            onPressed: state.isScanning ? null : () => controller.runTelemetryScan(),
                            child: state.isScanning
                                ? const SizedBox(
                                    height: 18,
                                    width: 18,
                                    child: CircularProgressIndicator(
                                      strokeWidth: 2,
                                      valueColor: AlwaysStoppedAnimation(Colors.white),
                                    ),
                                  )
                                : const Text('Run Telemetry Scan'),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
