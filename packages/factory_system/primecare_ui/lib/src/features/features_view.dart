// PRIMECARE CONSOLIDATED FILE
import 'package:primecare_ui/src/features/features_model.dart';
import 'package:primecare_ui/src/features/features_controller.dart';
import 'package:primecare_ui/src/theme/primecare_theme.dart';
import 'package:primecare_ui/src/design_system/clinical_glass.dart';
import 'package:primecare_ui/src/shared/src/components/governed_widget.dart';
import 'package:primecare_ui/src/shared/src/components/primecare_app_bar.dart';
import 'package:primecare_ui/src/shared/src/components/primecare_banner.dart';
import 'package:primecare_ui/src/shared/src/components/primecare_scaffold.dart';
import 'package:primecare_ui/src/shared/primecare_adapters.dart'
    hide isOnlineProvider, ProviderTTL;

// --- Start of administrative_forms\administrative_forms_view.dart ---

class AdministrativeFormsView extends ConsumerStatefulWidget {
  const AdministrativeFormsView({super.key});

  @override
  ConsumerState<AdministrativeFormsView> createState() =>
      _AdministrativeFormsViewState();
}

class _AdministrativeFormsViewState
    extends ConsumerState<AdministrativeFormsView>
    with TickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    final state = ref.watch(administrativeFormsControllerProvider);

    return MasterLayout(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'Administrative Approval Center',
            style: theme.typography.h3,
          ),
          bottom: TabBar(
            controller: _tabController,
            tabs: const [
              Tab(text: 'Expenses'),
              Tab(text: 'Leave Requests'),
              Tab(text: 'Payroll Runs'),
            ],
            onTap: (index) {
              ref
                  .read(administrativeFormsControllerProvider.notifier)
                  .selectForm(state.availableForms[index]);
            },
          ),
        ),
        body: TabBarView(
          controller: _tabController,
          children: [
            _buildApprovalList(theme, 'Expense Reimbursements', [
              'EXP-2024-001',
              'EXP-2024-002',
            ]),
            _buildApprovalList(theme, 'Leave Request Approvals', [
              'LR-2024-045',
              'LR-2024-046',
            ]),
            _buildApprovalList(theme, 'Payroll Run Authorizations', [
              'PAY-APR-2024',
              'PAY-MAY-2024',
            ]),
          ],
        ),
      ),
    );
  }

  Widget _buildApprovalList(
    PrimeCareThemeData theme,
    String title,
    List<String> items,
  ) {
    return ListView.builder(
      padding: EdgeInsets.all(theme.spacing.lg),
      itemCount: items.length,
      itemBuilder: (context, index) {
        return PrimeCareCard(
          margin: EdgeInsets.only(bottom: theme.spacing.md),
          padding: EdgeInsets.all(theme.spacing.md),
          child: Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(items[index], style: theme.typography.h4),
                  Text('Pending Review', style: theme.typography.labelSmall),
                ],
              ),
              const Spacer(),
              PrimeCareButton.secondary(
                onPressed: () {},
                label: 'View Details',
              ),
              SizedBox(width: theme.spacing.sm),
              PrimeCareButton(
                onPressed: () => ref
                    .read(administrativeFormsControllerProvider.notifier)
                    .approveForm(items[index]),
                label: 'Approve',
              ),
            ],
          ),
        );
      },
    );
  }
}

class AdministrativeFormsIntent extends PrimeCareScreen {
  AdministrativeFormsIntent() : super(title: 'AdministrativeForms');

  @override
  Widget build(BuildContext context) => const AdministrativeFormsView();
}

// --- End of administrative_forms\administrative_forms_view.dart ---

// --- Start of architectural_planning\architectural_planning_view.dart ---

class ArchitecturalPlanningView extends ConsumerWidget {
  const ArchitecturalPlanningView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncData = ref.watch(architecturalPlanningAdapterProvider);

    return PageTemplate(
      title: 'Architectural Planning Dashboard',
      subtitle: 'Infrastructure & Architectural Roadmap',
      actions: [
        IconButton(
          icon: const Icon(Icons.refresh),
          onPressed: () => ref.refresh(architecturalPlanningAdapterProvider),
        ),
      ],
      body: asyncData.when(
        data: (result) => result.fold(
          (data) => SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const AuraDashboardHud(),
                const SizedBox(height: 24),
                PrimeCareResponsiveKpiGrid(
                  children: data.metrics.kpis
                      .map(
                        (kpi) => PrimeCareKpiCard(
                          title: kpi.title,
                          value: kpi.value,
                          subtitle: kpi.subtitle ?? '',
                          icon: _getIconForMetric(kpi.title),
                          onPinToggle: () {},
                        ),
                      )
                      .toList(),
                ),
              ],
            ),
          ),
          (error) => Center(child: Text(error.toString())),
        ),
        loading: () => const PrimeCareSkeleton(),
        error: (e, s) => Center(child: Text(e.toString())),
      ),
    );
  }

  IconData _getIconForMetric(String title) {
    final t = title.toLowerCase();
    if (t.contains('roadmap')) return Icons.map_outlined;
    if (t.contains('blueprint')) return Icons.architecture_outlined;
    if (t.contains('capacity')) return Icons.storage_outlined;
    return Icons.account_tree_outlined;
  }
}

class ArchitecturalPlanningIntent extends PrimeCareScreen {
  ArchitecturalPlanningIntent() : super(title: 'ArchitecturalPlanning');

  @override
  Widget build(BuildContext context) => const ArchitecturalPlanningView();
}

// --- End of architectural_planning\architectural_planning_view.dart ---

// --- Start of billing_admin_dashboard\billing_admin_dashboard_view.dart ---

class BillingAdminDashboardView extends ConsumerWidget {
  const BillingAdminDashboardView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = context.theme;
    final state = ref.watch(billingAdminDashboardAdapterProvider);
    final controller = BillingAdminDashboardController(ref);

    return MasterLayout(
      child: state.when(
        data: (result) => result.fold(
          (viewModel) => _buildContent(
            context,
            theme,
            viewModel as BillingAdminDashboardViewModel,
            controller,
          ),
          (e) => DashboardErrorWidget(
            message: 'Billing Error: $e',
            onRetry: () => ref.refresh(administrativeFormsControllerProvider),
          ),
        ),
        loading: () => const DashboardLoadingWidget(),
        error: (e, st) => DashboardErrorWidget(
          message: 'Connection Error: $e',
          onRetry: () => ref.refresh(administrativeFormsControllerProvider),
        ),
      ),
    );
  }

  Widget _buildContent(
    BuildContext context,
    PrimeCareThemeData theme,
    BillingAdminDashboardViewModel vm,
    BillingAdminDashboardController controller,
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
                  Text('Billing Command Center', style: theme.typography.h2),
                  Text(
                    'Revenue aging, collection rates, and invoice velocity telemetry',
                    style: theme.typography.labelMedium,
                  ),
                ],
              ),
              const Spacer(),
              if (vm.isOfflineFallback) const OfflineStatusChip(),
              IconButton(
                icon: const Icon(Icons.refresh),
                onPressed: controller.refresh,
              ),
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
                    _buildRevenueMatrix(theme),
                    SizedBox(height: theme.spacing.xl),
                    _buildFinancialCharts(theme, vm),
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

  Widget _buildRevenueMatrix(PrimeCareThemeData theme) {
    return PrimeCareCard(
      padding: EdgeInsets.all(theme.spacing.xl),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Revenue Aging Matrix', style: theme.typography.h4),
          SizedBox(height: theme.spacing.lg),
          const Center(
            child: Text(
              'Global Financial Surveillance Active',
              style: TextStyle(fontStyle: FontStyle.italic),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFinancialCharts(
    PrimeCareThemeData theme,
    BillingAdminDashboardViewModel vm,
  ) {
    return Column(
      children: [
        PrimeCareChartCard(
          title: LocaleKeys.dashboards_common_labels_invoice_velocity_trend
              .tr(),
          chart: PrimeCareLineChart(
            chart: vm.metrics.charts.firstWhere(
              (c) => c.id == 'invoice-velocity',
              orElse: () => AnalyticsChart.empty(),
            ),
          ),
        ),
      ],
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

class BillingAdminDashboardIntent extends PrimeCareScreen {
  BillingAdminDashboardIntent() : super(title: 'BillingAdminDashboard');

  @override
  Widget build(BuildContext context) => const BillingAdminDashboardView();
}

// --- End of billing_admin_dashboard\billing_admin_dashboard_view.dart ---

// --- Start of ceo_dashboard\ceo_dashboard_view.dart ---

class CeoDashboardView extends ConsumerWidget {
  const CeoDashboardView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = context.theme;
    final state = ref.watch(ceoDashboardAdapterProvider);
    final controller = CeoDashboardController(ref);

    return MasterLayout(
      child: state.when(
        data: (result) => result.fold(
          (viewModel) => _buildContent(
            context,
            theme,
            viewModel as CeoDashboardModel,
            controller,
          ),
          (e) => DashboardErrorWidget(
            message: 'CEO Dashboard Error: $e',
            onRetry: () => ref.refresh(ceoDashboardAdapterProvider),
          ),
        ),
        loading: () => const DashboardLoadingWidget(),
        error: (e, st) => DashboardErrorWidget(
          message: 'Connection Error: $e',
          onRetry: () => ref.refresh(ceoDashboardAdapterProvider),
        ),
      ),
    );
  }

  Widget _buildContent(
    BuildContext context,
    PrimeCareThemeData theme,
    CeoDashboardModel vm,
    CeoDashboardController controller,
  ) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(theme.spacing.lg),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Executive Summary', style: theme.typography.h2),
              IconButton(
                icon: const Icon(Icons.refresh),
                onPressed: controller.refresh,
              ),
            ],
          ),
          SizedBox(height: theme.spacing.xl),
          PrimeCareResponsiveKpiGrid(metrics: vm.metrics),
          SizedBox(height: theme.spacing.xl),
          if (vm.insights.isNotEmpty) ...[
            Text('Intelligence Insights', style: theme.typography.h4),
            SizedBox(height: theme.spacing.md),
            // TODO: Add insight widgets
          ],
        ],
      ),
    );
  }
}

/// The high-fidelity intent for the CEO Dashboard.
/// Bypasses the universal screen engine to use the MVC view directly.
class CeoDashboardIntent extends PrimeCareScreen {
  CeoDashboardIntent()
    : super(
        name: 'ceo',
        title: 'CEO Command Center',
        route: '/offices/corporate/roles/ceo/dashboard',
        requiredRole: PlatformRole.ceo,
        blueprints: const [],
        componentLabels: ['MVC View'],
      );

  @override
  Widget build(BuildContext context) => const CeoDashboardView();
}

// --- End of ceo_dashboard\ceo_dashboard_view.dart ---

// --- Start of cfo_dashboard\cfo_dashboard_view.dart ---

class CfoDashboardView extends ConsumerWidget {
  const CfoDashboardView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncData = ref.watch(cfoDashboardAdapterProvider);

    return PageTemplate(
      title: LocaleKeys.dashboards_common_labels_cfo_dashboard.tr(),
      subtitle: LocaleKeys
          .dashboards_common_labels_financial_statements_and_forecasts_overview
          .tr(),
      actions: [
        IconButton(
          icon: const Icon(Icons.refresh),
          onPressed: () => ref.refresh(cfoDashboardAdapterProvider),
        ),
      ],
      body: asyncData.when(
        data: (result) => result.fold(
          (data) => SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                PrimeCareResponsiveKpiGrid(
                  children: data.kpis
                      .map(
                        (kpi) => PrimeCareKpiCard(
                          title: kpi.title,
                          value: kpi.value,
                          subtitle: kpi.subtitle ?? '',
                          icon: _getIconForMetric(kpi.title),
                          onPinToggle: () {},
                        ),
                      )
                      .toList(),
                ),
                const SizedBox(height: 24),
                // Additional sections like Revenue Trend charts would go here
              ],
            ),
          ),
          (error) => Center(child: Text(error.toString())),
        ),
        loading: () => const PrimeCareSkeleton(),
        error: (e, s) => Center(child: Text(e.toString())),
      ),
    );
  }

  IconData _getIconForMetric(String title) {
    final t = title.toLowerCase();
    if (t.contains('revenue') || t.contains('profit'))
      return Icons.payments_outlined;
    if (t.contains('expense') || t.contains('cost'))
      return Icons.account_balance_wallet_outlined;
    if (t.contains('claim')) return Icons.request_quote_outlined;
    return Icons.analytics_outlined;
  }
}

class CfoDashboardIntent extends PrimeCareScreen {
  CfoDashboardIntent() : super(title: 'CfoDashboard');

  @override
  Widget build(BuildContext context) => const CfoDashboardView();
}

// --- End of cfo_dashboard\cfo_dashboard_view.dart ---

// --- Start of chiropractor\chiropractor_view.dart ---

class ChiropractorView extends ConsumerWidget {
  const ChiropractorView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = context.theme;
    final state = ref.watch(chiropractorControllerProvider);

