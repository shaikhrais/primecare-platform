import 'package:flutter_riverpod/legacy.dart';
import '../models/head_of_marketing_brand_assets_model.dart';

class HeadOfMarketingBrandAssetsNotifier extends StateNotifier<HeadOfMarketingBrandAssetsModel> {
  HeadOfMarketingBrandAssetsNotifier() : super(const HeadOfMarketingBrandAssetsModel(isLoading: true));

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

final head_of_marketing_brand_assetsProvider = StateNotifierProvider<HeadOfMarketingBrandAssetsNotifier, HeadOfMarketingBrandAssetsModel>((ref) {
  return HeadOfMarketingBrandAssetsNotifier()..loadData();
});
