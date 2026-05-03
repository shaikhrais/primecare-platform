// @governance: id=SCREEN_CUSTOMER_SUPPORT_DASHBOARD
// @governance: isRenderOk=true
// @governance: userApprovedLayout=true
// @governance: lifecycleStatus=completed
// PRIMECARE CONSOLIDATED FILE
import 'package:primecare_ui/src/features/features_model.dart';
import 'package:primecare_ui/src/features/features_controller.dart';
import 'package:primecare_ui/src/theme/primecare_theme.dart';
import 'package:primecare_ui/src/shared/primecare_adapters.dart'
// @governance: isRenderOk=true
// @governance: userApprovedLayout=true
// @governance: lifecycleStatus=completed
// @governance: component=Data Table

    hide isOnlineProvider, ProviderTTL;

// @governance: component=Aura HUD (MTTR)
// @governance: component=SLA Performance Grid
// @governance: component=Customer Sentiment Hub
// @governance: component=Live Ticket Queue
class CustomerSupportDashboardView extends ConsumerWidget {
  const CustomerSupportDashboardView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = context.theme;
    final state = ref.watch(customerSupportDashboardAdapterProvider);

    return MasterLayout(
      child: state.when(
        data: (result) => result.fold(
          (vm) => _buildContent(
            context,
            theme,
            vm as CustomerSupportDashboardViewModel,
          ),
          (e) => DashboardErrorWidget(
            message: 'Support Error: $e',
            onRetry: () {},
          ),
        ),
        loading: () => const DashboardLoadingWidget(),
        error: (e, st) => DashboardErrorWidget(
          message: 'Connection Error: $e',
          onRetry: () => ref.refresh(crmFormsControllerProvider),
        ),
      ),
    );
  }

  Widget _buildContent(
    BuildContext context,
    PrimeCareThemeData theme,
    CustomerSupportDashboardViewModel vm,
  ) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(theme.spacing.lg),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    LocaleKeys.customer_support_dashboard_title.tr(),
                    style: theme.typography.h2,
                  ),
                  Text(
                    LocaleKeys.customer_support_dashboard_subtitle.tr(),
                    style: theme.typography.labelMedium,
                  ),
                ],
              ),
              const Spacer(),
              if (vm.isOfflineFallback) const OfflineStatusChip(),
            ],
          ),
          SizedBox(height: theme.spacing.xl),
          PrimeCareResponsiveKpiGrid(metrics: vm.metrics),
          SizedBox(height: theme.spacing.xl),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 2,
                child: Column(
                  children: [
                    _buildSupportHealthIndex(theme),
                    SizedBox(height: theme.spacing.xl),
                    const RegionalTicketLoadCard(),
                    SizedBox(height: theme.spacing.xl),
                    const SlaStatusCard(),
                    SizedBox(height: theme.spacing.xl),
                    _buildSupportCharts(theme, vm),
                    SizedBox(height: theme.spacing.xl),
                    Text('Live Ticket Queue', style: theme.typography.h3),
                    SizedBox(height: theme.spacing.md),
                    const LiveTicketQueueTable(),
                  ],
                ),
              ),
              if (vm.insights.isNotEmpty) ...[
                SizedBox(width: theme.spacing.xl),
                Expanded(child: _buildAuraInsightsColumn(theme, vm.insights)),
              ],
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSupportHealthIndex(PrimeCareThemeData theme) {
    return PrimeCareCard(
      padding: EdgeInsets.all(theme.spacing.xl),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Incident Resolution Velocity', style: theme.typography.h4),
          SizedBox(height: theme.spacing.lg),
          const Center(
            child: Text(
              'Global Support Surveillance Active',
              style: TextStyle(fontStyle: FontStyle.italic),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSupportCharts(
    PrimeCareThemeData theme,
    CustomerSupportDashboardViewModel vm,
  ) {
    final ticketChart = vm.metrics.charts.firstWhere(
      (c) => c.id == 'ticket-volume',
      orElse: () => AnalyticsChart.empty(),
    );

    if (ticketChart.id.isEmpty) return const SizedBox.shrink();

    return PrimeCareChartCard(
      title: LocaleKeys.dashboards_common_labels_ticket_volume_trend.tr(),
      chart: PrimeCareLineChart(chart: ticketChart),
    );
  }

  Widget _buildAuraInsightsColumn(
    PrimeCareThemeData theme,
    List<IntelligenceInsight> insights,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          LocaleKeys.dashboards_common_labels_aura_intelligence.tr(),
          style: theme.typography.h4,
        ),
        SizedBox(height: theme.spacing.lg),
        ...insights.map(
          (insight) => Padding(
            padding: EdgeInsets.only(bottom: theme.spacing.md),
            child: IntelligenceInsightCard(insight: insight),
          ),
        ),
      ],
    );
  }
}

