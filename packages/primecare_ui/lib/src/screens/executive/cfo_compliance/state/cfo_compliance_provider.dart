import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/cfo_compliance_model.dart';

class CfoComplianceNotifier extends StateNotifier<CfoComplianceModel> {
  CfoComplianceNotifier() : super(const CfoComplianceModel(isLoading: true));

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

final cfo_complianceProvider = StateNotifierProvider<CfoComplianceNotifier, CfoComplianceModel>((ref) {
  return CfoComplianceNotifier()..loadData();
});
