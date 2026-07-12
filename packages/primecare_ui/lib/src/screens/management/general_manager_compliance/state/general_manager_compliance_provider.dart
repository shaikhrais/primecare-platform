import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/general_manager_compliance_model.dart';

class GeneralManagerComplianceNotifier extends StateNotifier<GeneralManagerComplianceModel> {
  GeneralManagerComplianceNotifier() : super(const GeneralManagerComplianceModel(isLoading: true));

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

final general_manager_complianceProvider = StateNotifierProvider<GeneralManagerComplianceNotifier, GeneralManagerComplianceModel>((ref) {
  return GeneralManagerComplianceNotifier()..loadData();
});
