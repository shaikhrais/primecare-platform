import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';

class PswDashboardScreen extends ConsumerWidget {
  const PswDashboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = context.theme;
    final roleBase = 'Psw';

    return Cy(
      id: 'pswdashboard-screen',
      child: Scaffold(
        backgroundColor: theme.colors.background,
        appBar: AppBar(
          backgroundColor: theme.colors.surface,
          elevation: 0,
          title: Cy(
            id: 'pswdashboard-title',
            child: Text(
              'Psw Dashboard',
              style: theme.typography.h3.copyWith(color: theme.colors.onSurface),
            ),
          ),
        ),
        body: Semantics(
          label: 'data-cy:pswdashboard-content',
          container: true,
          child: Cy(
          id: 'pswdashboard-content',
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Cy(
                  id: 'pswdashboard-title',
                  child: Semantics(label: 'data-cy:pswdashboard-title', child: GovDashboardHero(
                    title: 'Psw Dashboard',
                    roleName: '$roleBase Dashboard',
                    description: 'Welcome to your governed operation center. Review key performance indicators, live telemetry logs, and compliance standings.',
                    onRefresh: () {},
                  )),
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
              ],
            ),
          ),
        ),
        ),
      ),
    );
  }
}
