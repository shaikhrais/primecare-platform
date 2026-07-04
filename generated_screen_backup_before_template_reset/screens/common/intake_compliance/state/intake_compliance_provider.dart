import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/intake_compliance_model.dart';

class IntakeComplianceNotifier extends StateNotifier<IntakeComplianceModel> {
  IntakeComplianceNotifier() : super(const IntakeComplianceModel(isLoading: true));

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

final intake_complianceProvider = StateNotifierProvider<IntakeComplianceNotifier, IntakeComplianceModel>((ref) {
  return IntakeComplianceNotifier()..loadData();
});
