import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/local_marketing_manager_compliance_model.dart';

class LocalMarketingManagerComplianceNotifier extends StateNotifier<LocalMarketingManagerComplianceModel> {
  LocalMarketingManagerComplianceNotifier() : super(const LocalMarketingManagerComplianceModel(isLoading: true));

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

final local_marketing_manager_complianceProvider = StateNotifierProvider<LocalMarketingManagerComplianceNotifier, LocalMarketingManagerComplianceModel>((ref) {
  return LocalMarketingManagerComplianceNotifier()..loadData();
});
