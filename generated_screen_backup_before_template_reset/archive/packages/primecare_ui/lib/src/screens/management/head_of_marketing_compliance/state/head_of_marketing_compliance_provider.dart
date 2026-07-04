import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/head_of_marketing_compliance_model.dart';

class HeadOfMarketingComplianceNotifier extends StateNotifier<HeadOfMarketingComplianceModel> {
  HeadOfMarketingComplianceNotifier() : super(const HeadOfMarketingComplianceModel(isLoading: true));

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

final head_of_marketing_complianceProvider = StateNotifierProvider<HeadOfMarketingComplianceNotifier, HeadOfMarketingComplianceModel>((ref) {
  return HeadOfMarketingComplianceNotifier()..loadData();
});
