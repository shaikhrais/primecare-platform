import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/system_verification_compliance_model.dart';

class SystemVerificationComplianceNotifier extends StateNotifier<SystemVerificationComplianceModel> {
  SystemVerificationComplianceNotifier() : super(const SystemVerificationComplianceModel(isLoading: true));

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

final system_verification_complianceProvider = StateNotifierProvider<SystemVerificationComplianceNotifier, SystemVerificationComplianceModel>((ref) {
  return SystemVerificationComplianceNotifier()..loadData();
});
