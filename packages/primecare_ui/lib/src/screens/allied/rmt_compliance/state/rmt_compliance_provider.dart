import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/rmt_compliance_model.dart';

class RmtComplianceNotifier extends StateNotifier<RmtComplianceModel> {
  RmtComplianceNotifier() : super(const RmtComplianceModel(isLoading: true));

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

final rmt_complianceProvider = StateNotifierProvider<RmtComplianceNotifier, RmtComplianceModel>((ref) {
  return RmtComplianceNotifier()..loadData();
});
