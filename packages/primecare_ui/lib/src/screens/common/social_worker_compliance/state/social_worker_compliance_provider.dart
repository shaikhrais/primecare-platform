import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/social_worker_compliance_model.dart';

class SocialWorkerComplianceNotifier extends StateNotifier<SocialWorkerComplianceModel> {
  SocialWorkerComplianceNotifier() : super(const SocialWorkerComplianceModel(isLoading: true));

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

final social_worker_complianceProvider = StateNotifierProvider<SocialWorkerComplianceNotifier, SocialWorkerComplianceModel>((ref) {
  return SocialWorkerComplianceNotifier()..loadData();
});
