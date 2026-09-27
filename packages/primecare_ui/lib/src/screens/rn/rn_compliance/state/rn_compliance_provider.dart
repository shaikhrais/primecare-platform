import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/rn_compliance_model.dart';

class RnComplianceNotifier extends StateNotifier<RnComplianceModel> {
  RnComplianceNotifier() : super(const RnComplianceModel(isLoading: true));

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

final rn_complianceProvider = StateNotifierProvider<RnComplianceNotifier, RnComplianceModel>((ref) {
  return RnComplianceNotifier()..loadData();
});
