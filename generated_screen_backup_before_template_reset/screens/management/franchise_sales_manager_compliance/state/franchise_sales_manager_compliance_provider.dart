import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/franchise_sales_manager_compliance_model.dart';

class FranchiseSalesManagerComplianceNotifier extends StateNotifier<FranchiseSalesManagerComplianceModel> {
  FranchiseSalesManagerComplianceNotifier() : super(const FranchiseSalesManagerComplianceModel(isLoading: true));

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

final franchise_sales_manager_complianceProvider = StateNotifierProvider<FranchiseSalesManagerComplianceNotifier, FranchiseSalesManagerComplianceModel>((ref) {
  return FranchiseSalesManagerComplianceNotifier()..loadData();
});
