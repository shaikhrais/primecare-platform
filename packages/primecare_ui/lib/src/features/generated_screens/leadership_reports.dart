import 'package:primecare_ui/primecare_ui.dart';

// --- MVC State Model ---
class LeadershipReportsState {
  final List<Map<String, dynamic>> reports;
  final Set<String> selectedReportIds;
  final String activeCategoryFilter;
  final bool isCompiling;
  final double compileProgress;
  final String? selectedReportId;
  final bool isDownloading;
  final String? downloadingReportId;

  const LeadershipReportsState({
    required this.reports,
    required this.selectedReportIds,
    required this.activeCategoryFilter,
    required this.isCompiling,
    required this.compileProgress,
    this.selectedReportId,
    required this.isDownloading,
    this.downloadingReportId,
  });

  LeadershipReportsState copyWith({
    List<Map<String, dynamic>>? reports,
    Set<String>? selectedReportIds,
    String? activeCategoryFilter,
    bool? isCompiling,
    double? compileProgress,
    String? selectedReportId,
    bool? isDownloading,
    String? downloadingReportId,
  }) {
    return LeadershipReportsState(
      reports: reports ?? this.reports,
      selectedReportIds: selectedReportIds ?? this.selectedReportIds,
      activeCategoryFilter: activeCategoryFilter ?? this.activeCategoryFilter,
      isCompiling: isCompiling ?? this.isCompiling,
      compileProgress: compileProgress ?? this.compileProgress,
      selectedReportId: selectedReportId ?? this.selectedReportId,
      isDownloading: isDownloading ?? this.isDownloading,
      downloadingReportId: downloadingReportId ?? this.downloadingReportId,
    );
  }
}

// --- Controller ---
class LeadershipReportsController extends StateNotifier<LeadershipReportsState> {
  final Ref _ref;

  LeadershipReportsController(this._ref)
      : super(
          const LeadershipReportsState(
            reports: [
              {
                'id': 'REP-101',
                'title': 'Q2 Strategic Board Review',
                'category': 'Strategy',
                'frequency': 'Quarterly',
                'status': 'Ready',
                'lastCompiled': '2026-05-18 10:14',
                'size': '4.2 MB',
                'description': 'Executive review of multi-regional caregiver KPIs, client retention indexes, and growth projections for investor review.',
                'sections': [
                  'Executive Overview & Vision Statement',
                  'Client and Caregiver Retention Analysis',
                  'Franchise Development Pipeline Status',
                  'Strategic Financial Indicators & Projections'
                ],
              },
              {
                'id': 'REP-102',
                'title': 'Clinical Compliance Audit',
                'category': 'Clinical',
                'frequency': 'Monthly',
                'status': 'Ready',
                'lastCompiled': '2026-05-12 16:45',
                'size': '2.8 MB',
                'description': 'Summary report of client cognitive scale screenings, ADL checksheet compliance, and nurse licensing audits across all active regions.',
                'sections': [
                  'Cognitive Scale Assessments Completed',
                  'ADL Checksheet Compliance Rates',
                  'Nurse Practice Act Licensing Parity',
                  'Corrective Action Plans & Incident Tracing'
                ],
              },
              {
                'id': 'REP-103',
                'title': 'Annual Franchise Financial Consolidation',
                'category': 'Finance',
                'frequency': 'Annual',
                'status': 'Stale',
                'lastCompiled': '2025-12-31 23:59',
                'size': '12.4 MB',
                'description': 'Comprehensive corporate financial statement consolidation including revenue streams, tax remittance simulations, and royalty fee summaries.',
                'sections': [
                  'Aggregate Revenue & Royalty Income Ledger',
                  'Operating Cost Ratios & Profitability Analysis',
                  'Tax Bracket Remittance Simulations',
                  'Consolidated Capital Reserve Metrics'
                ],
              },
              {
                'id': 'REP-104',
                'title': 'System-wide Staffing Shortage Report',
                'category': 'Operations',
                'frequency': 'Monthly',
                'status': 'Ready',
                'lastCompiled': '2026-05-19 09:00',
                'size': '1.5 MB',
                'description': 'Operational performance analysis on active caregiver clock-in delays, unallocated shift hotspots, and regional dispatch efficiency.',
                'sections': [
                  'Caregiver Clock-in & Schedule Parity',
                  'Unassigned Shift Density Heatmap',
                  'Average Dispatch Delays by Territory',
                  'Recruitment Velocity Requirements'
                ],
              },
              {
                'id': 'REP-105',
                'title': 'National Quality Assurance Digest',
                'category': 'Clinical',
                'frequency': 'Quarterly',
                'status': 'Ready',
                'lastCompiled': '2026-05-01 11:30',
                'size': '3.9 MB',
                'description': 'Clinical quality indicators, patient satisfaction levels, and safety audits compile designed for governance review.',
                'sections': [
                  'Patient Care Satisfaction Metrics',
                  'High-Risk Fall & Medication Incidents Ledger',
                  'Branch Level Quality Rating Audits',
                  'Regulatory Alignment Directives'
                ],
              },
            ],
            selectedReportIds: {},
            activeCategoryFilter: 'all',
            isCompiling: false,
            compileProgress: 0.0,
            isDownloading: false,
          ),
        );

