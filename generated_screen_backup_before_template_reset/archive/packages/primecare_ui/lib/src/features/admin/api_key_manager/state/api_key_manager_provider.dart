import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/api_key_manager_model.dart';

class ApiKeyManagerNotifier extends StateNotifier<ApiKeyManagerModel> {
  ApiKeyManagerNotifier() : super(const ApiKeyManagerModel(isLoading: true));

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

final api_key_managerProvider = StateNotifierProvider<ApiKeyManagerNotifier, ApiKeyManagerModel>((ref) {
  return ApiKeyManagerNotifier()..loadData();
});
