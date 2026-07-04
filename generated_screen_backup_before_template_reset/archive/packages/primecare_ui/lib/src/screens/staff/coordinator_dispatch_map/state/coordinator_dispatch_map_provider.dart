import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/coordinator_dispatch_map_model.dart';

class CoordinatorDispatchMapNotifier extends StateNotifier<CoordinatorDispatchMapModel> {
  CoordinatorDispatchMapNotifier() : super(const CoordinatorDispatchMapModel(isLoading: true));

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

final coordinator_dispatch_mapProvider = StateNotifierProvider<CoordinatorDispatchMapNotifier, CoordinatorDispatchMapModel>((ref) {
  return CoordinatorDispatchMapNotifier()..loadData();
});
