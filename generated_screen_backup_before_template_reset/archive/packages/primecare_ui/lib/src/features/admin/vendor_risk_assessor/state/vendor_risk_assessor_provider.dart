import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/vendor_risk_assessor_model.dart';

class VendorRiskAssessorNotifier extends StateNotifier<VendorRiskAssessorModel> {
  VendorRiskAssessorNotifier() : super(const VendorRiskAssessorModel(isLoading: true));

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

final vendor_risk_assessorProvider = StateNotifierProvider<VendorRiskAssessorNotifier, VendorRiskAssessorModel>((ref) {
  return VendorRiskAssessorNotifier()..loadData();
});
