import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/release_management_model.dart';

class ReleaseManagementNotifier extends StateNotifier<ReleaseManagementModel> {
  ReleaseManagementNotifier() : super(const ReleaseManagementModel(isLoading: true));

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

final release_managementProvider = StateNotifierProvider<ReleaseManagementNotifier, ReleaseManagementModel>((ref) {
  return ReleaseManagementNotifier()..loadData();
});