    return MasterLayout(
      child: Scaffold(
        appBar: AppBar(title: Text(state.title, style: theme.typography.h3)),
        body: Padding(
          padding: EdgeInsets.all(theme.spacing.xl),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Today\'s Schedule', style: theme.typography.h4),
              SizedBox(height: theme.spacing.md),
              Expanded(
                child: ListView.builder(
                  itemCount: state.appointments.length,
                  itemBuilder: (context, index) {
                    return PrimeCareCard(
                      margin: EdgeInsets.only(bottom: theme.spacing.md),
                      child: ListTile(
                        leading: const Icon(Icons.event),
                        title: Text(state.appointments[index]),
                        trailing: PrimeCareButton.secondary(
                          onPressed: () {},
                          label: 'View File',
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ChiropractorIntent extends PrimeCareScreen {
  ChiropractorIntent() : super(title: 'Chiropractor');

  @override
  Widget build(BuildContext context) => const ChiropractorView();
}

// --- End of chiropractor\chiropractor_view.dart ---

// --- Start of client\client_view.dart ---

class ClientView extends ConsumerWidget {
  const ClientView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(clientAdapterProvider);

    return MasterLayout(
      child: state.when(
        data: (result) => result.fold(
          (viewModel) => _buildContent(context, viewModel),
          (e) => DashboardErrorWidget(
            message: 'Client Sync Error: $e',
            onRetry: () => ref.refresh(cfoDashboardAdapterProvider),
          ),
        ),
        loading: () => const DashboardLoadingWidget(),
        error: (e, st) => DashboardErrorWidget(
          message: 'Connection Error: $e',
          onRetry: () => ref.refresh(cfoDashboardAdapterProvider),
        ),
      ),
    );
  }

  Widget _buildContent(BuildContext context, ClientViewModel vm) {
    final theme = context.theme;
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
                  Text('Client Care Hub', style: theme.typography.h2),
                  Text(
                    'Personalized telemetry and health insights',
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
          PrimeCareCard(
            padding: EdgeInsets.all(theme.spacing.xl),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Upcoming Appointments', style: theme.typography.h4),
                SizedBox(height: theme.spacing.lg),
                const Center(child: Text('No appointments scheduled.')),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class ClientIntent extends PrimeCareScreen {
  ClientIntent() : super(title: 'Client');

  @override
  Widget build(BuildContext context) => const ClientView();
}

// --- End of client\client_view.dart ---

// --- Start of client_dashboard\client_dashboard_view.dart ---

class ClientDashboardView extends ConsumerWidget {
  const ClientDashboardView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = context.theme;
    final state = ref.watch(clientDashboardAdapterProvider);
    final controller = ClientDashboardController(ref);

    return MasterLayout(
      child: state.when(
        data: (result) => result.fold(
          (viewModel) => _buildContent(
            context,
            theme,
            viewModel as ClientViewModel,
            controller,
          ),
          (e) => DashboardErrorWidget(
            message: 'Client Error: $e',
            onRetry: () => ref.refresh(clientDashboardAdapterProvider),
          ),
        ),
        loading: () => const DashboardLoadingWidget(),
        error: (e, st) => DashboardErrorWidget(
          message: 'Connection Error: $e',
          onRetry: () => ref.refresh(clientDashboardAdapterProvider),
        ),
      ),
    );
  }

  Widget _buildContent(
    BuildContext context,
    PrimeCareThemeData theme,
    ClientViewModel vm,
    ClientDashboardController controller,
  ) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(theme.spacing.lg),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Client Command Center', style: theme.typography.h2),
              IconButton(
                icon: const Icon(Icons.refresh),
                onPressed: controller.refresh,
              ),
            ],
          ),
          SizedBox(height: theme.spacing.xl),
          PrimeCareResponsiveKpiGrid(metrics: vm.metrics),
          SizedBox(height: theme.spacing.xl),
          PrimeCareCard(
            padding: EdgeInsets.all(theme.spacing.xl),
            child: Center(
              child: Text(
                LocaleKeys.dashboards_common_labels_operational_insights.tr(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ClientDashboardIntent extends PrimeCareScreen {
  ClientDashboardIntent() : super(title: 'ClientDashboard');

  @override
  Widget build(BuildContext context) => const ClientDashboardView();
}

// --- End of client_dashboard\client_dashboard_view.dart ---

// --- Start of clinical_director\clinical_director_view.dart ---

class ClinicalDirectorView extends ConsumerWidget {
  const ClinicalDirectorView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(clinicalDirectorAdapterProvider);

    return MasterLayout(
      child: state.when(
        data: (result) => result.fold(
          (viewModel) => _buildContent(context, viewModel),
          (e) => DashboardErrorWidget(
            message: 'Clinical Governance Error: $e',
            onRetry: () => ref.refresh(clinicalDirectorAdapterProvider),
          ),
        ),
        loading: () => const DashboardLoadingWidget(),
        error: (e, st) => DashboardErrorWidget(
          message: 'Connection Error: $e',
          onRetry: () => ref.refresh(clinicalDirectorAdapterProvider),
        ),
      ),
    );
  }

  Widget _buildContent(BuildContext context, ClinicalDirectorViewModel vm) {
    final theme = context.theme;
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
                  Text('Clinical Director Hub', style: theme.typography.h2),
                  Text(
                    'Facility medical governance and protocol surveillance',
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
          _buildGovernanceAlerts(theme),
        ],
      ),
    );
  }

  Widget _buildGovernanceAlerts(PrimeCareThemeData theme) {
    return PrimeCareCard(
      padding: EdgeInsets.all(theme.spacing.xl),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Clinical Compliance Alerts', style: theme.typography.h4),
          SizedBox(height: theme.spacing.lg),
          const ListTile(
            leading: Icon(Icons.warning_amber_rounded, color: Colors.orange),
            title: Text('Protocol Drift Detected in Sector 4'),
            subtitle: Text('Review medication administration deviation logs.'),
          ),
        ],
      ),
    );
  }
}

class ClinicalDirectorIntent extends PrimeCareScreen {
  ClinicalDirectorIntent() : super(title: 'ClinicalDirector');

  @override
  Widget build(BuildContext context) => const ClinicalDirectorView();
}

// --- End of clinical_director\clinical_director_view.dart ---

// --- Start of clinical_director_dashboard\clinical_director_dashboard_view.dart ---

class ClinicalDirectorDashboardView extends ConsumerWidget {
  const ClinicalDirectorDashboardView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = context.theme;
    final state = ref.watch(clinicalDirectorDashboardAdapterProvider);
    final controller = ClinicalDirectorDashboardController(ref);

    return MasterLayout(
      child: state.when(
        data: (result) => result.fold(
          (viewModel) => _buildContent(
            context,
            theme,
            viewModel as ClinicalDirectorViewModel,
            controller,
          ),
          (e) => DashboardErrorWidget(
            message: 'Clinical Error: $e',
            onRetry: () =>
                ref.refresh(clinicalDirectorDashboardAdapterProvider),
          ),
        ),
        loading: () => const DashboardLoadingWidget(),
        error: (e, st) => DashboardErrorWidget(
          message: 'Connection Error: $e',
          onRetry: () => ref.refresh(clinicalDirectorDashboardAdapterProvider),
        ),
      ),
    );
  }

  Widget _buildContent(
    BuildContext context,
    PrimeCareThemeData theme,
    ClinicalDirectorViewModel vm,
    ClinicalDirectorDashboardController controller,
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
                    'Clinical Director Command Center',
                    style: theme.typography.h2,
                  ),
                  Text(
                    'Clinical outcomes, patient safety, and quality assurance telemetry',
                    style: theme.typography.labelMedium,
                  ),
                ],
              ),
              const Spacer(),
              if (vm.isOfflineFallback) const OfflineStatusChip(),
              IconButton(
                icon: const Icon(Icons.refresh),
                onPressed: controller.refresh,
              ),
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
                    _buildClinicalPerformance(theme),
                    SizedBox(height: theme.spacing.xl),
                    _buildIncidentTrends(theme, vm),
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

  Widget _buildClinicalPerformance(PrimeCareThemeData theme) {
    return PrimeCareCard(
      padding: EdgeInsets.all(theme.spacing.xl),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Clinical Quality Performance', style: theme.typography.h4),
          SizedBox(height: theme.spacing.lg),
          const Center(
            child: Text(
              'Patient Outcomes Surveillance Active',
              style: TextStyle(fontStyle: FontStyle.italic),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildIncidentTrends(
    PrimeCareThemeData theme,
    ClinicalDirectorViewModel vm,
  ) {
    return PrimeCareChartCard(
      title: LocaleKeys.dashboards_common_labels_safety_incident_velocity.tr(),
      chart: PrimeCareLineChart(
        chart: vm.metrics.charts.firstWhere(
          (c) => c.id == 'incident-trends',
          orElse: () => AnalyticsChart.empty(),
        ),
      ),
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

class ClinicalDirectorDashboardIntent extends PrimeCareScreen {
  ClinicalDirectorDashboardIntent() : super(title: 'ClinicalDirectorDashboard');

  @override
  Widget build(BuildContext context) => const ClinicalDirectorDashboardView();
}

// --- End of clinical_director_dashboard\clinical_director_dashboard_view.dart ---

// --- Start of clinical_forms\clinical_forms_view.dart ---

class ClinicalFormsView extends ConsumerStatefulWidget {
  const ClinicalFormsView({super.key});

  @override
  ConsumerState<ClinicalFormsView> createState() => _ClinicalFormsViewState();
}

class _ClinicalFormsViewState extends ConsumerState<ClinicalFormsView>
    with TickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 8, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    final state = ref.watch(clinicalFormsControllerProvider);

    return MasterLayout(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'Clinical Documentation Terminal',
            style: theme.typography.h3,
          ),
          bottom: TabBar(
            controller: _tabController,
            isScrollable: true,
            tabs: const [
              Tab(text: 'Medication'),
              Tab(text: 'Vitals'),
              Tab(text: 'Incident'),
              Tab(text: 'Infection'),
              Tab(text: 'Care Plan'),
              Tab(text: 'Audit'),
              Tab(text: 'ADL'),
              Tab(text: 'Census'),
            ],
            onTap: (index) {
              ref
                  .read(clinicalFormsControllerProvider.notifier)
                  .selectForm(state.availableForms[index]);
            },
          ),
        ),
        body: TabBarView(
          controller: _tabController,
          children: [
            _buildFormContainer(
              theme,
              'Medication Refill Authorization',
              _buildMedicationForm(theme),
            ),
            _buildFormContainer(
              theme,
              'Daily Vitals Entry',
              _buildVitalsForm(theme),
            ),
            _buildFormContainer(
              theme,
              'Clinical Incident Reporting',
              _buildIncidentForm(theme),
            ),
            _buildFormContainer(
              theme,
              'Infection Control Surveillance',
              _buildInfectionForm(theme),
            ),
            _buildFormContainer(
              theme,
              'Care Plan Re-evaluation',
              _buildCarePlanForm(theme),
            ),
            _buildFormContainer(
              theme,
              'Clinical Audit Schedule',
              _buildAuditForm(theme),
            ),
            _buildFormContainer(
              theme,
              'ADL Performance Checklist',
              _buildAdlForm(theme),
            ),
            _buildFormContainer(
              theme,
              'Daily Census Enumeration',
              _buildCensusForm(theme),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFormContainer(
    PrimeCareThemeData theme,
    String title,
    Widget form,
  ) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(theme.spacing.xl),
      child: Center(
        child: Container(
          constraints: const BoxConstraints(maxWidth: 800),
          child: PrimeCareCard(
            padding: EdgeInsets.all(theme.spacing.xl),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: theme.typography.h4),
                SizedBox(height: theme.spacing.lg),
                form,
                SizedBox(height: theme.spacing.xl),
                SizedBox(
                  width: double.infinity,
                  child: PrimeCareButton(
                    onPressed: () {},
                    label: 'Submit for Clinical Review',
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildMedicationForm(PrimeCareThemeData theme) {
    return Column(
      children: [
        PrimeCareTextField(
          label: 'Medication Name',
          placeholder: 'Enter med name',
        ),
        SizedBox(height: theme.spacing.md),
        PrimeCareTextField(
          label: 'Dosage Protocol',
          placeholder: 'e.g., 5mg daily',
        ),
      ],
    );
  }

  Widget _buildVitalsForm(PrimeCareThemeData theme) {
    return Column(
      children: [
        PrimeCareTextField(label: 'Blood Pressure', placeholder: '120/80'),
        SizedBox(height: theme.spacing.md),
        PrimeCareTextField(label: 'Heart Rate', placeholder: 'bpm'),
      ],
    );
  }

  Widget _buildIncidentForm(PrimeCareThemeData theme) {
    return Column(
      children: [
        PrimeCareTextField(label: 'Incident Type', placeholder: 'Select type'),
        SizedBox(height: theme.spacing.md),
        PrimeCareTextField(
          label: 'Detailed Narrative',
          placeholder: 'Enter details',
        ),
      ],
    );
  }

  Widget _buildInfectionForm(PrimeCareThemeData theme) {
    return Column(
      children: [
        PrimeCareTextField(
          label: 'Pathogen identified',
          placeholder: 'Enter pathogen',
        ),
        SizedBox(height: theme.spacing.md),
        PrimeCareTextField(label: 'Quarantine Status', placeholder: 'Status'),
      ],
    );
  }

  Widget _buildCarePlanForm(PrimeCareThemeData theme) {
    return Column(
      children: [
        PrimeCareTextField(label: 'Patient ID', placeholder: 'P-XXXXX'),
        SizedBox(height: theme.spacing.md),
        PrimeCareTextField(
          label: 'Update Summary',
          placeholder: 'Enter summary',
        ),
      ],
    );
  }

  Widget _buildAuditForm(PrimeCareThemeData theme) {
    return Column(
      children: [
        PrimeCareTextField(label: 'Audit Area', placeholder: 'e.g., Sector A'),
        SizedBox(height: theme.spacing.md),
        PrimeCareTextField(label: 'Auditor Initials', placeholder: 'XXX'),
      ],
    );
  }

  Widget _buildAdlForm(PrimeCareThemeData theme) {
    return Column(
      children: [
        PrimeCareTextField(
          label: 'Mobility Status',
          placeholder: 'Select status',
        ),
        SizedBox(height: theme.spacing.md),
        PrimeCareTextField(
          label: 'Feeding Assistance',
          placeholder: 'Enter details',
        ),
      ],
    );
  }

  Widget _buildCensusForm(PrimeCareThemeData theme) {
    return Column(
      children: [
        PrimeCareTextField(label: 'Floor Count', placeholder: 'Enter number'),
        SizedBox(height: theme.spacing.md),
        PrimeCareTextField(
          label: 'Discharge Count',
          placeholder: 'Enter number',
        ),
      ],
    );
  }
}

class ClinicalFormsIntent extends PrimeCareScreen {
  ClinicalFormsIntent() : super(title: 'ClinicalForms');

  @override
  Widget build(BuildContext context) => const ClinicalFormsView();
}

// --- End of clinical_forms\clinical_forms_view.dart ---

// --- Start of clinic_dashboard\clinic_dashboard_view.dart ---

class ClinicDashboardView extends ConsumerWidget {
  const ClinicDashboardView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = context.theme;
    final state = ref.watch(clinicDashboardAdapterProvider);
    final controller = ClinicDashboardController(ref);

    return MasterLayout(
      child: state.when(
        data: (result) => result.fold(
          (viewModel) => _buildContent(context, theme, viewModel, controller),
          (e) => DashboardErrorWidget(
            message: 'Clinic Error: $e',
            onRetry: () => ref.refresh(clinicalFormsControllerProvider),
          ),
        ),
        loading: () => const DashboardLoadingWidget(),
        error: (e, st) => DashboardErrorWidget(
          message: 'Connection Error: $e',
          onRetry: () => ref.refresh(clinicalFormsControllerProvider),
        ),
      ),
    );
  }

  Widget _buildContent(
    BuildContext context,
    PrimeCareThemeData theme,
    ClinicDashboardModel vm,
    ClinicDashboardController controller,
  ) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(theme.spacing.lg),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Clinic Command Center', style: theme.typography.h2),
                  Text(
                    'Clinical outcomes and patient care overview',
                    style: theme.typography.bodyLarge,
                  ),
                ],
              ),
              Row(
                children: [
                  PrimeCareButton(
                    onPressed: () => _showIntake(context),
                    text: 'New Intake',
                    icon: Icons.person_add_rounded,
                  ),
                  const SizedBox(width: 8),
                  PrimeCareButton(
                    onPressed: () => _showVitalsCapture(context),
                    text: 'Capture Vitals',
                    icon: Icons.favorite_rounded,
                    isPrimary: true,
                  ),
                  const SizedBox(width: 8),
                  IconButton(
                    icon: const Icon(Icons.refresh),
                    onPressed: controller.refresh,
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: theme.spacing.xl),
          PrimeCareResponsiveKpiGrid(metrics: vm.metrics),
          SizedBox(height: theme.spacing.xl),
          PrimeCareCard(
            padding: EdgeInsets.all(theme.spacing.xl),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Operational Insights', style: theme.typography.h4),
                SizedBox(height: theme.spacing.md),
                const Divider(),
                if (vm.recentActivity.isEmpty)
                  const Center(child: Text('No recent activity'))
                else
                  ...vm.recentActivity.map(
                    (activity) => ListTile(
                      leading: Icon(
                        _getIconData(activity.icon),
                        color: _getColor(activity.color, theme),
                      ),
                      title: Text(activity.title),
                      subtitle: Text(activity.subtitle),
                      trailing: Text(activity.timestamp),
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _showIntake(BuildContext context) {
    showDialog<void>(
      context: context,
      builder: (context) => Dialog(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 800, maxHeight: 900),
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: PatientIntakeForm(
              onSuccess: () => Navigator.of(context).pop(),
            ),
          ),
        ),
      ),
    );
  }

  void _showVitalsCapture(BuildContext context) {
    showDialog<void>(
      context: context,
      builder: (context) => Dialog(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 600),
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: VitalsCaptureForm(
              onSuccess: () => Navigator.of(context).pop(),
            ),
          ),
        ),
      ),
    );
  }

  IconData _getIconData(String? icon) {
    switch (icon) {
      case 'check_circle':
        return Icons.check_circle;
      case 'verified':
        return Icons.verified;
      case 'warning':
        return Icons.warning;
      default:
        return Icons.info;
    }
  }

  Color _getColor(String? color, PrimeCareThemeData theme) {
    switch (color) {
      case 'green':
        return Colors.green;
      case 'blue':
        return Colors.blue;
      case 'orange':
        return Colors.orange;
      case 'red':
        return Colors.red;
      default:
        return theme.colors.textSecondary;
    }
  }
}

class ClinicDashboardIntent extends PrimeCareScreen {
  ClinicDashboardIntent() : super(title: 'ClinicDashboard');

  @override
  Widget build(BuildContext context) => const ClinicDashboardView();
}

// --- End of clinic_dashboard\clinic_dashboard_view.dart ---

// --- Start of common_forms\common_forms_view.dart ---

class CommonFormsView extends ConsumerWidget {
  const CommonFormsView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = context.theme;
    final state = ref.watch(commonFormsControllerProvider);

    return MasterLayout(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Common Utilities Center', style: theme.typography.h3),
        ),
        body: Row(
          children: [
            SizedBox(
              width: 250,
              child: ListView.builder(
                itemCount: state.availableForms.length,
                itemBuilder: (context, index) {
                  final form = state.availableForms[index];
                  return ListTile(
                    selected: state.selectedForm == form,
                    title: Text(form),
                    onTap: () => ref
                        .read(commonFormsControllerProvider.notifier)
                        .selectForm(form),
                  );
                },
              ),
            ),
            const VerticalDivider(width: 1),
            Expanded(child: _buildFormContent(theme, state.selectedForm)),
          ],
        ),
      ),
    );
  }

  Widget _buildFormContent(PrimeCareThemeData theme, String formTitle) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(theme.spacing.xl),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(formTitle, style: theme.typography.h2),
          SizedBox(height: theme.spacing.lg),
          PrimeCareCard(
            padding: EdgeInsets.all(theme.spacing.xl),
            child: Column(
              children: [
                PrimeCareTextField(
                  label: 'Reference Number',
                  placeholder: 'REF-XXXX',
                ),
                SizedBox(height: theme.spacing.md),
                PrimeCareTextField(
                  label: 'Description',
                  placeholder: 'Enter details',
                ),
                SizedBox(height: theme.spacing.xl),
                PrimeCareButton(onPressed: () {}, label: 'Submit Form'),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class CommonFormsIntent extends PrimeCareScreen {
  CommonFormsIntent() : super(title: 'CommonForms');

  @override
  Widget build(BuildContext context) => const CommonFormsView();
}

// --- End of common_forms\common_forms_view.dart ---

// --- Start of community_outreach_dashboard\community_outreach_dashboard_view.dart ---

class CommunityOutreachDashboardView extends ConsumerWidget {
  const CommunityOutreachDashboardView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = context.theme;
    final state = ref.watch(communityOutreachDashboardAdapterProvider);
    final controller = CommunityOutreachDashboardController(ref);

    return MasterLayout(
      child: state.when(
        data: (result) => result.fold(
          (viewModel) => _buildContent(context, theme, viewModel, controller),
          (e) => DashboardErrorWidget(
            message: 'Outreach Error: $e',
            onRetry: () => ref.refresh(commonFormsControllerProvider),
          ),
        ),
        loading: () => const DashboardLoadingWidget(),
        error: (e, st) => DashboardErrorWidget(
          message: 'Connection Error: $e',
          onRetry: () => ref.refresh(commonFormsControllerProvider),
        ),
      ),
    );
  }

  Widget _buildContent(
    BuildContext context,
    PrimeCareThemeData theme,
    CommunityOutreachDashboardViewModel vm,
    CommunityOutreachDashboardController controller,
  ) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(theme.spacing.lg),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Community Outreach Command Center',
                style: theme.typography.h2,
              ),
              IconButton(
                icon: const Icon(Icons.refresh),
                onPressed: controller.refresh,
              ),
            ],
          ),
          SizedBox(height: theme.spacing.xl),
          PrimeCareResponsiveKpiGrid(metrics: vm.metrics),
          SizedBox(height: theme.spacing.xl),
          PrimeCareCard(
            padding: EdgeInsets.all(theme.spacing.xl),
            child: Center(
              child: Text(
                LocaleKeys.dashboards_common_labels_operational_insights.tr(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class CommunityOutreachDashboardIntent extends PrimeCareScreen {
  CommunityOutreachDashboardIntent()
    : super(title: 'CommunityOutreachDashboard');

  @override
  Widget build(BuildContext context) => const CommunityOutreachDashboardView();
}

// --- End of community_outreach_dashboard\community_outreach_dashboard_view.dart ---

// --- Start of compliance_hub\compliance_hub_view.dart ---

class ComplianceHubView extends ConsumerWidget {
  const ComplianceHubView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncData = ref.watch(complianceHubAdapterProvider);

    return PageTemplate(
      title: LocaleKeys.dashboards_common_labels_compliance_hub.tr(),
      subtitle: LocaleKeys
          .dashboards_common_labels_regulatory_and_standard_compliance_status
          .tr(),
      actions: [
        IconButton(
          icon: const Icon(Icons.refresh),
          onPressed: () => ref.refresh(complianceHubAdapterProvider),
        ),
      ],
      body: asyncData.when(
        data: (result) => result.fold(
          (data) => SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const AuraDashboardHud(),
                const SizedBox(height: 24),
                PrimeCareResponsiveKpiGrid(
                  children: data.metrics.kpis
                      .map(
                        (kpi) => PrimeCareKpiCard(
                          title: kpi.title,
                          value: kpi.value,
                          subtitle: kpi.subtitle ?? '',
                          icon: _getIconForMetric(kpi.title),
                          onPinToggle: () {},
                        ),
                      )
                      .toList(),
                ),
              ],
            ),
          ),
          (error) => Center(child: Text(error.toString())),
        ),
        loading: () => const PrimeCareSkeleton(),
        error: (e, s) => Center(child: Text(e.toString())),
      ),
    );
  }

  IconData _getIconForMetric(String title) {
    final t = title.toLowerCase();
    if (t.contains('drift')) return Icons.warning_amber_outlined;
    if (t.contains('score')) return Icons.speed_outlined;
    if (t.contains('audit')) return Icons.fact_check_outlined;
    return Icons.security_outlined;
  }
}

class ComplianceHubIntent extends PrimeCareScreen {
  ComplianceHubIntent() : super(title: 'ComplianceHub');

  @override
  Widget build(BuildContext context) => const ComplianceHubView();
}

// --- End of compliance_hub\compliance_hub_view.dart ---

// --- Start of compliance_manager\compliance_manager_view.dart ---

class ComplianceManagerView extends ConsumerWidget {
  const ComplianceManagerView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = context.theme;
    final state = ref.watch(complianceManagerControllerProvider);

    return MasterLayout(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'Compliance & Risk Oversight',
            style: theme.typography.h3,
          ),
        ),
        body: Padding(
          padding: EdgeInsets.all(theme.spacing.xl),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              PrimeCareCard(
                child: ListTile(
                  title: Text(
                    'Global Compliance Score',
                    style: theme.typography.h4,
                  ),
                  trailing: Text(
                    '${(state.complianceScore * 100).toInt()}%',
                    style: theme.typography.h2.copyWith(color: Colors.green),
                  ),
                ),
              ),
              SizedBox(height: theme.spacing.xl),
              Text('Pending Audits', style: theme.typography.h4),
              SizedBox(height: theme.spacing.md),
              Expanded(
                child: ListView.builder(
                  itemCount: state.pendingAudits.length,
                  itemBuilder: (context, index) {
                    return PrimeCareCard(
                      margin: EdgeInsets.only(bottom: theme.spacing.md),
                      child: ListTile(
                        leading: const Icon(Icons.assignment_turned_in),
                        title: Text(state.pendingAudits[index]),
                        trailing: PrimeCareButton(
                          onPressed: () {},
                          label: 'Start Audit',
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ComplianceManagerIntent extends PrimeCareScreen {
  ComplianceManagerIntent() : super(title: 'ComplianceManager');

  @override
  Widget build(BuildContext context) => const ComplianceManagerView();
}

// --- End of compliance_manager\compliance_manager_view.dart ---

// --- Start of coo_dashboard\coo_dashboard_view.dart ---

class CooDashboardView extends ConsumerWidget {
  const CooDashboardView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncData = ref.watch(cooDashboardAdapterProvider);

    return PageTemplate(
      title: LocaleKeys.dashboards_common_labels_coo_dashboard.tr(),
      subtitle: LocaleKeys
          .dashboards_common_labels_logistics_and_operational_execution_overview
          .tr(),
      actions: [
        IconButton(
          icon: const Icon(Icons.refresh),
          onPressed: () => ref.refresh(cooDashboardAdapterProvider),
        ),
      ],
      body: asyncData.when(
        data: (result) => result.fold(
          (data) => SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                PrimeCareResponsiveKpiGrid(
                  children: data.kpis
                      .map(
                        (kpi) => PrimeCareKpiCard(
                          title: kpi.title,
                          value: kpi.value,
                          subtitle: kpi.subtitle ?? '',
                          icon: _getIconForMetric(kpi.title),
                          onPinToggle: () {},
                        ),
                      )
                      .toList(),
                ),
              ],
            ),
          ),
          (error) => Center(child: Text(error.toString())),
        ),
        loading: () => const PrimeCareSkeleton(),
        error: (e, s) => Center(child: Text(e.toString())),
      ),
    );
  }

  IconData _getIconForMetric(String title) {
    final t = title.toLowerCase();
    if (t.contains('logistics') || t.contains('fleet'))
      return Icons.local_shipping_outlined;
    if (t.contains('warehouse')) return Icons.inventory_2_outlined;
    if (t.contains('time')) return Icons.timer_outlined;
    return Icons.settings_applications_outlined;
  }
}

class CooDashboardIntent extends PrimeCareScreen {
  CooDashboardIntent() : super(title: 'CooDashboard');

  @override
  Widget build(BuildContext context) => const CooDashboardView();
}

// --- End of coo_dashboard\coo_dashboard_view.dart ---

// --- Start of corporate_governance_dashboard\corporate_governance_dashboard_view.dart ---

class CorporateGovernanceDashboardView extends ConsumerWidget {
  const CorporateGovernanceDashboardView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = context.theme;
    final state = ref.watch(corporateGovernanceDashboardAdapterProvider);
    final controller = ref.read(
      corporateGovernanceDashboardAdapterProvider.notifier,
    );

    return MasterLayout(
      child: state.when(
        data: (result) => result.fold(
          (viewModel) =>
              _buildContent(context, ref, theme, viewModel, controller),
          (e) => DashboardErrorWidget(
            message: 'Governance Error: $e',
            onRetry: () => ref.refresh(complianceHubAdapterProvider),
          ),
        ),
        loading: () => const DashboardLoadingWidget(),
        error: (e, st) => DashboardErrorWidget(
          message: 'Connection Error: $e',
          onRetry: () => ref.refresh(complianceHubAdapterProvider),
        ),
      ),
    );
  }

  Widget _buildContent(
    BuildContext context,
    WidgetRef ref,
    PrimeCareThemeData theme,
    CorporateGovernanceDashboardViewModel vm,
    CorporateGovernanceDashboardController controller,
  ) {
    final auditReports = ScreenRegistry.auditRegistry();
    final healthyCount = auditReports.where((r) => r.isHealthy).length;
    final totalCount = auditReports.length;

    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      padding: EdgeInsets.all(theme.spacing.lg),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (vm.isOfflineFallback)
            const Padding(
              padding: EdgeInsets.only(bottom: 24),
              child: PrimeCareBanner(
                message:
                    'Viewing cached governance snapshots. Real-time audit suspended.',
                type: BannerType.warning,
              ),
            ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        'Institutional Integrity HUD',
                        style: theme.typography.h1,
                      ),
                      const SizedBox(width: 16),
                      const PrimeCareBadge(
                        text: 'Registry Healthy',
                        type: BadgeType.success,
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Global platform governance, architectural compliance, and structural audit',
                    style: theme.typography.labelLarge.copyWith(
                      color: theme.colors.textSecondary,
                    ),
                  ),
                ],
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 8,
                ),
                child: Row(
                  children: [
                    Icon(
                      LucideIcons.shieldCheck,
                      size: 16,
                      color: theme.colors.primary,
                    ),
                    const SizedBox(width: 8),
                    Text('V4 Compliant', style: theme.typography.labelBold),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 32),
          Wrap(
            spacing: 12,
            runSpacing: 12,
            children: [
              PrimeCareChip(
                label: 'Audit Registry',
                onPressed: () => ScreenRegistry.auditRegistry(),
                color: theme.colors.primary,
              ),
              PrimeCareChip(
                label: 'Fix Drift',
                onPressed: controller.triggerRemediation,
                color: theme.colors.warning,
              ),
              PrimeCareChip(
                label: 'Update Blueprints',
                onPressed: () {},
                color: theme.colors.info,
              ),
            ],
          ),
          const SizedBox(height: 32),
          PrimeCareResponsiveKpiGrid(metrics: vm.metrics),
          const SizedBox(height: 32),
          if (vm.insights.isNotEmpty) ...[
            Text('Governance Intelligence', style: theme.typography.h3),
            const SizedBox(height: 16),
            ...vm.insights.map(
              (insight) => Padding(
                padding: const EdgeInsets.only(bottom: 16),
                child: IntelligenceInsightCard(insight: insight),
              ),
            ),
            const SizedBox(height: 32),
          ],
          if (vm.metrics.charts.isNotEmpty) ...[
            Text('Integrity Analytics', style: theme.typography.h3),
            const SizedBox(height: 16),
            ...vm.metrics.charts.map(
              (AnalyticsChart chart) => Padding(
                padding: const EdgeInsets.only(bottom: 24),
                child: PrimeCareChartCard(
                  title: chart.title,
                  chart: PrimeCareLineChart(chart: chart),
                ),
              ),
            ),
            const SizedBox(height: 32),
          ],
          Text('Structural Integrity Audit Log', style: theme.typography.h3),
          const SizedBox(height: 4),
          Text(
            'Real-time audit of $totalCount routes ($healthyCount verified)',
            style: theme.typography.labelMedium.copyWith(
              color: theme.colors.textSecondary,
            ),
          ),
          const SizedBox(height: 16),
          PrimeCareDataTable<RegistryAuditReport>(
            columns: const ['Role Path', 'Status', 'Message', 'Drift Details'],
            rows: auditReports.map((report) {
              return DataRow(
                cells: [
                  DataCell(
                    Text(report.route, style: theme.typography.labelSmall),
                  ),
                  DataCell(
                    PrimeCareBadge(
                      text: report.isHealthy ? 'Verified' : 'Drifted',
                      type: report.isHealthy
                          ? BadgeType.success
                          : BadgeType.error,
                    ),
                  ),
                  DataCell(
                    Text(
                      report.isHealthy ? 'Compliant' : report.message,
                      style: theme.typography.labelSmall.copyWith(
                        color: report.isHealthy
                            ? theme.colors.success
                            : theme.colors.error,
                      ),
                    ),
                  ),
                  DataCell(
                    Text(
                      !report.isHealthy && report.compliance != null
                          ? 'Missing: ${report.compliance!.missingLabels.join(", ")}'
                          : 'N/A',
                      style: theme.typography.labelSmall.copyWith(
                        color: theme.colors.textSecondary,
                      ),
                    ),
                  ),
                ],
              );
            }).toList(),
          ),
          const SizedBox(height: 64),
        ],
      ),
    );
  }
}

class CorporateGovernanceDashboardIntent extends PrimeCareScreen {
  CorporateGovernanceDashboardIntent()
    : super(title: 'CorporateGovernanceDashboard');

  @override
  Widget build(BuildContext context) =>
      const CorporateGovernanceDashboardView();
}

// --- End of corporate_governance_dashboard\corporate_governance_dashboard_view.dart ---

// --- Start of course_architect_dashboard\course_architect_dashboard_view.dart ---

class CourseArchitectDashboardView extends ConsumerWidget {
  const CourseArchitectDashboardView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = context.theme;
    final state = ref.watch(courseArchitectAdapterProvider);

    return MasterLayout(
      child: state.when(
        data: (result) => result.fold(
          (viewModel) => _buildContent(context, theme, viewModel.metrics),
          (e) => DashboardErrorWidget(
            message: 'Governance Error: $e',
            onRetry: () => ref.refresh(courseArchitectAdapterProvider),
          ),
        ),
        loading: () => const DashboardLoadingWidget(),
        error: (e, st) => DashboardErrorWidget(
          message: 'Connection Error: $e',
          onRetry: () => ref.refresh(courseArchitectAdapterProvider),
        ),
      ),
    );
  }

  Widget _buildContent(
    BuildContext context,
    PrimeCareThemeData theme,
    DashboardMetrics metrics,
  ) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(theme.spacing.lg),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Course Architect Command Center', style: theme.typography.h2),
          SizedBox(height: theme.spacing.xl),
          PrimeCareResponsiveKpiGrid(metrics: metrics),
          SizedBox(height: theme.spacing.xl),
          PrimeCareCard(
            padding: EdgeInsets.all(theme.spacing.xl),
            child: Center(
              child: Text(
                LocaleKeys.dashboards_common_labels_operational_insights.tr(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class CourseArchitectDashboardIntent extends PrimeCareScreen {
  CourseArchitectDashboardIntent() : super(title: 'CourseArchitectDashboard');

  @override
  Widget build(BuildContext context) => const CourseArchitectDashboardView();
}

// --- End of course_architect_dashboard\course_architect_dashboard_view.dart ---

// --- Start of crm_forms\crm_forms_view.dart ---

class CrmFormsView extends ConsumerWidget {
  const CrmFormsView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = context.theme;
    final state = ref.watch(crmFormsControllerProvider);

    return MasterLayout(
      child: Scaffold(
        appBar: AppBar(
          title: Text('CRM & Growth Dashboard', style: theme.typography.h3),
        ),
        body: Row(
          children: [
            SizedBox(
              width: 250,
              child: ListView.builder(
                itemCount: state.availableForms.length,
                itemBuilder: (context, index) {
                  final form = state.availableForms[index];
                  return ListTile(
                    selected: state.selectedForm == form,
                    title: Text(form),
                    onTap: () => ref
                        .read(crmFormsControllerProvider.notifier)
                        .selectForm(form),
                  );
                },
              ),
            ),
            const VerticalDivider(width: 1),
            Expanded(child: _buildFormContent(theme, state.selectedForm)),
          ],
        ),
      ),
    );
  }

  Widget _buildFormContent(PrimeCareThemeData theme, String formTitle) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(theme.spacing.xl),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(formTitle, style: theme.typography.h2),
          SizedBox(height: theme.spacing.lg),
          PrimeCareCard(
            padding: EdgeInsets.all(theme.spacing.xl),
            child: Column(
              children: [
                PrimeCareTextField(
                  label: 'Lead Name',
                  placeholder: 'Enter name',
                ),
                SizedBox(height: theme.spacing.md),
                PrimeCareTextField(
                  label: 'Campaign ID',
                  placeholder: 'MKT-2024-X',
                ),
                SizedBox(height: theme.spacing.xl),
                PrimeCareButton(onPressed: () {}, label: 'Process Growth Form'),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class CrmFormsIntent extends PrimeCareScreen {
  CrmFormsIntent() : super(title: 'CrmForms');

  @override
  Widget build(BuildContext context) => const CrmFormsView();
}

// --- End of crm_forms\crm_forms_view.dart ---

// --- Start of cto_dashboard\cto_dashboard_view.dart ---

class CtoDashboardView extends ConsumerWidget {
  const CtoDashboardView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncData = ref.watch(ctoDashboardAdapterProvider);

    return PageTemplate(
      title: LocaleKeys.dashboards_common_labels_cto_dashboard.tr(),
      subtitle: LocaleKeys
          .dashboards_common_labels_technical_operations_overview
          .tr(),
      actions: [
        IconButton(
          icon: const Icon(Icons.refresh),
          onPressed: () => ref.refresh(ctoDashboardAdapterProvider),
        ),
      ],
      body: asyncData.when(
        data: (result) => result.fold(
          (data) => SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                PrimeCareResponsiveKpiGrid(
                  children: data.kpis
                      .map(
                        (kpi) => PrimeCareKpiCard(
                          title: kpi.title,
                          value: kpi.value,
                          subtitle: kpi.subtitle ?? '',
                          icon: _getIconForMetric(kpi.title),
                          onPinToggle: () {},
                        ),
                      )
                      .toList(),
                ),
              ],
            ),
          ),
          (error) => Center(child: Text(error.toString())),
        ),
        loading: () => const PrimeCareSkeleton(),
        error: (e, s) => Center(child: Text(e.toString())),
      ),
    );
  }

  IconData _getIconForMetric(String title) {
    final t = title.toLowerCase();
    if (t.contains('uptime') || t.contains('system')) return Icons.dns_outlined;
    if (t.contains('user')) return Icons.people_outline;
    if (t.contains('latency') || t.contains('api')) return Icons.speed_outlined;
    if (t.contains('security')) return Icons.security_outlined;
    return Icons.analytics_outlined;
  }
}

class CtoDashboardIntent extends PrimeCareScreen {
  CtoDashboardIntent() : super(title: 'CtoDashboard');

  @override
  Widget build(BuildContext context) => const CtoDashboardView();
}

// --- End of cto_dashboard\cto_dashboard_view.dart ---

// --- Start of customer_support_dashboard\customer_support_dashboard_view.dart ---

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
                    'Support Excellence Dashboard',
                    style: theme.typography.h2,
                  ),
                  Text(
                    'Real-time resolution velocity, CSAT scores, and incident mgmt telemetry',
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
  CustomerSupportDashboardIntent() : super(title: 'CustomerSupportDashboard');

  @override
  Widget build(BuildContext context) => const CustomerSupportDashboardView();
}

// --- End of customer_support_dashboard\customer_support_dashboard_view.dart ---

// --- Start of cx_director_dashboard\cx_director_dashboard_view.dart ---

class CxDirectorDashboardView extends ConsumerWidget {
  const CxDirectorDashboardView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = context.theme;
    final state = ref.watch(cxDirectorDashboardAdapterProvider);

    return MasterLayout(
      child: state.when(
        data: (result) => result.fold(
          (vm) =>
              _buildContent(context, theme, vm as CXDirectorDashboardViewModel),
          (e) => DashboardErrorWidget(
            message: 'Experience Error: $e',
            onRetry: () => ref.refresh(cxDirectorDashboardAdapterProvider),
          ),
        ),
        loading: () => const DashboardLoadingWidget(),
        error: (e, st) => DashboardErrorWidget(
          message: 'Connection Error: $e',
          onRetry: () => ref.refresh(cxDirectorDashboardAdapterProvider),
        ),
      ),
    );
  }

  Widget _buildContent(
    BuildContext context,
    PrimeCareThemeData theme,
    CXDirectorDashboardViewModel vm,
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
                    'Experience Intelligence Center',
                    style: theme.typography.h2,
                  ),
                  Text(
                    'NPS, sentiment velocity, churn risk, and response latency telemetry',
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
                    _buildSentimentHeatmap(theme),
                    SizedBox(height: theme.spacing.xl),
                    _buildExperienceCharts(theme, vm),
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

  Widget _buildSentimentHeatmap(PrimeCareThemeData theme) {
    return PrimeCareCard(
      padding: EdgeInsets.all(theme.spacing.xl),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Sentiment Velocity Heatmap', style: theme.typography.h4),
          SizedBox(height: theme.spacing.lg),
          const Center(
            child: Text(
              'Global Experience Surveillance Active',
              style: TextStyle(fontStyle: FontStyle.italic),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildExperienceCharts(
    PrimeCareThemeData theme,
    CXDirectorDashboardViewModel vm,
  ) {
    final sentimentChart = vm.metrics.charts.firstWhere(
      (c) => c.id == 'sentiment-trend',
      orElse: () => AnalyticsChart.empty(),
    );

    if (sentimentChart.id.isEmpty) return const SizedBox.shrink();

    return Column(
      children: [
        PrimeCareChartCard(
          title: LocaleKeys.dashboards_common_labels_sentiment_velocity_trend
              .tr(),
          chart: PrimeCareLineChart(chart: sentimentChart),
        ),
      ],
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

class CxDirectorDashboardIntent extends PrimeCareScreen {
  CxDirectorDashboardIntent() : super(title: 'CxDirectorDashboard');

  @override
  Widget build(BuildContext context) => const CxDirectorDashboardView();
}

// --- End of cx_director_dashboard\cx_director_dashboard_view.dart ---

// --- Start of dynamic_screen_dashboard\dynamic_screen_dashboard_view.dart ---

class DynamicScreenDashboardView extends ConsumerWidget {
  const DynamicScreenDashboardView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = context.theme;
    final state = ref.watch(dynamicScreenDashboardAdapterProvider);

    return MasterLayout(
      child: state.when(
        data: (result) => result.fold(
          (viewModel) => _buildContent(context, theme, viewModel.metrics),
          (e) => DashboardErrorWidget(
            message: 'Governance Error: $e',
            onRetry: () => ref.refresh(cxDirectorDashboardAdapterProvider),
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
    DashboardMetrics metrics,
  ) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(theme.spacing.lg),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Dynamic Screen Command Center', style: theme.typography.h2),
          SizedBox(height: theme.spacing.xl),
          PrimeCareResponsiveKpiGrid(metrics: metrics),
          SizedBox(height: theme.spacing.xl),
          PrimeCareCard(
            padding: EdgeInsets.all(theme.spacing.xl),
            child: Center(
              child: Text(
                LocaleKeys.dashboards_common_labels_operational_insights.tr(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class DynamicScreenDashboardIntent extends PrimeCareScreen {
  DynamicScreenDashboardIntent() : super(title: 'DynamicScreenDashboard');

  @override
  Widget build(BuildContext context) => const DynamicScreenDashboardView();
}

// --- End of dynamic_screen_dashboard\dynamic_screen_dashboard_view.dart ---

// --- Start of error401_view\presentation\widgets\error401_page_view.dart ---
// Layer: 05_UI_PRESENTATION

/// Hardened error401PageView
class Error401pageview extends StatelessWidget {
  Error401pageview({super.key});

  @override
  Widget build(BuildContext context) {
    return PrimeCareResponsiveKpiGrid(
      children: [
        PrimeCareCard(
          child: Text(
            LocaleKeys
                .dashboards_common_labels_operational_sector__error401pageview
                .tr(),
          ),
        ),
      ],
    );
  }
}

// --- End of error401_view\presentation\widgets\error401_page_view.dart ---

// --- Start of error404_view\presentation\widgets\error404_page_view.dart ---
// Layer: 05_UI_PRESENTATION

/// Hardened error404PageView
class Error404pageview extends StatelessWidget {
  Error404pageview({super.key});

  @override
  Widget build(BuildContext context) {
    return PrimeCareResponsiveKpiGrid(
      children: [
        PrimeCareCard(
          child: Text(
            LocaleKeys
                .dashboards_common_labels_operational_sector__error404pageview
                .tr(),
          ),
        ),
      ],
    );
  }
}

// --- End of error404_view\presentation\widgets\error404_page_view.dart ---

// --- Start of family_dashboard\family_dashboard_view.dart ---

class FamilyDashboardView extends ConsumerWidget {
  const FamilyDashboardView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = context.theme;
    final state = ref.watch(familyDashboardAdapterProvider);

    return MasterLayout(
      child: state.when(
        data: (result) => result.fold(
          (viewModel) => _buildContent(context, theme, viewModel.metrics),
          (e) => DashboardErrorWidget(
            message: 'Governance Error: $e',
            onRetry: () => ref.refresh(familyDashboardAdapterProvider),
          ),
        ),
        loading: () => const DashboardLoadingWidget(),
        error: (e, st) => DashboardErrorWidget(
          message: 'Connection Error: $e',
          onRetry: () => ref.refresh(familyDashboardAdapterProvider),
        ),
      ),
    );
  }

  Widget _buildContent(
    BuildContext context,
    PrimeCareThemeData theme,
    DashboardMetrics metrics,
  ) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(theme.spacing.lg),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Family Command Center', style: theme.typography.h2),
          SizedBox(height: theme.spacing.xl),
          PrimeCareResponsiveKpiGrid(metrics: metrics),
          SizedBox(height: theme.spacing.xl),
          PrimeCareCard(
            padding: EdgeInsets.all(theme.spacing.xl),
            child: Center(
              child: Text(
                LocaleKeys.dashboards_common_labels_operational_insights.tr(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class FamilyDashboardIntent extends PrimeCareScreen {
  FamilyDashboardIntent() : super(title: 'FamilyDashboard');

  @override
  Widget build(BuildContext context) => const FamilyDashboardView();
}

// --- End of family_dashboard\family_dashboard_view.dart ---

// --- Start of family_member\family_member_view.dart ---

class FamilyMemberView extends ConsumerWidget {
  const FamilyMemberView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = context.theme;
    final state = ref.watch(familyMemberControllerProvider);

    return MasterLayout(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Family Care Connect', style: theme.typography.h3),
        ),
        body: Padding(
          padding: EdgeInsets.all(theme.spacing.xl),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Care Updates for ${state.patientName}',
                style: theme.typography.h4,
              ),
              SizedBox(height: theme.spacing.md),
              Expanded(
                child: ListView.builder(
                  itemCount: state.updates.length,
                  itemBuilder: (context, index) {
                    return PrimeCareCard(
                      margin: EdgeInsets.only(bottom: theme.spacing.md),
                      child: ListTile(
                        leading: const Icon(Icons.info_outline),
                        title: Text(state.updates[index]),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class FamilyMemberIntent extends PrimeCareScreen {
  FamilyMemberIntent() : super(title: 'FamilyMember');

  @override
  Widget build(BuildContext context) => const FamilyMemberView();
}

// --- End of family_member\family_member_view.dart ---

// --- Start of family_member_dashboard\family_member_dashboard_view.dart ---

class FamilyMemberDashboardView extends ConsumerWidget {
  const FamilyMemberDashboardView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = context.theme;
    final state = ref.watch(familyMemberDashboardAdapterProvider);

    return MasterLayout(
      child: state.when(
        data: (result) => result.fold(
          (viewModel) => _buildContent(context, theme, viewModel.metrics),
          (e) => DashboardErrorWidget(
            message: 'Governance Error: $e',
            onRetry: () => ref.refresh(familyMemberControllerProvider),
          ),
        ),
        loading: () => const DashboardLoadingWidget(),
        error: (e, st) => DashboardErrorWidget(
          message: 'Connection Error: $e',
          onRetry: () => ref.refresh(familyMemberControllerProvider),
        ),
      ),
    );
  }

  Widget _buildContent(
    BuildContext context,
    PrimeCareThemeData theme,
    DashboardMetrics metrics,
  ) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(theme.spacing.lg),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Family Member Command Center', style: theme.typography.h2),
          SizedBox(height: theme.spacing.xl),
          PrimeCareResponsiveKpiGrid(metrics: metrics),
          SizedBox(height: theme.spacing.xl),
          PrimeCareCard(
            padding: EdgeInsets.all(theme.spacing.xl),
            child: Center(
              child: Text(
                LocaleKeys.dashboards_common_labels_operational_insights.tr(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class FamilyMemberDashboardIntent extends PrimeCareScreen {
  FamilyMemberDashboardIntent() : super(title: 'FamilyMemberDashboard');

  @override
  Widget build(BuildContext context) => const FamilyMemberDashboardView();
}

// --- End of family_member_dashboard\family_member_dashboard_view.dart ---

// --- Start of finance_director_dashboard\finance_director_dashboard_view.dart ---

class FinanceDirectorDashboardView extends ConsumerWidget {
  const FinanceDirectorDashboardView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = context.theme;
    final state = ref.watch(financeDirectorDashboardAdapterProvider);

    return MasterLayout(
      shellType: AppShellType.admin,
      child: state.when(
        data: (result) => result.fold(
          (vm) => _buildContent(
            context,
            theme,
            vm as FinanceDirectorDashboardViewModel,
          ),
          (e) => DashboardErrorWidget(
            message: 'Governance Error: $e',
            onRetry: () => ref.refresh(financeDirectorDashboardAdapterProvider),
          ),
        ),
        loading: () => const DashboardLoadingWidget(),
        error: (e, st) => DashboardErrorWidget(
          message: 'Connection Error: $e',
          onRetry: () => ref.refresh(financeDirectorDashboardAdapterProvider),
        ),
      ),
    );
  }

  Widget _buildContent(
    BuildContext context,
    PrimeCareThemeData theme,
    FinanceDirectorDashboardViewModel vm,
  ) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(theme.spacing.xl),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildHeader(theme, vm),
          SizedBox(height: theme.spacing.xl),
          PrimeCareResponsiveKpiGrid(metrics: vm.metrics),
          SizedBox(height: theme.spacing.xl),
          _buildInsightsSection(context, theme, vm),
          SizedBox(height: theme.spacing.xl),
          _buildActionGrid(theme),
          if (vm.isOfflineFallback) ...[
            SizedBox(height: theme.spacing.xl),
            _buildOfflineWarning(theme),
          ],
        ],
      ),
    );
  }

  Widget _buildHeader(
    PrimeCareThemeData theme,
    FinanceDirectorDashboardViewModel vm,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Treasury Command',
          style: theme.typography.h1.copyWith(
            fontWeight: FontWeight.w800,
            letterSpacing: -1.0,
          ),
        ),
        SizedBox(height: theme.spacing.xs),
        Text(
          'Institutional Ledger • Sovereign Oversight',
          style: theme.typography.bodyLarge.copyWith(
            color: theme.colors.slate400,
            letterSpacing: 0.5,
          ),
        ),
      ],
    );
  }

  Widget _buildInsightsSection(
    BuildContext context,
    PrimeCareThemeData theme,
    FinanceDirectorDashboardViewModel vm,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Financial Intelligence', style: theme.typography.h3),
        SizedBox(height: theme.spacing.lg),
        PrimeCareCard(
          color: theme.colors.surfaceContainerLow,
          padding: EdgeInsets.all(theme.spacing.xl),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: vm.insights.isEmpty
                ? [
                    const Center(
                      child: Padding(
                        padding: EdgeInsets.symmetric(vertical: 20),
                        child: Text(
                          'AI is analyzing your ledger. No critical anomalies detected.',
                        ),
                      ),
                    ),
                  ]
                : vm.insights
                      .map(
                        (insight) => DashboardInsightRow(
                          title: insight.title.translate(context),
                          description: insight.summary.translate(context),
                          type: insight.type.name,
                        ),
                      )
                      .toList(),
          ),
        ),
      ],
    );
  }

  Widget _buildActionGrid(PrimeCareThemeData theme) {
    final actions = [
      {'label': 'P&L Report', 'icon': LucideIcons.fileText},
      {'label': 'Tax Remittance', 'icon': LucideIcons.shieldCheck},
      {'label': 'Adjust Budget', 'icon': LucideIcons.sliders},
      {'label': 'Audit Logs', 'icon': LucideIcons.history},
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Executive Actions', style: theme.typography.h3),
        SizedBox(height: theme.spacing.lg),
        Wrap(
          spacing: theme.spacing.md,
          runSpacing: theme.spacing.md,
          children: actions.map((action) {
            return PrimeCareButton(
              type: PrimeCareButtonType.secondary,
              onPressed: () {},
              icon: action['icon'] as IconData,
              label: action['label'] as String,
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildOfflineWarning(PrimeCareThemeData theme) {
    return Container(
      padding: EdgeInsets.all(theme.spacing.md),
      decoration: BoxDecoration(
        color: theme.colors.error.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(theme.radii.radiusSm),
        border: Border.all(color: theme.colors.error.withValues(alpha: 0.3)),
      ),
      child: Row(
        children: [
          Icon(LucideIcons.wifiOff, color: theme.colors.error, size: 16),
          SizedBox(width: theme.spacing.sm),
          Text(
            'Viewing LKG Snapshot. Some metrics may be stale.',
            style: theme.typography.bodySmall.copyWith(
              color: theme.colors.error,
            ),
          ),
        ],
      ),
    );
  }
}

class FinanceDirectorDashboardIntent extends PrimeCareScreen {
  FinanceDirectorDashboardIntent() : super(title: 'FinanceDirectorDashboard');

  @override
  Widget build(BuildContext context) => const FinanceDirectorDashboardView();
}

// --- End of finance_director_dashboard\finance_director_dashboard_view.dart ---

// --- Start of financial_forms\financial_forms_view.dart ---

class FinancialFormsView extends ConsumerWidget {
  const FinancialFormsView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = context.theme;
    final state = ref.watch(financialFormsControllerProvider);

    return MasterLayout(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Financial Terminal', style: theme.typography.h3),
        ),
        body: Row(
          children: [
            SizedBox(
              width: 250,
              child: ListView.builder(
                itemCount: state.availableForms.length,
                itemBuilder: (context, index) {
                  final form = state.availableForms[index];
                  return ListTile(
                    selected: state.selectedForm == form,
                    title: Text(form),
                    onTap: () => ref
                        .read(financialFormsControllerProvider.notifier)
                        .selectForm(form),
                  );
                },
              ),
            ),
            const VerticalDivider(width: 1),
            Expanded(child: _buildFormContent(theme, state.selectedForm)),
          ],
        ),
      ),
    );
  }

  Widget _buildFormContent(PrimeCareThemeData theme, String formTitle) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(theme.spacing.xl),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(formTitle, style: theme.typography.h2),
          SizedBox(height: theme.spacing.lg),
          PrimeCareCard(
            padding: EdgeInsets.all(theme.spacing.xl),
            child: Column(
              children: [
                PrimeCareTextField(
                  label: 'Account Code',
                  placeholder: 'GL-XXXX-YY',
                ),
                SizedBox(height: theme.spacing.md),
                PrimeCareTextField(label: 'Amount', placeholder: '0.00'),
                SizedBox(height: theme.spacing.xl),
                PrimeCareButton(
                  onPressed: () {},
                  label: 'Process Financial Entry',
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class FinancialFormsIntent extends PrimeCareScreen {
  FinancialFormsIntent() : super(title: 'Financial Terminal');

  @override
  Widget build(BuildContext context) => const FinancialFormsView();
}

// --- End of financial_forms\financial_forms_view.dart ---

// --- Start of franchise_owner\franchise_owner_view.dart ---

class FranchiseOwnerView extends ConsumerWidget {
  const FranchiseOwnerView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = context.theme;
    final state = ref.watch(franchiseOwnerControllerProvider);

    return MasterLayout(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'Franchise Operations: ${state.region}',
            style: theme.typography.h3,
          ),
        ),
        body: Padding(
          padding: EdgeInsets.all(theme.spacing.xl),
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: PrimeCareCard(
                      child: ListTile(
                        title: const Text('Monthly Revenue'),
                        subtitle: Text(
                          '\$${state.monthlyRevenue.toInt()}',
                          style: theme.typography.h2,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: theme.spacing.md),
                  Expanded(
                    child: PrimeCareCard(
                      child: ListTile(
                        title: const Text('Active Staff'),
                        subtitle: Text(
                          '${state.activeStaff}',
                          style: theme.typography.h2,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: theme.spacing.xl),
              PrimeCareButton(
                onPressed: () {},
                label: 'Generate Regional Report',
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class FranchiseOwnerIntent extends PrimeCareScreen {
  FranchiseOwnerIntent() : super(title: 'Franchise Owner Dashboard');

  @override
  Widget build(BuildContext context) => const FranchiseOwnerView();
}

// --- End of franchise_owner\franchise_owner_view.dart ---

// --- Start of franchise_owner_dashboard\franchise_owner_dashboard_view.dart ---

class FranchiseOwnerDashboardView extends ConsumerWidget {
  const FranchiseOwnerDashboardView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = context.theme;
    final state = ref.watch(franchiseOwnerAdapterProvider);

    return MasterLayout(
      child: state.when(
        data: (result) => result.fold(
          (vm) => _buildContent(
            context,
            theme,
            vm as FranchiseOwnerDashboardViewModel,
          ),
          (e) => DashboardErrorWidget(
            message: 'Governance Error: $e',
            onRetry: () {},
          ),
        ),
        loading: () => const DashboardLoadingWidget(),
        error: (e, st) => DashboardErrorWidget(
          message: 'Connection Error: $e',
          onRetry: () {},
        ),
      ),
    );
  }

  Widget _buildContent(
    BuildContext context,
    PrimeCareThemeData theme,
    FranchiseOwnerDashboardViewModel vm,
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
                    LocaleKeys.command_center_labels_franchise_center.tr(),
                    style: theme.typography.h2,
                  ),
                  Text(
                    'Unit profitability, royalty compliance, and operational growth telemetry',
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
                    _buildOperationalMatrix(theme),
                    SizedBox(height: theme.spacing.xl),
                    _buildBusinessCharts(theme, vm),
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

  Widget _buildOperationalMatrix(PrimeCareThemeData theme) {
    return PrimeCareCard(
      padding: EdgeInsets.all(theme.spacing.xl),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Regional Growth Matrix', style: theme.typography.h4),
          SizedBox(height: theme.spacing.lg),
          const Center(
            child: Text(
              'Business Intelligence Engine Initialized',
              style: TextStyle(fontStyle: FontStyle.italic),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBusinessCharts(
    PrimeCareThemeData theme,
    FranchiseOwnerDashboardViewModel vm,
  ) {
    return Column(
      children: [
        PrimeCareChartCard(
          title: LocaleKeys.dashboards_common_labels_unit_profitability_trend
              .tr(),
          chart: PrimeCareLineChart(
            chart: vm.metrics.charts.firstWhere(
              (c) => c.id == 'profitability-trend',
              orElse: () => AnalyticsChart.empty(),
            ),
          ),
        ),
      ],
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

class FranchiseOwnerDashboardIntent extends PrimeCareScreen {
  FranchiseOwnerDashboardIntent() : super(title: 'FranchiseOwnerDashboard');

  @override
  Widget build(BuildContext context) => const FranchiseOwnerDashboardView();
}

// --- End of franchise_owner_dashboard\franchise_owner_dashboard_view.dart ---

// --- Start of franchise_sales_manager_dashboard\franchise_sales_manager_dashboard_view.dart ---

class FranchiseSalesManagerDashboardView extends ConsumerWidget {
  const FranchiseSalesManagerDashboardView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = context.theme;
    final state = ref.watch(franchiseSalesAdapterProvider);

    return MasterLayout(
      child: state.when(
        data: (result) => result.fold(
          (viewModel) => _buildContent(context, theme, viewModel),
          (e) => DashboardErrorWidget(
            message: 'Governance Error: $e',
            onRetry: () => ref.refresh(financialFormsControllerProvider),
          ),
        ),
        loading: () => const DashboardLoadingWidget(),
        error: (e, st) => DashboardErrorWidget(
          message: 'Connection Error: $e',
          onRetry: () => ref.refresh(financialFormsControllerProvider),
        ),
      ),
    );
  }

  Widget _buildContent(
    BuildContext context,
    PrimeCareThemeData theme,
    FranchiseSalesManagerDashboardViewModel vm,
  ) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(theme.spacing.lg),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _DashboardHeader(isOffline: vm.isOfflineFallback),
          SizedBox(height: theme.spacing.xl),
          PrimeCareResponsiveKpiGrid(metrics: vm.metrics),
          SizedBox(height: theme.spacing.xl),
          _SalesFunnelSection(theme: theme),
          SizedBox(height: theme.spacing.xl),
          _FranchiseLeadList(theme: theme),
        ],
      ),
    );
  }
}

class _DashboardHeader extends StatelessWidget {
  final bool isOffline;
  const _DashboardHeader({required this.isOffline});

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    return Row(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Sales Command', style: theme.typography.h2),
            Text(
              'Pipeline velocity, lead conversion, and territorial expansion telemetry',
              style: theme.typography.labelMedium,
            ),
          ],
        ),
        const Spacer(),
        if (isOffline) const OfflineStatusChip(),
      ],
    );
  }
}

class _SalesFunnelSection extends StatelessWidget {
  final PrimeCareThemeData theme;
  const _SalesFunnelSection({required this.theme});

  @override
  Widget build(BuildContext context) {
    return PrimeCareCard(
      padding: EdgeInsets.all(theme.spacing.xl),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Conversion Pipeline', style: theme.typography.h4),
          SizedBox(height: theme.spacing.lg),
          const Center(
            child: Text(
              'Pipeline Visualization Engine Initialized',
              style: TextStyle(fontStyle: FontStyle.italic),
            ),
          ),
        ],
      ),
    );
  }
}

class _FranchiseLeadList extends StatelessWidget {
  final PrimeCareThemeData theme;
  const _FranchiseLeadList({required this.theme});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('High-Value Leads', style: theme.typography.h4),
        SizedBox(height: theme.spacing.lg),
        PrimeCareCard(
          padding: EdgeInsets.zero,
          child: Column(
            children: List.generate(
              3,
              (index) => ListTile(
                leading: CircleAvatar(
                  backgroundColor: theme.colors.primaryContainer,
                  child: Icon(
                    LucideIcons.user,
                    size: 16,
                    color: theme.colors.onPrimaryContainer,
                  ),
                ),
                title: Text('Lead Protocol #${index + 104}'),
                subtitle: const Text(
                  'Territory: North Atlantic • Qualification: Grade A',
                ),
                trailing: const Icon(LucideIcons.chevronRight, size: 16),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class FranchiseSalesManagerDashboardIntent extends PrimeCareScreen {
  FranchiseSalesManagerDashboardIntent()
    : super(title: 'FranchiseSalesManagerDashboard');

  @override
  Widget build(BuildContext context) =>
      const FranchiseSalesManagerDashboardView();
}

// --- End of franchise_sales_manager_dashboard\franchise_sales_manager_dashboard_view.dart ---

// --- Start of general_manager_dashboard\general_manager_dashboard_view.dart ---

class GeneralManagerDashboardView extends ConsumerWidget {
  const GeneralManagerDashboardView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = context.theme;
    final state = ref.watch(generalManagerAdapterProvider);

    return MasterLayout(
      child: state.when(
        data: (result) => result.fold(
          (viewModel) => _buildContent(context, theme, viewModel),
          (e) => DashboardErrorWidget(
            message: 'Governance Error: $e',
            onRetry: () => ref.refresh(generalManagerAdapterProvider),
          ),
        ),
        loading: () => const DashboardLoadingWidget(),
        error: (e, st) => DashboardErrorWidget(
          message: 'Connection Error: $e',
          onRetry: () => ref.refresh(generalManagerAdapterProvider),
        ),
      ),
    );
  }

  Widget _buildContent(
    BuildContext context,
    PrimeCareThemeData theme,
    GeneralManagerDashboardViewModel vm,
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
                  Text('Operational Command', style: theme.typography.h2),
                  Text(
                    'Efficiency, facility compliance, and multi-unit synchronization telemetry',
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
          _FacilityStatusSection(theme: theme),
          SizedBox(height: theme.spacing.xl),
          _AuditProtocolList(theme: theme),
        ],
      ),
    );
  }
}

class _FacilityStatusSection extends StatelessWidget {
  final PrimeCareThemeData theme;
  const _FacilityStatusSection({required this.theme});

  @override
  Widget build(BuildContext context) {
    return PrimeCareCard(
      padding: EdgeInsets.all(theme.spacing.xl),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Facility Readiness Matrix', style: theme.typography.h4),
          SizedBox(height: theme.spacing.lg),
          const Center(
            child: Text(
              'Operational Intelligence Engine Initialized',
              style: TextStyle(fontStyle: FontStyle.italic),
            ),
          ),
        ],
      ),
    );
  }
}

class _AuditProtocolList extends StatelessWidget {
  final PrimeCareThemeData theme;
  const _AuditProtocolList({required this.theme});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Compliance Audit Protocols', style: theme.typography.h4),
        SizedBox(height: theme.spacing.lg),
        PrimeCareCard(
          padding: EdgeInsets.zero,
          child: Column(
            children: List.generate(
              3,
              (index) => ListTile(
                leading: CircleAvatar(
                  backgroundColor: theme.colors.secondaryContainer,
                  child: Icon(
                    LucideIcons.clipboardCheck,
                    size: 16,
                    color: theme.colors.onSecondaryContainer,
                  ),
                ),
                title: Text('Compliance Protocol #${index + 201}'),
                subtitle: const Text(
                  'Facility: PrimeCare East • Status: In Progress',
                ),
                trailing: const Icon(LucideIcons.chevronRight, size: 16),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class GeneralManagerDashboardIntent extends PrimeCareScreen {
  GeneralManagerDashboardIntent() : super(title: 'GeneralManagerDashboard');

  @override
  Widget build(BuildContext context) => const GeneralManagerDashboardView();
}

// --- End of general_manager_dashboard\general_manager_dashboard_view.dart ---

// --- Start of guest_dashboard\guest_dashboard_view.dart ---

class GuestDashboardView extends ConsumerWidget {
  const GuestDashboardView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = context.theme;
    final state = ref.watch(guestDashboardAdapterProvider);

    return MasterLayout(
      child: state.when(
        data: (result) => result.fold(
          (viewModel) => _buildContent(context, theme, viewModel.metrics),
          (e) => DashboardErrorWidget(
            message: 'Governance Error: $e',
            onRetry: () => ref.refresh(guestDashboardAdapterProvider),
          ),
        ),
        loading: () => const DashboardLoadingWidget(),
        error: (e, st) => DashboardErrorWidget(
          message: 'Connection Error: $e',
          onRetry: () => ref.refresh(guestDashboardAdapterProvider),
        ),
      ),
    );
  }

  Widget _buildContent(
    BuildContext context,
    PrimeCareThemeData theme,
    DashboardMetrics metrics,
  ) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(theme.spacing.lg),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Guest Command Center', style: theme.typography.h2),
          SizedBox(height: theme.spacing.xl),
          PrimeCareResponsiveKpiGrid(metrics: metrics),
          SizedBox(height: theme.spacing.xl),
          PrimeCareCard(
            padding: EdgeInsets.all(theme.spacing.xl),
            child: Center(
              child: Text(
                LocaleKeys.dashboards_common_labels_operational_insights.tr(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class GuestDashboardIntent extends PrimeCareScreen {
  GuestDashboardIntent() : super(title: 'GuestDashboard');

  @override
  Widget build(BuildContext context) => const GuestDashboardView();
}

// --- End of guest_dashboard\guest_dashboard_view.dart ---

// --- Start of head_of_bus_dev_dashboard\head_of_bus_dev_dashboard_view.dart ---

class HeadOfBusDevDashboardView extends ConsumerWidget {
  const HeadOfBusDevDashboardView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = context.theme;
    final state = ref.watch(headOfBusDevAdapterProvider);

    return MasterLayout(
      child: state.when(
        data: (result) => result.fold(
          (viewModel) => _buildContent(context, theme, viewModel),
          (e) => DashboardErrorWidget(
            message: 'Governance Error: $e',
            onRetry: () => ref.refresh(headOfBusDevAdapterProvider),
          ),
        ),
        loading: () => const DashboardLoadingWidget(),
        error: (e, st) => DashboardErrorWidget(
          message: 'Connection Error: $e',
          onRetry: () => ref.refresh(headOfBusDevAdapterProvider),
        ),
      ),
    );
  }

  Widget _buildContent(
    BuildContext context,
    PrimeCareThemeData theme,
    HeadOfBusDevDashboardViewModel vm,
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
                  Text('Strategic Command', style: theme.typography.h2),
                  Text(
                    'Market expansion, partnership velocity, and global growth telemetry',
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
          _PartnershipFunnel(theme: theme),
          SizedBox(height: theme.spacing.xl),
          _StrategicOpportunities(theme: theme),
        ],
      ),
    );
  }
}

class _PartnershipFunnel extends StatelessWidget {
  final PrimeCareThemeData theme;
  const _PartnershipFunnel({required this.theme});

  @override
  Widget build(BuildContext context) {
    return PrimeCareCard(
      padding: EdgeInsets.all(theme.spacing.xl),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Partnership conversion pipeline', style: theme.typography.h4),
          SizedBox(height: theme.spacing.lg),
          const Center(
            child: Text(
              'Partnership Intelligence Engine Initialized',
              style: TextStyle(fontStyle: FontStyle.italic),
            ),
          ),
        ],
      ),
    );
  }
}

class _StrategicOpportunities extends StatelessWidget {
  final PrimeCareThemeData theme;
  const _StrategicOpportunities({required this.theme});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Strategic Growth Opportunities', style: theme.typography.h4),
        SizedBox(height: theme.spacing.lg),
        PrimeCareCard(
          padding: EdgeInsets.zero,
          child: Column(
            children: List.generate(
              3,
              (index) => ListTile(
                leading: CircleAvatar(
                  backgroundColor: theme.colors.tertiaryContainer,
                  child: Icon(
                    LucideIcons.globe,
                    size: 16,
                    color: theme.colors.onTertiaryContainer,
                  ),
                ),
                title: Text('Expansion Protocol #${index + 301}'),
                subtitle: const Text(
                  'Region: Southeast Asia • Market Fit: High',
                ),
                trailing: const Icon(LucideIcons.chevronRight, size: 16),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class HeadOfBusDevDashboardIntent extends PrimeCareScreen {
  HeadOfBusDevDashboardIntent() : super(title: 'HeadOfBusDevDashboard');

  @override
  Widget build(BuildContext context) => const HeadOfBusDevDashboardView();
}

// --- End of head_of_bus_dev_dashboard\head_of_bus_dev_dashboard_view.dart ---

// --- Start of head_of_marketing_dashboard\head_of_marketing_dashboard_view.dart ---

class HeadOfMarketingDashboardView extends ConsumerWidget {
  const HeadOfMarketingDashboardView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = context.theme;
    final state = ref.watch(headOfMarketingAdapterProvider);

    return MasterLayout(
      child: state.when(
        data: (result) => result.fold(
          (viewModel) => _buildContent(context, theme, viewModel),
          (e) => DashboardErrorWidget(
            message: 'Governance Error: $e',
            onRetry: () => ref.refresh(headOfMarketingAdapterProvider),
          ),
        ),
        loading: () => const DashboardLoadingWidget(),
        error: (e, st) => DashboardErrorWidget(
          message: 'Connection Error: $e',
          onRetry: () => ref.refresh(headOfMarketingAdapterProvider),
        ),
      ),
    );
  }

  Widget _buildContent(
    BuildContext context,
    PrimeCareThemeData theme,
    HeadOfMarketingDashboardViewModel vm,
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
                  Text('Marketing Command', style: theme.typography.h2),
                  Text(
                    'Brand resonance, campaign velocity, and market penetration telemetry',
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
          _MarketingCampaignSection(theme: theme),
          SizedBox(height: theme.spacing.xl),
          _CreativeAssetList(theme: theme),
        ],
      ),
    );
  }
}

class _MarketingCampaignSection extends StatelessWidget {
  final PrimeCareThemeData theme;
  const _MarketingCampaignSection({required this.theme});

  @override
  Widget build(BuildContext context) {
    return PrimeCareCard(
      padding: EdgeInsets.all(theme.spacing.xl),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Campaign ROI Matrix', style: theme.typography.h4),
          SizedBox(height: theme.spacing.lg),
          const Center(
            child: Text(
              'Campaign Intelligence Engine Initialized',
              style: TextStyle(fontStyle: FontStyle.italic),
            ),
          ),
        ],
      ),
    );
  }
}

class _CreativeAssetList extends StatelessWidget {
  final PrimeCareThemeData theme;
  const _CreativeAssetList({required this.theme});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Creative Performance Protocols', style: theme.typography.h4),
        SizedBox(height: theme.spacing.lg),
        PrimeCareCard(
          padding: EdgeInsets.zero,
          child: Column(
            children: List.generate(
              3,
              (index) => ListTile(
                leading: CircleAvatar(
                  backgroundColor: theme.colors.primaryContainer,
                  child: Icon(
                    LucideIcons.image,
                    size: 16,
                    color: theme.colors.onPrimaryContainer,
                  ),
                ),
                title: Text('Creative Protocol #${index + 401}'),
                subtitle: const Text(
                  'Campaign: Spring Expansion • Engagement: Top 5%',
                ),
                trailing: const Icon(LucideIcons.chevronRight, size: 16),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class HeadOfMarketingDashboardIntent extends PrimeCareScreen {
  HeadOfMarketingDashboardIntent() : super(title: 'HeadOfMarketingDashboard');

  @override
  Widget build(BuildContext context) => const HeadOfMarketingDashboardView();
}

// --- End of head_of_marketing_dashboard\head_of_marketing_dashboard_view.dart ---

// --- Start of hr_director_dashboard\hr_director_dashboard_view.dart ---

class HrDirectorDashboardView extends ConsumerWidget {
  const HrDirectorDashboardView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = context.theme;
    final state = ref.watch(hrDirectorDashboardAdapterProvider);

    return MasterLayout(
      child: state.when(
        data: (result) => result.fold(
          (viewModel) => _buildContent(context, theme, viewModel),
          (e) => DashboardErrorWidget(
            message: 'Governance Error: $e',
            onRetry: () => ref.refresh(hrDirectorDashboardAdapterProvider),
          ),
        ),
        loading: () => const DashboardLoadingWidget(),
        error: (e, st) => DashboardErrorWidget(
          message: 'Connection Error: $e',
          onRetry: () => ref.refresh(hrDirectorDashboardAdapterProvider),
        ),
      ),
    );
  }

  Widget _buildContent(
    BuildContext context,
    PrimeCareThemeData theme,
    HumanResourcesDirectorDashboardViewModel vm,
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
                    'Workforce Intelligence Hub',
                    style: theme.typography.h2,
                  ),
                  Text(
                    'Workforce stability, clinical turnover, and hiring velocity telemetry',
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
                    _buildWorkforceStability(theme),
                    SizedBox(height: theme.spacing.xl),
                    _buildRetentionCharts(theme, vm),
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

  Widget _buildWorkforceStability(PrimeCareThemeData theme) {
    return PrimeCareCard(
      padding: EdgeInsets.all(theme.spacing.xl),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Workforce Stability Matrix', style: theme.typography.h4),
          SizedBox(height: theme.spacing.lg),
          const Center(
            child: Text(
              'Regional Stability Surveillance Active',
              style: TextStyle(fontStyle: FontStyle.italic),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRetentionCharts(
    PrimeCareThemeData theme,
    HumanResourcesDirectorDashboardViewModel vm,
  ) {
    return Column(
      children: [
        PrimeCareChartCard(
          title: LocaleKeys.dashboards_common_labels_clinical_retention_trend
              .tr(),
          chart: PrimeCareLineChart(
            chart: vm.metrics.charts.firstWhere(
              (c) => c.id == 'retention-trend',
              orElse: () => AnalyticsChart.empty(),
            ),
          ),
        ),
      ],
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

class HrDirectorDashboardIntent extends PrimeCareScreen {
  HrDirectorDashboardIntent() : super(title: 'HrDirectorDashboard');

  @override
  Widget build(BuildContext context) => const HrDirectorDashboardView();
}

// --- End of hr_director_dashboard\hr_director_dashboard_view.dart ---

// --- Start of hr_forms\hr_forms_view.dart ---

class HrFormsView extends ConsumerStatefulWidget {
  const HrFormsView({super.key});

  @override
  ConsumerState<HrFormsView> createState() => _HrFormsViewState();
}

class _HrFormsViewState extends ConsumerState<HrFormsView>
    with TickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 5, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    final state = ref.watch(hrFormsControllerProvider);

    return MasterLayout(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'Human Resources Command Center',
            style: theme.typography.h3,
          ),
          bottom: TabBar(
            controller: _tabController,
            isScrollable: true,
            tabs: const [
              Tab(text: 'Leave Request'),
              Tab(text: 'Grievance'),
              Tab(text: 'Onboarding'),
              Tab(text: 'Interview'),
              Tab(text: 'Exit Interview'),
            ],
            onTap: (index) {
              ref
                  .read(hrFormsControllerProvider.notifier)
                  .selectForm(state.availableForms[index]);
            },
          ),
        ),
        body: TabBarView(
          controller: _tabController,
          children: [
            _buildFormContainer(
              theme,
              'Leave Request Form',
              _buildLeaveRequestForm(theme),
            ),
            _buildFormContainer(
              theme,
              'Employee Grievance Form',
              _buildGrievanceForm(theme),
            ),
            _buildFormContainer(
              theme,
              'New Onboarding Entry',
              _buildOnboardingForm(theme),
            ),
            _buildFormContainer(
              theme,
              'Interview Scheduler',
              _buildInterviewForm(theme),
            ),
            _buildFormContainer(
              theme,
              'Exit Interview Submission',
              _buildExitInterviewForm(theme),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFormContainer(
    PrimeCareThemeData theme,
    String title,
    Widget form,
  ) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(theme.spacing.xl),
      child: Center(
        child: Container(
          constraints: const BoxConstraints(maxWidth: 800),
          child: PrimeCareCard(
            padding: EdgeInsets.all(theme.spacing.xl),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: theme.typography.h4),
                SizedBox(height: theme.spacing.lg),
                form,
                SizedBox(height: theme.spacing.xl),
                SizedBox(
                  width: double.infinity,
                  child: PrimeCareButton(
                    onPressed: () {},
                    label: 'Submit for Processing',
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLeaveRequestForm(PrimeCareThemeData theme) {
    return Column(
      children: [
        PrimeCareTextField(label: 'Employee Name', placeholder: 'Enter name'),
        SizedBox(height: theme.spacing.md),
        PrimeCareTextField(
          label: 'Reason for Leave',
          placeholder: 'Describe reason',
        ),
        SizedBox(height: theme.spacing.md),
        PrimeCareTextField(label: 'Start Date', placeholder: 'YYYY-MM-DD'),
      ],
    );
  }

  Widget _buildGrievanceForm(PrimeCareThemeData theme) {
    return Column(
      children: [
        PrimeCareTextField(
          label: 'Incident Description',
          placeholder: 'Provide details',
        ),
        SizedBox(height: theme.spacing.md),
        PrimeCareTextField(
          label: 'Parties Involved',
          placeholder: 'List names',
        ),
      ],
    );
  }

  Widget _buildOnboardingForm(PrimeCareThemeData theme) {
    return Column(
      children: [
        PrimeCareTextField(label: 'Candidate ID', placeholder: 'C-XXXXX'),
        SizedBox(height: theme.spacing.md),
        PrimeCareTextField(
          label: 'Department Allocation',
          placeholder: 'Select department',
        ),
      ],
    );
  }

  Widget _buildInterviewForm(PrimeCareThemeData theme) {
    return Column(
      children: [
        PrimeCareTextField(label: 'Candidate Name', placeholder: 'Enter name'),
        SizedBox(height: theme.spacing.md),
        PrimeCareTextField(
          label: 'Panel Members',
          placeholder: 'List interviewers',
        ),
      ],
    );
  }

  Widget _buildExitInterviewForm(PrimeCareThemeData theme) {
    return Column(
      children: [
        PrimeCareTextField(
          label: 'Termination Reason',
          placeholder: 'Provide context',
        ),
        SizedBox(height: theme.spacing.md),
        PrimeCareTextField(
          label: 'Feedback Summary',
          placeholder: 'Key takeaways',
        ),
      ],
    );
  }
}

class HrFormsIntent extends PrimeCareScreen {
  HrFormsIntent() : super(title: 'HrForms');

  @override
  Widget build(BuildContext context) => const HrFormsView();
}

// --- End of hr_forms\hr_forms_view.dart ---

// --- Start of hr_hiring_dashboard\hr_hiring_dashboard_view.dart ---

class HrHiringDashboardView extends ConsumerWidget {
  const HrHiringDashboardView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = context.theme;
    final state = ref.watch(hrHiringDashboardAdapterProvider);

    return MasterLayout(
      child: state.when(
        data: (result) => result.fold(
          (viewModel) => _buildContent(context, theme, viewModel),
          (e) => DashboardErrorWidget(
            message: 'Governance Error: $e',
            onRetry: () => ref.refresh(hrFormsControllerProvider),
          ),
        ),
        loading: () => const DashboardLoadingWidget(),
        error: (e, st) => DashboardErrorWidget(
          message: 'Connection Error: $e',
          onRetry: () => ref.refresh(hrFormsControllerProvider),
        ),
      ),
    );
  }

  Widget _buildContent(
    BuildContext context,
    PrimeCareThemeData theme,
    HrHiringDashboardViewModel viewModel,
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
                    'HR Human Capital Dashboard',
                    style: theme.typography.h2,
                  ),
                  Text(
                    'Human capital, recruitment pipeline, and staff retention telemetry',
                    style: theme.typography.labelMedium,
                  ),
                ],
              ),
              const Spacer(),
              if (viewModel.isOfflineFallback) const OfflineStatusChip(),
            ],
          ),
          SizedBox(height: theme.spacing.xl),

          _buildHumanCapitalSummary(context, theme),
          SizedBox(height: theme.spacing.xl),

          PrimeCareResponsiveKpiGrid(metrics: viewModel.metrics),

          SizedBox(height: theme.spacing.xl),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 2,
                child: Column(
                  children: [
                    _buildRecruitmentPipeline(context, theme),
                    SizedBox(height: theme.spacing.xl),
                    _buildAdministrativeQueue(context, theme),
                  ],
                ),
              ),
              if (viewModel.insights.isNotEmpty) ...[
                SizedBox(width: theme.spacing.xl),
                Expanded(
                  child: _buildAuraInsightsColumn(theme, viewModel.insights),
                ),
              ],
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildHumanCapitalSummary(
    BuildContext context,
    PrimeCareThemeData theme,
  ) {
    return PrimeCareCard(
      padding: EdgeInsets.all(theme.spacing.xl),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'ORGANIZATIONAL HEALTH INDEX',
                  style: theme.typography.label.copyWith(
                    color: theme.colors.primary,
                    letterSpacing: 1.5,
                  ),
                ),
                SizedBox(height: theme.spacing.sm),
                Text('Status: Optimized', style: theme.typography.h1),
                SizedBox(height: theme.spacing.xs),
                Text(
                  'Staffing levels are at 94% of capacity. Retention has improved by 8% following the Q1 incentive program.',
                  style: theme.typography.bodyLarge.copyWith(
                    color: theme.colors.slateGray,
                  ),
                ),
              ],
            ),
          ),
          _buildGauge(theme, 0.94, 'Staff Capacity'),
        ],
      ),
    );
  }

  Widget _buildGauge(PrimeCareThemeData theme, double value, String label) {
    return SizedBox(
      width: 120,
      height: 120,
      child: Stack(
        alignment: Alignment.center,
        children: [
          CircularProgressIndicator(
            value: value,
            strokeWidth: 12,
            backgroundColor: theme.colors.surfaceContainerHighest,
            color: theme.colors.primary,
          ),
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                PrimeCareFormatters.formatPercentage(value),
                style: theme.typography.h2.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(label, style: theme.typography.labelSmall),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildRecruitmentPipeline(
    BuildContext context,
    PrimeCareThemeData theme,
  ) {
    return PrimeCareCard(
      padding: EdgeInsets.all(theme.spacing.lg),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Recruitment Pipeline', style: theme.typography.titleLarge),
          SizedBox(height: theme.spacing.md),
          _buildPipelineRow(
            theme,
            'Nursing (RN/RPN)',
            0.85,
            theme.colors.primary,
          ),
          _buildPipelineRow(
            theme,
            'Support Staff (PSW)',
            0.92,
            theme.colors.success,
          ),
          _buildPipelineRow(
            theme,
            'Clinical Admin',
            0.45,
            theme.colors.warning,
          ),
          _buildPipelineRow(theme, 'Specialist Care', 0.30, theme.colors.error),
          _buildPipelineRow(
            theme,
            'Facility Operations',
            0.70,
            theme.colors.primary,
          ),
        ],
      ),
    );
  }

  Widget _buildPipelineRow(
    PrimeCareThemeData theme,
    String role,
    double density,
    Color color,
  ) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: theme.spacing.sm),
      child: Column(
        children: [
          Row(
            children: [
              Text(
                role,
                style: theme.typography.bodyLarge.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
              const Spacer(),
              Text(
                ' ${PrimeCareFormatters.formatPercentage(density)} Fulfilled',
                style: theme.typography.label,
              ),
            ],
          ),
          SizedBox(height: theme.spacing.xs),
          LinearProgressIndicator(
            value: density,
            backgroundColor: theme.colors.surfaceContainerHighest,
            color: color,
            minHeight: 8,
            borderRadius: BorderRadius.circular(4),
          ),
        ],
      ),
    );
  }

  Widget _buildAdministrativeQueue(
    BuildContext context,
    PrimeCareThemeData theme,
  ) {
    return PrimeCareCard(
      padding: EdgeInsets.all(theme.spacing.lg),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Pending Actions', style: theme.typography.titleLarge),
          SizedBox(height: theme.spacing.md),
          _buildQueueItem(
            theme,
            'Leave Requests',
            '12',
            LucideIcons.calendar,
            theme.colors.primary,
          ),
          const Divider(),
          _buildQueueItem(
            theme,
            'Interviews Today',
            '5',
            LucideIcons.userCheck,
            theme.colors.success,
          ),
          const Divider(),
          _buildQueueItem(
            theme,
            'Expiring Certs',
            '8',
            LucideIcons.alertTriangle,
            theme.colors.warning,
          ),
          const Divider(),
          _buildQueueItem(
            theme,
            'New Hires Onboarding',
            '3',
            LucideIcons.briefcase,
            theme.colors.info,
          ),
        ],
      ),
    );
  }

  Widget _buildQueueItem(
    PrimeCareThemeData theme,
    String title,
    String value,
    IconData icon,
    Color color,
  ) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: theme.spacing.md),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(theme.spacing.sm),
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, color: color, size: 20),
          ),
          SizedBox(width: theme.spacing.md),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: theme.typography.labelSmall),
              Text(value, style: theme.typography.h3),
            ],
          ),
        ],
      ),
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

class HrHiringDashboardIntent extends PrimeCareScreen {
  HrHiringDashboardIntent() : super(title: 'HrHiringDashboard');

  @override
  Widget build(BuildContext context) => const HrHiringDashboardView();
}

// --- End of hr_hiring_dashboard\hr_hiring_dashboard_view.dart ---

// --- Start of hr_manager_dashboard\hr_manager_dashboard_view.dart ---

class HrManagerDashboardView extends ConsumerWidget {
  const HrManagerDashboardView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = context.theme;
    final state = ref.watch(hrManagerDashboardAdapterProvider);

    return MasterLayout(
      child: state.when(
        data: (result) => result.fold(
          (viewModel) => _buildContent(context, theme, viewModel),
          (e) => DashboardErrorWidget(
            message: 'Governance Error: $e',
            onRetry: () => ref.refresh(hrManagerDashboardAdapterProvider),
          ),
        ),
        loading: () => const DashboardLoadingWidget(),
        error: (e, st) => DashboardErrorWidget(
          message: 'Connection Error: $e',
          onRetry: () => ref.refresh(hrManagerDashboardAdapterProvider),
        ),
      ),
    );
  }

  Widget _buildContent(
    BuildContext context,
    PrimeCareThemeData theme,
    HumanResourcesManagerDashboardViewModel vm,
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
                  Text('Human Capital Command', style: theme.typography.h2),
                  Text(
                    'Workforce stability, payroll velocity, and compliance telemetry',
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
                    _buildStaffingVelocity(theme),
                    SizedBox(height: theme.spacing.xl),
                    const TrainingComplianceGrid(),
                    SizedBox(height: theme.spacing.xl),
                    const HiringFunnelGrid(),
                    SizedBox(height: theme.spacing.xl),
                    const HrActionHub(),
                  ],
                ),
              ),
              if (vm.insights.isNotEmpty) ...[
                SizedBox(width: theme.spacing.xl),
                Expanded(child: _buildIntelligenceSection(theme, vm.insights)),
              ],
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStaffingVelocity(PrimeCareThemeData theme) {
    return PrimeCareChartCard(
      title: LocaleKeys.dashboards_common_labels_staffing_velocity_matrix.tr(),
      chart: PrimeCareLineChart(
        chart: AnalyticsChart(
          id: 'hiring_trend',
          title: LocaleKeys.dashboards_common_labels_velocity_score.tr(),
          type: ChartType.line,
          dataPoints: [
            ChartDataPoint(label: 'Jan', value: 42),
            ChartDataPoint(label: 'Feb', value: 38),
            ChartDataPoint(label: 'Mar', value: 54),
            ChartDataPoint(label: 'Apr', value: 62),
            ChartDataPoint(label: 'May', value: 58),
            ChartDataPoint(label: 'Jun', value: 71),
          ],
        ),
      ),
    );
  }

  Widget _buildIntelligenceSection(
    PrimeCareThemeData theme,
    List<IntelligenceInsight> insights,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Capital Intelligence', style: theme.typography.h4),
        SizedBox(height: theme.spacing.md),
        Column(
          children: insights
              .map(
                (insight) => Padding(
                  padding: EdgeInsets.only(bottom: theme.spacing.md),
                  child: IntelligenceInsightCard(insight: insight),
                ),
              )
              .toList(),
        ),
      ],
    );
  }
}

class HiringFunnelGrid extends StatelessWidget {
  const HiringFunnelGrid({super.key});
  @override
  Widget build(BuildContext context) => PrimeCareCard(
    child: Center(
      child: Padding(
        padding: EdgeInsets.all(context.theme.spacing.xl),
        child: Text(
          LocaleKeys.dashboards_common_labels_active_hiring_funnel.tr(),
        ),
      ),
    ),
  );
}

class TrainingComplianceGrid extends StatelessWidget {
  const TrainingComplianceGrid({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;

    return PrimeCareCard(
      padding: EdgeInsets.all(theme.spacing.lg),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Institutional Compliance', style: theme.typography.h3),
          Text(
            'Mandatory training and certification audit status',
            style: theme.typography.labelMedium,
          ),
          SizedBox(height: theme.spacing.lg),
          PrimeCareDataTable<Map<String, String>>(
            columns: const ['Certification', 'Certified', 'Expiring', 'Status'],
            rows: [
              _buildRow('First Aid / CPR', '92%', '8', 'STABLE'),
              _buildRow('Dementia Care', '85%', '12', 'CAUTION'),
              _buildRow('WHMIS 2026', '98%', '2', 'STABLE'),
              _buildRow('Privacy Policy', '75%', '24', 'CRITICAL'),
            ],
          ),
        ],
      ),
    );
  }

  DataRow _buildRow(
    String cert,
    String certified,
    String expiring,
    String status,
  ) {
    return DataRow(
      cells: [
        DataCell(Text(cert)),
        DataCell(
          Text(certified, style: const TextStyle(fontWeight: FontWeight.bold)),
        ),
        DataCell(Text(expiring)),
        DataCell(PrimeCareBadge(text: status, type: _getBadgeType(status))),
      ],
    );
  }

  BadgeType _getBadgeType(String status) {
    switch (status) {
      case 'STABLE':
        return BadgeType.success;
      case 'CAUTION':
        return BadgeType.warning;
      case 'CRITICAL':
        return BadgeType.error;
      default:
        return BadgeType.neutral;
    }
  }
}

class HrActionHub extends StatelessWidget {
  const HrActionHub({super.key});

  @override
  Widget build(BuildContext context) {
    return PrimeCareQuickActionsGrid(
      actions: [
        PrimeCareActionItem(
          title: LocaleKeys.dashboards_common_labels_post_job.tr(),
          icon: LucideIcons.briefcase,
          route: '/hr/jobs/new',
        ),
        PrimeCareActionItem(
          title: LocaleKeys.dashboards_common_labels_approve_leave.tr(),
          icon: LucideIcons.calendarX,
          route: '/hr/leave',
        ),
        PrimeCareActionItem(
          title: LocaleKeys.dashboards_common_labels_run_payroll.tr(),
          icon: LucideIcons.banknote,
          route: '/hr/payroll',
        ),
        PrimeCareActionItem(
          title: LocaleKeys.dashboards_common_labels_audit_training.tr(),
          icon: LucideIcons.graduationCap,
          route: '/hr/training',
        ),
      ],
    );
  }
}

class HrManagerDashboardIntent extends PrimeCareScreen {
  HrManagerDashboardIntent() : super(title: 'HrManagerDashboard');

  @override
  Widget build(BuildContext context) => const HrManagerDashboardView();
}

// --- End of hr_manager_dashboard\hr_manager_dashboard_view.dart ---

// --- Start of infection_control_dashboard\infection_control_dashboard_view.dart ---

class InfectionControlDashboardView extends ConsumerWidget {
  const InfectionControlDashboardView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = context.theme;
    final state = ref.watch(infectionControlDashboardAdapterProvider);

    return MasterLayout(
      child: state.when(
        data: (result) => result.fold(
          (viewModel) => _buildContent(context, theme, viewModel),
          (e) => DashboardErrorWidget(
            message: 'Governance Error: $e',
            onRetry: () =>
                ref.refresh(infectionControlDashboardAdapterProvider),
          ),
        ),
        loading: () => const DashboardLoadingWidget(),
        error: (e, st) => DashboardErrorWidget(
          message: 'Connection Error: $e',
          onRetry: () => ref.refresh(infectionControlDashboardAdapterProvider),
        ),
      ),
    );
  }

  Widget _buildContent(
    BuildContext context,
    PrimeCareThemeData theme,
    InfectionControlDashboardViewModel vm,
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
                  Text('Public Health Hub', style: theme.typography.h2),
                  Text(
                    'Infection telemetry, outbreak tracking, and immunization status',
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
                    InfectionTelemetryHeatmap(
                      chart: vm.metrics.charts.firstWhere(
                        (c) => c.id == 'infection-telemetry',
                        orElse: () => AnalyticsChart.empty(),
                      ),
                    ),
                    SizedBox(height: theme.spacing.xl),
                    const OutbreakStatusGrid(),
                    SizedBox(height: theme.spacing.xl),
                    const InfectionActionHub(),
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

class InfectionTelemetryHeatmap extends StatelessWidget {
  final AnalyticsChart chart;

  const InfectionTelemetryHeatmap({super.key, required this.chart});

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    return PrimeCareCard(
      padding: EdgeInsets.all(theme.spacing.xl),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Infection Telemetry', style: theme.typography.h3),
              const PrimeCareBadge(text: 'LIVE', type: BadgeType.info),
            ],
          ),
          SizedBox(height: theme.spacing.lg),
          AspectRatio(
            aspectRatio: 1.7,
            child: PrimeCareLineChart(chart: chart),
          ),
        ],
      ),
    );
  }
}

class OutbreakStatusGrid extends StatelessWidget {
  const OutbreakStatusGrid({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Active Outbreak Monitoring', style: theme.typography.h3),
        SizedBox(height: theme.spacing.md),
        LayoutBuilder(
          builder: (context, constraints) {
            final crossAxisCount = constraints.maxWidth > 768 ? 2 : 1;
            return GridView.count(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisCount: crossAxisCount,
              mainAxisSpacing: theme.spacing.md,
              crossAxisSpacing: theme.spacing.md,
              childAspectRatio: 3,
              children: [
                _buildOutbreakCard(
                  context,
                  'Unit 4B - Influenza',
                  'Confirmed: 3 | Suspected: 5',
                  'QUARANTINE',
                  theme.colors.error,
                ),
                _buildOutbreakCard(
                  context,
                  'Sector 7 - MRSA',
                  'Confirmed: 1 | Suspected: 2',
                  'MONITORED',
                  theme.colors.warning,
                ),
              ],
            );
          },
        ),
      ],
    );
  }

  Widget _buildOutbreakCard(
    BuildContext context,
    String title,
    String subtitle,
    String tag,
    Color color,
  ) {
    final theme = context.theme;
    return PrimeCareCard(
      padding: EdgeInsets.all(theme.spacing.md),
      child: Row(
        children: [
          Container(
            width: 4,
            height: double.infinity,
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          SizedBox(width: theme.spacing.md),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(title, style: theme.typography.labelLarge),
                Text(subtitle, style: theme.typography.labelSmall),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(
              horizontal: theme.spacing.sm,
              vertical: theme.spacing.xs,
            ),
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(4),
              border: Border.all(color: color.withValues(alpha: 0.3)),
            ),
            child: Text(
              tag,
              style: theme.typography.labelSmall.copyWith(
                color: color,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class InfectionActionHub extends StatelessWidget {
  const InfectionActionHub({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    return Row(
      children: [
        Expanded(
          child: PrimeCareButton(
            label: 'Report Outbreak',
            onPressed: () {},
            type: PrimeCareButtonType.primary,
            icon: LucideIcons.alertTriangle,
          ),
        ),
        SizedBox(width: theme.spacing.md),
        Expanded(
          child: PrimeCareButton(
            label: 'Audit PPE',
            onPressed: () {},
            type: PrimeCareButtonType.secondary,
            icon: LucideIcons.shieldCheck,
          ),
        ),
      ],
    );
  }
}

class InfectionControlDashboardIntent extends PrimeCareScreen {
  InfectionControlDashboardIntent() : super(title: 'InfectionControlDashboard');

  @override
  Widget build(BuildContext context) => const InfectionControlDashboardView();
}

// --- End of infection_control_dashboard\infection_control_dashboard_view.dart ---

// --- Start of intake_coordinator\intake_coordinator_view.dart ---

class IntakeCoordinatorView extends ConsumerWidget {
  const IntakeCoordinatorView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(intakeCoordinatorAdapterProvider);

    return MasterLayout(
      child: state.when(
        data: (result) => result.fold(
          (viewModel) => _buildContent(context, viewModel),
          (e) => DashboardErrorWidget(
            message: 'Intake Governance Error: $e',
            onRetry: () => ref.refresh(intakeCoordinatorAdapterProvider),
          ),
        ),
        loading: () => const DashboardLoadingWidget(),
        error: (e, st) => DashboardErrorWidget(
          message: 'Connection Error: $e',
          onRetry: () => ref.refresh(intakeCoordinatorAdapterProvider),
        ),
      ),
    );
  }

  Widget _buildContent(BuildContext context, IntakeCoordinatorViewModel vm) {
    final theme = context.theme;
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
                  Text('Intake Hub', style: theme.typography.h2),
                  Text(
                    'Referral pipeline, eligibility checks, and document telemetry',
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
                    _buildActivePipelineCard(theme),
                    SizedBox(height: theme.spacing.xl),
                    _buildIntakeCharts(theme, vm),
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

  Widget _buildActivePipelineCard(PrimeCareThemeData theme) {
    return PrimeCareCard(
      padding: EdgeInsets.all(theme.spacing.xl),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Active Intake Pipeline', style: theme.typography.h4),
          SizedBox(height: theme.spacing.lg),
          const Center(
            child: Text(
              'Candidate Surveillance Active',
              style: TextStyle(fontStyle: FontStyle.italic),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildIntakeCharts(
    PrimeCareThemeData theme,
    IntakeCoordinatorViewModel vm,
  ) {
    return Column(
      children: [
        PrimeCareChartCard(
          title: 'Referral Velocity',
          chart: PrimeCareLineChart(
            chart: vm.metrics.charts.firstWhere(
              (c) => c.id == 'referral-velocity',
              orElse: () => AnalyticsChart.empty(),
            ),
          ),
        ),
      ],
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

class IntakeCoordinatorIntent extends PrimeCareScreen {
  IntakeCoordinatorIntent() : super(title: 'IntakeCoordinator');

  @override
  Widget build(BuildContext context) => const IntakeCoordinatorView();
}

// --- End of intake_coordinator\intake_coordinator_view.dart ---

// --- Start of intake_coordinator_dashboard\intake_coordinator_dashboard_view.dart ---

class IntakeCoordinatorDashboardView extends ConsumerWidget {
  const IntakeCoordinatorDashboardView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = context.theme;
    final state = ref.watch(intakeCoordinatorDashboardAdapterProvider);

    return MasterLayout(
      child: state.when(
        data: (result) => result.fold(
          (viewModel) => _buildContent(context, theme, viewModel),
          (e) => DashboardErrorWidget(
            message: 'Governance Error: $e',
            onRetry: () =>
                ref.refresh(intakeCoordinatorDashboardAdapterProvider),
          ),
        ),
        loading: () => const DashboardLoadingWidget(),
        error: (e, st) => DashboardErrorWidget(
          message: 'Connection Error: $e',
          onRetry: () => ref.refresh(intakeCoordinatorDashboardAdapterProvider),
        ),
      ),
    );
  }

  Widget _buildContent(
    BuildContext context,
    PrimeCareThemeData theme,
    IntakeCoordinatorDashboardViewModel vm,
  ) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(theme.spacing.lg),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Intake Coordinator Command Center', style: theme.typography.h2),
          SizedBox(height: theme.spacing.xl),
          PrimeCareResponsiveKpiGrid(metrics: vm.metrics),
          SizedBox(height: theme.spacing.xl),
          PrimeCareCard(
            padding: EdgeInsets.all(theme.spacing.xl),
            child: Center(
              child: Text(
                LocaleKeys.dashboards_common_labels_operational_insights.tr(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class IntakeCoordinatorDashboardIntent extends PrimeCareScreen {
  IntakeCoordinatorDashboardIntent()
    : super(title: 'IntakeCoordinatorDashboard');

  @override
  Widget build(BuildContext context) => const IntakeCoordinatorDashboardView();
}

// --- End of intake_coordinator_dashboard\intake_coordinator_dashboard_view.dart ---

// --- Start of intake_dashboard\intake_dashboard_view.dart ---

class IntakeDashboardView extends ConsumerWidget {
  const IntakeDashboardView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = context.theme;
    final state = ref.watch(intakeDashboardAdapterProvider);

    return MasterLayout(
      child: state.when(
        data: (result) => result.fold(
          (viewModel) => _buildContent(context, theme, viewModel),
          (e) => DashboardErrorWidget(
            message: 'Governance Error: $e',
            onRetry: () => ref.refresh(intakeDashboardAdapterProvider),
          ),
        ),
        loading: () => const DashboardLoadingWidget(),
        error: (e, st) => DashboardErrorWidget(
          message: 'Connection Error: $e',
          onRetry: () => ref.refresh(intakeDashboardAdapterProvider),
        ),
      ),
    );
  }

  Widget _buildContent(
    BuildContext context,
    PrimeCareThemeData theme,
    IntakeDashboardViewModel vm,
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
                  Text('Admission Command Center', style: theme.typography.h2),
                  Text(
                    'Referral pipeline telemetry, triage velocity, and admission throughput',
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
                    _buildAdmissionPipeline(theme),
                    SizedBox(height: theme.spacing.xl),
                    _buildAdmissionCharts(theme, vm),
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

  Widget _buildAdmissionPipeline(PrimeCareThemeData theme) {
    return PrimeCareCard(
      padding: EdgeInsets.all(theme.spacing.xl),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Admission Pipeline & Triage', style: theme.typography.h4),
          SizedBox(height: theme.spacing.lg),
          const Center(
            child: Text(
              'Dynamic Admission Engine Initialized',
              style: TextStyle(fontStyle: FontStyle.italic),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAdmissionCharts(
    PrimeCareThemeData theme,
    IntakeDashboardViewModel vm,
  ) {
    return Column(
      children: [
        PrimeCareChartCard(
          title: LocaleKeys.dashboards_common_labels_referral_velocity_trend
              .tr(),
          chart: PrimeCareLineChart(
            chart: vm.metrics.charts.firstWhere(
              (c) => c.id == 'referral-velocity',
              orElse: () => AnalyticsChart.empty(),
            ),
          ),
        ),
      ],
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

class IntakeDashboardIntent extends PrimeCareScreen {
  IntakeDashboardIntent() : super(title: 'IntakeDashboard');

  @override
  Widget build(BuildContext context) => const IntakeDashboardView();
}

// --- End of intake_dashboard\intake_dashboard_view.dart ---

// --- Start of it_security_dashboard\it_security_dashboard_view.dart ---

class ITSecurityDashboardView extends ConsumerWidget {
  const ITSecurityDashboardView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = context.theme;
    final state = ref.watch(itSecurityDashboardAdapterProvider);

    return MasterLayout(
      child: state.when(
        data: (result) => result.fold(
          (viewModel) => _buildContent(context, theme, viewModel),
          (e) => DashboardErrorWidget(
            message: 'Governance Error: $e',
            onRetry: () => ref.refresh(itSecurityDashboardAdapterProvider),
          ),
        ),
        loading: () => const DashboardLoadingWidget(),
        error: (e, st) => DashboardErrorWidget(
          message: 'Connection Error: $e',
          onRetry: () => ref.refresh(itSecurityDashboardAdapterProvider),
        ),
      ),
    );
  }

  Widget _buildContent(
    BuildContext context,
    PrimeCareThemeData theme,
    ITSecurityDashboardViewModel vm,
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
                  Text('Cyber Shield Command', style: theme.typography.h2),
                  Text(
                    'Real-time threat telemetry and system integrity surveillance',
                    style: theme.typography.labelMedium,
                  ),
                ],
              ),
              const Spacer(),
              if (vm.isOfflineFallback) const OfflineStatusChip(),
            ],
          ),
          SizedBox(height: theme.spacing.xl),

          // Command HUD
          Row(
            children: [
              PrimeCareChip(label: 'Threat Scan', onPressed: () {}),
              SizedBox(width: theme.spacing.sm),
              PrimeCareChip(label: 'Rotate Keys', onPressed: () {}),
              SizedBox(width: theme.spacing.sm),
              PrimeCareChip(label: 'Purge Cache', onPressed: () {}),
              const Spacer(),
              PrimeCareChip(
                label: 'Emergency Lockdown',
                color: theme.colors.error,
                onPressed: () {},
              ),
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
                    PrimeCareChartCard(
                      title: LocaleKeys
                          .dashboards_common_labels_security_matrix__block_velocity
                          .tr(),
                      chart: PrimeCareLineChart(
                        chart: AnalyticsChart(
                          id: 'block-velocity',
                          title: LocaleKeys
                              .dashboards_common_labels_block_velocity
                              .tr(),
                          type: ChartType.line,
                          dataPoints: [
                            ChartDataPoint(label: '00:00', value: 45),
                            ChartDataPoint(label: '04:00', value: 52),
                            ChartDataPoint(label: '08:00', value: 48),
                            ChartDataPoint(label: '12:00', value: 61),
                            ChartDataPoint(label: '16:00', value: 55),
                            ChartDataPoint(label: '20:00', value: 68),
                            ChartDataPoint(label: '23:59', value: 72),
                          ],
                        ),
                        lineColor: Colors.cyanAccent,
                      ),
                    ),
                    SizedBox(height: theme.spacing.xl),
                    PrimeCareSectionHeader(
                      title: LocaleKeys
                          .dashboards_common_labels_security_audit_trail
                          .tr(),
                    ),
                    SizedBox(height: theme.spacing.md),
                    PrimeCareDataTable<dynamic>(
                      columns: const ['Timestamp', 'Event', 'Origin', 'Status'],
                      rows:
                          [
                                [
                                  '10:45 AM',
                                  'SSL Handshake Success',
                                  'ONT-NODE-04',
                                  'Verified',
                                ],
                                [
                                  '10:42 AM',
                                  'Brute Force Blocked',
                                  '192.168.1.104',
                                  'Neutralized',
                                ],
                                [
                                  '10:38 AM',
                                  'Kernel Patch Applied',
                                  'SYS-CORE-01',
                                  'Success',
                                ],
                                [
                                  '10:35 AM',
                                  'Key Rotation Scheduled',
                                  'SYSTEM',
                                  'Pending',
                                ],
                              ]
                              .map(
                                (row) => DataRow(
                                  cells: row
                                      .map((cell) => DataCell(Text(cell)))
                                      .toList(),
                                ),
                              )
                              .toList(),
                    ),
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

class ITSecurityDashboardIntent extends PrimeCareScreen {
  ITSecurityDashboardIntent() : super(title: 'ITSecurityDashboard');

  @override
  Widget build(BuildContext context) => const ITSecurityDashboardView();
}

// --- End of it_security_dashboard\it_security_dashboard_view.dart ---

// --- Start of local_marketing_manager_dashboard\local_marketing_manager_dashboard_view.dart ---

class LocalMarketingManagerDashboardView extends ConsumerWidget {
  const LocalMarketingManagerDashboardView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = context.theme;
    final state = ref.watch(localMarketingManagerDashboardAdapterProvider);

    return MasterLayout(
      child: state.when(
        data: (result) => result.fold(
          (viewModel) => _buildContent(
            context,
            theme,
            viewModel as LocalMarketingManagerDashboardViewModel,
          ),
          (e) => DashboardErrorWidget(
            message: 'Governance Error: $e',
            onRetry: () =>
                ref.refresh(localMarketingManagerDashboardAdapterProvider),
          ),
        ),
        loading: () => const DashboardLoadingWidget(),
        error: (e, st) => DashboardErrorWidget(
          message: 'Connection Error: $e',
          onRetry: () =>
              ref.refresh(localMarketingManagerDashboardAdapterProvider),
        ),
      ),
    );
  }

  Widget _buildContent(
    BuildContext context,
    PrimeCareThemeData theme,
    LocalMarketingManagerDashboardViewModel viewModel,
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
                    LocaleKeys.command_center_labels_marketing_center.tr(),
                    style: theme.typography.h2,
                  ),
                  Text(
                    'Growth telemetry, campaign ROI, and lead conversion velocity',
                    style: theme.typography.labelMedium,
                  ),
                ],
              ),
              const Spacer(),
              if (viewModel.isOfflineFallback) const OfflineStatusChip(),
            ],
          ),
          SizedBox(height: theme.spacing.xl),

          PrimeCareResponsiveKpiGrid(metrics: viewModel.metrics),
          SizedBox(height: theme.spacing.xl),

          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 2,
                child: Column(
                  children: [
                    _buildCampaignPerformance(context, theme),
                    SizedBox(height: theme.spacing.xl),
                    _buildLeadConversionFunnel(context, theme),
                  ],
                ),
              ),
              if (viewModel.insights.isNotEmpty) ...[
                SizedBox(width: theme.spacing.xl),
                Expanded(
                  child: _buildAuraInsightsColumn(theme, viewModel.insights),
                ),
              ],
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildCampaignPerformance(
    BuildContext context,
    PrimeCareThemeData theme,
  ) {
    return PrimeCareCard(
      padding: EdgeInsets.all(theme.spacing.lg),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Active Campaign ROI', style: theme.typography.titleLarge),
          SizedBox(height: theme.spacing.md),
          _buildPerformanceRow(
            theme,
            'Senior Living Expo',
            0.85,
            theme.colors.success,
          ),
          _buildPerformanceRow(
            theme,
            'Facebook Outreach',
            0.62,
            theme.colors.primary,
          ),
          _buildPerformanceRow(
            theme,
            'Local Print Ads',
            0.45,
            theme.colors.warning,
          ),
          _buildPerformanceRow(
            theme,
            'Community Referral',
            0.91,
            theme.colors.info,
          ),
        ],
      ),
    );
  }

  Widget _buildPerformanceRow(
    PrimeCareThemeData theme,
    String name,
    double value,
    Color color,
  ) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: theme.spacing.sm),
      child: Column(
        children: [
          Row(
            children: [
              Text(name, style: theme.typography.bodyLarge),
              const Spacer(),
              Text(
                '${(value * 10).toStringAsFixed(1)}x ROI',
                style: theme.typography.label,
              ),
            ],
          ),
          SizedBox(height: theme.spacing.xs),
          LinearProgressIndicator(
            value: value,
            backgroundColor: theme.colors.surfaceContainerHighest,
            color: color,
            minHeight: 8,
            borderRadius: BorderRadius.circular(4),
          ),
        ],
      ),
    );
  }

  Widget _buildLeadConversionFunnel(
    BuildContext context,
    PrimeCareThemeData theme,
  ) {
    return PrimeCareCard(
      padding: EdgeInsets.all(theme.spacing.lg),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Conversion Velocity', style: theme.typography.titleLarge),
          SizedBox(height: theme.spacing.md),
          _buildFunnelStep(theme, 'New Leads', 124, theme.colors.primary),
          _buildFunnelStep(theme, 'Qualified', 85, theme.colors.info),
          _buildFunnelStep(theme, 'Assessment', 42, theme.colors.warning),
          _buildFunnelStep(theme, 'Contracted', 18, theme.colors.success),
        ],
      ),
    );
  }

  Widget _buildFunnelStep(
    PrimeCareThemeData theme,
    String step,
    int count,
    Color color,
  ) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: theme.spacing.sm),
      child: Row(
        children: [
          Container(
            width: 4,
            height: 32,
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          SizedBox(width: theme.spacing.md),
          Text(step, style: theme.typography.bodyLarge),
          const Spacer(),
          Text(
            count.toString(),
            style: theme.typography.h4.copyWith(color: color),
          ),
        ],
      ),
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

class LocalMarketingManagerDashboardIntent extends PrimeCareScreen {
  LocalMarketingManagerDashboardIntent()
    : super(title: 'LocalMarketingManagerDashboard');

  @override
  Widget build(BuildContext context) =>
      const LocalMarketingManagerDashboardView();
}

// --- End of local_marketing_manager_dashboard\local_marketing_manager_dashboard_view.dart ---

// --- Start of marketing_manager\marketing_manager_dashboard_view.dart ---

class MarketingManagerDashboardView extends ConsumerWidget {
  const MarketingManagerDashboardView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = context.theme;
    final state = ref.watch(marketingManagerDashboardAdapterProvider);

    return MasterLayout(
      child: state.when(
        data: (result) => result.fold(
          (viewModel) => _buildContent(context, theme, viewModel),
          (e) => DashboardErrorWidget(
            message: 'Governance Error: $e',
            onRetry: () =>
                ref.refresh(marketingManagerDashboardAdapterProvider),
          ),
        ),
        loading: () => const DashboardLoadingWidget(),
        error: (e, st) => DashboardErrorWidget(
          message: 'Connection Error: $e',
          onRetry: () => ref.refresh(marketingManagerDashboardAdapterProvider),
        ),
      ),
    );
  }

  Widget _buildContent(
    BuildContext context,
    PrimeCareThemeData theme,
    MarketingManagerDashboardViewModel viewModel,
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
                  Text('Growth & Branding Hub', style: theme.typography.h2),
                  Text(
                    'Global campaign performance and brand intelligence telemetry',
                    style: theme.typography.labelMedium,
                  ),
                ],
              ),
              const Spacer(),
              if (viewModel.isOfflineFallback) const OfflineStatusChip(),
            ],
          ),
          SizedBox(height: theme.spacing.xl),

          PrimeCareResponsiveKpiGrid(metrics: viewModel.metrics),
          SizedBox(height: theme.spacing.xl),

          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 2,
                child: Column(children: [_buildCampaignFunnel(context, theme)]),
              ),
              if (viewModel.insights.isNotEmpty) ...[
                SizedBox(width: theme.spacing.xl),
                Expanded(
                  child: _buildAuraInsightsColumn(theme, viewModel.insights),
                ),
              ],
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildCampaignFunnel(BuildContext context, PrimeCareThemeData theme) {
    return PrimeCareCard(
      padding: EdgeInsets.all(theme.spacing.lg),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            LocaleKeys.dashboards_common_labels_campaign_conversion_funnel.tr(),
            style: theme.typography.titleLarge,
          ),
          SizedBox(height: theme.spacing.xl),
          _buildFunnelStage(
            theme,
            'Awareness',
            '1.2M',
            1.0,
            theme.colors.primary.withValues(alpha: 0.2),
          ),
          _buildFunnelStage(
            theme,
            'Interest',
            '450K',
            0.37,
            theme.colors.primary.withValues(alpha: 0.4),
          ),
          _buildFunnelStage(
            theme,
            'Consideration',
            '120K',
            0.10,
            theme.colors.primary.withValues(alpha: 0.6),
          ),
          _buildFunnelStage(
            theme,
            'Conversion',
            '12.5K',
            0.01,
            theme.colors.primary,
          ),
        ],
      ),
    );
  }

  Widget _buildFunnelStage(
    PrimeCareThemeData theme,
    String label,
    String value,
    double factor,
    Color color,
  ) {
    return Padding(
      padding: EdgeInsets.only(bottom: theme.spacing.md),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                label,
                style: theme.typography.bodyLarge.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                value,
                style: theme.typography.bodyLarge.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          SizedBox(height: theme.spacing.xs),
          Container(
            height: 12,
            width: double.infinity,
            decoration: BoxDecoration(
              color: theme.colors.surfaceContainerHighest,
              borderRadius: BorderRadius.circular(6),
            ),
            child: FractionallySizedBox(
              alignment: Alignment.centerLeft,
              widthFactor: factor,
              child: Container(
                decoration: BoxDecoration(
                  color: color,
                  borderRadius: BorderRadius.circular(6),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAuraInsightsColumn(
    PrimeCareThemeData theme,
    List<IntelligenceInsight> insights,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Brand Intelligence', style: theme.typography.h4),
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

class MarketingManagerDashboardIntent extends PrimeCareScreen {
  MarketingManagerDashboardIntent() : super(title: 'MarketingManagerDashboard');

  @override
  Widget build(BuildContext context) => const MarketingManagerDashboardView();
}

// --- End of marketing_manager\marketing_manager_dashboard_view.dart ---

// --- Start of marketing_manager\marketing_manager_view.dart ---

class MarketingManagerView extends ConsumerWidget {
  const MarketingManagerView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = context.theme;
    final state = ref.watch(marketingManagerControllerProvider);

    return MasterLayout(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Marketing Performance Hub', style: theme.typography.h3),
        ),
        body: Padding(
          padding: EdgeInsets.all(theme.spacing.xl),
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: PrimeCareCard(
                      child: ListTile(
                        title: const Text('Active Campaigns'),
                        subtitle: Text(
                          '${state.activeCampaigns}',
                          style: theme.typography.h2,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: theme.spacing.md),
                  Expanded(
                    child: PrimeCareCard(
                      child: ListTile(
                        title: const Text('Lead Conversions'),
                        subtitle: Text(
                          '${state.leadConversions}',
                          style: theme.typography.h2,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: theme.spacing.xl),
              PrimeCareButton(onPressed: () {}, label: 'Launch New Campaign'),
            ],
          ),
        ),
      ),
    );
  }
}

class MarketingManagerIntent extends PrimeCareScreen {
  MarketingManagerIntent() : super(title: 'MarketingManager');

  @override
  Widget build(BuildContext context) => const MarketingManagerView();
}

// --- End of marketing_manager\marketing_manager_view.dart ---

// --- Start of operations_manager_dashboard\operations_manager_dashboard_view.dart ---

class OperationsManagerDashboardView extends ConsumerWidget {
  const OperationsManagerDashboardView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = context.theme;
    final state = ref.watch(operationsManagerDashboardAdapterProvider);

    return MasterLayout(
      child: state.when(
        data: (result) => result.fold(
          (viewModel) => _buildContent(
            context,
            theme,
            viewModel as OperationsManagerDashboardViewModel,
          ),
          (e) => DashboardErrorWidget(
            message: 'Governance Error: $e',
            onRetry: () => ref.refresh(marketingManagerControllerProvider),
          ),
        ),
        loading: () => const DashboardLoadingWidget(),
        error: (e, st) => DashboardErrorWidget(
          message: 'Connection Error: $e',
          onRetry: () => ref.refresh(marketingManagerControllerProvider),
        ),
      ),
    );
  }

  Widget _buildContent(
    BuildContext context,
    PrimeCareThemeData theme,
    OperationsManagerDashboardViewModel viewModel,
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
                  if (viewModel.isOfflineFallback) const OfflineStatusChip(),
                ],
              ),
            ],
          ),
          SizedBox(height: theme.spacing.xl),

          _buildOpsContinuitySummary(context, theme),
          SizedBox(height: theme.spacing.xl),

          PrimeCareResponsiveKpiGrid(metrics: viewModel.metrics),
          SizedBox(height: theme.spacing.xl),

          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 2,
                child: Column(
                  children: [
                    _buildInventoryDistribution(context, theme),
                    SizedBox(height: theme.spacing.xl),
                    _buildMaintenanceLog(context, theme),
                  ],
                ),
              ),
              if (viewModel.insights.isNotEmpty) ...[
                SizedBox(width: theme.spacing.xl),
                Expanded(
                  child: _buildAuraInsightsColumn(theme, viewModel.insights),
                ),
              ],
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildOpsContinuitySummary(
    BuildContext context,
    PrimeCareThemeData theme,
  ) {
    return PrimeCareCard(
      padding: EdgeInsets.all(theme.spacing.xl),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'OPERATIONAL CONTINUITY SCORE',
                  style: theme.typography.label.copyWith(
                    color: theme.colors.primary,
                    letterSpacing: 1.5,
                  ),
                ),
                SizedBox(height: theme.spacing.sm),
                Text('Status: Highly Stable', style: theme.typography.h1),
                SizedBox(height: theme.spacing.xs),
                Text(
                  'Facility uptime is at 99.8%. Supply chain routes are optimized with no critical shortages detected in the last 48 hours.',
                  style: theme.typography.bodyLarge.copyWith(
                    color: theme.colors.slateGray,
                  ),
                ),
              ],
            ),
          ),
          _buildGauge(theme, 0.99, 'System Uptime'),
        ],
      ),
    );
  }

  Widget _buildGauge(PrimeCareThemeData theme, double value, String label) {
    return SizedBox(
      width: 120,
      height: 120,
      child: Stack(
        alignment: Alignment.center,
        children: [
          CircularProgressIndicator(
            value: value,
            strokeWidth: 12,
            backgroundColor: theme.colors.surfaceContainerHighest,
            color: theme.colors.success,
          ),
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                PrimeCareFormatters.formatPercentage(value),
                style: theme.typography.h2.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(label, style: theme.typography.labelSmall),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildInventoryDistribution(
    BuildContext context,
    PrimeCareThemeData theme,
  ) {
    return PrimeCareCard(
      padding: EdgeInsets.all(theme.spacing.lg),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Key Inventory Categories', style: theme.typography.titleLarge),
          SizedBox(height: theme.spacing.md),
          _buildInventoryRow(
            theme,
            'Medical Consumables',
            0.88,
            theme.colors.primary,
          ),
          _buildInventoryRow(
            theme,
            'Pharmaceutical Stock',
            0.95,
            theme.colors.success,
          ),
          _buildInventoryRow(
            theme,
            'PPE & Safety Gear',
            0.62,
            theme.colors.warning,
          ),
          _buildInventoryRow(
            theme,
            'Sanitization Supplies',
            0.78,
            theme.colors.primary,
          ),
          _buildInventoryRow(
            theme,
            'Facility Spares',
            0.45,
            theme.colors.error,
          ),
        ],
      ),
    );
  }

  Widget _buildInventoryRow(
    PrimeCareThemeData theme,
    String category,
    double level,
    Color color,
  ) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: theme.spacing.sm),
      child: Column(
        children: [
          Row(
            children: [
              Text(
                category,
                style: theme.typography.bodyLarge.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
              const Spacer(),
              Text(
                ' ${PrimeCareFormatters.formatPercentage(level)} Stock',
                style: theme.typography.label,
              ),
            ],
          ),
          SizedBox(height: theme.spacing.xs),
          LinearProgressIndicator(
            value: level,
            backgroundColor: theme.colors.surfaceContainerHighest,
            color: color,
            minHeight: 8,
            borderRadius: BorderRadius.circular(4),
          ),
        ],
      ),
    );
  }

  Widget _buildMaintenanceLog(BuildContext context, PrimeCareThemeData theme) {
    return PrimeCareCard(
      padding: EdgeInsets.all(theme.spacing.lg),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Facility Maintenance', style: theme.typography.titleLarge),
          SizedBox(height: theme.spacing.md),
          _buildLogItem(
            theme,
            'HVAC Periodic Service',
            'In Progress',
            LucideIcons.wind,
            theme.colors.primary,
          ),
          const Divider(),
          _buildLogItem(
            theme,
            'Generator Test',
            'Completed',
            LucideIcons.zap,
            theme.colors.success,
          ),
          const Divider(),
          _buildLogItem(
            theme,
            'Elevator Repair (West)',
            'Urgent',
            LucideIcons.arrowUpCircle,
            theme.colors.error,
          ),
          const Divider(),
          _buildLogItem(
            theme,
            'IT Node Migration',
            'Scheduled',
            LucideIcons.server,
            theme.colors.info,
          ),
        ],
      ),
    );
  }

  Widget _buildLogItem(
    PrimeCareThemeData theme,
    String task,
    String status,
    IconData icon,
    Color color,
  ) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: theme.spacing.md),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(theme.spacing.sm),
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, color: color, size: 20),
          ),
          SizedBox(width: theme.spacing.md),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                task,
                style: theme.typography.bodyLarge.copyWith(
                  fontWeight: FontWeight.w500,
                ),
              ),
              Text(
                status,
                style: theme.typography.labelSmall.copyWith(color: color),
              ),
            ],
          ),
        ],
      ),
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

class OperationsManagerDashboardIntent extends PrimeCareScreen {
  OperationsManagerDashboardIntent()
    : super(title: 'OperationsManagerDashboard');

  @override
  Widget build(BuildContext context) => const OperationsManagerDashboardView();
}

// --- End of operations_manager_dashboard\operations_manager_dashboard_view.dart ---

// --- Start of owner_dashboard\owner_dashboard_view.dart ---

class OwnerDashboardView extends ConsumerWidget {
  const OwnerDashboardView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = context.theme;
    final state = ref.watch(ownerDashboardAdapterProvider);

    return MasterLayout(
      child: state.when(
        data: (result) => result.fold(
          (viewModel) => _buildContent(
            context,
            theme,
            viewModel as OwnerDashboardViewModel,
          ),
          (e) => DashboardErrorWidget(
            message: 'Owner Governance Error: $e',
            onRetry: () => ref.refresh(ownerDashboardAdapterProvider),
          ),
        ),
        loading: () => const DashboardLoadingWidget(),
        error: (e, st) => DashboardErrorWidget(
          message: 'Connection Error: $e',
          onRetry: () => ref.refresh(ownerDashboardAdapterProvider),
        ),
      ),
    );
  }

  Widget _buildContent(
    BuildContext context,
    PrimeCareThemeData theme,
    OwnerDashboardViewModel vm,
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
                  Text('Owner Command Center', style: theme.typography.h2),
                  Text(
                    'Enterprise valuation, EBITDA velocity, and global compliance',
                    style: theme.typography.labelMedium,
                  ),
                ],
              ),
              const Spacer(),
              if (vm.isOfflineFallback) const OfflineStatusChip(),
            ],
          ),
          SizedBox(height: theme.spacing.xl),

          GovernedWidget(
            subsystem: PlatformSubsystem.metrics,
            child: PrimeCareResponsiveKpiGrid(metrics: vm.metrics),
          ),
          SizedBox(height: theme.spacing.xl),

          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 2,
                child: Column(
                  children: [
                    PrimeCareCard(
                      padding: EdgeInsets.all(theme.spacing.xl),
                      child: const Center(
                        child: Text(
                          'Operational Insights Unified',
                          style: TextStyle(fontStyle: FontStyle.italic),
                        ),
                      ),
                    ),
                    SizedBox(height: theme.spacing.xl),
                    _buildSecondaryCharts(theme, vm),
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

  Widget _buildSecondaryCharts(
    PrimeCareThemeData theme,
    OwnerDashboardViewModel vm,
  ) {
    return Column(
      children: [
        PrimeCareChartCard(
          title: LocaleKeys.dashboards_common_labels_enterprise_valuation_trend
              .tr(),
          chart: PrimeCareLineChart(
            chart: vm.metrics.charts.firstWhere(
              (c) => c.id == 'valuation-trend',
              orElse: () => AnalyticsChart.empty(),
            ),
          ),
        ),
      ],
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
            child: GovernedWidget(
              subsystem: PlatformSubsystem.auraAI,
              child: IntelligenceInsightCard(insight: insight),
            ),
          ),
        ),
      ],
    );
  }
}

class OwnerDashboardIntent extends PrimeCareScreen {
  OwnerDashboardIntent() : super(title: 'OwnerDashboard');

  @override
  Widget build(BuildContext context) => const OwnerDashboardView();
}

// --- End of owner_dashboard\owner_dashboard_view.dart ---

// --- Start of partnership_manager_dashboard\partnership_manager_dashboard_view.dart ---

class PartnershipManagerDashboardView extends ConsumerWidget {
  const PartnershipManagerDashboardView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = context.theme;
    final state = ref.watch(partnershipManagerDashboardAdapterProvider);

    return MasterLayout(
      child: state.when(
        data: (result) => result.fold(
          (viewModel) => _buildContent(
            context,
            theme,
            viewModel as PartnershipManagerDashboardViewModel,
          ),
          (e) => DashboardErrorWidget(
            message: 'Partnership Governance Error: $e',
            onRetry: () =>
                ref.refresh(partnershipManagerDashboardAdapterProvider),
          ),
        ),
        loading: () => const DashboardLoadingWidget(),
        error: (e, st) => DashboardErrorWidget(
          message: 'Connection Error: $e',
          onRetry: () =>
              ref.refresh(partnershipManagerDashboardAdapterProvider),
        ),
      ),
    );
  }

  Widget _buildContent(
    BuildContext context,
    PrimeCareThemeData theme,
    PartnershipManagerDashboardViewModel vm,
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
                    'Partnership Command Center',
                    style: theme.typography.h2,
                  ),
                  Text(
                    'Partner referrals, conversion rates, and active deal pipeline telemetry',
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
                    _buildPartnerNetworkMatrix(theme),
                    SizedBox(height: theme.spacing.xl),
                    _buildPartnershipCharts(theme, vm),
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

  Widget _buildPartnerNetworkMatrix(PrimeCareThemeData theme) {
    return PrimeCareCard(
      padding: EdgeInsets.all(theme.spacing.xl),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Partner Synergy Network', style: theme.typography.h4),
          SizedBox(height: theme.spacing.lg),
          const Center(
            child: Text(
              'Relationship Analytics Surveillance Active',
              style: TextStyle(fontStyle: FontStyle.italic),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPartnershipCharts(
    PrimeCareThemeData theme,
    PartnershipManagerDashboardViewModel vm,
  ) {
    return Column(
      children: [
        PrimeCareChartCard(
          title: LocaleKeys
              .dashboards_common_labels_referral_conversion_velocity
              .tr(),
          chart: PrimeCareLineChart(
            chart: vm.metrics.charts.firstWhere(
              (c) => c.id == 'conversion-velocity',
              orElse: () => AnalyticsChart.empty(),
            ),
          ),
        ),
      ],
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

class PartnershipManagerDashboardIntent extends PrimeCareScreen {
  PartnershipManagerDashboardIntent()
    : super(title: 'PartnershipManagerDashboard');

  @override
  Widget build(BuildContext context) => const PartnershipManagerDashboardView();
}

// --- End of partnership_manager_dashboard\partnership_manager_dashboard_view.dart ---

// --- Start of patient_dashboard\patient_dashboard_view.dart ---

class PatientDashboardView extends ConsumerWidget {
  const PatientDashboardView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = context.theme;
    final state = ref.watch(patientDashboardAdapterProvider);
    final controller = PatientDashboardController(ref);

    return MasterLayout(
      child: state.when(
        data: (result) => result.fold(
          (viewModel) => _buildContent(
            context,
            theme,
            viewModel as PatientDashboardViewModel,
            controller,
          ),
          (e) => DashboardErrorWidget(
            message: 'Patient Error: $e',
            onRetry: () => ref.refresh(patientDashboardAdapterProvider),
          ),
        ),
        loading: () => const DashboardLoadingWidget(),
        error: (e, st) => DashboardErrorWidget(
          message: 'Connection Error: $e',
          onRetry: () => ref.refresh(patientDashboardAdapterProvider),
        ),
      ),
    );
  }

  Widget _buildContent(
    BuildContext context,
    PrimeCareThemeData theme,
    PatientDashboardViewModel vm,
    PatientDashboardController controller,
  ) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(theme.spacing.lg),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Patient Command Center', style: theme.typography.h2),
                  Text(
                    'Personal wellness and care plan overview',
                    style: theme.typography.bodyLarge,
                  ),
                ],
              ),
              IconButton(
                icon: const Icon(Icons.refresh),
                onPressed: controller.refresh,
              ),
            ],
          ),
          SizedBox(height: theme.spacing.xl),
          PrimeCareResponsiveKpiGrid(metrics: vm.metrics),
          SizedBox(height: theme.spacing.xl),
          const PatientActionHub(),
          SizedBox(height: theme.spacing.xl),
          const CarePlanProgressGrid(),
        ],
      ),
    );
  }
}

class CarePlanProgressGrid extends StatelessWidget {
  const CarePlanProgressGrid({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;

    return PrimeCareCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Care Plan Progress', style: theme.typography.h3),
          Text(
            'Real-time tracking of wellness goals and clinical milestones',
            style: theme.typography.labelMedium,
          ),
          SizedBox(height: theme.spacing.lg),
          PrimeCareDataTable<Map<String, String>>(
            columns: const ['Goal', 'Milestone', 'Progress', 'Status'],
            rows: [
              _buildRow('Mobility', 'Daily Walk', '80%', 'SUCCESS'),
              _buildRow('Nutrition', 'Diet Compliance', '100%', 'SUCCESS'),
              _buildRow('Hydration', 'Fluids Target', '65%', 'INFO'),
              _buildRow('Medication', 'Daily Regimen', '100%', 'SUCCESS'),
            ],
          ),
        ],
      ),
    );
  }

  DataRow _buildRow(
    String goal,
    String milestone,
    String progress,
    String status,
  ) {
    return DataRow(
      cells: [
        DataCell(Text(goal)),
        DataCell(Text(milestone)),
        DataCell(
          Text(progress, style: const TextStyle(fontWeight: FontWeight.bold)),
        ),
        DataCell(
          PrimeCareBadge(
            text: status,
            type: status == 'SUCCESS' ? BadgeType.success : BadgeType.info,
          ),
        ),
      ],
    );
  }
}

class PatientActionHub extends StatelessWidget {
  const PatientActionHub({super.key});

  @override
  Widget build(BuildContext context) {
    return PrimeCareQuickActionsGrid(
      actions: [
        PrimeCareActionItem(
          title: LocaleKeys.dashboards_common_labels_request_meds.tr(),
          icon: LucideIcons.pill,
          route: '/patient/meds/request',
        ),
        PrimeCareActionItem(
          title: LocaleKeys.dashboards_common_labels_message_nurse.tr(),
          icon: LucideIcons.messageSquare,
          route: '/patient/messages',
        ),
        PrimeCareActionItem(
          title: LocaleKeys.dashboards_common_labels_care_plan.tr(),
          icon: LucideIcons.fileText,
          route: '/patient/care-plan',
        ),
        PrimeCareActionItem(
          title: LocaleKeys.dashboards_common_labels_vitals_log.tr(),
          icon: LucideIcons.activity,
          route: '/patient/vitals',
        ),
      ],
    );
  }
}

class PatientDashboardIntent extends PrimeCareScreen {
  PatientDashboardIntent() : super(title: 'PatientDashboard');

  @override
  Widget build(BuildContext context) => const PatientDashboardView();
}

// --- End of patient_dashboard\patient_dashboard_view.dart ---

// --- Start of physiotherapist\physiotherapist_view.dart ---

class PhysiotherapistView extends ConsumerWidget {
  const PhysiotherapistView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = context.theme;
    final state = ref.watch(physiotherapistControllerProvider);

    return MasterLayout(
      child: Scaffold(
        appBar: AppBar(title: Text(state.title, style: theme.typography.h3)),
        body: Padding(
          padding: EdgeInsets.all(theme.spacing.xl),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Rehabilitation Schedule', style: theme.typography.h4),
              SizedBox(height: theme.spacing.md),
              Expanded(
                child: ListView.builder(
                  itemCount: state.sessions.length,
                  itemBuilder: (context, index) {
                    return PrimeCareCard(
                      margin: EdgeInsets.only(bottom: theme.spacing.md),
                      child: ListTile(
                        leading: const Icon(Icons.fitness_center),
                        title: Text(state.sessions[index]),
                        trailing: PrimeCareButton.secondary(
                          onPressed: () {},
                          label: 'Patient Summary',
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class PhysiotherapistIntent extends PrimeCareScreen {
  PhysiotherapistIntent() : super(title: 'Physiotherapist');

  @override
  Widget build(BuildContext context) => const PhysiotherapistView();
}

// --- End of physiotherapist\physiotherapist_view.dart ---

// --- Start of psw\psw_view.dart ---

class PswView extends ConsumerWidget {
  const PswView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(pswAdapterProvider);

    return MasterLayout(
      child: state.when(
        data: (result) => result.fold(
          (viewModel) => _buildContent(context, viewModel),
          (e) => DashboardErrorWidget(
            message: 'PSW Sync Error: $e',
            onRetry: () => ref.refresh(physiotherapistControllerProvider),
          ),
        ),
        loading: () => const DashboardLoadingWidget(),
        error: (e, st) => DashboardErrorWidget(
          message: 'Connection Error: $e',
          onRetry: () => ref.refresh(physiotherapistControllerProvider),
        ),
      ),
    );
  }

  Widget _buildContent(BuildContext context, PswViewModel vm) {
    final theme = context.theme;
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
                    'Personal Support Worker Hub',
                    style: theme.typography.h2,
                  ),
                  Text(
                    'Direct care telemetry and patient support insights',
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
          _buildTaskMatrix(theme),
        ],
      ),
    );
  }

  Widget _buildTaskMatrix(PrimeCareThemeData theme) {
    return PrimeCareCard(
      padding: EdgeInsets.all(theme.spacing.xl),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Active Care Tasks', style: theme.typography.h4),
          SizedBox(height: theme.spacing.lg),
          const Center(child: Text('No active tasks assigned.')),
        ],
      ),
    );
  }
}

class PswIntent extends PrimeCareScreen {
  PswIntent() : super(title: 'Psw');

  @override
  Widget build(BuildContext context) => const PswView();
}

// --- End of psw\psw_view.dart ---

// --- Start of psw_dashboard\psw_dashboard_view.dart ---

class PswDashboardView extends ConsumerWidget {
  const PswDashboardView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = context.theme;
    final state = ref.watch(pswDashboardAdapterProvider);

    return MasterLayout(
      child: state.when(
        data: (result) => result.fold(
          (viewModel) => _buildContent(context, theme, viewModel),
          (e) => DashboardErrorWidget(
            message: 'Governance Error: $e',
            onRetry: () => ref.refresh(pswDashboardAdapterProvider),
          ),
        ),
        loading: () => const DashboardLoadingWidget(),
        error: (e, st) => DashboardErrorWidget(
          message: 'Connection Error: $e',
          onRetry: () => ref.refresh(pswDashboardAdapterProvider),
        ),
      ),
    );
  }

  Widget _buildContent(
    BuildContext context,
    PrimeCareThemeData theme,
    PswDashboardViewModel viewModel,
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
                  Text('PSW Command Center', style: theme.typography.h2),
                  Text(
                    'Personal support workflow and care delivery telemetry',
                    style: theme.typography.labelMedium,
                  ),
                ],
              ),
              const Spacer(),
              if (viewModel.isOfflineFallback) const OfflineStatusChip(),
            ],
          ),
          SizedBox(height: theme.spacing.xl),

          PrimeCareResponsiveKpiGrid(metrics: viewModel.metrics),
          SizedBox(height: theme.spacing.xl),

          PrimeCareCard(
            padding: EdgeInsets.all(theme.spacing.xl),
            child: Center(
              child: Text(
                LocaleKeys.dashboards_common_labels_operational_insights.tr(),
                style: theme.typography.bodyLarge,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class PswDashboardIntent extends PrimeCareScreen {
  PswDashboardIntent() : super(title: 'PswDashboard');

  @override
  Widget build(BuildContext context) => const PswDashboardView();
}

// --- End of psw_dashboard\psw_dashboard_view.dart ---

// --- Start of qa_dashboard\qa_dashboard_view.dart ---

class QaDashboardView extends ConsumerWidget {
  const QaDashboardView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = context.theme;
    final state = ref.watch(qaDashboardAdapterProvider);

    return MasterLayout(
      child: state.when(
        data: (result) => result.fold(
          (viewModel) => _buildContent(context, theme, viewModel),
          (e) => DashboardErrorWidget(
            message: 'Governance Error: $e',
            onRetry: () => ref.refresh(qaDashboardAdapterProvider),
          ),
        ),
        loading: () => const DashboardLoadingWidget(),
        error: (e, st) => DashboardErrorWidget(
          message: 'Connection Error: $e',
          onRetry: () => ref.refresh(qaDashboardAdapterProvider),
        ),
      ),
    );
  }

  Widget _buildContent(
    BuildContext context,
    PrimeCareThemeData theme,
    QaDashboardViewModel viewModel,
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
                  Text('Quality Assurance Hub', style: theme.typography.h2),
                  Text(
                    'Regulatory compliance, audit telemetry, and clinical incident surveillance',
                    style: theme.typography.labelMedium,
                  ),
                ],
              ),
              const Spacer(),
              if (viewModel.isOfflineFallback) const OfflineStatusChip(),
            ],
          ),
          SizedBox(height: theme.spacing.xl),

          PrimeCareResponsiveKpiGrid(metrics: viewModel.metrics),
          SizedBox(height: theme.spacing.xl),

          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 2,
                child: Column(
                  children: [
                    _buildComplianceDetails(theme),
                    SizedBox(height: theme.spacing.xl),
                    _buildComplianceCharts(theme, viewModel),
                  ],
                ),
              ),
              if (viewModel.insights.isNotEmpty) ...[
                SizedBox(width: theme.spacing.xl),
                Expanded(
                  child: _buildAuraInsightsColumn(theme, viewModel.insights),
                ),
              ],
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildComplianceDetails(PrimeCareThemeData theme) {
    return PrimeCareCard(
      padding: EdgeInsets.all(theme.spacing.xl),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Audit Coverage Heatmap - Active Units',
            style: theme.typography.h4,
          ),
          SizedBox(height: theme.spacing.lg),
          const Center(
            child: Text(
              'QA Compliance Engine Initialized',
              style: TextStyle(fontStyle: FontStyle.italic),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildComplianceCharts(
    PrimeCareThemeData theme,
    QaDashboardViewModel viewModel,
  ) {
    return Column(
      children: [
        PrimeCareChartCard(
          title: LocaleKeys.dashboards_common_labels_regulatory_compliance_trend
              .tr(),
          chart: PrimeCareLineChart(
            chart: viewModel.metrics.charts.firstWhere(
              (c) => c.id == 'compliance-trend',
              orElse: () => AnalyticsChart.empty(),
            ),
          ),
        ),
      ],
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

class QaDashboardIntent extends PrimeCareScreen {
  QaDashboardIntent() : super(title: 'QaDashboard');

  @override
  Widget build(BuildContext context) => const QaDashboardView();
}

// --- End of qa_dashboard\qa_dashboard_view.dart ---

// --- Start of quality_assurance_dashboard\quality_assurance_dashboard_view.dart ---

class QualityAssuranceDashboardView extends ConsumerWidget {
  const QualityAssuranceDashboardView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = context.theme;
    final state = ref.watch(qualityAssuranceDashboardAdapterProvider);

    return MasterLayout(
      child: state.when(
        data: (result) => result.fold(
          (viewModel) => _buildContent(context, theme, viewModel),
          (e) => DashboardErrorWidget(
            message: 'Governance Error: $e',
            onRetry: () =>
                ref.refresh(qualityAssuranceDashboardAdapterProvider),
          ),
        ),
        loading: () => const DashboardLoadingWidget(),
        error: (e, st) => DashboardErrorWidget(
          message: 'Connection Error: $e',
          onRetry: () => ref.refresh(qualityAssuranceDashboardAdapterProvider),
        ),
      ),
    );
  }

  Widget _buildContent(
    BuildContext context,
    PrimeCareThemeData theme,
    QualityAssuranceDashboardViewModel viewModel,
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
                    'Quality Assurance Command Center',
                    style: theme.typography.h2,
                  ),
                  Text(
                    'Regulatory oversight and clinical quality telemetry',
                    style: theme.typography.labelMedium,
                  ),
                ],
              ),
              const Spacer(),
              if (viewModel.isOfflineFallback) const OfflineStatusChip(),
            ],
          ),
          SizedBox(height: theme.spacing.xl),

          PrimeCareResponsiveKpiGrid(metrics: viewModel.metrics),
          SizedBox(height: theme.spacing.xl),

          PrimeCareCard(
            padding: EdgeInsets.all(theme.spacing.xl),
            child: Center(
              child: Text(
                LocaleKeys.dashboards_common_labels_operational_insights.tr(),
                style: theme.typography.bodyLarge,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class QualityAssuranceDashboardIntent extends PrimeCareScreen {
  QualityAssuranceDashboardIntent() : super(title: 'QualityAssuranceDashboard');

  @override
  Widget build(BuildContext context) => const QualityAssuranceDashboardView();
}

// --- End of quality_assurance_dashboard\quality_assurance_dashboard_view.dart ---

// --- Start of receptionist_dashboard\receptionist_dashboard_view.dart ---

class ReceptionistDashboardView extends ConsumerWidget {
  const ReceptionistDashboardView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = context.theme;
    final state = ref.watch(receptionistDashboardAdapterProvider);

    return MasterLayout(
      child: state.when(
        data: (result) => result.fold(
          (viewModel) => _buildContent(context, theme, viewModel),
          (e) => DashboardErrorWidget(
            message: 'Governance Error: $e',
            onRetry: () => ref.refresh(receptionistDashboardAdapterProvider),
          ),
        ),
        loading: () => const DashboardLoadingWidget(),
        error: (e, st) => DashboardErrorWidget(
          message: 'Connection Error: $e',
          onRetry: () => ref.refresh(receptionistDashboardAdapterProvider),
        ),
      ),
    );
  }

  Widget _buildContent(
    BuildContext context,
    PrimeCareThemeData theme,
    ReceptionistDashboardViewModel viewModel,
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
                    'Receptionist Command Center',
                    style: theme.typography.h2,
                  ),
                  Text(
                    'Front-desk operations and visitor management telemetry',
                    style: theme.typography.labelMedium,
                  ),
                ],
              ),
              const Spacer(),
              if (viewModel.isOfflineFallback) const OfflineStatusChip(),
            ],
          ),
          SizedBox(height: theme.spacing.xl),

          PrimeCareResponsiveKpiGrid(metrics: viewModel.metrics),
          SizedBox(height: theme.spacing.xl),

          PrimeCareCard(
            padding: EdgeInsets.all(theme.spacing.xl),
            child: Center(
              child: Text(
                LocaleKeys.dashboards_common_labels_operational_insights.tr(),
                style: theme.typography.bodyLarge,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ReceptionistDashboardIntent extends PrimeCareScreen {
  ReceptionistDashboardIntent() : super(title: 'ReceptionistDashboard');

  @override
  Widget build(BuildContext context) => const ReceptionistDashboardView();
}

// --- End of receptionist_dashboard\receptionist_dashboard_view.dart ---

// --- Start of regional_bdm_dashboard\regional_bdm_dashboard_view.dart ---

class RegionalBdmDashboardView extends ConsumerWidget {
  const RegionalBdmDashboardView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = context.theme;
    final state = ref.watch(regionalBdmDashboardAdapterProvider);

    return MasterLayout(
      child: state.when(
        data: (result) => result.fold(
          (viewModel) => _buildContent(
            context,
            theme,
            viewModel as RegionalBdmDashboardViewModel,
          ),
          (e) => DashboardErrorWidget(
            message: 'Governance Error: $e',
            onRetry: () => ref.refresh(regionalBdmDashboardAdapterProvider),
          ),
        ),
        loading: () => const DashboardLoadingWidget(),
        error: (e, st) => DashboardErrorWidget(
          message: 'Connection Error: $e',
          onRetry: () => ref.refresh(regionalBdmDashboardAdapterProvider),
        ),
      ),
    );
  }

  Widget _buildContent(
    BuildContext context,
    PrimeCareThemeData theme,
    RegionalBdmDashboardViewModel viewModel,
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
                    'Regional BDM Command Center',
                    style: theme.typography.h2,
                  ),
                  Text(
                    'Regional business development and growth telemetry',
                    style: theme.typography.labelMedium,
                  ),
                ],
              ),
              const Spacer(),
              if (viewModel.isOfflineFallback) const OfflineStatusChip(),
            ],
          ),
          SizedBox(height: theme.spacing.xl),

          PrimeCareResponsiveKpiGrid(metrics: viewModel.metrics),
          SizedBox(height: theme.spacing.xl),

          PrimeCareCard(
            padding: EdgeInsets.all(theme.spacing.xl),
            child: Center(
              child: Text(
                LocaleKeys.dashboards_common_labels_operational_insights.tr(),
                style: theme.typography.bodyLarge,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class RegionalBdmDashboardIntent extends PrimeCareScreen {
  RegionalBdmDashboardIntent() : super(title: 'RegionalBdmDashboard');

  @override
  Widget build(BuildContext context) => const RegionalBdmDashboardView();
}

// --- End of regional_bdm_dashboard\regional_bdm_dashboard_view.dart ---

// --- Start of regional_manager\regional_manager_dashboard_view.dart ---

class RegionalManagerDashboardView extends ConsumerWidget {
  const RegionalManagerDashboardView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = context.theme;
    final state = ref.watch(regionalManagerDashboardAdapterProvider);

    return MasterLayout(
      child: state.when(
        data: (result) => result.fold(
          (viewModel) => _buildContent(context, theme, viewModel),
          (e) => DashboardErrorWidget(
            message: 'Governance Error: $e',
            onRetry: () => ref.refresh(regionalManagerDashboardAdapterProvider),
          ),
        ),
        loading: () => const DashboardLoadingWidget(),
        error: (e, st) => DashboardErrorWidget(
          message: 'Connection Error: $e',
          onRetry: () => ref.refresh(regionalManagerDashboardAdapterProvider),
        ),
      ),
    );
  }

  Widget _buildContent(
    BuildContext context,
    PrimeCareThemeData theme,
    RegionalManagerDashboardViewModel viewModel,
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
                  Text('Regional Oversight Hub', style: theme.typography.h2),
                  Text(
                    'Territory performance, franchise health, and expansion telemetry',
                    style: theme.typography.labelMedium,
                  ),
                ],
              ),
              const Spacer(),
              if (viewModel.isOfflineFallback) const OfflineStatusChip(),
            ],
          ),
          SizedBox(height: theme.spacing.xl),

          PrimeCareResponsiveKpiGrid(metrics: viewModel.metrics),
          SizedBox(height: theme.spacing.xl),

          Text(
            'Franchise Performance Matrix',
            style: theme.typography.titleLarge,
          ),
          SizedBox(height: theme.spacing.md),
          _buildFranchiseGrid(theme),
          SizedBox(height: theme.spacing.xl),

          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 2,
                child: Column(children: [_buildGrowthMap(theme)]),
              ),
              if (viewModel.insights.isNotEmpty) ...[
                SizedBox(width: theme.spacing.xl),
                Expanded(
                  child: _buildAuraInsightsColumn(theme, viewModel.insights),
                ),
              ],
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildFranchiseGrid(PrimeCareThemeData theme) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
        childAspectRatio: 2.5,
      ),
      itemCount: 6,
      itemBuilder: (context, index) => PrimeCareCard(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            CircleAvatar(
              backgroundColor: theme.colors.primary,
              child: const Icon(Icons.business, color: Colors.white, size: 16),
            ),
            const SizedBox(width: 12),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Franchise #${100 + index}',
                  style: theme.typography.bodyLarge.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  'Active • 98% CSAT',
                  style: theme.typography.labelSmall.copyWith(
                    color: theme.colors.success,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildGrowthMap(PrimeCareThemeData theme) {
    return PrimeCareCard(
      padding: EdgeInsets.all(theme.spacing.lg),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            LocaleKeys.dashboards_common_labels_territory_growth_map.tr(),
            style: theme.typography.titleLarge,
          ),
          SizedBox(height: theme.spacing.md),
          Container(
            height: 300,
            decoration: BoxDecoration(
              color: theme.colors.surfaceContainerHighest,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Center(
              child: Icon(
                Icons.public,
                size: 64,
                color: theme.colors.primary.withValues(alpha: 0.5),
              ),
            ),
          ),
        ],
      ),
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

class RegionalManagerDashboardIntent extends PrimeCareScreen {
  RegionalManagerDashboardIntent() : super(title: 'RegionalManagerDashboard');

  @override
  Widget build(BuildContext context) => const RegionalManagerDashboardView();
}

// --- End of regional_manager\regional_manager_dashboard_view.dart ---

// --- Start of regional_manager_ontario_dashboard\regional_manager_ontario_dashboard_view.dart ---

class RegionalManagerOntarioDashboardView extends ConsumerWidget {
  const RegionalManagerOntarioDashboardView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = context.theme;
    final state = ref.watch(regionalManagerOntarioDashboardAdapterProvider);

    return MasterLayout(
      child: state.when(
        data: (result) => result.fold(
          (viewModel) => _buildContent(context, theme, viewModel),
          (e) => DashboardErrorWidget(
            message: 'Ontario Governance Error: $e',
            onRetry: () =>
                ref.refresh(regionalManagerOntarioDashboardAdapterProvider),
          ),
        ),
        loading: () => const DashboardLoadingWidget(),
        error: (e, st) => DashboardErrorWidget(
          message: 'Connection Error: $e',
          onRetry: () =>
              ref.refresh(regionalManagerOntarioDashboardAdapterProvider),
        ),
      ),
    );
  }

  Widget _buildContent(
    BuildContext context,
    PrimeCareThemeData theme,
    RegionalManagerOntarioDashboardViewModel viewModel,
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
                    'Regional Command Center: Ontario',
                    style: theme.typography.h2,
                  ),
                  Text(
                    'OHIP billing velocity, LHIN compliance, and regional retention tracking',
                    style: theme.typography.labelMedium,
                  ),
                ],
              ),
              const Spacer(),
              if (viewModel.isOfflineFallback) const OfflineStatusChip(),
            ],
          ),
          SizedBox(height: theme.spacing.xl),

          GovernedWidget(
            subsystem: PlatformSubsystem.metrics,
            child: PrimeCareResponsiveKpiGrid(metrics: viewModel.metrics),
          ),
          SizedBox(height: theme.spacing.xl),

          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 2,
                child: Column(
                  children: [
                    PrimeCareCard(
                      padding: EdgeInsets.all(theme.spacing.xl),
                      child: const Center(
                        child: Text(
                          'Regional Operational Insights Unified',
                          style: TextStyle(fontStyle: FontStyle.italic),
                        ),
                      ),
                    ),
                    SizedBox(height: theme.spacing.xl),
                    _buildRegionalCharts(theme, viewModel),
                  ],
                ),
              ),
              if (viewModel.insights.isNotEmpty) ...[
                SizedBox(width: theme.spacing.xl),
                Expanded(
                  child: _buildAuraInsightsColumn(theme, viewModel.insights),
                ),
              ],
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildRegionalCharts(
    PrimeCareThemeData theme,
    RegionalManagerOntarioDashboardViewModel viewModel,
  ) {
    return Column(
      children: [
        PrimeCareChartCard(
          title: LocaleKeys.dashboards_common_labels_regional_ohip_velocity
              .tr(),
          chart: PrimeCareLineChart(
            chart: viewModel.metrics.charts.firstWhere(
              (c) => c.id == 'ohip-velocity',
              orElse: () => AnalyticsChart.empty(),
            ),
          ),
        ),
      ],
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
            child: GovernedWidget(
              subsystem: PlatformSubsystem.auraAI,
              child: IntelligenceInsightCard(insight: insight),
            ),
          ),
        ),
      ],
    );
  }
}

class RegionalManagerOntarioDashboardIntent extends PrimeCareScreen {
  RegionalManagerOntarioDashboardIntent()
    : super(title: 'RegionalManagerOntarioDashboard');

  @override
  Widget build(BuildContext context) =>
      const RegionalManagerOntarioDashboardView();
}

// --- End of regional_manager_ontario_dashboard\regional_manager_ontario_dashboard_view.dart ---

// --- Start of regional_manager_usa_dashboard\regional_manager_usa_dashboard_view.dart ---

class RegionalManagerUsaDashboardView extends ConsumerWidget {
  const RegionalManagerUsaDashboardView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = context.theme;
    final state = ref.watch(regionalManagerUsaDashboardAdapterProvider);

    return MasterLayout(
      child: state.when(
        data: (result) => result.fold(
          (viewModel) => _buildContent(
            context,
            theme,
            viewModel as RegionalManagerUsaDashboardViewModel,
          ),
          (e) => DashboardErrorWidget(
            message: 'USA Governance Error: $e',
            onRetry: () =>
                ref.refresh(regionalManagerUsaDashboardAdapterProvider),
          ),
        ),
        loading: () => const DashboardLoadingWidget(),
        error: (e, st) => DashboardErrorWidget(
          message: 'Connection Error: $e',
          onRetry: () =>
              ref.refresh(regionalManagerUsaDashboardAdapterProvider),
        ),
      ),
    );
  }

  Widget _buildContent(
    BuildContext context,
    PrimeCareThemeData theme,
    RegionalManagerUsaDashboardViewModel viewModel,
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
                    'Regional Command Center: USA',
                    style: theme.typography.h2,
                  ),
                  Text(
                    'Operational insights, KPI tracking, and regional telemetry',
                    style: theme.typography.labelMedium,
                  ),
                ],
              ),
              const Spacer(),
              if (viewModel.isOfflineFallback) const OfflineStatusChip(),
            ],
          ),
          SizedBox(height: theme.spacing.xl),

          PrimeCareResponsiveKpiGrid(metrics: viewModel.metrics),
          SizedBox(height: theme.spacing.xl),

          PrimeCareCard(
            padding: EdgeInsets.all(theme.spacing.xl),
            child: Center(
              child: Text(
                LocaleKeys.dashboards_common_labels_operational_insights.tr(),
                style: theme.typography.bodyLarge.copyWith(
                  fontStyle: FontStyle.italic,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class RegionalManagerUsaDashboardIntent extends PrimeCareScreen {
  RegionalManagerUsaDashboardIntent()
    : super(title: 'RegionalManagerUsaDashboard');

  @override
  Widget build(BuildContext context) => const RegionalManagerUsaDashboardView();
}

// --- End of regional_manager_usa_dashboard\regional_manager_usa_dashboard_view.dart ---

// --- Start of region_dashboard\region_dashboard_view.dart ---

class RegionDashboardView extends ConsumerWidget {
  const RegionDashboardView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncData = ref.watch(regionDashboardAdapterProvider);

    return PageTemplate(
      title: LocaleKeys.dashboards_common_labels_regional_dashboard.tr(),
      subtitle: LocaleKeys
          .dashboards_common_labels_regional_performance_overview
          .tr(),
      actions: [
        IconButton(
          icon: const Icon(Icons.refresh),
          onPressed: () => ref.refresh(regionDashboardAdapterProvider),
        ),
      ],
      body: asyncData.when(
        data: (result) => result.fold(
          (data) => SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                PrimeCareResponsiveKpiGrid(
                  children: data.kpis
                      .map(
                        (kpi) => PrimeCareKpiCard(
                          title: kpi.title,
                          value: kpi.value,
                          subtitle: kpi.subtitle ?? '',
                          icon: _getIconForMetric(kpi.title),
                          onPinToggle: () {},
                        ),
                      )
                      .toList(),
                ),
              ],
            ),
          ),
          (error) => Center(child: Text(error.toString())),
        ),
        loading: () => const PrimeCareSkeleton(),
        error: (e, s) => Center(child: Text(e.toString())),
      ),
    );
  }

  IconData _getIconForMetric(String title) {
    final t = title.toLowerCase();
    if (t.contains('growth')) return Icons.trending_up_outlined;
    if (t.contains('density')) return Icons.map_outlined;
    if (t.contains('resource')) return Icons.people_outline;
    if (t.contains('compliance')) return Icons.gavel_outlined;
    return Icons.analytics_outlined;
  }
}

class RegionDashboardIntent extends PrimeCareScreen {
  RegionDashboardIntent() : super(title: 'RegionDashboard');

  @override
  Widget build(BuildContext context) => const RegionDashboardView();
}

// --- End of region_dashboard\region_dashboard_view.dart ---

// --- Start of rmt_dashboard\rmt_dashboard_view.dart ---

class RmtDashboardView extends ConsumerWidget {
  const RmtDashboardView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = context.theme;
    final state = ref.watch(rmtDashboardAdapterProvider);

    return MasterLayout(
      child: state.when(
        data: (result) => result.fold(
          (viewModel) => _buildContent(context, theme, viewModel),
          (e) => DashboardErrorWidget(
            message: 'RMT Governance Error: $e',
            onRetry: () => ref.refresh(regionDashboardAdapterProvider),
          ),
        ),
        loading: () => const DashboardLoadingWidget(),
        error: (e, st) => DashboardErrorWidget(
          message: 'Connection Error: $e',
          onRetry: () => ref.refresh(regionDashboardAdapterProvider),
        ),
      ),
    );
  }

  Widget _buildContent(
    BuildContext context,
    PrimeCareThemeData theme,
    RmtDashboardViewModel viewModel,
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
                  Text('RMT Command Center', style: theme.typography.h2),
                  Text(
                    'Therapeutic outcomes, schedule density, and clinical telemetry',
                    style: theme.typography.labelMedium,
                  ),
                ],
              ),
              const Spacer(),
              if (viewModel.isOfflineFallback) const OfflineStatusChip(),
            ],
          ),
          SizedBox(height: theme.spacing.xl),

