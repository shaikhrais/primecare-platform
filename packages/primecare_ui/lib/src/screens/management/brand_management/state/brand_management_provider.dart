import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/brand_management_model.dart';

class BrandManagementNotifier extends StateNotifier<BrandManagementModel> {
  BrandManagementNotifier() : super(const BrandManagementModel(isLoading: true));

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

final brand_managementProvider = StateNotifierProvider<BrandManagementNotifier, BrandManagementModel>((ref) {
  return BrandManagementNotifier()..loadData();
});
