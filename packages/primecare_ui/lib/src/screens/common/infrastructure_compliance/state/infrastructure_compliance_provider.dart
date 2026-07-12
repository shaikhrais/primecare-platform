import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/infrastructure_compliance_model.dart';

class InfrastructureComplianceNotifier extends StateNotifier<InfrastructureComplianceModel> {
  InfrastructureComplianceNotifier() : super(const InfrastructureComplianceModel(isLoading: true));

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

final infrastructure_complianceProvider = StateNotifierProvider<InfrastructureComplianceNotifier, InfrastructureComplianceModel>((ref) {
  return InfrastructureComplianceNotifier()..loadData();
});
