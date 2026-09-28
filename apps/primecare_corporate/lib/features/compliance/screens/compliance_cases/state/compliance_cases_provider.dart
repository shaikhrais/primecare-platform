import 'package:flutter_riverpod/legacy.dart';
import '../models/compliance_cases_model.dart';

class ComplianceCasesNotifier extends StateNotifier<ComplianceCasesModel> {
  ComplianceCasesNotifier() : super(const ComplianceCasesModel(isLoading: true));

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

final compliance_casesProvider = StateNotifierProvider<ComplianceCasesNotifier, ComplianceCasesModel>((ref) {
  return ComplianceCasesNotifier()..loadData();
});
