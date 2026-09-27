import 'package:primecare_ui/primecare_ui.dart';
import 'physician_dashboard_screen_controller.dart';

class PhysicianDashboardScreen extends GovernedConsumerWidget {
  @override
  String get screenDescription =>
      'The physician dashboard requires components for displaying metrics, action buttons for key functions, and APIs for managing prescriptions and lab orders.';

  @override
  List<String> get requiredComponents => const [
        'GovMetricCard',
        'GovTelemetryChart',
        'LoadingIndicator',
        'ActionButton',
        'AuditLogsSection',
        'RecentActionsLog',
      ];

  @override
  List<String> get requiredFunctions => const [
        'submitEPrescription',
        'authorizeLabOrder',
        'runComplianceScan',
        'syncSecurityPosture',
        'updatePolicies',
        'exportAuditLogs',
      ];

  const PhysicianDashboardScreen({super.key});

  @override
  Widget buildScreen(BuildContext context, WidgetRef ref) {
    final state = ref.watch(physicianDashboardScreenControllerProvider);
    final controller = ref.read(physicianDashboardScreenControllerProvider.notifier);
    final theme = context.theme;
    final roleBase = 'Physician';

    return Cy(
      id: 'physiciandashboard-screen',
      child: Scaffold(
        backgroundColor: theme.colors.dashboardBackground,
        appBar: AppBar(
          backgroundColor: theme.colors.surface,
          elevation: 0,
          title: Semantics(label: 'data-cy:physiciandashboard-title', container: true, child: Container(child:  Text(
            key: const Key('physiciandashboard-title'),
            'Physician Dashboard',
            style: theme.typography.h3.copyWith(color: theme.colors.onSurface),
          ))),
          actions: [
            IconButton(
              key: const Key('physiciandashboard-btn-1'),
              icon: Icon(LucideIcons.refreshCw, color: theme.colors.primary),
              onPressed: () => controller.performAction(),
            ),
          ],
        ),
        body: state.when(
          data: (data) => ResponsiveSplitDashboard(
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
                  label: 'data-cy:physiciandashboard-title',
                  child: GovDashboardHero(
                    title: 'Physician Dashboard',
                    roleName: '$roleBase Dashboard',
                    description: 'Welcome to your governed operation center. Review key performance indicators, live telemetry logs, and compliance standings.',
                    onRefresh: () => controller.performAction(),
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
                  key: const Key('physiciandashboard-btn-2'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: theme.colors.primaryContainer,
                    foregroundColor: Colors.white,
                    elevation: 4,
                    shadowColor: theme.colors.primary.withValues(alpha: 0.3),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)),
                  ),
                  icon: const Icon(LucideIcons.playCircle, size: 18),
                  onPressed: () => controller.performAction(),
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
                    Padding(
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
                              'System initialized & security sync complete.',
                              style: theme.typography.bodySmall.copyWith(color: theme.colors.onSurfaceVariant),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),
                    SizedBox(
                      width: double.infinity,
                      height: 48,
                      child: ElevatedButton(
                        key: const Key('physiciandashboard-btn-3'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: theme.colors.primary,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                        ),
                        onPressed: () => controller.performAction(),
                        child: Text(
                          'Execute Operational Audit Scan',
                          style: theme.typography.button.copyWith(color: Colors.white),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (err, stack) => Center(child: Text('Error: $err')),
        ),
      ),
    );
  }
}
