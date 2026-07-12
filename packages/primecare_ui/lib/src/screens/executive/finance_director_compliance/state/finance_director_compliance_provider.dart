import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/finance_director_compliance_model.dart';

class FinanceDirectorComplianceNotifier extends StateNotifier<FinanceDirectorComplianceModel> {
  FinanceDirectorComplianceNotifier() : super(const FinanceDirectorComplianceModel(isLoading: true));

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

final finance_director_complianceProvider = StateNotifierProvider<FinanceDirectorComplianceNotifier, FinanceDirectorComplianceModel>((ref) {
  return FinanceDirectorComplianceNotifier()..loadData();
});
