import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'physiotherapist_dashboard_screen_controller.dart';

class PhysiotherapistDashboardScreen extends ConsumerWidget {
  const PhysiotherapistDashboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(physiotherapistDashboardScreenControllerProvider);
    final controller = ref.read(physiotherapistDashboardScreenControllerProvider.notifier);
    final theme = context.theme;
    final roleBase = 'Physiotherapist';

    return Cy(
      id: 'physiotherapistdashboard-screen',
      child: Scaffold(
        backgroundColor: theme.colors.background,
        appBar: AppBar(
          backgroundColor: theme.colors.surface,
          elevation: 0,
          title: Text(
            key: const Key('physiotherapistdashboard-title'),
            'Physiotherapist Dashboard',
            style: theme.typography.h3.copyWith(color: theme.colors.onSurface),
          ),
          actions: [
            IconButton(
              key: const Key('physiotherapistdashboard-btn-1'),
              icon: Icon(LucideIcons.refreshCw, color: theme.colors.primary),
              onPressed: () => controller.performAction(),
            ),
          ],
        ),
        body: state.when(
          data: (data) => Cy(
            id: 'physiotherapistdashboard-content',
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // === Governance Injected UI Components & Buttons ===
                  SizedBox(
                    width: double.infinity,
                    height: 48,
                    child: ElevatedButton(
                      key: const Key('physiotherapistdashboard-btn-2'),
                      onPressed: () => controller.performAction(),
                      child: Text('Execute: Button 1'.tr()),
                    ),
                  ),

                  Cy(
                    id: 'physiotherapistdashboard-title',
                    child: GovDashboardHero(
                      title: 'Physiotherapist Dashboard',
                      roleName: '$roleBase Dashboard',
                      description: 'Welcome to your governed operation center. Review key performance indicators, live telemetry logs, and compliance standings.',
                      onRefresh: () => controller.performAction(),
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
                            key: const Key('physiotherapistdashboard-btn-3'),
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
            ),
          ),
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (err, stack) => Center(child: Text('Error: $err')),
        ),
      ),
    );
  }
}