  void updateCategoryFilter(String category) {
    state = state.copyWith(activeCategoryFilter: category);
  }

  void toggleReportSelection(String id) {
    final current = Set<String>.from(state.selectedReportIds);
    if (current.contains(id)) {
      current.remove(id);
    } else {
      current.add(id);
    }
    state = state.copyWith(selectedReportIds: current);
  }

  void toggleAllSelection(List<String> visibleIds) {
    final current = Set<String>.from(state.selectedReportIds);
    final allVisibleSelected = visibleIds.every((id) => current.contains(id));

    if (allVisibleSelected) {
      for (final id in visibleIds) {
        current.remove(id);
      }
    } else {
      for (final id in visibleIds) {
        current.add(id);
      }
    }
    state = state.copyWith(selectedReportIds: current);
  }

  void selectReport(String? id) {
    state = state.copyWith(selectedReportId: id);
  }

  void compileSelected() {
    if (state.selectedReportIds.isEmpty || state.isCompiling) return;

    state = state.copyWith(
      isCompiling: true,
      compileProgress: 0.0,
    );

    try {
      _ref.read(auraBehavioralTelemetryProvider).logStructuralEvent(
            route: '/generated/leadership_reports',
            eventType: 'leadership_report_compilation_started',
            metadata: {
              'report_ids': state.selectedReportIds.toList(),
              'count': state.selectedReportIds.length,
              'timestamp': DateTime.now().toIso8601String(),
            },
          );
    } catch (_) {}

    _simulateProgress(1);
  }

  void _simulateProgress(int step) {
    if (step > 5) {
      final updatedReports = state.reports.map((rep) {
        if (state.selectedReportIds.contains(rep['id'])) {
          final now = DateTime.now();
          final formatted = '${now.year}-${now.month.toString().padLeft(2, '0')}-${now.day.toString().padLeft(2, '0')} ${now.hour.toString().padLeft(2, '0')}:${now.minute.toString().padLeft(2, '0')}';
          return Map<String, dynamic>.from(rep)
            ..['status'] = 'Ready'
            ..['lastCompiled'] = formatted;
        }
        return rep;
      }).toList();

      state = state.copyWith(
        reports: updatedReports,
        isCompiling: false,
        compileProgress: 1.0,
        selectedReportIds: {},
      );
      return;
    }

    Future.delayed(const Duration(milliseconds: 400), () {
      if (!state.isCompiling) return;
      state = state.copyWith(compileProgress: step / 5.0);
      _simulateProgress(step + 1);
    });
  }

