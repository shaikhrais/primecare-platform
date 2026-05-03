import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/services.dart';
import '../../core/governance/screen_registry.dart';
import '../services/governance_exporter.dart';
import '../models/governance_issue.dart';
import '../models/governance_report.dart';
import '../models/governance_severity.dart';
import '../models/governance_category.dart';
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

class GovernanceDashboard extends ConsumerStatefulWidget {
  final GovernanceReport? report;
  const GovernanceDashboard({super.key, this.report});

  @override
  ConsumerState<GovernanceDashboard> createState() => _GovernanceDashboardState();
}

class _GovernanceDashboardState extends ConsumerState<GovernanceDashboard> with SingleTickerProviderStateMixin {
  late GovernanceReport _report;
  late TabController _tabController;
  
  GovernanceSeverity? _selectedSeverity;
  GovernanceCategory? _selectedCategory;
  String _searchQuery = '';

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _refreshReport();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  void _refreshReport() {
    ref.read(governanceProvider.notifier).refresh();
  }

  Future<void> _exportReport(String format) async {
    String content = '';
    
    if (format == 'pdf') {
      await GovernanceExporter.toPdf(_report);
      // In a real app, use path_provider and file_picker to save
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Professional PDF Report Generated (Ready for Download)'),
            backgroundColor: Colors.blue,
            behavior: SnackBarBehavior.floating,
          ),
        );
      }
      return;
    }

    switch (format) {
      case 'markdown':
        content = GovernanceExporter.toMarkdown(_report);
        break;
      case 'html':
        content = GovernanceExporter.toHtml(_report);
        break;
      case 'json':
        content = GovernanceExporter.toJson(_report);
        break;
      case 'csv':
        content = GovernanceExporter.toCsv(_report);
        break;
    }

    await Clipboard.setData(ClipboardData(text: content));
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Report exported as $format and copied to clipboard!'),
        backgroundColor: Colors.blue,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final governanceState = ref.watch(governanceProvider);
    final report = governanceState.report;

    if (report == null) {
      return const Center(child: CircularProgressIndicator());
    }

    _report = report; // Keep for backward compatibility in some methods

    final filteredIssues = _report.issues.where((issue) {
      final matchesSeverity = _selectedSeverity == null || issue.severity == _selectedSeverity;
      final matchesCategory = _selectedCategory == null || issue.category == _selectedCategory;
      final matchesSearch = _searchQuery.isEmpty || 
                            issue.screenId.toLowerCase().contains(_searchQuery.toLowerCase()) ||
                            issue.title.toLowerCase().contains(_searchQuery.toLowerCase());
      return matchesSeverity && matchesCategory && matchesSearch;
    }).toList();

    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(48),
        child: Container(
          decoration: BoxDecoration(
            color: Theme.of(context).cardColor,
            border: Border(bottom: BorderSide(color: Colors.grey.withValues(alpha: 0.1))),
          ),
          child: TabBar(
            controller: _tabController,
            labelColor: Colors.blue,
            unselectedLabelColor: Colors.grey,
            indicatorColor: Colors.blue,
            tabs: const [
              Tab(text: 'Platform Audit'),
              Tab(text: 'Remediation Patches'),
            ],
          ),
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildAuditView(filteredIssues, governanceState),
          GovernancePatchManager(issues: filteredIssues),
        ],
      ),
    );
  }

  Widget _buildAuditView(List<GovernanceIssue> filteredIssues, GovernanceState governanceState) {
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
                  if (governanceState.hasDrift || governanceState.brokenScreens > 0)
                    Padding(
                      padding: const EdgeInsets.only(right: 12),
                      child: OutlinedButton.icon(
                        onPressed: governanceState.isSyncing 
                          ? null 
                          : () => ref.read(governanceProvider.notifier).applyAutomatedFixes(),
                        icon: governanceState.isSyncing 
                          ? const SizedBox(width: 16, height: 16, child: CircularProgressIndicator(strokeWidth: 2))
                          : const Icon(Icons.auto_fix_high_rounded, size: 20),
                        label: const Text('Auto-Remediate'),
                        style: OutlinedButton.styleFrom(
                          foregroundColor: Colors.blue,
                          side: const BorderSide(color: Colors.blue),
                        ),
                      ),
                    ),
                  PopupMenuButton<String>(
                    onSelected: _exportReport,
                    itemBuilder: (context) => [
                      const PopupMenuItem(value: 'pdf', child: Text('Professional PDF Report')),
                      const PopupMenuItem(value: 'html', child: Text('Export HTML (Professional)')),
                      const PopupMenuItem(value: 'markdown', child: Text('Export Markdown')),
                      const PopupMenuItem(value: 'json', child: Text('Export JSON')),
                      const PopupMenuItem(value: 'csv', child: Text('Export CSV')),
                    ],
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.blue),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Row(
                        children: [
                          Icon(Icons.download_rounded, color: Colors.blue, size: 20),
                          SizedBox(width: 8),
                          Text('Export', style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold)),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  ElevatedButton.icon(
                    onPressed: _refreshReport,
                    icon: const Icon(Icons.refresh_rounded),
                    label: const Text('Re-Scan'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
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
                    Expanded(flex: 3, child: GovernanceKPIGrid(report: _report)),
                    const SizedBox(width: 24),
                    Expanded(flex: 2, child: GovernanceDomainChart(report: _report)),
                  ],
                );
              } else {
                return Column(
                  children: [
                    Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GovernanceMasterScore(report: _report),
              const SizedBox(width: 48),
              Expanded(
                child: GovernanceKPIGrid(report: _report),
              ),
            ],
          ),
                    const SizedBox(height: 24),
                    GovernanceDomainChart(report: _report),
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
                        child: GovernanceTrendChart(trendData: governanceState.healthTrend),
                      ),
                    ),
                    const SizedBox(width: 24),
                    Expanded(
                      flex: 2,
                      child: SizedBox(
                        height: 400,
                        child: GovernanceEventFeed(events: governanceState.recentEvents),
                      ),
                    ),
                  ],
                );
              } else {
                return Column(
                  children: [
                    SizedBox(
                      height: 350,
                      child: GovernanceTrendChart(trendData: governanceState.healthTrend),
                    ),
                    const SizedBox(height: 24),
                    SizedBox(
                      height: 400,
                      child: GovernanceEventFeed(events: governanceState.recentEvents),
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
                  selectedSeverity: _selectedSeverity,
                  selectedCategory: _selectedCategory,
                  onSeverityChanged: (s) => setState(() => _selectedSeverity = s),
                  onCategoryChanged: (c) => setState(() => _selectedCategory = c),
                  onClear: () => setState(() {
                    _selectedSeverity = null;
                    _selectedCategory = null;
                  }),
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
                      borderSide: BorderSide(color: Colors.grey.withValues(alpha: 0.1)),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(color: Colors.grey.withValues(alpha: 0.1)),
                    ),
                  ),
                  onChanged: (v) => setState(() => _searchQuery = v),
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
                'Showing ${filteredIssues.length} of ${_report.totalIssues} issues',
                style: const TextStyle(color: Colors.grey, fontSize: 12),
              ),
            ],
          ),
          const SizedBox(height: 16),
          GovernanceIssueTable(issues: filteredIssues),
          const SizedBox(height: 32),
          GovernanceComplianceChecklist(report: _report),
          const SizedBox(height: 32),
          _buildReadinessPanel(),
        ],
      ),
    );
  }

  Widget _buildReadinessPanel() {
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
                  style: TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                Text(
                  '${_report.productionReadyScreens} screens meet all production quality gates. ${_report.blockedScreens} screens are currently blocked by critical or high-severity issues.',
                  style: TextStyle(color: Colors.white.withValues(alpha: 0.8), fontSize: 14),
                ),
              ],
            ),
          ),
          const SizedBox(width: 32),
          CircularProgressIndicator(
            value: _report.totalScreens > 0 ? _report.productionReadyScreens / _report.totalScreens : 0,
            backgroundColor: Colors.white.withValues(alpha: 0.2),
            valueColor: const AlwaysStoppedAnimation<Color>(Colors.greenAccent),
            strokeWidth: 8,
          ),
        ],
      ),
    );
  }
}
