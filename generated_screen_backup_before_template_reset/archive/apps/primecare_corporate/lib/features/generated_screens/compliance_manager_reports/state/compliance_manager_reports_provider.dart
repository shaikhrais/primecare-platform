import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/compliance_manager_reports_model.dart';

class ComplianceManagerReportsNotifier extends StateNotifier<ComplianceManagerReportsModel> {
  ComplianceManagerReportsNotifier() : super(const ComplianceManagerReportsModel(isLoading: true));

  Future<void> loadData() async {
    state = state.copyWith(isLoading: true);
    try {
      // TODO: Call API service
      state = state.copyWith(isLoading: false, data: const {});
    } catch (e) {
      state = state.copyWith(isLoading: false, errorMessage: e.toString());
    }
  }
}

final compliance_manager_reportsProvider = StateNotifierProvider<ComplianceManagerReportsNotifier, ComplianceManagerReportsModel>((ref) {
  return ComplianceManagerReportsNotifier()..loadData();
});
