import 'package:flutter_riverpod/legacy.dart';
import '../models/head_of_marketing_content_approval_model.dart';

class HeadOfMarketingContentApprovalNotifier extends StateNotifier<HeadOfMarketingContentApprovalModel> {
  HeadOfMarketingContentApprovalNotifier() : super(const HeadOfMarketingContentApprovalModel(isLoading: true));

  Future<void> loadData() async {
    state = state.copyWith(isLoading: true);
    try {
      // TODO: Call API service
      state = state.copyWith(isLoading: false, data: const <String, dynamic>{});
    } catch (e) {
      state = state.copyWith(isLoading: false, errorMessage: e.toString());
    }
  }
}

final head_of_marketing_content_approvalProvider = StateNotifierProvider<HeadOfMarketingContentApprovalNotifier, HeadOfMarketingContentApprovalModel>((ref) {
  return HeadOfMarketingContentApprovalNotifier()..loadData();
});
