import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/screen_status_model.dart';

class ScreenStatusNotifier extends StateNotifier<ScreenStatusModel> {
  ScreenStatusNotifier() : super(const ScreenStatusModel(isLoading: true));

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

final screen_statusProvider = StateNotifierProvider<ScreenStatusNotifier, ScreenStatusModel>((ref) {
  return ScreenStatusNotifier()..loadData();
});