          PrimeCareResponsiveKpiGrid(metrics: viewModel.metrics),
          SizedBox(height: theme.spacing.xl),

          PrimeCareCard(
            padding: EdgeInsets.all(theme.spacing.xl),
            child: Center(
              child: Text(
                LocaleKeys.dashboards_common_labels_operational_insights.tr(),
                style: theme.typography.bodyLarge.copyWith(
                  fontStyle: FontStyle.italic,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class RmtDashboardIntent extends PrimeCareScreen {
  RmtDashboardIntent() : super(title: 'RmtDashboard');

  @override
  Widget build(BuildContext context) => const RmtDashboardView();
}

// --- End of rmt_dashboard\rmt_dashboard_view.dart ---

// --- Start of rn\rn_view.dart ---

class RnView extends ConsumerWidget {
  const RnView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(rnAdapterProvider);

    return MasterLayout(
      child: state.when(
        data: (result) => result.fold(
          (viewModel) => _buildContent(context, viewModel),
          (e) => DashboardErrorWidget(
            message: 'RN Sync Error: $e',
            onRetry: () => ref.refresh(rnAdapterProvider),
          ),
        ),
        loading: () => const DashboardLoadingWidget(),
        error: (e, st) => DashboardErrorWidget(
          message: 'Connection Error: $e',
          onRetry: () => ref.refresh(rnAdapterProvider),
        ),
      ),
    );
  }

  Widget _buildContent(BuildContext context, RnViewModel vm) {
    final theme = context.theme;
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
                  Text('Registered Nurse Hub', style: theme.typography.h2),
                  Text(
                    'Clinical surveillance and critical care orchestration',
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
          _buildClinicalMatrix(theme),
        ],
      ),
    );
  }

  Widget _buildClinicalMatrix(PrimeCareThemeData theme) {
    return PrimeCareCard(
      padding: EdgeInsets.all(theme.spacing.xl),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Critical Care Surveillance', style: theme.typography.h4),
          SizedBox(height: theme.spacing.lg),
          const Center(
            child: Text('All patient vitals within normal parameters.'),
          ),
        ],
      ),
    );
  }
}

