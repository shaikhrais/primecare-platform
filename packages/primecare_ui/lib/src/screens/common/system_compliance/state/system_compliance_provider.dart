import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/system_compliance_model.dart';

class SystemComplianceNotifier extends StateNotifier<SystemComplianceModel> {
  SystemComplianceNotifier() : super(const SystemComplianceModel(isLoading: true));

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

final system_complianceProvider = StateNotifierProvider<SystemComplianceNotifier, SystemComplianceModel>((ref) {
  return SystemComplianceNotifier()..loadData();
});
