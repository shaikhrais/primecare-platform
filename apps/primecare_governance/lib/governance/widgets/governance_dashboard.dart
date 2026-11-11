import 'package:primecare_ui/primecare_ui.dart' show PrimePopupMenuButton, PrimeTabBar;
import 'package:primecare_ui/primecare_ui.dart';
// Governance - Category: view | Purpose: UI Screen component rendering the Governance Dashboard workspace interface.
import 'package:flutter_core/flutter_core.dart';
import 'package:flutter/services.dart';
import '../../core/governance/screen_registry.dart';
import '../models/governance_report.dart';
import 'governance_kpi_grid.dart';
import 'governance_issue_table.dart';
import 'governance_filter_bar.dart';

import 'governance_patch_manager.dart';
import 'governance_domain_chart.dart';
import 'governance_compliance_checklist.dart';
import 'governance_master_score.dart';
import 'governance_trend_chart.dart';
import 'governance_event_feed.dart';
import '../../core/governance/governance_provider.dart';
import '../controllers/governance_dashboard_controller.dart';
import 'network_parity_audit_table.dart';
import 'platform_discovery_viewer.dart';
import 'platform_readiness_viewer.dart';

class GovernanceDashboard extends GovernedScreen {
  final GovernanceReport? report;
  const GovernanceDashboard({super.key, this.report});

  @override
  String get featureId => 'SYSTEM_GOVERNANCE_DASHBOARD';

  @override
  String get requiredRole => 'ADMIN';

  @override
  Widget buildGovernedView(BuildContext context, WidgetRef ref) {
    return const _GovernanceDashboardContent();
  }
}

class _GovernanceDashboardContent extends ConsumerStatefulWidget {
  const _GovernanceDashboardContent();

  @override
  ConsumerState<_GovernanceDashboardContent> createState() =>
      _GovernanceDashboardContentState();
}

