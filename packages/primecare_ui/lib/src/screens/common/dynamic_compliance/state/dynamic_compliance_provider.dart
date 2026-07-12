import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/dynamic_compliance_model.dart';

class DynamicComplianceNotifier extends StateNotifier<DynamicComplianceModel> {
  DynamicComplianceNotifier() : super(const DynamicComplianceModel(isLoading: true));

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

final dynamic_complianceProvider = StateNotifierProvider<DynamicComplianceNotifier, DynamicComplianceModel>((ref) {
  return DynamicComplianceNotifier()..loadData();
});
