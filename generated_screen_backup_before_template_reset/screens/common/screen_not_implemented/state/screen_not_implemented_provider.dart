import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/screen_not_implemented_model.dart';

class ScreenNotImplementedNotifier extends StateNotifier<ScreenNotImplementedModel> {
  ScreenNotImplementedNotifier() : super(const ScreenNotImplementedModel(isLoading: true));

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

final screen_not_implementedProvider = StateNotifierProvider<ScreenNotImplementedNotifier, ScreenNotImplementedModel>((ref) {
  return ScreenNotImplementedNotifier()..loadData();
});
