import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/scheduling_operations4_k_model.dart';

class SchedulingOperations4KNotifier extends StateNotifier<SchedulingOperations4KModel> {
  SchedulingOperations4KNotifier() : super(const SchedulingOperations4KModel(isLoading: true));

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

final scheduling_operations4_kProvider = StateNotifierProvider<SchedulingOperations4KNotifier, SchedulingOperations4KModel>((ref) {
  return SchedulingOperations4KNotifier()..loadData();
});