  void downloadReport(String id) {
    state = state.copyWith(
      isDownloading: true,
      downloadingReportId: id,
    );

    try {
      _ref.read(auraBehavioralTelemetryProvider).logStructuralEvent(
            route: '/generated/leadership_reports',
            eventType: 'leadership_report_download_triggered',
            metadata: {
              'report_id': id,
              'timestamp': DateTime.now().toIso8601String(),
            },
          );
    } catch (_) {}

    Future.delayed(const Duration(milliseconds: 1800), () {
      state = state.copyWith(
        isDownloading: false,
        downloadingReportId: null,
      );
    });
  }
}

// --- Provider ---
final leadershipReportsControllerProvider =
    StateNotifierProvider<LeadershipReportsController, LeadershipReportsState>((ref) {
  return LeadershipReportsController(ref);
});

// --- View ---
class LeadershipReports extends GovernedConsumerWidget {
  const LeadershipReports({super.key});

  @override
  Widget buildScreen(BuildContext context, WidgetRef ref) {
    final state = ref.watch(leadershipReportsControllerProvider);
    final controller = ref.read(leadershipReportsControllerProvider.notifier);
    final theme = context.theme;

    // Filter reports
    final filteredReports = state.reports.where((rep) {
      if (state.activeCategoryFilter == 'all') return true;
      return (rep['category'] as String).toLowerCase() == state.activeCategoryFilter.toLowerCase();
    }).toList();

    final visibleIds = filteredReports.map((r) => r['id'] as String).toList();
    final allVisibleSelected = visibleIds.isNotEmpty &&
        visibleIds.every((id) => state.selectedReportIds.contains(id));

    final selectedReport = state.selectedReportId == null
        ? null
        : state.reports.firstWhere((r) => r['id'] == state.selectedReportId);

    // KPI Counters
    final totalCount = state.reports.length;
    final staleCount = state.reports.where((r) => r['status'] == 'Stale').length;
    final activeCategories = state.reports.map((r) => r['category']).toSet().length;

    return Scaffold(
      backgroundColor: theme.colors.background,
      appBar: AppBar(
        backgroundColor: theme.colors.surface,
        elevation: 0,
        title: Row(
          children: [
            Icon(LucideIcons.fileSpreadsheet, color: theme.colors.primary),
            const SizedBox(width: 12),
            Text(
              'Board & Leadership Executive Portal',
              style: theme.typography.h3.copyWith(color: theme.colors.onSurface),
            ),
          ],
        ),
      ),
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Executive Strategy & Reports Digest',
                          style: theme.typography.h2.copyWith(color: theme.colors.onSurface),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'Generate, compile, and download board-level reviews, quality assurance audits, and regional consolidated financials.',
                          style: theme.typography.bodyMedium.copyWith(color: theme.colors.onSurfaceVariant),
                        ),
                      ],
                    ),
                    if (state.selectedReportIds.isNotEmpty)
                      ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: theme.colors.primary,
                          foregroundColor: theme.colors.onPrimary,
                          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(theme.radiusMd),
                          ),
                        ),
                        onPressed: state.isCompiling ? null : controller.compileSelected,
                        icon: const Icon(LucideIcons.play, size: 16),
                        label: Text('Compile Selected (${state.selectedReportIds.length})'),
                      ),
                  ],
                ),
                const SizedBox(height: 24),

                // KPI Counter Section
                Row(
                  children: [
                    Expanded(
                      child: _KpiCounterCard(
                        title: 'Total Board Ledger Reports',
                        value: totalCount.toString(),
                        icon: LucideIcons.folders,
                        color: theme.colors.primary,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: _KpiCounterCard(
                        title: 'Consolidation Hotspots (Stale)',
                        value: staleCount.toString(),
                        icon: LucideIcons.alertTriangle,
                        color: staleCount > 0 ? Colors.amber : Colors.green,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: _KpiCounterCard(
                        title: 'Operational Dimensions',
                        value: activeCategories.toString(),
                        icon: LucideIcons.layers,
                        color: Colors.blue,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 24),

                // Compilation Progress Bar
                if (state.isCompiling) ...[
                  Container(
                    padding: const EdgeInsets.all(16),
                    margin: const EdgeInsets.only(bottom: 20),
                    decoration: BoxDecoration(
                      color: theme.colors.primary.withValues(alpha: 0.05),
                      borderRadius: BorderRadius.circular(theme.radiusMd),
                      border: Border.all(color: theme.colors.primary.withValues(alpha: 0.2)),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Compiling Selected Executive Reports...',
                              style: theme.typography.bodyMedium.copyWith(
                                color: theme.colors.primary,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              '${(state.compileProgress * 100).toInt()}%',
                              style: theme.typography.bodySmall.copyWith(
                                color: theme.colors.primary,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(theme.radiusSm),
                          child: LinearProgressIndicator(
                            value: state.compileProgress,
                            minHeight: 8,
                            backgroundColor: theme.colors.background,
                            valueColor: AlwaysStoppedAnimation<Color>(theme.colors.primary),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],

                // Filter & Select All Actions Row
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  decoration: BoxDecoration(
                    color: theme.colors.surface,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(theme.radiusMd),
                      topRight: Radius.circular(theme.radiusMd),
                    ),
                    border: Border(
                      top: BorderSide(color: theme.colors.border),
                      left: BorderSide(color: theme.colors.border),
                      right: BorderSide(color: theme.colors.border),
                    ),
                  ),
                  child: Row(
                    children: [
                      Checkbox(
                        value: allVisibleSelected,
                        activeColor: theme.colors.primary,
                        onChanged: (val) => controller.toggleAllSelection(visibleIds),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        'Select All Visible',
                        style: theme.typography.bodyMedium.copyWith(
                          color: theme.colors.onSurface,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const Spacer(),
                      Wrap(
                        spacing: 8,
                        children: [
                          _FilterChip(
                            label: 'All Topics',
                            value: 'all',
                            activeValue: state.activeCategoryFilter,
                            onTap: controller.updateCategoryFilter,
                          ),
                          _FilterChip(
                            label: 'Strategy',
                            value: 'strategy',
                            activeValue: state.activeCategoryFilter,
                            onTap: controller.updateCategoryFilter,
                          ),
                          _FilterChip(
                            label: 'Clinical',
                            value: 'clinical',
                            activeValue: state.activeCategoryFilter,
                            onTap: controller.updateCategoryFilter,
                          ),
                          _FilterChip(
                            label: 'Finance',
                            value: 'finance',
                            activeValue: state.activeCategoryFilter,
                            onTap: controller.updateCategoryFilter,
                          ),
                          _FilterChip(
                            label: 'Operations',
                            value: 'operations',
                            activeValue: state.activeCategoryFilter,
                            onTap: controller.updateCategoryFilter,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                // Reports Ledger List
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      color: theme.colors.surface,
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(theme.radiusMd),
                        bottomRight: Radius.circular(theme.radiusMd),
                      ),
                      border: Border.all(color: theme.colors.border),
                    ),
                    child: filteredReports.isEmpty
                        ? Center(
                            child: Text(
                              'No executive reports found matching filter.',
                              style: theme.typography.bodyMedium.copyWith(color: theme.colors.onSurfaceVariant),
                            ),
                          )
                        : ListView.separated(
                            itemCount: filteredReports.length,
                            separatorBuilder: (context, index) => const Divider(height: 1),
                            itemBuilder: (context, index) {
                              final rep = filteredReports[index];
                              final repId = rep['id'] as String;
                              final isSelected = state.selectedReportIds.contains(repId);
                              final isStale = rep['status'] == 'Stale';

                              return InkWell(
                                onTap: () => controller.selectReport(repId),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 18.0),
                                  child: Row(
                                    children: [
                                      Checkbox(
                                        value: isSelected,
                                        activeColor: theme.colors.primary,
                                        onChanged: (val) => controller.toggleReportSelection(repId),
                                      ),
                                      const SizedBox(width: 12),
                                      Expanded(
                                        flex: 4,
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              children: [
                                                Text(
                                                  (rep['title'] as String),
                                                  style: theme.typography.h4.copyWith(
                                                    color: theme.colors.onSurface,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                                const SizedBox(width: 12),
                                                Container(
                                                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                                                  decoration: BoxDecoration(
                                                    color: isStale
                                                        ? Colors.amber.withValues(alpha: 0.1)
                                                        : Colors.green.withValues(alpha: 0.1),
                                                    borderRadius: BorderRadius.circular(theme.radiusSm),
                                                  ),
                                                  child: Text(
                                                    (rep['status'] as String),
                                                    style: theme.typography.bodySmall.copyWith(
                                                      color: isStale ? Colors.amber[800] : Colors.green[800],
                                                      fontWeight: FontWeight.bold,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            const SizedBox(height: 6),
                                            Text(
                                              (rep['description'] as String),
                                              style: theme.typography.bodyMedium.copyWith(
                                                color: theme.colors.onSurfaceVariant,
                                              ),
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ],
                                        ),
                                      ),
                                      const SizedBox(width: 24),
                                      Expanded(
                                        flex: 2,
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.end,
                                          children: [
                                            Text(
                                              'Topic: ${rep['category']}',
                                              style: theme.typography.bodySmall.copyWith(
                                                color: theme.colors.primary,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            const SizedBox(height: 4),
                                            Text(
                                              'Size: ${rep['size']} | ${rep['frequency']}',
                                              style: theme.typography.bodySmall.copyWith(
                                                color: theme.colors.onSurfaceVariant,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      const SizedBox(width: 16),
                                      Icon(
                                        LucideIcons.chevronRight,
                                        color: theme.colors.onSurfaceVariant,
                                        size: 20,
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                  ),
                ),
              ],
            ),
          ),

          // Detail Slide Panel
          if (selectedReport != null)
            Positioned(
              right: 0,
              top: 0,
              bottom: 0,
              width: 420,
              child: Container(
                decoration: BoxDecoration(
                  color: theme.colors.surface,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.15),
                      blurRadius: 12,
                      offset: const Offset(-3, 0),
                    ),
                  ],
                  border: Border(left: BorderSide(color: theme.colors.border)),
                ),
                padding: const EdgeInsets.all(24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Executive Overview',
                          style: theme.typography.h3.copyWith(color: theme.colors.onSurface),
                        ),
                        IconButton(
                          icon: const Icon(LucideIcons.x),
                          onPressed: () => controller.selectReport(null),
                        ),
                      ],
                    ),
                    const Divider(),
                    const SizedBox(height: 16),
                    Text(
                      (selectedReport['title'] as String),
                      style: theme.typography.h2.copyWith(color: theme.colors.onSurface),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                          decoration: BoxDecoration(
                            color: theme.colors.primary.withValues(alpha: 0.1),
                            borderRadius: BorderRadius.circular(theme.radiusSm),
                          ),
                          child: Text(
                            (selectedReport['category'] as String),
                            style: theme.typography.bodySmall.copyWith(
                              color: theme.colors.primary,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Text(
                          'Compiled Frequency: ${selectedReport['frequency']}',
                          style: theme.typography.bodySmall.copyWith(color: theme.colors.onSurfaceVariant),
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),
                    Text(
                      'Briefing Summary:',
                      style: theme.typography.bodyMedium.copyWith(
                        color: theme.colors.onSurface,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      (selectedReport['description'] as String),
                      style: theme.typography.bodyMedium.copyWith(color: theme.colors.onSurfaceVariant),
                    ),
                    const SizedBox(height: 24),
                    Text(
                      'Report Structure & Sections:',
                      style: theme.typography.bodyMedium.copyWith(
                        color: theme.colors.onSurface,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: theme.colors.background,
                          borderRadius: BorderRadius.circular(theme.radiusSm),
                          border: Border.all(color: theme.colors.border),
                        ),
                        child: ListView.separated(
                          itemCount: (selectedReport['sections'] as List).length,
                          separatorBuilder: (context, idx) => const SizedBox(height: 10),
                          itemBuilder: (context, idx) {
                            final sect = (selectedReport['sections'] as List)[idx] as String;
                            return Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                CircleAvatar(
                                  radius: 8,
                                  backgroundColor: theme.colors.primary.withValues(alpha: 0.1),
                                  child: Text(
                                    '${idx + 1}',
                                    style: theme.typography.bodySmall.copyWith(
                                      color: theme.colors.primary,
                                      fontSize: 10,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 10),
                                Expanded(
                                  child: Text(
                                    sect,
                                    style: theme.typography.bodySmall.copyWith(
                                      color: theme.colors.onSurfaceVariant,
                                    ),
                                  ),
                                ),
                              ],
                            );
                          },
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),
                    _ReportDetailRow(label: 'Last Compile Timestamp', value: (selectedReport['lastCompiled'] as String)),
                    _ReportDetailRow(label: 'Payload File Size', value: (selectedReport['size'] as String)),
                    const SizedBox(height: 24),
                    if (state.isDownloading && state.downloadingReportId == selectedReport['id'])
                      const Center(
                        child: Column(
                          children: [
                            CircularProgressIndicator(),
                            SizedBox(height: 12),
                            Text('Downloading Encrypted PDF payload...'),
                          ],
                        ),
                      )
                    else
                      SizedBox(
                        width: double.infinity,
                        height: 48,
                        child: ElevatedButton.icon(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: theme.colors.primary,
                            foregroundColor: theme.colors.onPrimary,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(theme.radiusMd),
                            ),
                          ),
                          onPressed: () => controller.downloadReport((selectedReport['id'] as String)),
                          icon: const Icon(LucideIcons.downloadCloud, size: 18),
                          label: const Text('Download Secure PDF Copy'),
                        ),
                      ),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }
}

class _KpiCounterCard extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;
  final Color color;

  const _KpiCounterCard({
    required this.title,
    required this.value,
    required this.icon,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: theme.colors.surface,
        borderRadius: BorderRadius.circular(theme.radiusMd),
        border: Border.all(color: theme.colors.border),
      ),
      child: Row(
        children: [
          CircleAvatar(
            backgroundColor: color.withValues(alpha: 0.1),
            child: Icon(icon, color: color),
          ),
          const SizedBox(width: 16),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: theme.typography.bodySmall.copyWith(color: theme.colors.onSurfaceVariant),
              ),
              const SizedBox(height: 4),
              Text(
                value,
                style: theme.typography.h2.copyWith(
                  color: theme.colors.onSurface,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _FilterChip extends StatelessWidget {
  final String label;
  final String value;
  final String activeValue;
  final ValueChanged<String> onTap;

  const _FilterChip({
    required this.label,
    required this.value,
    required this.activeValue,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    final isActive = value == activeValue;
    return GestureDetector(
      onTap: () => onTap(value),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          color: isActive ? theme.colors.primary : theme.colors.background,
          borderRadius: BorderRadius.circular(theme.radiusSm),
          border: Border.all(
            color: isActive ? theme.colors.primary : theme.colors.border,
          ),
        ),
        child: Text(
          label,
          style: theme.typography.bodySmall.copyWith(
            color: isActive ? theme.colors.onPrimary : theme.colors.onSurfaceVariant,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}

class _ReportDetailRow extends StatelessWidget {
  final String label;
  final String value;

  const _ReportDetailRow({
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: theme.typography.bodyMedium.copyWith(color: theme.colors.onSurfaceVariant),
          ),
          Text(
            value,
            style: theme.typography.bodyMedium.copyWith(
              color: theme.colors.onSurface,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
