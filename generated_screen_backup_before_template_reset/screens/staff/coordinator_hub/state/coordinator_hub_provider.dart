import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/coordinator_hub_model.dart';

class CoordinatorHubNotifier extends StateNotifier<CoordinatorHubModel> {
  CoordinatorHubNotifier() : super(const CoordinatorHubModel(isLoading: true));

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

final coordinator_hubProvider = StateNotifierProvider<CoordinatorHubNotifier, CoordinatorHubModel>((ref) {
  return CoordinatorHubNotifier()..loadData();
});