class RegionalTicketLoadCard extends StatelessWidget {
  const RegionalTicketLoadCard({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    return PrimeCareCard(
      padding: EdgeInsets.all(theme.spacing.lg),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Regional Ticket Load', style: theme.typography.h4),
          SizedBox(height: theme.spacing.md),
          _buildQueueRow(context, 'Ontario North', 0.82, theme.colors.error),
          _buildQueueRow(context, 'BC Clinical', 0.54, theme.colors.warning),
          _buildQueueRow(
            context,
            'Alberta Support',
            0.31,
            theme.colors.success,
          ),
          _buildQueueRow(
            context,
            'Quebec Expansion',
            0.94,
            theme.colors.secondary,
          ),
        ],
      ),
    );
  }

  Widget _buildQueueRow(
    BuildContext context,
    String name,
    double load,
    Color color,
  ) {
    final theme = context.theme;
    return Padding(
      padding: EdgeInsets.symmetric(vertical: theme.spacing.xs),
      child: Column(
        children: [
          Row(
            children: [
              Text(
                name,
                style: theme.typography.bodyLarge.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
              const Spacer(),
              Text(
                '${(load * 100).toInt()}% Capacity',
                style: theme.typography.labelSmall,
              ),
            ],
          ),
          SizedBox(height: theme.spacing.xs),
          LinearProgressIndicator(
            value: load,
            backgroundColor: theme.colors.surfaceContainerHighest,
            color: color,
            minHeight: 8,
            borderRadius: BorderRadius.circular(4),
          ),
        ],
      ),
    );
  }
}

class SlaStatusCard extends StatelessWidget {
  const SlaStatusCard({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    return PrimeCareCard(
      padding: EdgeInsets.all(theme.spacing.lg),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('SLA Status (Last 24h)', style: theme.typography.h4),
          SizedBox(height: theme.spacing.md),
          _buildSlaItem(
            context,
            'First Response',
            '< 15m',
            LucideIcons.timer,
            theme.colors.success,
          ),
          const Divider(height: 24),
          _buildSlaItem(
            context,
            'Critical Resolution',
            '< 2h',
            LucideIcons.zap,
            theme.colors.warning,
          ),
          const Divider(height: 24),
          _buildSlaItem(
            context,
            'Standard Tickets',
            '< 24h',
            LucideIcons.checkCircle,
            theme.colors.success,
          ),
        ],
      ),
    );
  }

  Widget _buildSlaItem(
    BuildContext context,
    String title,
    String value,
    IconData icon,
    Color color,
  ) {
    final theme = context.theme;
    return Row(
      children: [
        PrimeCareIcon(icon, color: color, size: 20),
        SizedBox(width: theme.spacing.sm),
        Expanded(child: Text(title, style: theme.typography.bodyLarge)),
        Text(value, style: theme.typography.h4.copyWith(color: color)),
      ],
    );
  }
}

class LiveTicketQueueTable extends StatelessWidget {
  const LiveTicketQueueTable({super.key});

  @override
  Widget build(BuildContext context) {
    return PrimeCareDataTable<dynamic>(
      columns: const ['ID', 'Subject', 'User', 'Priority', 'SLA'],
      rows:
          [
                [
                  '#8421',
                  'Billing Error: Ontario North',
                  'Sarah Jenkins',
                  'Critical',
                  '12m left',
                ],
                [
                  '#8419',
                  'Login Loop in Mobile App',
                  'Robert Chen',
                  'High',
                  '45m left',
                ],
                [
                  '#8415',
                  'Franchise Portal Permissions',
                  'Mike Ross',
                  'Medium',
                  '4h left',
                ],
                [
                  '#8412',
                  'Documentation Sync Issue',
                  'Elena Gilbert',
                  'Low',
                  '1d left',
                ],
              ]
              .map(
                (row) => DataRow(
                  cells: row.map((cell) => DataCell(Text(cell))).toList(),
                ),
              )
              .toList(),
    );
  }
}

class CustomerSupportDashboardIntent extends PrimeCareScreen {
  CustomerSupportDashboardIntent()
      : super(
          name: 'customer_support_dashboard',
          title: LocaleKeys.customer_support_dashboard_title,
          route: '/corporate/support/excellence',
          requiredRole: PlatformRole.customerSupport,
          form: PrimeCareForm.customerSupportDashboard,
          provider: customerSupportDashboardAdapterProvider,
          componentLabels: const ['Aura HUD', 'Support Surveillance'],
        );

  @override
  Widget build(BuildContext context) => const CustomerSupportDashboardView();
}