class _GovernanceDashboardContentState
    extends ConsumerState<_GovernanceDashboardContent>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  void _refreshReport() {
    ref.read(governanceDashboardControllerProvider.notifier).rescan();
  }

  Future<void> _exportReport(String format, GovernanceReport report) async {
    try {
      final result = await ref
          .read(governanceDashboardControllerProvider.notifier)
          .exportReport(format, report);

      if (result != null) {
        if (!mounted) return;
        if (format != 'pdf') {
          await Clipboard.setData(ClipboardData(text: result));
        }
        if (!mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
          PrimeSnackBar(
            content: PrimeText(
              'governance.dashboard.reportExported'.tr(args: [format]),
              style: TextStyle(color: PrimeActionPalette.of(context, PrimeActionTone.primary).onAccent),
            ),
            backgroundColor: PrimeActionPalette.of(context, PrimeActionTone.primary).accent,
            behavior: SnackBarBehavior.floating,
          ),
        );
      }
    } catch (_) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        PrimeSnackBar(content: PrimeText('common.error'.tr())),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final governanceState = ref.watch(governanceProvider);
    final report = governanceState.report;

    if (report == null) {
      return const Center(child: PrimeCircularProgressIndicator());
    }

    final dashboardStateAsync = ref.watch(governanceDashboardControllerProvider);
    final dashboardState = dashboardStateAsync.value ?? const GovernanceDashboardState();

    final filteredIssues = report.issues.where((issue) {
      final matchesSeverity =
          dashboardState.selectedSeverity == null ||
          issue.severity == dashboardState.selectedSeverity;
      final matchesCategory =
          dashboardState.selectedCategory == null ||
          issue.category == dashboardState.selectedCategory;
      final matchesSearch =
          dashboardState.searchQuery.isEmpty ||
          issue.screenId.toLowerCase().contains(
            dashboardState.searchQuery.toLowerCase(),
          ) ||
          issue.title.toLowerCase().contains(
            dashboardState.searchQuery.toLowerCase(),
          );
      return matchesSeverity && matchesCategory && matchesSearch;
    }).toList();

    return PrimeScaffold(
      backgroundColor: context.theme.colors.surface.withValues(alpha: 0),
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(48),
        child: Container(
          decoration: BoxDecoration(
            color: context.theme.colors.surface,
            border: Border(
              bottom: BorderSide(color: context.theme.colors.outlineVariant),
            ),
          ),
          child: PrimeTabBar(
            controller: _tabController,
            labelColor: PrimeActionPalette.of(context, PrimeActionTone.primary).accent,
            unselectedLabelColor: context.theme.colors.surfaceContainerHigh,
            indicatorColor: PrimeActionPalette.of(context, PrimeActionTone.primary).accent,
            tabs: const [
              Tab(text: 'Architecture Audit'),
              Tab(text: 'Microservice Mesh'),
              Tab(text: 'System Readiness'),
              Tab(text: 'Remediation Patches'),
            ],
          ),
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildAuditView(
            filteredIssues,
            governanceState,
            dashboardState,
            report,
          ),
          const PlatformDiscoveryViewer(),
          const PlatformReadinessViewer(),
          GovernancePatchManager(issues: filteredIssues),
        ],
      ),
    );
  }

  Widget _buildAuditView(
    List<PlatformAuditIssue> filteredIssues,
    GovernanceState governanceState,
    GovernanceDashboardState dashboardState,
    GovernanceReport report,
  ) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Wrap(
            alignment: WrapAlignment.spaceBetween,
            runSpacing: 16,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const PrimeText(
                    'Architecture Governance',
                    style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                  ),
                  PrimeText(
                    'Checked-in app registry: ${ScreenRegistry.screens.length} screens; acceptance evidence pending',
                    style: TextStyle(color: context.theme.colors.onSurfaceVariant),
                  ),
                ],
              ),
              Wrap(
                spacing: 12,
                runSpacing: 12,
                children: [
                  if (governanceState.hasDrift ||
                      governanceState.brokenScreens > 0)
                    PrimeOutlinedButton.icon(
                      onPressed: governanceState.isSyncing
                          ? null
                          : () => ref
                                .read(
                                  governanceDashboardControllerProvider
                                      .notifier,
                                )
                                .remediate(),
                      icon: governanceState.isSyncing
                          ? const SizedBox(
                              width: 16,
                              height: 16,
                              child: PrimeCircularProgressIndicator(
                                strokeWidth: 2,
                              ),
                            )
                          : const PrimeIcon(Icons.auto_fix_high_rounded, size: 20),
                      label: PrimeText('governance.dashboard.auto_remediate'.tr()),
                      style: PrimeOutlinedButton.styleFrom(
                        foregroundColor: PrimeActionPalette.of(context, PrimeActionTone.primary).onBase,
                        side: BorderSide(color: PrimeActionPalette.of(context, PrimeActionTone.primary).accent),
                      ),
                    ),
                  PrimePopupMenuButton<String>(
                    onSelected: (format) => _exportReport(format, report),
                    itemBuilder: (context) => [
                      PopupMenuItem(
                        value: 'pdf',
                        child: PrimeText('governance.dashboard.export_pdf'.tr()),
                      ),
                      PopupMenuItem(
                        value: 'html',
                        child: PrimeText('governance.dashboard.export_html'.tr()),
                      ),
                      PopupMenuItem(
                        value: 'markdown',
                        child: PrimeText(
                          'governance.dashboard.export_markdown'.tr(),
                        ),
                      ),
                      PopupMenuItem(
                        value: 'json',
                        child: PrimeText('governance.dashboard.export_json'.tr()),
                      ),
                      PopupMenuItem(
                        value: 'csv',
                        child: PrimeText('governance.dashboard.export_csv'.tr()),
                      ),
                    ],
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 10,
                      ),
                      decoration: BoxDecoration(
                        border: Border.all(color: PrimeActionPalette.of(context, PrimeActionTone.primary).accent),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          if (dashboardState.isExporting)
                            const SizedBox(
                              width: 16,
                              height: 16,
                              child: PrimeCircularProgressIndicator(strokeWidth: 2),
                            )
                          else
                            PrimeIcon(
                              Icons.download_rounded,
                              color: PrimeActionPalette.of(context, PrimeActionTone.primary).onBase,
                              size: 20,
                            ),
                          const SizedBox(width: 8),
                          PrimeText(
                            'Export',
                            style: TextStyle(
                              color: PrimeActionPalette.of(context, PrimeActionTone.primary).onBase,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  PrimeElevatedButton.icon(
                    onPressed: _refreshReport,
                    icon: const PrimeIcon(Icons.refresh_rounded),
                    label: PrimeText('governance.dashboard.rescan'.tr()),
                    style: PrimeElevatedButton.styleFrom(
                      backgroundColor: PrimeActionPalette.of(context, PrimeActionTone.primary).accent,
                      foregroundColor: PrimeActionPalette.of(context, PrimeActionTone.primary).onAccent,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 12,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 32),
          LayoutBuilder(
            builder: (context, constraints) {
              if (constraints.maxWidth > 1000) {
                return Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(flex: 3, child: GovernanceKPIGrid(report: report)),
                    const SizedBox(width: 24),
                    Expanded(
                      flex: 2,
                      child: GovernanceDomainChart(report: report),
                    ),
                  ],
                );
              } else {
                return Column(
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        GovernanceMasterScore(report: report),
                        const SizedBox(width: 48),
                        Expanded(child: GovernanceKPIGrid(report: report)),
                      ],
                    ),
                    const SizedBox(height: 24),
                    GovernanceDomainChart(report: report),
                  ],
                );
              }
            },
          ),
          const SizedBox(height: 32),
          LayoutBuilder(
            builder: (context, constraints) {
              if (constraints.maxWidth > 1200) {
                return Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      flex: 3,
                      child: SizedBox(
                        height: 400,
                        child: GovernanceTrendChart(
                          trendData: governanceState.healthTrend,
                        ),
                      ),
                    ),
                    const SizedBox(width: 24),
                    Expanded(
                      flex: 2,
                      child: SizedBox(
                        height: 400,
                        child: GovernanceEventFeed(
                          events: governanceState.recentEvents,
                        ),
                      ),
                    ),
                  ],
                );
              } else {
                return Column(
                  children: [
                    SizedBox(
                      height: 350,
                      child: GovernanceTrendChart(
                        trendData: governanceState.healthTrend,
                      ),
                    ),
                    const SizedBox(height: 24),
                    SizedBox(
                      height: 400,
                      child: GovernanceEventFeed(
                        events: governanceState.recentEvents,
                      ),
                    ),
                  ],
                );
              }
            },
          ),
          const SizedBox(height: 32),

          Wrap(
            spacing: 16,
            runSpacing: 16,
            crossAxisAlignment: WrapCrossAlignment.center,
            children: [
              GovernanceFilterBar(
                selectedSeverity: dashboardState.selectedSeverity,
                selectedCategory: dashboardState.selectedCategory,
                onSeverityChanged: (s) => ref
                    .read(governanceDashboardControllerProvider.notifier)
                    .setSeverity(s),
                onCategoryChanged: (c) => ref
                    .read(governanceDashboardControllerProvider.notifier)
                    .setCategory(c),
                onClear: () => ref
                    .read(governanceDashboardControllerProvider.notifier)
                    .clearFilters(),
              ),
              SizedBox(
                width: 300,
                child: PrimeTextField(key: const Key('governance_dashboard_textfield_input_1'),
                  decoration: InputDecoration(
                    hintText: 'Search screens...',
                    prefixIcon: const PrimeIcon(Icons.search),
                    filled: true,
                    fillColor: context.theme.colors.surface,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(
                        color: context.theme.colors.outlineVariant,
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(
                        color: context.theme.colors.outlineVariant,
                      ),
                    ),
                  ),
                  onChanged: (v) => ref
                      .read(governanceDashboardControllerProvider.notifier)
                      .setSearchQuery(v),
                ),
              ),
            ],
          ),

          const SizedBox(height: 24),
          Wrap(
            alignment: WrapAlignment.spaceBetween,
            runSpacing: 8,
            children: [
              const PrimeText(
                'Detected Architectural Issues',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              PrimeText(
                'Showing ${filteredIssues.length} of ${report.totalIssues} issues',
                style: TextStyle(color: context.theme.colors.onSurfaceVariant, fontSize: 12),
              ),
            ],
          ),
          const SizedBox(height: 16),
          GovernanceIssueTable(issues: filteredIssues),
          const SizedBox(height: 32),
          Wrap(
            alignment: WrapAlignment.spaceBetween,
            runSpacing: 8,
            children: [
              const PrimeText(
                'Network Parity & Backend Audit',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: PrimeActionPalette.of(context, PrimeActionTone.success).surface,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    PrimeIcon(Icons.security, size: 14, color: PrimeActionPalette.of(context, PrimeActionTone.success).onSurface),
                    SizedBox(width: 4),
                    PrimeText(
                      'ZERO-TRUST ENFORCED',
                      style: TextStyle(
                        color: PrimeActionPalette.of(context, PrimeActionTone.success).onSurface,
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          const NetworkParityAuditTable(),
          const SizedBox(height: 32),
          GovernanceComplianceChecklist(report: report),
          const SizedBox(height: 32),
          _buildReadinessPanel(report),
        ],
      ),
    );
  }

  Widget _buildReadinessPanel(GovernanceReport report) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [PrimeActionPalette.of(context, PrimeActionTone.primary).accent, PrimeActionPalette.of(context, PrimeActionTone.primary).accent],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                PrimeText(
                  'Production Readiness Status',
                  style: TextStyle(
                    color: PrimeActionPalette.of(context, PrimeActionTone.primary).onAccent,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                PrimeText(
                  '${report.productionReadyScreens} screens meet all production quality gates. ${report.blockedScreens} screens are currently blocked by critical or high-severity issues.',
                  style: TextStyle(
                    color: PrimeActionPalette.of(context, PrimeActionTone.primary).onAccent,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 32),
          PrimeCircularProgressIndicator(
            value: report.totalScreens > 0
                ? report.productionReadyScreens / report.totalScreens
                : 0,
            backgroundColor: PrimeActionPalette.of(context, PrimeActionTone.primary).onAccent.withValues(alpha: 0.2),
            valueColor: AlwaysStoppedAnimation<Color>(PrimeActionPalette.of(context, PrimeActionTone.primary).onAccent),
            strokeWidth: 8,
          ),
        ],
      ),
    );
  }
}
