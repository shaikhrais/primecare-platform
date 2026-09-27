import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/brand_asset_library_model.dart';

class BrandAssetLibraryNotifier extends StateNotifier<BrandAssetLibraryModel> {
  BrandAssetLibraryNotifier() : super(const BrandAssetLibraryModel(isLoading: true));

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

final brand_asset_libraryProvider = StateNotifierProvider<BrandAssetLibraryNotifier, BrandAssetLibraryModel>((ref) {
  return BrandAssetLibraryNotifier()..loadData();
});
