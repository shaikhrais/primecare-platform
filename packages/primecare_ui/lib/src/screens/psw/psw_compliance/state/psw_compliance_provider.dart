import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/psw_compliance_model.dart';

class PswComplianceNotifier extends StateNotifier<PswComplianceModel> {
  PswComplianceNotifier() : super(const PswComplianceModel(isLoading: true));

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

final psw_complianceProvider = StateNotifierProvider<PswComplianceNotifier, PswComplianceModel>((ref) {
  return PswComplianceNotifier()..loadData();
});
