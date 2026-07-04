import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/receptionist_compliance_model.dart';

class ReceptionistComplianceNotifier extends StateNotifier<ReceptionistComplianceModel> {
  ReceptionistComplianceNotifier() : super(const ReceptionistComplianceModel(isLoading: true));

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

final receptionist_complianceProvider = StateNotifierProvider<ReceptionistComplianceNotifier, ReceptionistComplianceModel>((ref) {
  return ReceptionistComplianceNotifier()..loadData();
});
