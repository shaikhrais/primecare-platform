import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/role_access_model.dart';

class RoleAccessNotifier extends StateNotifier<RoleAccessModel> {
  RoleAccessNotifier() : super(const RoleAccessModel(isLoading: true));

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

final role_accessProvider = StateNotifierProvider<RoleAccessNotifier, RoleAccessModel>((ref) {
  return RoleAccessNotifier()..loadData();
});
