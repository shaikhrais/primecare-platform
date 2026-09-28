import 'package:flutter_riverpod/legacy.dart';
import '../models/head_of_marketing_leads_model.dart';

class HeadOfMarketingLeadsNotifier extends StateNotifier<HeadOfMarketingLeadsModel> {
  HeadOfMarketingLeadsNotifier() : super(const HeadOfMarketingLeadsModel(isLoading: true));

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

final head_of_marketing_leadsProvider = StateNotifierProvider<HeadOfMarketingLeadsNotifier, HeadOfMarketingLeadsModel>((ref) {
  return HeadOfMarketingLeadsNotifier()..loadData();
});
