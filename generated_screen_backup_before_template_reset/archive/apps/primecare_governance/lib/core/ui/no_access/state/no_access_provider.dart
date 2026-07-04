import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/no_access_model.dart';

class NoAccessNotifier extends StateNotifier<NoAccessModel> {
  NoAccessNotifier() : super(const NoAccessModel(isLoading: true));

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

final no_accessProvider = StateNotifierProvider<NoAccessNotifier, NoAccessModel>((ref) {
  return NoAccessNotifier()..loadData();
});
