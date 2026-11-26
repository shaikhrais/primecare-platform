// Governance - Category: controller | Purpose: Standalone compile-safe Notifier for GovernanceDashboardController and its visual filters.
import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_core/flutter_core.dart';
import '../../core/governance/governance_provider.dart';
import '../models/governance_report.dart';
import '../services/governance_exporter.dart';
import 'package:primecare_ui/src/features/reports/report_pdf_exporter.dart';

final governancePdfExportProvider = Provider<ReportPdfExport>(
  (ref) => ReportPdfExporter().export,
);

class GovernanceDashboardState {
  final AuditSeverity? selectedSeverity;
  final GovernanceCategory? selectedCategory;
  final String searchQuery;
  final bool isExporting;

  const GovernanceDashboardState({
    this.selectedSeverity,
    this.selectedCategory,
    this.searchQuery = '',
    this.isExporting = false,
  });

  GovernanceDashboardState copyWith({
    AuditSeverity? selectedSeverity,
    GovernanceCategory? selectedCategory,
    String? searchQuery,
    bool? isExporting,
    bool clearSeverity = false,
    bool clearCategory = false,
  }) {
    return GovernanceDashboardState(
      selectedSeverity: clearSeverity ? null : (selectedSeverity ?? this.selectedSeverity),
      selectedCategory: clearCategory ? null : (selectedCategory ?? this.selectedCategory),
      searchQuery: searchQuery ?? this.searchQuery,
      isExporting: isExporting ?? this.isExporting,
    );
  }
}

final governanceDashboardControllerProvider =
    AsyncNotifierProvider<GovernanceDashboardController, GovernanceDashboardState>(() {
  return GovernanceDashboardController();
});

class GovernanceDashboardController extends AsyncNotifier<GovernanceDashboardState> {
  @override
  FutureOr<GovernanceDashboardState> build() async {
    return const GovernanceDashboardState();
  }

  void setSeverity(AuditSeverity? severity) {
    if (state.value == null) return;
    state = AsyncValue.data(state.value!.copyWith(
      selectedSeverity: severity,
      clearSeverity: severity == null,
    ));
  }

  void setCategory(GovernanceCategory? category) {
    if (state.value == null) return;
    state = AsyncValue.data(state.value!.copyWith(
      selectedCategory: category,
      clearCategory: category == null,
    ));
  }

  void setSearchQuery(String query) {
    if (state.value == null) return;
    state = AsyncValue.data(state.value!.copyWith(searchQuery: query));
  }

  void clearFilters() {
    if (state.value == null) return;
    state = AsyncValue.data(state.value!.copyWith(
      clearSeverity: true,
      clearCategory: true,
      searchQuery: '',
    ));
  }

  void rescan() {
    ref.read(governanceProvider.notifier).refresh();
  }

  Future<void> remediate() async {
    await ref.read(governanceProvider.notifier).applyAutomatedFixes();
  }

  Future<String?> exportReport(String format, GovernanceReport report) async {
    if (state.value == null || state.value!.isExporting) return null;
    state = AsyncValue.data(state.value!.copyWith(isExporting: true));
    try {
      if (format == 'json') {
        return GovernanceExporter.toJson(report);
      } else if (format == 'csv') {
        return GovernanceExporter.toCsv(report);
      } else if (format == 'html') {
        return GovernanceExporter.toHtml(report);
      } else if (format == 'pdf') {
        final bytes = await GovernanceExporter.toPdf(report);
        if (!ref.mounted) return null;
        const filename = 'primecare-governance-report.pdf';
        final saved = await ref.read(governancePdfExportProvider)(bytes, filename);
        return saved ? filename : null;
      } else if (format == 'markdown') {
        return GovernanceExporter.toMarkdown(report);
      }
      throw ArgumentError.value(format, 'format', 'Unsupported report format');
    } finally {
      if (ref.mounted && state.value != null) {
        state = AsyncValue.data(state.value!.copyWith(isExporting: false));
      }
    }
  }
}
