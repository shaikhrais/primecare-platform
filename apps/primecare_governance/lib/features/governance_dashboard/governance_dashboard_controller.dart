import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'governance_dashboard_model.dart';
import '../../governance/models/governance_severity.dart';
import '../../governance/models/governance_category.dart';
import '../../governance/models/governance_report.dart';
import '../../governance/services/governance_exporter.dart';

final governanceDashboardControllerProvider =
    NotifierProvider<GovernanceDashboardController, GovernanceDashboardModel>(
      () {
        return GovernanceDashboardController();
      },
    );

class GovernanceDashboardController extends Notifier<GovernanceDashboardModel> {
  @override
  GovernanceDashboardModel build() => const GovernanceDashboardModel();

  void setSeverity(GovernanceSeverity? severity) {
    if (severity == null) {
      state = state.copyWith(clearSeverity: true);
    } else {
      state = state.copyWith(selectedSeverity: severity);
    }
  }

  void setCategory(GovernanceCategory? category) {
    if (category == null) {
      state = state.copyWith(clearCategory: true);
    } else {
      state = state.copyWith(selectedCategory: category);
    }
  }

  void clearFilters() {
    state = state.copyWith(clearSeverity: true, clearCategory: true);
  }

  void setSearchQuery(String query) {
    state = state.copyWith(searchQuery: query);
  }

  Future<bool> exportReport(GovernanceReport report, String format) async {
    String content = '';

    if (format == 'pdf') {
      await GovernanceExporter.toPdf(report);
      return true;
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

    await Clipboard.setData(ClipboardData(text: content));
    return false; // return false meaning it wasn't pdf, it was clipboard
  }
}