class RnIntent extends PrimeCareScreen {
  RnIntent() : super(title: 'Rn');

  @override
  Widget build(BuildContext context) => const RnView();
}

// --- End of rn\rn_view.dart ---

// --- Start of rn_dashboard\rn_dashboard_view.dart ---

class RnDashboardView extends ConsumerWidget {
  const RnDashboardView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = context.theme;
    final state = ref.watch(rnDashboardAdapterProvider);

    return MasterLayout(
      child: state.when(
        data: (result) => result.fold(
          (viewModel) => _buildContent(context, theme, viewModel),
          (e) => DashboardErrorWidget(
            message: 'Governance Error: $e',
            onRetry: () => ref.refresh(rnDashboardAdapterProvider),
          ),
        ),
        loading: () => const DashboardLoadingWidget(),
        error: (e, st) => DashboardErrorWidget(
          message: 'Connection Error: $e',
          onRetry: () => ref.refresh(rnDashboardAdapterProvider),
        ),
      ),
    );
  }

  Widget _buildContent(
    BuildContext context,
    PrimeCareThemeData theme,
    RnDashboardViewModel viewModel,
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
                  Text('RN Command Center', style: theme.typography.h2),
                  Text(
                    'Clinical oversight and nursing workflow telemetry',
                    style: theme.typography.labelMedium,
                  ),
                ],
              ),
              const Spacer(),
              if (viewModel.isOfflineFallback) const OfflineStatusChip(),
            ],
          ),
          SizedBox(height: theme.spacing.xl),

          PrimeCareResponsiveKpiGrid(metrics: viewModel.metrics),
          SizedBox(height: theme.spacing.xl),

          PrimeCareCard(
            padding: EdgeInsets.all(theme.spacing.xl),
            child: Center(
              child: Text(
                LocaleKeys.dashboards_common_labels_operational_insights.tr(),
                style: theme.typography.bodyLarge,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class RnDashboardIntent extends PrimeCareScreen {
  RnDashboardIntent() : super(title: 'RnDashboard');

  @override
  Widget build(BuildContext context) => const RnDashboardView();
}

// --- End of rn_dashboard\rn_dashboard_view.dart ---

// --- Start of rpn\rpn_view.dart ---

class RpnView extends ConsumerWidget {
  const RpnView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(rpnAdapterProvider);

    return MasterLayout(
      child: state.when(
        data: (result) => result.fold(
          (viewModel) => _buildContent(context, viewModel),
          (e) => DashboardErrorWidget(
            message: 'RPN Sync Error: $e',
            onRetry: () => ref.refresh(rpnAdapterProvider),
          ),
        ),
        loading: () => const DashboardLoadingWidget(),
        error: (e, st) => DashboardErrorWidget(
          message: 'Connection Error: $e',
          onRetry: () => ref.refresh(rpnAdapterProvider),
        ),
      ),
    );
  }

  Widget _buildContent(BuildContext context, RpnViewModel vm) {
    final theme = context.theme;
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
                    'Registered Practical Nurse Hub',
                    style: theme.typography.h2,
                  ),
                  Text(
                    'Practical clinical telemetry and nursing support',
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
          _buildPracticalClinicalMatrix(theme),
        ],
      ),
    );
  }

  Widget _buildPracticalClinicalMatrix(PrimeCareThemeData theme) {
    return PrimeCareCard(
      padding: EdgeInsets.all(theme.spacing.xl),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Medication Administration Surveillance',
            style: theme.typography.h4,
          ),
          SizedBox(height: theme.spacing.lg),
          const Center(child: Text('All medication rounds are on schedule.')),
        ],
      ),
    );
  }
}

