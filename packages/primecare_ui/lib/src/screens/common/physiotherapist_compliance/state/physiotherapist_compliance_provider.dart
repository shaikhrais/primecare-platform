import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/physiotherapist_compliance_model.dart';

class PhysiotherapistComplianceNotifier extends StateNotifier<PhysiotherapistComplianceModel> {
  PhysiotherapistComplianceNotifier() : super(const PhysiotherapistComplianceModel(isLoading: true));

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

final physiotherapist_complianceProvider = StateNotifierProvider<PhysiotherapistComplianceNotifier, PhysiotherapistComplianceModel>((ref) {
  return PhysiotherapistComplianceNotifier()..loadData();
});
