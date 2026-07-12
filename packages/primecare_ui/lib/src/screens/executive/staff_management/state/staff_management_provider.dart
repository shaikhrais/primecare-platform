import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/staff_management_model.dart';

class StaffManagementNotifier extends StateNotifier<StaffManagementModel> {
  StaffManagementNotifier() : super(const StaffManagementModel(isLoading: true));

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

final staff_managementProvider = StateNotifierProvider<StaffManagementNotifier, StaffManagementModel>((ref) {
  return StaffManagementNotifier()..loadData();
});
