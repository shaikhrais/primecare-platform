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
        backgroundColor: theme.colors.dashboardBackground,
        appBar: AppBar(
          backgroundColor: theme.colors.surface,
          elevation: 0,
          title: Semantics(
            label: 'data-cy:pswdashboard-title',
            child: Text(
              key: const Key('pswdashboard-title'),
              'Psw Dashboard',
              style: theme.typography.h3.copyWith(color: theme.colors.onSurface),
            ),
          ),
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
                label: 'data-cy:pswdashboard-title',
                child: GovDashboardHero(
                  title: 'Psw Dashboard',
                  roleName: '$roleBase Dashboard',
                  description: 'Welcome to your governed operation center. Review key performance indicators, live telemetry logs, and compliance standings.',
                  onRefresh: () {},
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
          defaultSidebarWidgets: const [
            AiInsightsCard(
              heading: 'PSW Telemetry Insights',
              suggestions: ['Complete tasks checklist before closing shift.', 'Ensure hydration protocols are recorded for all residents.', 'Report any behavioral shifts directly to the shift supervisor.'],
            ),
          ],
        ),
      ),
    );
  }
}
