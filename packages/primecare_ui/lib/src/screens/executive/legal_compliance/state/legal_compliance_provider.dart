import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/legal_compliance_model.dart';

class LegalComplianceNotifier extends StateNotifier<LegalComplianceModel> {
  LegalComplianceNotifier() : super(const LegalComplianceModel(isLoading: true));

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

final legal_complianceProvider = StateNotifierProvider<LegalComplianceNotifier, LegalComplianceModel>((ref) {
  return LegalComplianceNotifier()..loadData();
});
