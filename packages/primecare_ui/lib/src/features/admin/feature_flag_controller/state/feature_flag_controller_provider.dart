import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/feature_flag_controller_model.dart';

class FeatureFlagControllerNotifier extends StateNotifier<FeatureFlagControllerModel> {
  FeatureFlagControllerNotifier() : super(const FeatureFlagControllerModel(isLoading: true));

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

final feature_flag_controllerProvider = StateNotifierProvider<FeatureFlagControllerNotifier, FeatureFlagControllerModel>((ref) {
  return FeatureFlagControllerNotifier()..loadData();
});
