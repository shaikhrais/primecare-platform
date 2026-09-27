import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/operations_manager_compliance_model.dart';

class OperationsManagerComplianceNotifier extends StateNotifier<OperationsManagerComplianceModel> {
  OperationsManagerComplianceNotifier() : super(const OperationsManagerComplianceModel(isLoading: true));

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

final operations_manager_complianceProvider = StateNotifierProvider<OperationsManagerComplianceNotifier, OperationsManagerComplianceModel>((ref) {
  return OperationsManagerComplianceNotifier()..loadData();
});
