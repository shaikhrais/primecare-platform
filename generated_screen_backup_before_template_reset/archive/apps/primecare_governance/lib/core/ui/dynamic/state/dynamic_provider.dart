import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/dynamic_model.dart';

class DynamicNotifier extends StateNotifier<DynamicModel> {
  DynamicNotifier() : super(const DynamicModel(isLoading: true));

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

final dynamicProvider = StateNotifierProvider<DynamicNotifier, DynamicModel>((ref) {
  return DynamicNotifier()..loadData();
});
