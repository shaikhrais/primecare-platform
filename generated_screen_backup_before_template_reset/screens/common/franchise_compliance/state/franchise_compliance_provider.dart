import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/franchise_compliance_model.dart';

class FranchiseComplianceNotifier extends StateNotifier<FranchiseComplianceModel> {
  FranchiseComplianceNotifier() : super(const FranchiseComplianceModel(isLoading: true));

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

final franchise_complianceProvider = StateNotifierProvider<FranchiseComplianceNotifier, FranchiseComplianceModel>((ref) {
  return FranchiseComplianceNotifier()..loadData();
});
