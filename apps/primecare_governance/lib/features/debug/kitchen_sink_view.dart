import 'package:primecare_ui/primecare_ui.dart';

class KitchenSinkView extends StatelessWidget {
  const KitchenSinkView({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;

    // Mock Data for components
    final mockMetrics = DashboardMetrics(
      kpis: {
        'Total Visits': 124,
        'Active Clients': 42,
        'Pending Tasks': 8,
        'Completion Rate': '94%',
      },
      insights: [],
      charts: [],
      recentActivity: [],
    );

    return CustomScrollView(
      slivers: [
        SliverToBoxAdapter(
          child: Padding(
            padding: EdgeInsets.all(theme.spacing.md),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SystemIntegrityManifest(),
                SizedBox(height: theme.spacing.md),
                
                _buildSection(context, 'Premium High-Fidelity Stats', [
                  GridView.count(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    crossAxisCount: 2,
                    crossAxisSpacing: theme.spacing.md,
                    mainAxisSpacing: theme.spacing.md,
                    childAspectRatio: 1.4,
                    children: [
                      PrimeCareStatCard(
                        title: 'Active PSWs',
                        value: '142',
                        deltaSuffix: '+12%',
                        icon: LucideIcons.users,
                        iconColor: theme.colors.primary,
                      ),
                      PrimeCareStatCard(
                        title: 'Compliance Score',
                        value: '98.4%',
                        deltaSuffix: 'Stable',
                        icon: LucideIcons.shieldCheck,
                        iconColor: theme.colors.success,
                      ),
                    ],
                  ),
                ]),

                _buildSection(context, 'KPI Grids', [
                  DashboardKpiGrid(metrics: mockMetrics),
                ]),

                _buildSection(context, 'Glassmorphism & Panels', [
                  ClinicalGlassPanel(
                    title: 'Clinical Intelligence Hub',
                    icon: LucideIcons.activity,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Real-time telemetry from active units.',
                          style: theme.typography.bodyMedium.copyWith(color: theme.colors.onSurfaceVariant),
                        ),
                        SizedBox(height: theme.spacing.md),
                        LinearProgressIndicator(
                          value: 0.65,
                          backgroundColor: theme.colors.divider,
                          valueColor: AlwaysStoppedAnimation<Color>(theme.colors.primary),
                        ),
                        SizedBox(height: theme.spacing.sm),
                        Text(
                          'Unit Efficiency: 65%',
                          style: theme.typography.bodySmall.copyWith(color: theme.colors.primary),
                        ),
                      ],
                    ),
                  ),
                ]),

                _buildSection(context, 'Charts & Visualization', [
                  SizedBox(
                    height: 200,
                    child: PrimeCareChartCard(
                      title: 'Weekly Performance',
                      chart: Center(
                        child: Text(
                          '[ Interactive Chart Placeholder ]',
                          style: theme.typography.bodySmall.copyWith(color: theme.colors.onSurfaceVariant),
                        ),
                      ),
                    ),
                  ),
                ]),

                _buildSection(context, 'Operational Feedback', [
                  const DashboardLoadingWidget(),
                  SizedBox(height: theme.spacing.lg),
                  const DashboardErrorWidget(
                    message: 'Connection to Clinical Gateway timed out after 30s.',
                  ),
                ]),

                _buildSection(context, 'Form Elements', [
                  const PrimeCareTextField(
                    label: 'Patient ID',
                    hintText: 'PC-XXXX-XXXX',
                  ),
                  SizedBox(height: theme.spacing.md),
                  const PrimeCareTextField(
                    label: 'Clinical Observation',
                    maxLines: 3,
                    hintText: 'Enter findings...',
                  ),
                ]),

                _buildSection(context, 'Actionable Insights', [
                  ActionableInsightCard(
                    insight: IntelligenceInsight(
                      id: 'opt-1',
                      title: 'Logistics Optimization',
                      summary: 'Route optimization can save 45 mins of travel time today.',
                      impact: InsightImpact.positive,
                    ),
                  ),
                  ActionableInsightCard(
                    insight: IntelligenceInsight(
                      id: 'crit-1',
                      title: 'Missed Medication',
                      summary: 'Aura detected a missing MAR entry for Unit 12A.',
                      impact: InsightImpact.critical,
                    ),
                  ),
                ]),

                const SizedBox(height: 80),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSection(BuildContext context, String title, List<Widget> children) {
    final theme = context.theme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        DashboardSectionHeader(title: title),
        SizedBox(height: theme.spacing.sm),
        ...children,
        SizedBox(height: theme.spacing.xl),
      ],
    );
  }
}
