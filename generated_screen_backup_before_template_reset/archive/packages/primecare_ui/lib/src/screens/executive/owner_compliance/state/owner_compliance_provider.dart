import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/owner_compliance_model.dart';

class OwnerComplianceNotifier extends StateNotifier<OwnerComplianceModel> {
  OwnerComplianceNotifier() : super(const OwnerComplianceModel(isLoading: true));

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

final owner_complianceProvider = StateNotifierProvider<OwnerComplianceNotifier, OwnerComplianceModel>((ref) {
  return OwnerComplianceNotifier()..loadData();
});
