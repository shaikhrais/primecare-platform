import 'package:primecare_ui/primecare_ui.dart';
import 'governance_dashboard_controller.dart';
import '../../core/governance/screen_registry.dart' as local_registry;
import '../../governance/models/governance_issue.dart';
import '../../governance/models/governance_report.dart';
import '../../governance/widgets/governance_kpi_grid.dart';
import '../../governance/widgets/governance_issue_table.dart';
import '../../governance/widgets/governance_filter_bar.dart';
import '../../governance/widgets/governance_patch_manager.dart';
import '../../governance/widgets/governance_domain_chart.dart';
import '../../governance/widgets/governance_compliance_checklist.dart';
import '../../governance/widgets/governance_master_score.dart';
import '../../governance/widgets/governance_trend_chart.dart';
import '../../governance/widgets/governance_event_feed.dart';
import '../../core/governance/governance_provider.dart';
import '../clinical_reference/widgets/clinical_education_dashboard_widget.dart';

class GovernanceDashboardView extends GovernedConsumerWidget {
  const GovernanceDashboardView({super.key});

  void _exportReport(
    BuildContext context,
    WidgetRef ref,
    GovernanceReport report,
    String format,
  ) async {
    final controller = ref.read(governanceDashboardControllerProvider.notifier);
    final isPdf = await controller.exportReport(report, format);

    if (context.mounted) {
      if (isPdf) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
              'Professional PDF Report Generated (Ready for Download)',
            ),
            backgroundColor: Colors.blue,
            behavior: SnackBarBehavior.floating,
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'Report exported as $format and copied to clipboard!',
            ),
            backgroundColor: Colors.blue,
            behavior: SnackBarBehavior.floating,
          ),
        );
      }
    }
  }

  @override
  Widget buildScreen(BuildContext context, WidgetRef ref) {
    final theme = context.theme;
    final governanceState = ref.watch(governanceProvider);
    final report = governanceState.report;

    if (report == null) {
      return const Center(child: CircularProgressIndicator());
    }

    return DefaultTabController(
      length: 2,
      child: Container(
        color: theme.colors.background,
        child: Column(
          children: [
            Material(
              color: theme.colors.surface,
              elevation: 0,
              child: Container(
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(color: theme.colors.outlineVariant),
                  ),
                ),
                child: TabBar(
                  labelColor: theme.colors.primary,
                  unselectedLabelColor: theme.colors.onSurfaceVariant,
                  indicatorColor: theme.colors.primary,
                  indicatorWeight: 3,
                  labelStyle: theme.typography.bodyMedium.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                  unselectedLabelStyle: theme.typography.bodyMedium,
                  tabs: [
                    Tab(text: 'Platform Audit'.tr()),
                    Tab(text: 'Remediation Patches'.tr()),
                  ],
                ),
              ),
            ),
            Expanded(
              child: TabBarView(
                children: [
                  _buildAuditView(context, ref, report, governanceState),
                  GovernancePatchManager(
                    issues: _getFilteredIssues(ref, report),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<GovernanceIssue> _getFilteredIssues(
    WidgetRef ref,
    GovernanceReport report,
  ) {
    final state = ref.watch(governanceDashboardControllerProvider);
    return report.issues.where((issue) {
      final matchesSeverity =
          state.selectedSeverity == null ||
          issue.severity == state.selectedSeverity;
      final matchesCategory =
          state.selectedCategory == null ||
          issue.category == state.selectedCategory;
      final matchesSearch =
          state.searchQuery.isEmpty ||
          issue.screenId.toLowerCase().contains(
            state.searchQuery.toLowerCase(),
          ) ||
          issue.title.toLowerCase().contains(state.searchQuery.toLowerCase());
      return matchesSeverity && matchesCategory && matchesSearch;
    }).toList();
  }

  Widget _buildAuditView(
    BuildContext context,
    WidgetRef ref,
    GovernanceReport report,
    GovernanceState governanceState,
  ) {
    final filteredIssues = _getFilteredIssues(ref, report);
    final controller = ref.read(governanceDashboardControllerProvider.notifier);
    final state = ref.watch(governanceDashboardControllerProvider);

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
                    'Live architectural audit of ${local_registry.ScreenRegistry.screens.length} platform screens',
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
                                  .read(governanceProvider.notifier)
                                  .applyAutomatedFixes(),
                        icon: governanceState.isSyncing
                            ? const SizedBox(
                                width: 16,
                                height: 16,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                ),
                              )
                            : const Icon(Icons.auto_fix_high_rounded, size: 20),
                        label: const Text('Auto-Remediate'),
                        style: OutlinedButton.styleFrom(
                          foregroundColor: Colors.blue,
                          side: const BorderSide(color: Colors.blue),
                        ),
                      ),
                    ),
                  PopupMenuButton<String>(
                    onSelected: (format) =>
                        _exportReport(context, ref, report, format),
                    itemBuilder: (context) => [
                      const PopupMenuItem(
                        value: 'pdf',
                        child: Text('Professional PDF Report'),
                      ),
                      const PopupMenuItem(
                        value: 'html',
                        child: Text('Export HTML (Professional)'),
                      ),
                      const PopupMenuItem(
                        value: 'markdown',
                        child: Text('Export Markdown'),
                      ),
                      const PopupMenuItem(
                        value: 'json',
                        child: Text('Export JSON'),
                      ),
                      const PopupMenuItem(
                        value: 'csv',
                        child: Text('Export CSV'),
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
                      child: const Row(
                        children: [
                          Icon(
                            Icons.download_rounded,
                            color: Colors.blue,
                            size: 20,
                          ),
                          SizedBox(width: 8),
                          Text(
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
                    onPressed: () =>
                        ref.read(governanceProvider.notifier).refresh(),
                    icon: const Icon(Icons.refresh_rounded),
                    label: const Text('Re-Scan'),
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
          const ClinicalEducationDashboardWidget(),
          const SizedBox(height: 32),
          _buildClinicalTip(context, ref),
          const SizedBox(height: 32),
          Row(
            children: [
              Expanded(
                child: GovernanceFilterBar(
                  selectedSeverity: state.selectedSeverity,
                  selectedCategory: state.selectedCategory,
                  onSeverityChanged: controller.setSeverity,
                  onCategoryChanged: controller.setCategory,
                  onClear: controller.clearFilters,
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
                  onChanged: controller.setSearchQuery,
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
          GovernanceComplianceChecklist(report: report),
          const SizedBox(height: 32),
          _buildReadinessPanel(report),
        ],
      ),
    );
  }

  Widget _buildClinicalTip(BuildContext context, WidgetRef ref) {
    final theme = context.theme;
    final tipAsync = ref.watch(clinicalTipProvider);

    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: theme.colors.primary.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: theme.colors.primary.withValues(alpha: 0.1)),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: theme.colors.primary.withValues(alpha: 0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(LucideIcons.lightbulb, color: theme.colors.primary),
          ),
          const SizedBox(width: 20),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Clinical Tip of the Day',
                  style: theme.typography.h3.copyWith(
                    color: theme.colors.primary,
                  ),
                ),
                const SizedBox(height: 8),
                tipAsync.when(
                  data: (article) => ClinicalTermHighlighter(
                    text:
                        article?.content ??
                        'No clinical tips available at the moment.',
                  ),
                  loading: () => const Text('Loading clinical tip...'),
                  error: (e, _) => const Text('Unable to load clinical tip.'),
                ),
              ],
            ),
          ),
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
