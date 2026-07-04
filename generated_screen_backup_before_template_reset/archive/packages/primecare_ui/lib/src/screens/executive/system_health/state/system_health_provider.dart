import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/system_health_model.dart';

class SystemHealthNotifier extends StateNotifier<SystemHealthModel> {
  SystemHealthNotifier() : super(const SystemHealthModel(isLoading: true));

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

final system_healthProvider = StateNotifierProvider<SystemHealthNotifier, SystemHealthModel>((ref) {
  return SystemHealthNotifier()..loadData();
});
