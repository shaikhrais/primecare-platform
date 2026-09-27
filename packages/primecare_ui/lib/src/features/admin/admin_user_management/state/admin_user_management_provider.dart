import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/admin_user_management_model.dart';

class AdminUserManagementNotifier extends StateNotifier<AdminUserManagementModel> {
  AdminUserManagementNotifier() : super(const AdminUserManagementModel(isLoading: true));

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

final admin_user_managementProvider = StateNotifierProvider<AdminUserManagementNotifier, AdminUserManagementModel>((ref) {
  return AdminUserManagementNotifier()..loadData();
});
