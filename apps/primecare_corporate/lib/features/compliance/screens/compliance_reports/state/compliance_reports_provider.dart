import 'package:flutter_riverpod/legacy.dart';
import '../models/compliance_reports_model.dart';

class ComplianceReportsNotifier extends StateNotifier<ComplianceReportsModel> {
  ComplianceReportsNotifier() : super(const ComplianceReportsModel(isLoading: true));

  Future<void> loadData() async {
    state = state.copyWith(isLoading: true);
    try {
      // TODO: Call API service
      state = state.copyWith(isLoading: false, data: const <String, dynamic>{});
    } catch (e) {
      state = state.copyWith(isLoading: false, errorMessage: e.toString());
    }
  }
}

final compliance_reportsProvider = StateNotifierProvider<ComplianceReportsNotifier, ComplianceReportsModel>((ref) {
  return ComplianceReportsNotifier()..loadData();
});