class RpnIntent extends PrimeCareScreen {
  RpnIntent() : super(title: 'Rpn');

  @override
  Widget build(BuildContext context) => const RpnView();
}

// --- End of rpn\rpn_view.dart ---

// --- Start of scheduler_dashboard\scheduler_dashboard_view.dart ---

class SchedulerDashboardView extends ConsumerWidget {
  const SchedulerDashboardView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = context.theme;
    final state = ref.watch(schedulerDashboardAdapterProvider);

    return MasterLayout(
      child: state.when(
        data: (result) => result.fold(
          (viewModel) => _buildContent(context, theme, viewModel),
          (e) => DashboardErrorWidget(
            message: 'Logistics Error: $e',
            onRetry: () => ref.refresh(schedulerDashboardAdapterProvider),
          ),
        ),
        loading: () => const DashboardLoadingWidget(),
        error: (e, st) => DashboardErrorWidget(
          message: 'Connection Error: $e',
          onRetry: () => ref.refresh(schedulerDashboardAdapterProvider),
        ),
      ),
    );
  }

  Widget _buildContent(
    BuildContext context,
    PrimeCareThemeData theme,
    SchedulerDashboardViewModel viewModel,
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
                  Text('Logistics Command Center', style: theme.typography.h2),
                  Text(
                    'Staffing velocity, shift coverage, and travel optimization telemetry',
                    style: theme.typography.labelMedium,
                  ),
                ],
              ),
              const Spacer(),
              if (viewModel.isOfflineFallback) const OfflineStatusChip(),
            ],
          ),
          SizedBox(height: theme.spacing.xl),

          PrimeCareResponsiveKpiGrid(metrics: viewModel.metrics),
          SizedBox(height: theme.spacing.xl),

          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 2,
                child: Column(
                  children: [
                    _buildLogisticsCard(theme),
                    SizedBox(height: theme.spacing.xl),
                    _buildStaffingCharts(theme, viewModel),
                  ],
                ),
              ),
              if (viewModel.insights.isNotEmpty) ...[
                SizedBox(width: theme.spacing.xl),
                Expanded(
                  child: _buildAuraInsightsColumn(theme, viewModel.insights),
                ),
              ],
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildLogisticsCard(PrimeCareThemeData theme) {
    return PrimeCareCard(
      padding: EdgeInsets.all(theme.spacing.xl),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Staffing Grid - Active Clusters', style: theme.typography.h4),
          SizedBox(height: theme.spacing.lg),
          const Center(
            child: Text(
              'Dynamic Logistics Engine Initialized',
              style: TextStyle(fontStyle: FontStyle.italic),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStaffingCharts(
    PrimeCareThemeData theme,
    SchedulerDashboardViewModel viewModel,
  ) {
    return Column(
      children: [
        PrimeCareChartCard(
          title: LocaleKeys.dashboards_common_labels_shift_coverage_velocity
              .tr(),
          chart: PrimeCareLineChart(
            chart: viewModel.metrics.charts.firstWhere(
              (c) => c.id == 'coverage-velocity',
              orElse: () => AnalyticsChart.empty(),
            ),
          ),
        ),
      ],
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

class SchedulerDashboardIntent extends PrimeCareScreen {
  SchedulerDashboardIntent() : super(title: 'SchedulerDashboard');

  @override
  Widget build(BuildContext context) => const SchedulerDashboardView();
}

// --- End of scheduler_dashboard\scheduler_dashboard_view.dart ---

// --- Start of scrum_master_dashboard\scrum_master_dashboard_view.dart ---

class ScrumMasterDashboardView extends ConsumerWidget {
  const ScrumMasterDashboardView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = context.theme;
    final state = ref.watch(scrumMasterDashboardAdapterProvider);

    return MasterLayout(
      child: state.when(
        data: (result) => result.fold(
          (viewModel) => _buildContent(context, theme, viewModel),
          (e) => DashboardErrorWidget(
            message: 'Agile Governance Error: $e',
            onRetry: () => ref.refresh(scrumMasterDashboardAdapterProvider),
          ),
        ),
        loading: () => const DashboardLoadingWidget(),
        error: (e, st) => DashboardErrorWidget(
          message: 'Connection Error: $e',
          onRetry: () => ref.refresh(scrumMasterDashboardAdapterProvider),
        ),
      ),
    );
  }

  Widget _buildContent(
    BuildContext context,
    PrimeCareThemeData theme,
    ScrumMasterDashboardViewModel viewModel,
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
                  Text('Agile Command Center', style: theme.typography.h2),
                  Text(
                    'Sprint velocity, burndown telemetry, and delivery risk analysis',
                    style: theme.typography.labelMedium,
                  ),
                ],
              ),
              const Spacer(),
              if (viewModel.isOfflineFallback) const OfflineStatusChip(),
            ],
          ),
          SizedBox(height: theme.spacing.xl),

          PrimeCareResponsiveKpiGrid(metrics: viewModel.metrics),
          SizedBox(height: theme.spacing.xl),

          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 2,
                child: Column(
                  children: [
                    _buildAgileVelocityCard(theme),
                    SizedBox(height: theme.spacing.xl),
                    _buildDeliveryCharts(theme, viewModel),
                  ],
                ),
              ),
              if (viewModel.insights.isNotEmpty) ...[
                SizedBox(width: theme.spacing.xl),
                Expanded(
                  child: _buildAuraInsightsColumn(theme, viewModel.insights),
                ),
              ],
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildAgileVelocityCard(PrimeCareThemeData theme) {
    return PrimeCareCard(
      padding: EdgeInsets.all(theme.spacing.xl),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Sprint Burndown - Active Cycle', style: theme.typography.h4),
          SizedBox(height: theme.spacing.lg),
          const Center(
            child: Text(
              'Dynamic Agile Engine Initialized',
              style: TextStyle(fontStyle: FontStyle.italic),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDeliveryCharts(
    PrimeCareThemeData theme,
    ScrumMasterDashboardViewModel viewModel,
  ) {
    return Column(
      children: [
        PrimeCareChartCard(
          title: LocaleKeys.dashboards_common_labels_sprint_velocity_trend.tr(),
          chart: PrimeCareLineChart(
            chart: viewModel.metrics.charts.firstWhere(
              (c) => c.id == 'sprint-velocity',
              orElse: () => AnalyticsChart.empty(),
            ),
          ),
        ),
      ],
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

class ScrumMasterDashboardIntent extends PrimeCareScreen {
  ScrumMasterDashboardIntent() : super(title: 'ScrumMasterDashboard');

  @override
  Widget build(BuildContext context) => const ScrumMasterDashboardView();
}

// --- End of scrum_master_dashboard\scrum_master_dashboard_view.dart ---

// --- Start of shareholder_intelligence\shareholder_intelligence_view.dart ---

class ShareholderIntelligenceView extends ConsumerWidget {
  const ShareholderIntelligenceView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(shareholderIntelligenceAdapterProvider);

    return MasterLayout(
      child: state.when(
        data: (result) => result.fold(
          (viewModel) => _buildContent(context, viewModel),
          (e) => DashboardErrorWidget(
            message: 'Governance Error: $e',
            onRetry: () => ref.refresh(shareholderIntelligenceAdapterProvider),
          ),
        ),
        loading: () => const DashboardLoadingWidget(),
        error: (e, st) => DashboardErrorWidget(
          message: 'Connection Error: $e',
          onRetry: () => ref.refresh(shareholderIntelligenceAdapterProvider),
        ),
      ),
    );
  }

  Widget _buildContent(
    BuildContext context,
    ShareholderIntelligenceViewModel vm,
  ) {
    final theme = context.theme;
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
                    'Shareholder Intelligence Hub',
                    style: theme.typography.h2,
                  ),
                  Text(
                    'Equity telemetry, valuation analytics, and dividend surveillance',
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
                    _buildEquityMatrixCard(theme),
                    SizedBox(height: theme.spacing.xl),
                    _buildShareholderCharts(theme, vm),
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

  Widget _buildEquityMatrixCard(PrimeCareThemeData theme) {
    return PrimeCareCard(
      padding: EdgeInsets.all(theme.spacing.xl),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Equity Ownership Matrix', style: theme.typography.h4),
          SizedBox(height: theme.spacing.lg),
          const Center(
            child: Text(
              'Valuation Engine Active',
              style: TextStyle(fontStyle: FontStyle.italic),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildShareholderCharts(
    PrimeCareThemeData theme,
    ShareholderIntelligenceViewModel vm,
  ) {
    return Column(
      children: [
        PrimeCareChartCard(
          title: 'Valuation Trend',
          chart: PrimeCareLineChart(
            chart: vm.metrics.charts.firstWhere(
              (c) => c.id == 'valuation-trend',
              orElse: () => AnalyticsChart.empty(),
            ),
          ),
        ),
      ],
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

class ShareholderIntelligenceIntent extends PrimeCareScreen {
  ShareholderIntelligenceIntent() : super(title: 'ShareholderIntelligence');

  @override
  Widget build(BuildContext context) => const ShareholderIntelligenceView();
}

// --- End of shareholder_intelligence\shareholder_intelligence_view.dart ---

// --- Start of sign_in_view\sign_in_view.dart ---

class SignInView extends ConsumerWidget {
  const SignInView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ClinicalGlassPanel(
      title: LocaleKeys.dashboards_common_labels_sign_in_page_view.tr(),
      child: PrimeCareCard(
        child: Text(
          LocaleKeys
              .dashboards_common_labels_operational_sector__sign_in_page_view
              .tr(),
        ),
      ),
    );
  }
}

class SignInIntent extends PrimeCareScreen {
  SignInIntent() : super(title: 'SignIn');

  @override
  Widget build(BuildContext context) => const SignInView();
}

// --- End of sign_in_view\sign_in_view.dart ---

// --- Start of sign_out_view\sign_out_view.dart ---

class SignOutView extends ConsumerWidget {
  const SignOutView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ClinicalGlassPanel(
      title: LocaleKeys.dashboards_common_labels_sign_out_page_view.tr(),
      child: PrimeCareCard(
        child: Text(
          LocaleKeys
              .dashboards_common_labels_operational_sector__sign_out_page_view
              .tr(),
        ),
      ),
    );
  }
}

class SignOutIntent extends PrimeCareScreen {
  SignOutIntent() : super(title: 'SignOut');

  @override
  Widget build(BuildContext context) => const SignOutView();
}

// --- End of sign_out_view\sign_out_view.dart ---

// --- Start of sign_up_view\sign_up_view.dart ---

class SignUpView extends ConsumerWidget {
  const SignUpView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ClinicalGlassPanel(
      title: LocaleKeys.dashboards_common_labels_sign_up_page_view.tr(),
      child: PrimeCareCard(
        child: Text(
          LocaleKeys
              .dashboards_common_labels_operational_sector__sign_up_page_view
              .tr(),
        ),
      ),
    );
  }
}

class SignUpIntent extends PrimeCareScreen {
  SignUpIntent() : super(title: 'SignUp');

  @override
  Widget build(BuildContext context) => const SignUpView();
}

// --- End of sign_up_view\sign_up_view.dart ---

// --- Start of social_worker_dashboard\social_worker_dashboard_view.dart ---

class SocialWorkerDashboardView extends ConsumerWidget {
  const SocialWorkerDashboardView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = context.theme;
    final state = ref.watch(socialWorkerDashboardAdapterProvider);

    return PrimeCareScaffold(
      color: theme.colors.background,
      appBar: PrimeCareAppBar(
        title: LocaleKeys.dashboards_common_labels_social_care_command_hud.tr(),
        actions: [
          IconButton(
            icon: const Icon(LucideIcons.fileText),
            onPressed: () {},
            tooltip: 'Download Reports',
          ),
          IconButton(icon: const Icon(LucideIcons.bell), onPressed: () {}),
        ],
      ),
      body: Column(
        children: [
          const AuraDashboardHud(),
          Expanded(
            child: state.when(
              data: (result) => result.fold(
                (viewModel) => _buildContent(context, theme, viewModel, ref),
                (e) => DashboardErrorWidget(
                  message: 'Social Care Error: $e',
                  onRetry: () =>
                      ref.refresh(socialWorkerDashboardAdapterProvider),
                ),
              ),
              loading: () => const DashboardLoadingWidget(),
              error: (e, st) => DashboardErrorWidget(
                message: 'Connection Error: $e',
                onRetry: () =>
                    ref.refresh(socialWorkerDashboardAdapterProvider),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContent(
    BuildContext context,
    PrimeCareThemeData theme,
    SocialWorkerDashboardViewModel viewModel,
    WidgetRef ref,
  ) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      padding: EdgeInsets.all(theme.spacing.lg),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Command Hub Actions
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                PrimeCareChip(
                  label: 'Add Client',
                  onPressed: () =>
                      ref.read(socialWorkerActionHandler)('BTN_ADD_CLIENT'),
                  color: theme.colors.primary,
                ),
                SizedBox(width: theme.spacing.sm),
                PrimeCareChip(
                  label: 'Crisis Override',
                  onPressed: () => ref.read(socialWorkerActionHandler)(
                    'BTN_CRISIS_OVERRIDE',
                  ),
                  color: theme.colors.error,
                ),
                SizedBox(width: theme.spacing.sm),
                PrimeCareChip(
                  label: 'Community Map',
                  onPressed: () =>
                      ref.read(socialWorkerActionHandler)('BTN_MAP_RESOURCE'),
                ),
              ],
            ),
          ),
          SizedBox(height: theme.spacing.xl),

          Text(
            'Social Care Health Pulse',
            style: theme.typography.h3.copyWith(fontWeight: FontWeight.bold),
          ),
          SizedBox(height: theme.spacing.md),
          PrimeCareResponsiveKpiGrid(metrics: viewModel.metrics),
          SizedBox(height: theme.spacing.xl),

          LayoutBuilder(
            builder: (context, constraints) {
              final isWide = constraints.maxWidth > 1000;
              return Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 3,
                    child: Column(
                      children: [
                        _buildMainChart(theme, viewModel.metrics),
                        SizedBox(height: theme.spacing.xl),
                        _buildEventLedger(theme, viewModel.metrics),
                      ],
                    ),
                  ),
                  if (isWide) ...[
                    SizedBox(width: theme.spacing.xl),
                    Expanded(
                      flex: 2,
                      child: _buildAuraInsightsColumn(
                        theme,
                        viewModel.insights,
                      ),
                    ),
                  ],
                ],
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildMainChart(PrimeCareThemeData theme, DashboardMetrics metrics) {
    final chart = metrics.charts.firstWhere(
      (c) => c.id == 'intervention-dynamics',
      orElse: () => AnalyticsChart.empty(),
    );

    return PrimeCareChartCard(
      title: LocaleKeys.dashboards_common_labels_intervention_stability_vector
          .tr(),
      chart: PrimeCareLineChart(chart: chart),
    );
  }

  Widget _buildAuraInsightsColumn(
    PrimeCareThemeData theme,
    List<IntelligenceInsight> insights,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(LucideIcons.sparkles, color: theme.colors.primary, size: 20),
            SizedBox(width: theme.spacing.sm),
            Text('Aura Social Node', style: theme.typography.h4),
          ],
        ),
        SizedBox(height: theme.spacing.md),
        if (insights.isEmpty)
          Text(
            'No AI insights detected at this cycle.',
            style: theme.typography.bodySmall,
          )
        else
          ...insights.map(
            (i) => Padding(
              padding: EdgeInsets.only(bottom: theme.spacing.md),
              child: IntelligenceInsightCard(insight: i),
            ),
          ),
      ],
    );
  }

  Widget _buildEventLedger(PrimeCareThemeData theme, DashboardMetrics metrics) {
    return PrimeCareCard(
      padding: EdgeInsets.zero,
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(theme.spacing.lg),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  LocaleKeys.dashboards_common_labels_social_event_ledger.tr(),
                  style: theme.typography.h4,
                ),
                SizedBox(height: theme.spacing.xs),
                Text(
                  LocaleKeys
                      .dashboards_common_labels_real_time_feed_of_patient_interactions_and_linkage_events
                      .tr(),
                  style: theme.typography.labelMedium,
                ),
              ],
            ),
          ),
          ...metrics.recentActivity.map(
            (activity) => Column(
              children: [
                ListTile(
                  leading: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: _getActivityColor(
                        activity.color,
                        theme,
                      ).withValues(alpha: 0.1),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      _getActivityIcon(activity.icon),
                      color: _getActivityColor(activity.color, theme),
                      size: 18,
                    ),
                  ),
                  title: Text(
                    activity.title,
                    style: theme.typography.labelLarge,
                  ),
                  subtitle: Text(
                    activity.subtitle,
                    style: theme.typography.bodySmall,
                  ),
                  trailing: Text(
                    activity.timestamp,
                    style: theme.typography.labelSmall,
                  ),
                ),
                if (activity != metrics.recentActivity.last)
                  Divider(
                    height: 1,
                    indent: 72,
                    color: theme.colors.border.withValues(alpha: 0.5),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Color _getActivityColor(String? color, PrimeCareThemeData theme) {
    switch (color) {
      case 'green':
        return theme.colors.success;
      case 'blue':
        return theme.colors.primary;
      case 'orange':
        return theme.colors.warning;
      case 'red':
        return theme.colors.error;
      default:
        return theme.colors.textSecondary;
    }
  }

  IconData _getActivityIcon(String? icon) {
    switch (icon) {
      case 'users':
        return LucideIcons.users;
      case 'check-circle':
        return LucideIcons.checkCircle;
      case 'map-pin':
        return LucideIcons.mapPin;
      case 'alert-circle':
        return LucideIcons.alertCircle;
      default:
        return LucideIcons.activity;
    }
  }
}

class SocialWorkerDashboardIntent extends PrimeCareScreen {
  SocialWorkerDashboardIntent() : super(title: 'SocialWorkerDashboard');

  @override
  Widget build(BuildContext context) => const SocialWorkerDashboardView();
}

// --- End of social_worker_dashboard\social_worker_dashboard_view.dart ---

// --- Start of support_dashboard\support_dashboard_view.dart ---

class SupportDashboardView extends ConsumerWidget {
  const SupportDashboardView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = context.theme;
    final state = ref.watch(supportDashboardAdapterProvider);

    return MasterLayout(
      child: state.when(
        data: (result) => result.fold(
          (viewModel) => _buildContent(context, theme, viewModel),
          (e) => DashboardErrorWidget(
            message: 'Support Governance Error: $e',
            onRetry: () => ref.refresh(supportDashboardAdapterProvider),
          ),
        ),
        loading: () => const DashboardLoadingWidget(),
        error: (e, st) => DashboardErrorWidget(
          message: 'Connection Error: $e',
          onRetry: () => ref.refresh(supportDashboardAdapterProvider),
        ),
      ),
    );
  }

  Widget _buildContent(
    BuildContext context,
    PrimeCareThemeData theme,
    SupportDashboardViewModel viewModel,
  ) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(theme.spacing.lg),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                LocaleKeys.dashboards_support_title.tr(),
                style: theme.typography.h2,
              ),
              const Spacer(),
              if (viewModel.isOfflineFallback) const OfflineStatusChip(),
            ],
          ),
          SizedBox(height: theme.spacing.xl),

          PrimeCareResponsiveKpiGrid(metrics: viewModel.metrics),
          SizedBox(height: theme.spacing.xl),

          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(flex: 2, child: _buildOperationDetails(theme)),
              if (viewModel.insights.isNotEmpty) ...[
                SizedBox(width: theme.spacing.xl),
                Expanded(
                  child: _buildAuraInsightsColumn(theme, viewModel.insights),
                ),
              ],
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildOperationDetails(PrimeCareThemeData theme) {
    return PrimeCareCard(
      padding: EdgeInsets.all(theme.spacing.xl),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            LocaleKeys.dashboards_support_labels_operational_volume.tr(),
            style: theme.typography.h4,
          ),
          SizedBox(height: theme.spacing.lg),
          Center(
            child: Text(
              LocaleKeys
                  .dashboards_common_labels_support_queue_visualization___active_tickets
                  .tr(),
              style: theme.typography.bodyLarge.copyWith(
                fontStyle: FontStyle.italic,
              ),
            ),
          ),
        ],
      ),
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
          LocaleKeys.dashboards_support_labels_aura_intelligence.tr(),
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

class SupportDashboardIntent extends PrimeCareScreen {
  SupportDashboardIntent() : super(title: 'SupportDashboard');

  @override
  Widget build(BuildContext context) => const SupportDashboardView();
}

// --- End of support_dashboard\support_dashboard_view.dart ---

// --- Start of system_dashboard\system_dashboard_view.dart ---

class SystemDashboardView extends ConsumerWidget {
  const SystemDashboardView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncData = ref.watch(systemDashboardAdapterProvider);

    return PageTemplate(
      title: LocaleKeys.dashboards_common_labels_system_dashboard.tr(),
      subtitle: LocaleKeys
          .dashboards_common_labels_enterprise_wide_operational_overview
          .tr(),
      actions: [
        IconButton(
          icon: const Icon(Icons.refresh),
          onPressed: () => ref.refresh(systemDashboardAdapterProvider),
        ),
      ],
      body: asyncData.when(
        data: (result) => result.fold(
          (data) => SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                PrimeCareResponsiveKpiGrid(
                  children: data.kpis
                      .map(
                        (kpi) => PrimeCareKpiCard(
                          title: kpi.title,
                          value: kpi.value,
                          subtitle: kpi.subtitle ?? '',
                          icon: _getIconForMetric(kpi.title),
                          onPinToggle: () {},
                        ),
                      )
                      .toList(),
                ),
              ],
            ),
          ),
          (error) => Center(child: Text(error.toString())),
        ),
        loading: () => const PrimeCareSkeleton(),
        error: (e, s) => Center(child: Text(e.toString())),
      ),
    );
  }

  IconData _getIconForMetric(String title) {
    final t = title.toLowerCase();
    if (t.contains('efficiency')) return Icons.trending_up_outlined;
    if (t.contains('clinic')) return Icons.business_outlined;
    if (t.contains('patient')) return Icons.person_outline;
    if (t.contains('budget')) return Icons.account_balance_outlined;
    return Icons.analytics_outlined;
  }
}

class SystemDashboardIntent extends PrimeCareScreen {
  SystemDashboardIntent() : super(title: 'SystemDashboard');

  @override
  Widget build(BuildContext context) => const SystemDashboardView();
}

// --- End of system_dashboard\system_dashboard_view.dart ---

// --- Start of system_verification_dashboard\system_verification_dashboard_view.dart ---

class SystemVerificationDashboardView extends ConsumerWidget {
  const SystemVerificationDashboardView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = context.theme;
    final state = ref.watch(systemVerificationDashboardAdapterProvider);

    return MasterLayout(
      child: state.when(
        data: (result) => result.fold(
          (viewModel) => _buildContent(context, theme, viewModel),
          (e) => DashboardErrorWidget(
            message: 'Verification Governance Error: $e',
            onRetry: () => ref.refresh(systemDashboardAdapterProvider),
          ),
        ),
        loading: () => const DashboardLoadingWidget(),
        error: (e, st) => DashboardErrorWidget(
          message: 'Connection Error: $e',
          onRetry: () => ref.refresh(systemDashboardAdapterProvider),
        ),
      ),
    );
  }

  Widget _buildContent(
    BuildContext context,
    PrimeCareThemeData theme,
    SystemVerificationDashboardViewModel viewModel,
  ) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(theme.spacing.lg),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                'System Verification Command Center',
                style: theme.typography.h2,
              ),
              const Spacer(),
              if (viewModel.isOfflineFallback) const OfflineStatusChip(),
            ],
          ),
          SizedBox(height: theme.spacing.xl),

          PrimeCareResponsiveKpiGrid(metrics: viewModel.metrics),
          SizedBox(height: theme.spacing.xl),

          PrimeCareCard(
            padding: EdgeInsets.all(theme.spacing.xl),
            child: Center(
              child: Text(
                LocaleKeys.dashboards_common_labels_operational_insights.tr(),
                style: theme.typography.bodyLarge.copyWith(
                  fontStyle: FontStyle.italic,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class SystemVerificationDashboardIntent extends PrimeCareScreen {
  SystemVerificationDashboardIntent()
    : super(title: 'SystemVerificationDashboard');

  @override
  Widget build(BuildContext context) => const SystemVerificationDashboardView();
}

// --- End of system_verification_dashboard\system_verification_dashboard_view.dart ---

// --- Start of territory_expansion_manager_dashboard\territory_expansion_manager_dashboard_view.dart ---

class TerritoryExpansionManagerDashboardView extends ConsumerWidget {
  const TerritoryExpansionManagerDashboardView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = context.theme;
    final state = ref.watch(territoryExpansionManagerDashboardAdapterProvider);

    return MasterLayout(
      child: state.when(
        data: (result) => result.fold(
          (viewModel) => _buildContent(context, theme, viewModel),
          (e) => DashboardErrorWidget(
            message: 'Expansion Governance Error: $e',
            onRetry: () =>
                ref.refresh(territoryExpansionManagerDashboardAdapterProvider),
          ),
        ),
        loading: () => const DashboardLoadingWidget(),
        error: (e, st) => DashboardErrorWidget(
          message: 'Connection Error: $e',
          onRetry: () =>
              ref.refresh(territoryExpansionManagerDashboardAdapterProvider),
        ),
      ),
    );
  }

  Widget _buildContent(
    BuildContext context,
    PrimeCareThemeData theme,
    TerritoryExpansionManagerDashboardViewModel viewModel,
  ) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(theme.spacing.lg),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                'Territory Expansion Manager Command Center',
                style: theme.typography.h2,
              ),
              const Spacer(),
              if (viewModel.isOfflineFallback) const OfflineStatusChip(),
            ],
          ),
          SizedBox(height: theme.spacing.xl),

          PrimeCareResponsiveKpiGrid(metrics: viewModel.metrics),
          SizedBox(height: theme.spacing.xl),

          PrimeCareCard(
            padding: EdgeInsets.all(theme.spacing.xl),
            child: Center(
              child: Text(
                LocaleKeys.dashboards_common_labels_operational_insights.tr(),
                style: theme.typography.bodyLarge.copyWith(
                  fontStyle: FontStyle.italic,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class TerritoryExpansionManagerDashboardIntent extends PrimeCareScreen {
  TerritoryExpansionManagerDashboardIntent()
    : super(title: 'TerritoryExpansionManagerDashboard');

  @override
  Widget build(BuildContext context) =>
      const TerritoryExpansionManagerDashboardView();
}

// --- End of territory_expansion_manager_dashboard\territory_expansion_manager_dashboard_view.dart ---

// --- Start of territory_sales_manager_dashboard\territory_sales_manager_dashboard_view.dart ---

class TerritorySalesManagerDashboardView extends ConsumerWidget {
  const TerritorySalesManagerDashboardView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = context.theme;
    final state = ref.watch(territorySalesManagerDashboardAdapterProvider);

    return MasterLayout(
      child: state.when(
        data: (result) => result.fold(
          (viewModel) => _buildContent(context, theme, viewModel),
          (e) => DashboardErrorWidget(
            message: 'Sales Governance Error: $e',
            onRetry: () =>
                ref.refresh(territorySalesManagerDashboardAdapterProvider),
          ),
        ),
        loading: () => const DashboardLoadingWidget(),
        error: (e, st) => DashboardErrorWidget(
          message: 'Connection Error: $e',
          onRetry: () =>
              ref.refresh(territorySalesManagerDashboardAdapterProvider),
        ),
      ),
    );
  }

  Widget _buildContent(
    BuildContext context,
    PrimeCareThemeData theme,
    TerritorySalesManagerDashboardViewModel viewModel,
  ) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(theme.spacing.lg),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                'Territory Sales Manager Command Center',
                style: theme.typography.h2,
              ),
              const Spacer(),
              if (viewModel.isOfflineFallback) const OfflineStatusChip(),
            ],
          ),
          SizedBox(height: theme.spacing.xl),

          PrimeCareResponsiveKpiGrid(metrics: viewModel.metrics),
          SizedBox(height: theme.spacing.xl),

          PrimeCareCard(
            padding: EdgeInsets.all(theme.spacing.xl),
            child: Center(
              child: Text(
                LocaleKeys.dashboards_common_labels_operational_insights.tr(),
                style: theme.typography.bodyLarge.copyWith(
                  fontStyle: FontStyle.italic,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class TerritorySalesManagerDashboardIntent extends PrimeCareScreen {
  TerritorySalesManagerDashboardIntent()
    : super(title: 'TerritorySalesManagerDashboard');

  @override
  Widget build(BuildContext context) =>
      const TerritorySalesManagerDashboardView();
}

// --- End of territory_sales_manager_dashboard\territory_sales_manager_dashboard_view.dart ---

// --- Start of training_coordinator_dashboard\training_coordinator_dashboard_view.dart ---

class TrainingCoordinatorDashboardView extends ConsumerWidget {
  const TrainingCoordinatorDashboardView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = context.theme;
    final state = ref.watch(trainingCoordinatorDashboardAdapterProvider);

    return MasterLayout(
      child: state.when(
        data: (result) => result.fold(
          (viewModel) => _buildContent(context, theme, viewModel),
          (e) => DashboardErrorWidget(
            message: 'Training Governance Error: $e',
            onRetry: () =>
                ref.refresh(trainingCoordinatorDashboardAdapterProvider),
          ),
        ),
        loading: () => const DashboardLoadingWidget(),
        error: (e, st) => DashboardErrorWidget(
          message: 'Connection Error: $e',
          onRetry: () =>
              ref.refresh(trainingCoordinatorDashboardAdapterProvider),
        ),
      ),
    );
  }

  Widget _buildContent(
    BuildContext context,
    PrimeCareThemeData theme,
    TrainingCoordinatorDashboardViewModel viewModel,
  ) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(theme.spacing.lg),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                'Training Coordinator Command Center',
                style: theme.typography.h2,
              ),
              const Spacer(),
              if (viewModel.isOfflineFallback) const OfflineStatusChip(),
            ],
          ),
          SizedBox(height: theme.spacing.xl),

          PrimeCareResponsiveKpiGrid(metrics: viewModel.metrics),
          SizedBox(height: theme.spacing.xl),

          PrimeCareCard(
            padding: EdgeInsets.all(theme.spacing.xl),
            child: Center(
              child: Text(
                LocaleKeys.dashboards_common_labels_operational_insights.tr(),
                style: theme.typography.bodyLarge.copyWith(
                  fontStyle: FontStyle.italic,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class TrainingCoordinatorDashboardIntent extends PrimeCareScreen {
  TrainingCoordinatorDashboardIntent()
    : super(title: 'TrainingCoordinatorDashboard');

  @override
  Widget build(BuildContext context) =>
      const TrainingCoordinatorDashboardView();
}

// --- End of training_coordinator_dashboard\training_coordinator_dashboard_view.dart ---

// --- Start of training_director_certificate_dashboard\training_director_certificate_dashboard_view.dart ---

class TrainingDirectorCertificateDashboardView extends ConsumerWidget {
  const TrainingDirectorCertificateDashboardView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = context.theme;
    final state = ref.watch(trainingDirectorCertDashboardAdapterProvider);

    return MasterLayout(
      child: state.when(
        data: (result) => result.fold(
          (viewModel) => _buildContent(context, theme, viewModel),
          (e) => DashboardErrorWidget(
            message: 'Certificate Governance Error: $e',
            onRetry: () =>
                ref.refresh(trainingDirectorCertDashboardAdapterProvider),
          ),
        ),
        loading: () => const DashboardLoadingWidget(),
        error: (e, st) => DashboardErrorWidget(
          message: 'Connection Error: $e',
          onRetry: () =>
              ref.refresh(trainingDirectorCertDashboardAdapterProvider),
        ),
      ),
    );
  }

  Widget _buildContent(
    BuildContext context,
    PrimeCareThemeData theme,
    TrainingDirectorCertificateDashboardViewModel viewModel,
  ) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(theme.spacing.lg),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                'Training Director Certificate Command Center',
                style: theme.typography.h2,
              ),
              const Spacer(),
              if (viewModel.isOfflineFallback) const OfflineStatusChip(),
            ],
          ),
          SizedBox(height: theme.spacing.xl),

          PrimeCareResponsiveKpiGrid(metrics: viewModel.metrics),
          SizedBox(height: theme.spacing.xl),

          PrimeCareCard(
            padding: EdgeInsets.all(theme.spacing.xl),
            child: Center(
              child: Text(
                LocaleKeys.dashboards_common_labels_operational_insights.tr(),
                style: theme.typography.bodyLarge.copyWith(
                  fontStyle: FontStyle.italic,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class TrainingDirectorCertificateDashboardIntent extends PrimeCareScreen {
  TrainingDirectorCertificateDashboardIntent()
    : super(title: 'TrainingDirectorCertificateDashboard');

  @override
  Widget build(BuildContext context) =>
      const TrainingDirectorCertificateDashboardView();
}

// --- End of training_director_certificate_dashboard\training_director_certificate_dashboard_view.dart ---

// --- Start of training_director_dashboard\training_director_dashboard_view.dart ---

class TrainingDirectorDashboardView extends ConsumerWidget {
  const TrainingDirectorDashboardView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = context.theme;
    final state = ref.watch(trainingDirectorDashboardAdapterProvider);

    return MasterLayout(
      child: state.when(
        data: (result) => result.fold(
          (viewModel) => _buildContent(
            context,
            theme,
            viewModel as TrainingDirectorDashboardViewModel,
          ),
          (e) => DashboardErrorWidget(
            message: 'Training Director Governance Error: $e',
            onRetry: () =>
                ref.refresh(trainingDirectorDashboardAdapterProvider),
          ),
        ),
        loading: () => const DashboardLoadingWidget(),
        error: (e, st) => DashboardErrorWidget(
          message: 'Connection Error: $e',
          onRetry: () => ref.refresh(trainingDirectorDashboardAdapterProvider),
        ),
      ),
    );
  }

  Widget _buildContent(
    BuildContext context,
    PrimeCareThemeData theme,
    TrainingDirectorDashboardViewModel vm,
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
                    LocaleKeys.command_center_labels_training_center.tr(),
                    style: theme.typography.h2,
                  ),
                  Text(
                    'Completion rates, compliance status, and certification velocity telemetry',
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
                    _buildCurriculumMatrix(theme),
                    SizedBox(height: theme.spacing.xl),
                    _buildTrainingCharts(theme, vm),
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

  Widget _buildCurriculumMatrix(PrimeCareThemeData theme) {
    return PrimeCareCard(
      padding: EdgeInsets.all(theme.spacing.xl),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            LocaleKeys.command_center_labels_curriculum_compliance.tr(),
            style: theme.typography.h4,
          ),
          SizedBox(height: theme.spacing.lg),
          const Center(
            child: Text(
              'Educational Analytics Surveillance Active',
              style: TextStyle(fontStyle: FontStyle.italic),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTrainingCharts(
    PrimeCareThemeData theme,
    TrainingDirectorDashboardViewModel vm,
  ) {
    return Column(
      children: [
        PrimeCareChartCard(
          title: LocaleKeys
              .dashboards_common_labels_certification_velocity_trend
              .tr(),
          chart: PrimeCareLineChart(
            chart: vm.metrics.charts.firstWhere(
              (c) => c.id == 'certification-velocity',
              orElse: () => AnalyticsChart.empty(),
            ),
          ),
        ),
      ],
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

class TrainingDirectorDashboardIntent extends PrimeCareScreen {
  TrainingDirectorDashboardIntent() : super(title: 'TrainingDirectorDashboard');

  @override
  Widget build(BuildContext context) => const TrainingDirectorDashboardView();
}

// --- End of training_director_dashboard\training_director_dashboard_view.dart ---

// --- Start of training_hub_dashboard\training_hub_dashboard_view.dart ---

class TrainingHubDashboardView extends ConsumerWidget {
  const TrainingHubDashboardView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = context.theme;
    final state = ref.watch(trainingHubDashboardAdapterProvider);

    return MasterLayout(
      child: state.when(
        data: (result) => result.fold(
          (viewModel) => _buildContent(context, theme, viewModel),
          (e) => DashboardErrorWidget(
            message: 'Training Hub Governance Error: $e',
            onRetry: () => ref.refresh(trainingHubDashboardAdapterProvider),
          ),
        ),
        loading: () => const DashboardLoadingWidget(),
        error: (e, st) => DashboardErrorWidget(
          message: 'Connection Error: $e',
          onRetry: () => ref.refresh(trainingHubDashboardAdapterProvider),
        ),
      ),
    );
  }

  Widget _buildContent(
    BuildContext context,
    PrimeCareThemeData theme,
    TrainingHubDashboardViewModel vm,
  ) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(theme.spacing.lg),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                LocaleKeys.command_center_labels_training_hub_center.tr(),
                style: theme.typography.h2,
              ),
              const Spacer(),
              if (vm.isOfflineFallback) const OfflineStatusChip(),
            ],
          ),
          SizedBox(height: theme.spacing.xl),

          PrimeCareResponsiveKpiGrid(metrics: vm.metrics),
          SizedBox(height: theme.spacing.xl),

          PrimeCareCard(
            padding: EdgeInsets.all(theme.spacing.xl),
            child: Center(
              child: Text(
                LocaleKeys.dashboards_common_labels_operational_insights.tr(),
                style: theme.typography.bodyLarge.copyWith(
                  fontStyle: FontStyle.italic,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class TrainingHubDashboardIntent extends PrimeCareScreen {
  TrainingHubDashboardIntent() : super(title: 'TrainingHubDashboard');

  @override
  Widget build(BuildContext context) => const TrainingHubDashboardView();
}

// --- End of training_hub_dashboard\training_hub_dashboard_view.dart ---

// --- Start of verification_hub\verification_hub_view.dart ---

class VerificationHubView extends ConsumerWidget {
  const VerificationHubView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncData = ref.watch(verificationHubAdapterProvider);

    return PageTemplate(
      title: LocaleKeys.dashboards_common_labels_verification_hub.tr(),
      subtitle: 'Verification Status',
      actions: [
        IconButton(
          icon: const Icon(Icons.refresh),
          onPressed: () => ref.refresh(verificationHubAdapterProvider),
        ),
      ],
      body: asyncData.when(
        data: (result) => result.fold(
          (data) => SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const AuraDashboardHud(),
                const SizedBox(height: 24),
                PrimeCareResponsiveKpiGrid(
                  children: data.metrics.kpis
                      .map(
                        (kpi) => PrimeCareKpiCard(
                          title: kpi.title,
                          value: kpi.value,
                          subtitle: kpi.subtitle ?? '',
                          icon: _getIconForMetric(kpi.title),
                          onPinToggle: () {},
                        ),
                      )
                      .toList(),
                ),
              ],
            ),
          ),
          (error) => Center(child: Text(error.toString())),
        ),
        loading: () => const PrimeCareSkeleton(),
        error: (e, s) => Center(child: Text(e.toString())),
      ),
    );
  }

  IconData _getIconForMetric(String title) {
    final t = title.toLowerCase();
    if (t.contains('verify')) return Icons.verified_user_outlined;
    if (t.contains('pending')) return Icons.pending_actions_outlined;
    if (t.contains('reject')) return Icons.gpp_bad_outlined;
    return Icons.fact_check_outlined;
  }
}

class VerificationHubIntent extends PrimeCareScreen {
  VerificationHubIntent() : super(title: 'VerificationHub');

  @override
  Widget build(BuildContext context) => const VerificationHubView();
}

// --- End of verification_hub\verification_hub_view.dart ---

// --- Start of volunteer_coordinator_dashboard\volunteer_coordinator_dashboard_view.dart ---

class VolunteerCoordinatorDashboardView extends ConsumerWidget {
  const VolunteerCoordinatorDashboardView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = context.theme;
    final state = ref.watch(volunteerCoordinatorDashboardAdapterProvider);

    return MasterLayout(
      child: state.when(
        data: (result) => result.fold(
          (viewModel) => _buildContent(context, theme, viewModel),
          (e) => DashboardErrorWidget(
            message: 'Volunteer Governance Error: $e',
            onRetry: () => ref.refresh(verificationHubAdapterProvider),
          ),
        ),
        loading: () => const DashboardLoadingWidget(),
        error: (e, st) => DashboardErrorWidget(
          message: 'Connection Error: $e',
          onRetry: () => ref.refresh(verificationHubAdapterProvider),
        ),
      ),
    );
  }

  Widget _buildContent(
    BuildContext context,
    PrimeCareThemeData theme,
    VolunteerCoordinatorDashboardViewModel vm,
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
                    LocaleKeys.command_center_labels_volunteer_center.tr(),
                    style: theme.typography.h2,
                  ),
                  Text(
                    'Active volunteer counts, shift coverage, and engagement trends',
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
                    PrimeCareCard(
                      padding: EdgeInsets.all(theme.spacing.xl),
                      child: const Center(
                        child: Text(
                          'Volunteer Engagement Insights Unified',
                          style: TextStyle(fontStyle: FontStyle.italic),
                        ),
                      ),
                    ),
                    SizedBox(height: theme.spacing.xl),
                    _buildEngagementCharts(theme, vm),
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

  Widget _buildEngagementCharts(
    PrimeCareThemeData theme,
    VolunteerCoordinatorDashboardViewModel vm,
  ) {
    return Column(
      children: [
        PrimeCareChartCard(
          title: LocaleKeys.dashboards_common_labels_volunteer_retention_trend
              .tr(),
          chart: PrimeCareLineChart(
            chart: vm.metrics.charts.firstWhere(
              (c) => c.id == 'retention-trend',
              orElse: () => AnalyticsChart.empty(),
            ),
          ),
        ),
      ],
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

class VolunteerCoordinatorDashboardIntent extends PrimeCareScreen {
  VolunteerCoordinatorDashboardIntent()
    : super(title: 'VolunteerCoordinatorDashboard');

  @override
  Widget build(BuildContext context) =>
      const VolunteerCoordinatorDashboardView();
}

// --- End of volunteer_coordinator_dashboard\volunteer_coordinator_dashboard_view.dart ---

class PatientIntakeForm extends StatelessWidget {
  final VoidCallback onSuccess;
  const PatientIntakeForm({required this.onSuccess, super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const PrimeCareTextField(
          label: 'Full Name',
          placeholder: 'Enter patient name',
        ),
        const SizedBox(height: 16),
        const PrimeCareTextField(
          label: 'Reason for Visit',
          placeholder: 'Enter reason',
        ),
        const SizedBox(height: 24),
        PrimeCareButton(onPressed: onSuccess, label: 'Submit Intake'),
      ],
    );
  }
}

class VitalsCaptureForm extends StatelessWidget {
  final VoidCallback onSuccess;
  const VitalsCaptureForm({required this.onSuccess, super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const PrimeCareTextField(
          label: 'Blood Pressure',
          placeholder: '120/80',
        ),
        const SizedBox(height: 16),
        const PrimeCareTextField(label: 'Temperature', placeholder: '36.6'),
        const SizedBox(height: 24),
        PrimeCareButton(onPressed: onSuccess, label: 'Save Vitals'),
      ],
    );
  }
}
