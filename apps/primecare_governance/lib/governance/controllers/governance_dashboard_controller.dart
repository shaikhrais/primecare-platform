import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/governance_severity.dart';
import '../models/governance_category.dart';
import '../models/governance_report.dart';
import '../services/governance_exporter.dart';
import '../../core/governance/governance_provider.dart';

class GovernanceDashboardState {
  final GovernanceSeverity? selectedSeverity;
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
    GovernanceSeverity? selectedSeverity,
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

class GovernanceDashboardController extends Notifier<GovernanceDashboardState> {
  @override
  GovernanceDashboardState build() {
    return const GovernanceDashboardState();
  }

  void setSeverity(GovernanceSeverity? severity) {
    state = state.copyWith(
      selectedSeverity: severity,
      clearSeverity: severity == null,
    );
  }

  void setCategory(GovernanceCategory? category) {
    state = state.copyWith(
      selectedCategory: category,
      clearCategory: category == null,
    );
  }

  void setSearchQuery(String query) {
    state = state.copyWith(searchQuery: query);
  }

  void clearFilters() {
    state = state.copyWith(
      clearSeverity: true,
      clearCategory: true,
      searchQuery: '',
    );
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
    state = state.copyWith(isExporting: true);
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
      state = state.copyWith(isExporting: false);
    }
  }
}

final governanceDashboardControllerProvider =
    NotifierProvider<GovernanceDashboardController, GovernanceDashboardState>(
      () => GovernanceDashboardController(),
    );
