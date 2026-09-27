import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/cto_release_management_model.dart';

class CtoReleaseManagementNotifier extends StateNotifier<CtoReleaseManagementModel> {
  CtoReleaseManagementNotifier() : super(const CtoReleaseManagementModel(isLoading: true));

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

final cto_release_managementProvider = StateNotifierProvider<CtoReleaseManagementNotifier, CtoReleaseManagementModel>((ref) {
  return CtoReleaseManagementNotifier()..loadData();
});
