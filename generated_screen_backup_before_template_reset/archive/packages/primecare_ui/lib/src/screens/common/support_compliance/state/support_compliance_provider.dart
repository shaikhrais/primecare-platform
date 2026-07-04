import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/support_compliance_model.dart';

class SupportComplianceNotifier extends StateNotifier<SupportComplianceModel> {
  SupportComplianceNotifier() : super(const SupportComplianceModel(isLoading: true));

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

final support_complianceProvider = StateNotifierProvider<SupportComplianceNotifier, SupportComplianceModel>((ref) {
  return SupportComplianceNotifier()..loadData();
});
