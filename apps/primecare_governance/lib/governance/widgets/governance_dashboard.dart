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
        SnackBar(
          content: Text(
            format == 'pdf'
                ? 'Professional PDF Report Generated (Ready for Download)'
                : 'governance.dashboard.reportExported'.tr(args: [format]),
          ),
          backgroundColor: Colors.blue,
          behavior: SnackBarBehavior.floating,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final governanceState = ref.watch(governanceProvider);
    final report = governanceState.report;

    if (report == null) {
      return const Center(child: CircularProgressIndicator());
    }

    final dashboardState = ref.watch(governanceDashboardControllerProvider);

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

    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(48),
        child: Container(
          decoration: BoxDecoration(
            color: Theme.of(context).cardColor,
            border: Border(
              bottom: BorderSide(color: Colors.grey.withValues(alpha: 0.1)),
            ),
          ),
          child: TabBar(
            controller: _tabController,
            labelColor: Colors.blue,
            unselectedLabelColor: Colors.grey,
            indicatorColor: Colors.blue,
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
          const PlatformDiscoveryViewer(baseUrl: 'http://localhost:8700/api/governance'),
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
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Architecture Governance',
                    style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    'Live architectural audit of ${ScreenRegistry.screens.length} platform screens',
                    style: const TextStyle(color: Colors.grey),
                  ),
                ],
              ),
              Row(
                children: [
                  if (governanceState.hasDrift ||
                      governanceState.brokenScreens > 0)
                    Padding(
                      padding: const EdgeInsets.only(right: 12),
                      child: OutlinedButton.icon(
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
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                ),
                              )
                            : const Icon(Icons.auto_fix_high_rounded, size: 20),
                        label: Text('governance.dashboard.auto_remediate'.tr()),
                        style: OutlinedButton.styleFrom(
                          foregroundColor: Colors.blue,
                          side: const BorderSide(color: Colors.blue),
                        ),
                      ),
                    ),
                  PopupMenuButton<String>(
                    onSelected: (format) => _exportReport(format, report),
                    itemBuilder: (context) => [
                      PopupMenuItem(
                        value: 'pdf',
                        child: Text('governance.dashboard.export_pdf'.tr()),
                      ),
                      PopupMenuItem(
                        value: 'html',
                        child: Text('governance.dashboard.export_html'.tr()),
                      ),
                      PopupMenuItem(
                        value: 'markdown',
                        child: Text(
                          'governance.dashboard.export_markdown'.tr(),
                        ),
                      ),
                      PopupMenuItem(
                        value: 'json',
                        child: Text('governance.dashboard.export_json'.tr()),
                      ),
                      PopupMenuItem(
                        value: 'csv',
                        child: Text('governance.dashboard.export_csv'.tr()),
                      ),
                    ],
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 10,
                      ),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.blue),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(
                        children: [
                          if (dashboardState.isExporting)
                            const SizedBox(
                              width: 16,
                              height: 16,
                              child: CircularProgressIndicator(strokeWidth: 2),
                            )
                          else
                            const Icon(
                              Icons.download_rounded,
                              color: Colors.blue,
                              size: 20,
                            ),
                          const SizedBox(width: 8),
                          const Text(
                            'Export',
                            style: TextStyle(
                              color: Colors.blue,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  ElevatedButton.icon(
                    onPressed: _refreshReport,
                    icon: const Icon(Icons.refresh_rounded),
                    label: Text('governance.dashboard.rescan'.tr()),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      foregroundColor: Colors.white,
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

          Row(
            children: [
              Expanded(
                child: GovernanceFilterBar(
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
              ),
              const SizedBox(width: 16),
              SizedBox(
                width: 300,
                child: TextField(
                  decoration: InputDecoration(
                    hintText: 'Search screens...',
                    prefixIcon: const Icon(Icons.search),
                    filled: true,
                    fillColor: Theme.of(context).cardColor,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(
                        color: Colors.grey.withValues(alpha: 0.1),
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(
                        color: Colors.grey.withValues(alpha: 0.1),
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
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Detected Architectural Issues',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              Text(
                'Showing ${filteredIssues.length} of ${report.totalIssues} issues',
                style: const TextStyle(color: Colors.grey, fontSize: 12),
              ),
            ],
          ),
          const SizedBox(height: 16),
          GovernanceIssueTable(issues: filteredIssues),
          const SizedBox(height: 32),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Network Parity & Backend Audit',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.green.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Row(
                  children: [
                    Icon(Icons.security, size: 14, color: Colors.green),
                    SizedBox(width: 4),
                    Text(
                      'ZERO-TRUST ENFORCED',
                      style: TextStyle(
                        color: Colors.green,
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
          colors: [Colors.blue.shade900, Colors.blue.shade700],
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
                const Text(
                  'Production Readiness Status',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  '${report.productionReadyScreens} screens meet all production quality gates. ${report.blockedScreens} screens are currently blocked by critical or high-severity issues.',
                  style: TextStyle(
                    color: Colors.white.withValues(alpha: 0.8),
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 32),
          CircularProgressIndicator(
            value: report.totalScreens > 0
                ? report.productionReadyScreens / report.totalScreens
                : 0,
            backgroundColor: Colors.white.withValues(alpha: 0.2),
            valueColor: const AlwaysStoppedAnimation<Color>(Colors.greenAccent),
            strokeWidth: 8,
          ),
        ],
      ),
    );
  }
}
