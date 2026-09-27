import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/admin_screen_health_model.dart';

class AdminScreenHealthNotifier extends StateNotifier<AdminScreenHealthModel> {
  AdminScreenHealthNotifier() : super(const AdminScreenHealthModel(isLoading: true));

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

final admin_screen_healthProvider = StateNotifierProvider<AdminScreenHealthNotifier, AdminScreenHealthModel>((ref) {
  return AdminScreenHealthNotifier()..loadData();
});
