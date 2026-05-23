// Governance - Category: view | Purpose: UI Screen component rendering the Governance Dashboard Controller workspace interface.
import 'dart:async';
import 'package:flutter_core/flutter_core.dart';
import '../models/governance_report.dart';
import '../services/governance_exporter.dart';
import '../../core/governance/governance_provider.dart';

class GovernanceDashboardState {
  final AuditSeverity? selectedSeverity;
  final GovernanceCategory? selectedCategory;
  final String searchQuery;
  final bool isExporting;
  final String? lastExportPath;

  const GovernanceDashboardState({
    this.selectedSeverity,
    this.selectedCategory,
    this.searchQuery = '',
    this.isExporting = false,
    this.lastExportPath,
  });

  GovernanceDashboardState copyWith({
    AuditSeverity? selectedSeverity,
    bool clearSeverity = false,
    GovernanceCategory? selectedCategory,
    bool clearCategory = false,
    String? searchQuery,
    bool? isExporting,
    String? lastExportPath,
    bool clearExportPath = false,
  }) {
    return GovernanceDashboardState(
      selectedSeverity: clearSeverity
          ? null
          : selectedSeverity ?? this.selectedSeverity,
      selectedCategory: clearCategory
          ? null
          : selectedCategory ?? this.selectedCategory,
      searchQuery: searchQuery ?? this.searchQuery,
      isExporting: isExporting ?? this.isExporting,
      lastExportPath: clearExportPath
          ? null
          : lastExportPath ?? this.lastExportPath,
    );
  }
}

class GovernanceDashboardController extends AsyncNotifier<GovernanceDashboardState> {
  @override
  FutureOr<GovernanceDashboardState> build() async {
    return const GovernanceDashboardState();
  }

  void setSeverity(AuditSeverity? severity) {
    if (state.value == null) return;
    state = AsyncData(state.value!.copyWith(
      selectedSeverity: severity,
      clearSeverity: severity == null,
    ));
  }

  void setCategory(GovernanceCategory? category) {
    if (state.value == null) return;
    state = AsyncData(state.value!.copyWith(
      selectedCategory: category,
      clearCategory: category == null,
    ));
  }

  void setSearchQuery(String query) {
    if (state.value == null) return;
    state = AsyncData(state.value!.copyWith(searchQuery: query));
  }

  void clearFilters() {
    if (state.value == null) return;
    state = AsyncData(state.value!.copyWith(
      clearSeverity: true,
      clearCategory: true,
      searchQuery: '',
    ));
  }

  /// Business Logic: Rescan the platform
  void rescan() {
    ref.read(governanceProvider.notifier).refresh();
  }

  /// Business Logic: Apply automated fixes
  Future<void> remediate() async {
    await ref.read(governanceProvider.notifier).applyAutomatedFixes();
  }

  /// Business Logic: Export report
  Future<String?> exportReport(String format, GovernanceReport report) async {
    if (state.value == null) return null;
    state = AsyncData(state.value!.copyWith(isExporting: true));
    try {
      String content = '';
      if (format == 'pdf') {
        await GovernanceExporter.toPdf(report);
        return 'Professional PDF Report Generated';
      }

      switch (format) {
        case 'markdown':
          content = GovernanceExporter.toMarkdown(report);
          break;
        case 'html':
          content = GovernanceExporter.toHtml(report);
          break;
        case 'json':
          content = GovernanceExporter.toJson(report);
          break;
        case 'csv':
          content = GovernanceExporter.toCsv(report);
          break;
      }
      return content;
    } finally {
      if (state.value != null) {
        state = AsyncData(state.value!.copyWith(isExporting: false));
      }
    }
  }
}

final governanceDashboardControllerProvider =
    AsyncNotifierProvider<GovernanceDashboardController, GovernanceDashboardState>(
      () => GovernanceDashboardController(),
    );
