import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/franchise_owner_compliance_model.dart';

class FranchiseOwnerComplianceNotifier extends StateNotifier<FranchiseOwnerComplianceModel> {
  FranchiseOwnerComplianceNotifier() : super(const FranchiseOwnerComplianceModel(isLoading: true));

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

final franchise_owner_complianceProvider = StateNotifierProvider<FranchiseOwnerComplianceNotifier, FranchiseOwnerComplianceModel>((ref) {
  return FranchiseOwnerComplianceNotifier()..loadData();
});
