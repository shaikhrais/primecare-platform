import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/user_management_model.dart';

class UserManagementNotifier extends StateNotifier<UserManagementModel> {
  UserManagementNotifier() : super(const UserManagementModel(isLoading: true));

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

final user_managementProvider = StateNotifierProvider<UserManagementNotifier, UserManagementModel>((ref) {
  return UserManagementNotifier()..loadData();
});
