import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/local_marketing_manager_assets_model.dart';

class LocalMarketingManagerAssetsNotifier extends StateNotifier<LocalMarketingManagerAssetsModel> {
  LocalMarketingManagerAssetsNotifier() : super(const LocalMarketingManagerAssetsModel(isLoading: true));

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

final local_marketing_manager_assetsProvider = StateNotifierProvider<LocalMarketingManagerAssetsNotifier, LocalMarketingManagerAssetsModel>((ref) {
  return LocalMarketingManagerAssetsNotifier()..loadData();
});
