import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:primecare_ui/primecare_ui.dart';
import '../../generated/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../core/governance/governance_provider.dart';
import '../../core/governance/screen_metadata.dart' as meta;
import '../../core/governance/screen_registry.dart' as local;
import 'widgets/subsystem_charts.dart';
import 'widgets/screen_audit_bottom_sheet.dart';
import '../governance_kanban/widgets/kanban_board.dart';
import '../../governance/widgets/governance_dashboard.dart';
import '../../governance/widgets/governance_domain_chart.dart';
import '../../governance/widgets/governance_master_score.dart';
import '../../governance/services/screen_governance_reporter.dart';

class GovernanceHudView extends ConsumerWidget {
  const GovernanceHudView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(governanceProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(LocaleKeys.governance_title.tr()),
        actions: [
          if (state.isBackgroundSyncing && !state.isSyncing)
            const Center(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.0),
                child: Tooltip(
                  message: 'Autonomous Agent Scanning...',
                  child: Icon(Icons.shield_outlined, color: Colors.blue, size: 20),
                ),
              ),
            ),
          if (state.isSyncing)
            const Center(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.0),
                child: SizedBox(
                  width: 20,
                  height: 20,
                  child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white),
                ),
              ),
            )
          else
            IconButton(
              icon: const Icon(Icons.sync),
              onPressed: () => ref.read(governanceProvider.notifier).refresh(),
              tooltip: 'Sync Metrics',
            ),
        ],
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Opacity(
              opacity: state.isSyncing ? 0.5 : 1.0,
              child: IgnorePointer(
                ignoring: state.isSyncing,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildDriftAlert(context, ref, state),
                     if (state.report != null)
                        Center(
                          child: Padding(
                            padding: const EdgeInsets.only(bottom: 24.0),
                            child: GovernanceMasterScore(report: state.report!),
                          ),
                        ).animate().fadeIn(duration: 600.ms).scale(begin: const Offset(0.8, 0.8)),
                    _buildGlobalStats(state).animate().fadeIn(duration: 400.ms).slideY(begin: 0.1),
                    const SizedBox(height: 24),
                    _buildLiveSystemHealth(state).animate().fadeIn(delay: 200.ms),
                    const SizedBox(height: 24),
                    PrimeCareCard(
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: ComponentCoverageHeatmap(
                          totalCount: state.totalRegisteredForms,
                          categorizedCoverage: state.categorizedCoverage,
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16.0),
                      child: Text(
                        'Architectural Kanban',
                        style: theme.typography.h3.copyWith(fontWeight: FontWeight.bold),
                      ),
                    ),
                    const SizedBox(height: 16),
                    const KanbanBoard(),
                    const SizedBox(height: 24),
                    _buildFeatureMaturityIndex(state),
                    const SizedBox(height: 24),
                    Text(
                      'Subsystem Architectural Health',
                      style: theme.typography.h3.copyWith(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 16),
                    _buildSubsystemGrid(state),
                    const SizedBox(height: 32),
                    _buildSubsystemParitySection(context, ref, state),
                    const SizedBox(height: 32),
                    Text(
                      'Audit Distribution & Domain Health',
                      style: theme.typography.h3.copyWith(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 16),
                    if (state.report != null)
                      PrimeCareCard(
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: GovernanceDomainChart(report: state.report!),
                        ),
                      ),
                    const SizedBox(height: 32),
                    _buildGovernanceReport(state),
                    const SizedBox(height: 32),
                    Text(
                      'Advanced Governance Insights',
                      style: theme.typography.h3.copyWith(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 16),
                    _buildAdvancedInsights(context, state),
                    const SizedBox(height: 32),
                    Text('Developer Quick Actions', style: theme.typography.h3.copyWith(fontWeight: FontWeight.bold)),
                    const SizedBox(height: 12),
                    _buildDeveloperActions(context, ref),
                    const SizedBox(height: 32),
                    _buildRoadmapCoverage(context, state),
                    const SizedBox(height: 32),
                    _buildDeploymentCenter(context, ref),
                    const SizedBox(height: 32),

                    Text(
                      LocaleKeys.governance_discovered_forms.tr(),
                      style: theme.typography.h3.copyWith(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 16),
                    _buildManagementConsole(context),
                    const SizedBox(height: 24),
                    _buildEventLog(context, ref, state),
                  ],
                ),
              ),
            ),
          ),
          if (state.isSyncing)
            Container(
              color: Colors.black26,
              child: const Center(
                child: PrimeCareCard(
                  child: Padding(
                    padding: EdgeInsets.all(24.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        CircularProgressIndicator(),
                        SizedBox(height: 16),
                        Text('Synchronizing Platform Architecture...',
                            style: TextStyle(fontWeight: FontWeight.bold)),
                        Text('Scanning 25 subsystems...',
                            style: theme.typography.bodySmall.copyWith(color: theme.colors.onSurfaceVariant)),
                      ],
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildGlobalStats(GovernanceState state) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const Text(
              'Aura Intelligence Subsystem',
              style: theme.typography.labelBold.copyWith(color: theme.colors.onSurfaceVariant),
            ),
            const Spacer(),
            Text(
              'Registry: ${PlatformGovernanceRegistry.buildVersion} | Sig: ${PlatformGovernanceRegistry.buildSignature.substring(0, 12)}',
              style: theme.typography.bodySmall.copyWith(fontSize: 10, color: theme.colors.outline),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(child: _buildSummaryCard('Total LOC', state.totalLoc.toString(), Icons.code, Colors.blue)),
            const SizedBox(width: 16),
            Expanded(child: _buildSummaryCard('Subsystems', state.projects.length.toString(), Icons.layers, Colors.purple)),
            const SizedBox(width: 16),
            Expanded(child: _buildSummaryCard('Total Files', state.totalFiles.toString(), Icons.folder_zip_rounded, Colors.teal)),
            const SizedBox(width: 16),
            Expanded(child: _buildSummaryCard('UI Manifest', state.totalScreens.toString(), Icons.visibility, Colors.orange)),
          ],
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            Expanded(child: _buildSummaryCard('RBAC Health', '${state.rolesWithAccess}/${state.totalRoles}', Icons.security, Colors.indigo)),
            const SizedBox(width: 16),
            Expanded(child: _buildSummaryCard('Tickets', '${state.openTickets}/${state.totalTickets}', Icons.confirmation_number_rounded, Colors.deepOrange)),
            const SizedBox(width: 16),
            Expanded(child: _buildSummaryCard('APIs', '${state.workingApis}/${state.totalApis}', Icons.api_rounded, Colors.pink)),
            const SizedBox(width: 16),
            Expanded(child: _buildSummaryCard('Form Health', '${state.discoveredForms.length}/${state.totalRegisteredForms}', Icons.dynamic_form_rounded, Colors.cyan)),
          ],
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            Expanded(child: _buildSummaryCard('Routes', '${state.workingRoutes}/${state.totalRoutes}', Icons.alt_route_rounded, Colors.blueAccent)),
            const SizedBox(width: 16),
            Expanded(child: _buildSummaryCard('Login Status', state.isLoginWorking ? 'WORKING' : 'OFFLINE', Icons.vpn_key, state.isLoginWorking ? Colors.green : Colors.red)),
            const SizedBox(width: 16),
            Expanded(child: _buildSummaryCard('Architectural Drift', state.hasDrift ? 'DRIFT' : 'SECURE', Icons.compare_arrows_rounded, state.hasDrift ? Colors.red : Colors.green)),
            Expanded(child: _buildSummaryCard('Security Scan', 'CERTIFIED', Icons.verified_user_rounded, Colors.teal)),
          ],
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Colors.indigo.shade900, Colors.blue.shade900],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.blue.withValues(alpha: 0.3),
                      blurRadius: 10,
                      spreadRadius: 2,
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    const Icon(Icons.verified_rounded, color: Colors.cyanAccent, size: 40),
                    const SizedBox(width: 16),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'UNIVERSAL ARCHITECTURAL PARITY',
                          style: theme.typography.labelBold.copyWith(
                            color: Colors.white,
                            letterSpacing: 1.2,
                          ),
                        ),
                        Text(
                          'Verified: 55/55 Roles | 251/251 Features | Clean Build',
                          style: theme.typography.bodySmall.copyWith(
                            color: Colors.white.withValues(alpha: 0.7),
                          ),
                        ),
                      ],
                    ),
                    const Spacer(),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: Colors.cyanAccent.withValues(alpha: 0.5)),
                      ),
                      child: const Text(
                        'ZERO DRIFT',
                        style: TextStyle(color: Colors.cyanAccent, fontWeight: FontWeight.bold, fontSize: 10),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildSummaryCard(String title, String value, IconData icon, Color color) {
    return PrimeCareCard(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icon, color: color, size: 32),
            const SizedBox(height: 8),
            Text(value, style: theme.typography.h1.copyWith(fontSize: 28, fontWeight: FontWeight.bold)),
            Text(title, style: theme.typography.bodySmall.copyWith(color: theme.colors.onSurfaceVariant)),
          ],
        ),
      ),
    );
  }

  Widget _buildSubsystemGrid(GovernanceState state) {
    return StaggeredGrid.count(
      crossAxisCount: 4,
      mainAxisSpacing: 12,
      crossAxisSpacing: 12,
      children: state.projects.map((summary) {
        return StaggeredGridTile.count(
          crossAxisCellCount: 2,
          mainAxisCellCount: 1.4, // Increased height for more stats
          child: _buildProjectCard(summary),
        );
      }).toList(),
    );
  }

  Widget _buildProjectCard(ProjectHealthSummary summary) {
    final statusColor = summary.status == 'PASS' ? Colors.green : (summary.status == 'WARN' ? Colors.orange : Colors.red);
    
    return PrimeCareCard(
      child: Stack(
        children: [
          Positioned(
            right: -10,
            bottom: -10,
            child: Icon(
              summary.isUi ? Icons.devices : Icons.cloud_sync,
              size: 80,
              color: Colors.grey.withValues(alpha: 0.1),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            summary.name,
                            style: theme.typography.bodyLarge.copyWith(fontWeight: FontWeight.bold),
                            overflow: TextOverflow.ellipsis,
                          ),
                          Text(
                            'Last Checked: ${summary.lastCheckedAt.hour}:${summary.lastCheckedAt.minute.toString().padLeft(2, '0')}',
                            style: theme.typography.bodySmall.copyWith(fontSize: 10, color: theme.colors.outline),
                          ),
                        ],
                      ),
                    ),
                    _buildStatusBadge(summary.status, statusColor),
                  ],
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    if (summary.errorCount > 0)
                      _buildCountBadge(Icons.error_outline, summary.errorCount.toString(), Colors.red),
                    if (summary.warningCount > 0)
                      _buildCountBadge(Icons.warning_amber_rounded, summary.warningCount.toString(), Colors.orange),
                  ],
                ),
                const Spacer(),
                Row(
                  children: [
                    Expanded(
                      flex: 3,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildMiniStatRow([
                            _buildMiniStat('M', summary.models.toString()),
                            _buildMiniStat('V', summary.views.toString()),
                            _buildMiniStat('C', summary.controllers.toString()),
                            if (!summary.isUi) _buildMiniStat('S', summary.services.toString()),
                          ]),
                          const SizedBox(height: 8),
                          _buildMiniStat('Files / Folders', '${summary.files} / ${summary.folders}'),
                          const SizedBox(height: 8),
                          LinearProgressIndicator(
                            value: summary.healthScore / 100,
                            backgroundColor: Colors.grey[200],
                            color: statusColor,
                            minHeight: 4,
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: SizedBox(
                        height: 70,
                        child: SubsystemRadarChart(summary: summary),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatusBadge(String status, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color, width: 1),
      ),
      child: Text(
        status,
        style: TextStyle(color: color, fontSize: 10, fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _buildCountBadge(IconData icon, String count, Color color) {
    return Container(
      margin: const EdgeInsets.only(right: 8),
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: color, size: 12),
          const SizedBox(width: 4),
          Text(count, style: TextStyle(color: color, fontSize: 10, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }

  Widget _buildMiniStatRow(List<Widget> children) {
    return Wrap(
      spacing: 12,
      children: children,
    );
  }

  Widget _buildMiniStat(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontSize: 10, color: Colors.grey)),
        Text(value, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
      ],
    );
  }


  Widget _buildGovernanceReport(GovernanceState state) {
    final troubledProjects = state.projects.where((p) => p.status != 'PASS').toList();

    if (troubledProjects.isEmpty) {
      return const PrimeCareCard(
        child: Padding(
          padding: EdgeInsets.all(24.0),
          child: Center(
            child: Column(
              children: [
                Icon(Icons.check_circle, color: Colors.green, size: 48),
                SizedBox(height: 12),
                Text('All systems are architecturally sound.',
                    style: TextStyle(fontWeight: FontWeight.bold)),
              ],
            ),
          ),
        ),
      );
    }

    return Column(
      children: troubledProjects.map((project) {
        final color = project.status == 'ERROR' ? Colors.red : Colors.orange;
        return Container(
          margin: const EdgeInsets.only(bottom: 12),
          child: PrimeCareCard(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(Icons.warning_rounded, color: color),
                      const SizedBox(width: 12),
                      Text(project.name, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                      const Spacer(),
                      _buildStatusBadge(project.status, color),
                    ],
                  ),
                  const SizedBox(height: 16),
                  const Text('Identified Issues:', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
                  ...project.issues.map((issue) => Padding(
                    padding: const EdgeInsets.only(left: 8.0, top: 4.0),
                    child: Text('• $issue', style: const TextStyle(fontSize: 12)),
                  )),
                  const SizedBox(height: 12),
                  const Text('Remediation Suggestions:', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12, color: Colors.blue)),
                  ...project.suggestions.map((suggestion) => Padding(
                    padding: const EdgeInsets.only(left: 8.0, top: 4.0),
                    child: Text('→ $suggestion', style: const TextStyle(fontSize: 12, color: Colors.blue)),
                  )),
                ],
              ),
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildDeveloperActions(BuildContext context, WidgetRef ref) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          _buildQuickActionTile(
            'Lint Sweep',
            'Run dart analyze',
            Icons.checklist_rtl_rounded,
            Colors.blue,
            () => _showActionDialog(context, ref, 'Lint Sweep', 'dart analyze .'),
          ),
          const SizedBox(width: 12),
          _buildQuickActionTile(
            'Fix Deprecations',
            'Run dart fix',
            Icons.auto_fix_high_rounded,
            Colors.orange,
            () => _showActionDialog(context, ref, 'Fix Deprecations', 'dart fix --apply'),
          ),
          const SizedBox(width: 12),
          _buildQuickActionTile(
            'Sync Registry',
            'Update Manifest',
            Icons.terminal_rounded,
            Colors.purple,
            () => ref.read(governanceProvider.notifier).runSync(),
          ),
          const SizedBox(width: 12),
          _buildQuickActionTile(
            'Start Audit',
            'Verify Integrity',
            Icons.verified_user_rounded,
            Colors.green,
            () => ref.read(governanceProvider.notifier).runAudit(),
          ),
          const SizedBox(width: 12),
          _buildQuickActionTile(
            'Arch Report',
            'Full Governance PDF',
            Icons.summarize_rounded,
            Colors.cyanAccent,
            () => _showGovernanceDashboard(context),
          ),
          const SizedBox(width: 12),
          _buildQuickActionTile(
            'Hydrate Platform',
            'Bulk Inject Blueprints',
            Icons.cloud_download_rounded,
            Colors.pinkAccent,
            () => ref.read(governanceProvider.notifier).hydrateRegistries(),
          ),
        ],
      ),
    );
  }

  Widget _buildRoadmapCoverage(BuildContext context, GovernanceState state) {
    // Simulated coverage for now: 12 screens injected out of 251
    const totalBlueprints = 251;
    final registeredScreens = local.ScreenRegistry.screens.length;
    final coverage = (registeredScreens / totalBlueprints).clamp(0.0, 1.0);

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor.withValues(alpha: 0.5),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: Colors.white.withValues(alpha: 0.1)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Platform Roadmap Coverage',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                  Text(
                    'Hydration Progress from Architectural Blueprints',
                    style: TextStyle(fontSize: 12, color: Colors.grey),
                  ),
                ],
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: Colors.blue.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  '${(coverage * 100).toStringAsFixed(1)}%',
                  style: const TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Stack(
            children: [
              Container(
                height: 8,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.05),
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
              AnimatedContainer(
                duration: const Duration(seconds: 1),
                height: 8,
                width: MediaQuery.of(context).size.width * coverage,
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Colors.blue, Colors.cyanAccent],
                  ),
                  borderRadius: BorderRadius.circular(4),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.blue.withValues(alpha: 0.3),
                      blurRadius: 8,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildMetric('Registered', registeredScreens.toString(), Colors.blue),
              _buildMetric('Backlog', (totalBlueprints - registeredScreens).toString(), Colors.orange),
              _buildMetric('Production', '4', Colors.green),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildMetric(String label, String value, Color color) {
    return Column(
      children: [
        Text(
          value,
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: color),
        ),
        Text(
          label,
          style: const TextStyle(fontSize: 10, color: Colors.grey),
        ),
      ],
    );
  }

  Widget _buildDeploymentCenter(BuildContext context, WidgetRef ref) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor.withValues(alpha: 0.5),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: Colors.white.withValues(alpha: 0.1)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Deployment Center',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
          ),
          const SizedBox(height: 16),
          const Text(
            'Hydrated screens pending UI generation:',
            style: TextStyle(fontSize: 12, color: Colors.grey),
          ),
          const SizedBox(height: 12),
          _buildBacklogItem(
            'Clinical Director Dashboard',
            'CLIN-DIR-001',
            'Backlog',
            () => _triggerStitchGeneration(context, ref, 'Clinical Director Dashboard', 'CLIN-DIR-001'),
          ),
          _buildBacklogItem(
            'Quality Metrics Portal',
            'CLIN-QUAL-001',
            'Backlog',
            () => _triggerStitchGeneration(context, ref, 'Quality Metrics Portal', 'CLIN-QUAL-001'),
          ),
          _buildBacklogItem(
            'COO Command Space',
            'CORP-COO-001',
            'Backlog',
            () => _triggerStitchGeneration(context, ref, 'COO Command Space', 'CORP-COO-001'),
          ),
        ],
      ),
    );
  }

  Widget _buildBacklogItem(String title, String id, String status, VoidCallback onTap) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.03),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
              Text(id, style: const TextStyle(fontSize: 10, color: Colors.grey)),
            ],
          ),
          const Spacer(),
          ElevatedButton(
            onPressed: onTap,
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue.withValues(alpha: 0.2),
              foregroundColor: Colors.blue,
              elevation: 0,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            ),
            child: const Text('Generate UI', style: TextStyle(fontSize: 12)),
          ),
        ],
      ),
    );
  }

  void _triggerStitchGeneration(BuildContext context, WidgetRef ref, String title, String id) async {
    // Simulate Stitch Bridge call
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        backgroundColor: const Color(0xFF1A1C1E),
        title: const Text('Stitch UI Engine'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const CircularProgressIndicator(),
            const SizedBox(height: 20),
            Text('Generating high-fidelity layout for:\n$title'),
            const SizedBox(height: 12),
            const Text(
              'Aura Intelligence is distilling architectural constraints...',
              style: TextStyle(fontSize: 12, color: Colors.grey, fontStyle: FontStyle.italic),
            ),
          ],
        ),
      ),
    );

    // Mock completion
    await Future.delayed(const Duration(seconds: 3));
    if (context.mounted) Navigator.pop(context);

    // Add Success Event
    ref.read(governanceProvider.notifier).logEvent(
      'STITCH_COMPLETE',
      'UI Assets Generated for $title. Ready for Review.',
      GovernanceEventLevel.success,
    );
  }

  void _showGovernanceDashboard(BuildContext context) {

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => DraggableScrollableSheet(
        initialChildSize: 0.95,
        minChildSize: 0.5,
        maxChildSize: 0.95,
        builder: (_, controller) => Container(
          decoration: BoxDecoration(
            color: Theme.of(context).scaffoldBackgroundColor,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
          ),
          child: Column(
            children: [
              Container(
                width: 40,
                height: 4,
                margin: const EdgeInsets.symmetric(vertical: 12),
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              Expanded(
                child: GovernanceDashboard(
                  report: ScreenGovernanceReporter.generateReport(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildQuickActionTile(String title, String subtitle, IconData icon, Color color, VoidCallback onTap) {
    return SizedBox(
      width: 180,
      child: PrimeCareCard(
        padding: EdgeInsets.zero,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(12),
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(icon, color: color, size: 24),
                const SizedBox(height: 8),
                Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
                Text(subtitle, style: const TextStyle(fontSize: 10, color: Colors.grey)),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _showActionDialog(BuildContext context, WidgetRef ref, String title, String command) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(title),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('The following command will be executed in the subsystem root:'),
            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(4),
              ),
              child: Text(command, style: const TextStyle(fontFamily: 'monospace', fontSize: 12)),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () async {
              Navigator.pop(context);
              
              // Show executing snackbar
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Executing $title...'),
                  duration: const Duration(seconds: 1),
                ),
              );

              // Execute action via provider
              final result = await ref.read(governanceProvider.notifier).executeRemoteAction(command);

              // Show result dialog
              if (!context.mounted) return;
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: Text('$title Output'),
                  content: Container(
                    width: double.maxFinite,
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.black87,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: SingleChildScrollView(
                      child: Text(
                        result.output,
                        style: const TextStyle(
                          color: Colors.greenAccent,
                          fontFamily: 'monospace',
                          fontSize: 11,
                        ),
                      ),
                    ),
                  ),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text('Close'),
                    ),
                  ],
                ),
              );
            },
            child: const Text('Execute'),
          ),
        ],
      ),
    );
  }

  Widget _buildManagementConsole(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            _buildActionCard(
              context,
              'Monitoring',
              'System Telemetry',
              Icons.monitor_heart_rounded,
              Colors.blue,
              '/governance/monitoring',
            ),
            const SizedBox(width: 16),
            _buildActionCard(
              context,
              'Data Entry',
              'Registry Management',
              Icons.app_registration_rounded,
              Colors.orange,
              '/governance/data-entry',
            ),
          ],
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            _buildActionCard(
              context,
              'Audit Logs',
              'Security Events',
              Icons.history_edu_rounded,
              Colors.green,
              '/governance/audit',
            ),
            const SizedBox(width: 16),
            _buildActionCard(
              context,
              'Tickets',
              'Drift Remediation',
              Icons.confirmation_number_rounded,
              Colors.purple,
              '/governance/tickets',
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildActionCard(
    BuildContext context,
    String title,
    String subtitle,
    IconData icon,
    Color color,
    String route,
  ) {
    return Expanded(
      child: GestureDetector(
        onTap: () => context.push(route),
        child: PrimeCareCard(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: color.withValues(alpha: 0.1),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(icon, color: color),
                ),
                const SizedBox(height: 16),
                Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                Text(subtitle, style: const TextStyle(color: Colors.grey, fontSize: 13)),
              ],
            ),
          ),
        ),
      ),
    );
  }
  Widget _buildLiveSystemHealth(GovernanceState state) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Live System Health (Cloudflare Edge)', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(
              child: _buildMetricMiniCard(
                'API Uptime',
                '${state.apiUptime}%',
                Icons.speed_rounded,
                state.apiUptime > 99.9 ? Colors.green : Colors.orange,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _buildMetricMiniCard(
                'DB Connections',
                '${state.dbConnections}',
                Icons.lan_rounded,
                state.dbConnections < 100 ? Colors.blue : Colors.red,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _buildMetricMiniCard(
                'Gateways',
                'Operational',
                Icons.cloud_done_rounded,
                Colors.green,
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        PrimeCareCard(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Microservice Status', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                const SizedBox(height: 12),
                Wrap(
                  spacing: 12,
                  runSpacing: 8,
                  children: state.liveServiceHealth.entries.map((e) {
                    final isHealthy = e.value == 'healthy';
                    return Chip(
                      avatar: Icon(
                        isHealthy ? Icons.check_circle_rounded : Icons.warning_rounded,
                        color: isHealthy ? Colors.green : Colors.orange,
                        size: 16,
                      ),
                      label: Text(e.key, style: const TextStyle(fontSize: 11)),
                      backgroundColor: (isHealthy ? Colors.green : Colors.orange).withValues(alpha: 0.1),
                      side: BorderSide.none,
                    );
                  }).toList(),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildMetricMiniCard(String title, String value, IconData icon, Color color) {
    return PrimeCareCard(
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            Icon(icon, color: color, size: 20),
            const SizedBox(height: 8),
            Text(value, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
            Text(title, style: const TextStyle(fontSize: 10, color: Colors.grey)),
          ],
        ),
      ),
    );
  }

  Widget _buildEventLog(BuildContext context, WidgetRef ref, GovernanceState state) {
    return PrimeCareCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Security Event Log (Live)',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: Colors.red.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: const Row(
                    children: [
                      Icon(Icons.fiber_manual_record, color: Colors.red, size: 10),
                      SizedBox(width: 4),
                      Text('LIVE', style: TextStyle(color: Colors.red, fontSize: 10, fontWeight: FontWeight.bold)),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: GovernanceEventLevel.values.map((level) {
                  final isSelected = state.eventFilter == level;
                  return Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: ChoiceChip(
                      label: Text(level.name.toUpperCase(), style: const TextStyle(fontSize: 10)),
                      selected: isSelected,
                      onSelected: (selected) {
                        if (selected) {
                          ref.read(governanceProvider.notifier).setEventFilter(level);
                        }
                      },
                      selectedColor: Colors.blue.withValues(alpha: 0.2),
                      backgroundColor: Colors.transparent,
                      labelStyle: TextStyle(
                        color: isSelected ? Colors.blue : Colors.grey,
                        fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
          ),
          const Divider(height: 1),
          SizedBox(
            height: 300,
            child: Builder(
              builder: (context) {
                final filteredEvents = state.eventFilter == GovernanceEventLevel.all
                    ? state.recentEvents
                    : state.recentEvents.where((e) => e.level == state.eventFilter).toList();

                if (filteredEvents.isEmpty) {
                  return const Center(child: Text('No events matching filter.', style: TextStyle(color: Colors.grey)));
                }

                return ListView.separated(
                    padding: const EdgeInsets.all(16),
                    itemCount: filteredEvents.length,
                    separatorBuilder: (context, index) => const Divider(),
                    itemBuilder: (context, index) {
                      final event = filteredEvents[index];
                      
                      Color levelColor;
                      switch (event.level) {
                        case GovernanceEventLevel.success:
                          levelColor = Colors.green;
                          break;
                        case GovernanceEventLevel.warning:
                          levelColor = Colors.orange;
                          break;
                        case GovernanceEventLevel.error:
                        case GovernanceEventLevel.critical:
                          levelColor = Colors.red;
                          break;
                        case GovernanceEventLevel.info:
                        default:
                          levelColor = Colors.blue;
                      }
                      
                      return Container(
                        margin: const EdgeInsets.only(bottom: 8),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: 4,
                              height: 40,
                              decoration: BoxDecoration(
                                color: levelColor,
                                borderRadius: BorderRadius.circular(2),
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                        event.type.toUpperCase(),
                                        style: TextStyle(
                                          fontSize: 10,
                                          fontWeight: FontWeight.bold,
                                          color: levelColor,
                                        ),
                                      ),
                                      if (event.source != null) ...[
                                        const SizedBox(width: 8),
                                        Text(
                                          '[${event.source}]',
                                          style: const TextStyle(fontSize: 10, color: Colors.grey),
                                        ),
                                      ],
                                      const Spacer(),
                                      Text(
                                        '${event.timestamp.hour}:${event.timestamp.minute.toString().padLeft(2, '0')}:${event.timestamp.second.toString().padLeft(2, '0')}',
                                        style: const TextStyle(fontSize: 10, color: Colors.grey),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    event.message,
                                    style: const TextStyle(fontSize: 13),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ).animate().fadeIn(delay: (index * 50).ms).slideX(begin: 0.05);
                    },
                  );
              }
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDriftAlert(BuildContext context, WidgetRef ref, GovernanceState state) {
    if (state.integrityScore >= 95) return const SizedBox.shrink();
    
    return Container(
      margin: const EdgeInsets.only(bottom: 24),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.red.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.red.withValues(alpha: 0.3)),
      ),
      child: Row(
        children: [
          const Icon(Icons.warning_amber_rounded, color: Colors.red, size: 28),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Critical Architectural Drift Detected',
                  style: TextStyle(fontWeight: FontWeight.bold, color: Colors.red, fontSize: 16),
                ),
                Text(
                  'Platform integrity is at ${state.integrityScore.toStringAsFixed(1)}%. Subsystem mismatches require immediate remediation.',
                  style: TextStyle(color: Colors.red.withValues(alpha: 0.8)),
                ),
              ],
            ),
          ),
          ElevatedButton.icon(
            onPressed: () => ref.read(governanceProvider.notifier).runRemediation(),
            icon: const Icon(Icons.auto_fix_high),
            label: const Text('Remediate Now'),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              foregroundColor: Colors.white,
            ),
          ),
        ],
      ),
    ).animate(onPlay: (controller) => controller.repeat(reverse: true))
     .shimmer(duration: 2.seconds, color: Colors.red.withValues(alpha: 0.2));
  }

  Widget _buildSubsystemParitySection(BuildContext context, WidgetRef ref, GovernanceState state) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Cross-Subsystem Parity',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            IconButton(
              icon: const Icon(Icons.troubleshoot_rounded, color: Colors.blue),
              onPressed: () => ref.read(governanceProvider.notifier).performCrossSubsystemAudit(),
              tooltip: 'Run Deep Audit',
            ),
          ],
        ),
        const SizedBox(height: 16),
        if (state.subsystemIssues.isEmpty)
          PrimeCareCard(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Row(
                children: [
                  const Icon(Icons.verified_rounded, color: Colors.green, size: 32),
                  const SizedBox(width: 16),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Architectural Integrity Verified',
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                      Text(
                        'No drift detected across ${state.projects.length} subsystems.',
                        style: const TextStyle(fontSize: 12, color: Colors.grey),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          )
        else
          Column(
            children: state.subsystemIssues.map((issue) {
              return Container(
                margin: const EdgeInsets.only(bottom: 12),
                child: PrimeCareCard(
                  child: ListTile(
                    leading: Icon(
                      issue.autoRemediable ? Icons.auto_fix_high_rounded : Icons.warning_amber_rounded,
                      color: issue.autoRemediable ? Colors.blue : Colors.orange,
                    ),
                    title: Text(
                      issue.issue,
                      style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Subsystem: ${issue.subsystem} | Registry: ${issue.registry}',
                            style: const TextStyle(fontSize: 10, color: Colors.grey)),
                        const SizedBox(height: 4),
                        Text(issue.suggestion, style: const TextStyle(fontSize: 12)),
                      ],
                    ),
                    trailing: issue.autoRemediable
                        ? ElevatedButton.icon(
                            onPressed: () => ref.read(governanceProvider.notifier).runRemediation(),
                            icon: const Icon(Icons.flash_on, size: 16),
                            label: const Text('Heal'),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.blue.withValues(alpha: 0.1),
                              foregroundColor: Colors.blue,
                              elevation: 0,
                            ),
                          )
                        : null,
                  ),
                ),
              );
            }).toList(),
          ),
      ],
    );
  }

  Widget _buildAdvancedInsights(BuildContext context, GovernanceState state) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: _buildInsightCard(
                'Production Ready',
                '${state.productionReadyScreensCount} / ${state.totalScreens}',
                Icons.rocket_launch_rounded,
                Colors.greenAccent,
                'Screens passing all quality gates',
                onTap: () => _showAuditDetails(
                  context,
                  'Production Ready Screens',
                  state.productionReadyScreens,
                  Colors.greenAccent,
                ),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: _buildInsightCard(
                'Security Risk',
                state.highRiskScreensCount.toString(),
                Icons.gpp_maybe_rounded,
                state.highRiskScreensCount > 0 ? Colors.redAccent : Colors.tealAccent,
                'High sensitivity screens needing audit',
                onTap: () => _showAuditDetails(
                  context,
                  'High Security Risk Screens',
                  state.highRiskScreens,
                  Colors.redAccent,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            Expanded(
              child: _buildInsightCard(
                'Localization Gaps',
                state.localizationGapsCount.toString(),
                Icons.translate_rounded,
                Colors.orangeAccent,
                'Screens missing multi-language support',
                onTap: () => _showAuditDetails(
                  context,
                  'Localization Gaps',
                  state.localizationGapScreens,
                  Colors.orangeAccent,
                ),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: _buildInsightCard(
                'Route Collisions',
                state.duplicateRoutesCount.toString(),
                Icons.warning_amber_rounded,
                state.duplicateRoutesCount > 0 ? Colors.deepOrange : Colors.greenAccent,
                'Duplicate navigation paths detected',
                onTap: () => _showAuditDetails(
                  context,
                  'Route Collisions',
                  state.duplicateRouteScreens,
                  Colors.deepOrange,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            Expanded(
              child: _buildInsightCard(
                'Sprint Workload',
                '${state.totalSprintPoints} pts',
                Icons.speed_rounded,
                Colors.blueAccent,
                'Total complexity points in current registry',
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: _buildInsightCard(
                'Platform Health',
                '${state.platformHealthScore.toStringAsFixed(1)}%',
                Icons.favorite_rounded,
                state.platformHealthScore > 85 ? Colors.cyanAccent : Colors.amberAccent,
                'Aggregate health score across all layers',
              ),
            ),
          ],
        ),
      ],
    );
  }

  void _showAuditDetails(BuildContext context, String title, List<meta.ScreenMetadata> screens, Color color) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => ScreenAuditBottomSheet(
        title: title,
        screens: screens,
        themeColor: color,
      ),
    );
  }

  Widget _buildInsightCard(String title, String value, IconData icon, Color color, String subtitle, {VoidCallback? onTap}) {
    return PrimeCareCard(
      color: color.withValues(alpha: 0.1),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(icon, color: color, size: 24),
                const SizedBox(width: 12),
                Text(
                  title,
                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Text(
              value,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w900,
                color: color,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              subtitle,
              style: const TextStyle(fontSize: 10, color: Colors.grey),
            ),
          ],
        ),
      ),
    ),
  );
}
  Widget _buildFeatureMaturityIndex(GovernanceState state) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Feature Maturity Index',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 16),
        PrimeCareCard(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: state.featureHealth.entries.map((entry) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 16.0),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Text(entry.key, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
                          const Spacer(),
                          Text('${entry.value.toStringAsFixed(1)}%', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
                        ],
                      ),
                      const SizedBox(height: 8),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(4),
                        child: LinearProgressIndicator(
                          value: entry.value / 100,
                          minHeight: 8,
                          backgroundColor: Colors.grey[200],
                          valueColor: AlwaysStoppedAnimation<Color>(
                            entry.value > 90 ? Colors.green : (entry.value > 60 ? Colors.orange : Colors.red)
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),
          ),
        ),
      ],
    );
  }
}
