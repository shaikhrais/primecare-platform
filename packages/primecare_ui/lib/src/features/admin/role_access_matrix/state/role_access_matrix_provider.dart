import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/role_access_matrix_model.dart';

class RoleAccessMatrixNotifier extends StateNotifier<RoleAccessMatrixModel> {
  RoleAccessMatrixNotifier() : super(const RoleAccessMatrixModel(isLoading: true));

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

final role_access_matrixProvider = StateNotifierProvider<RoleAccessMatrixNotifier, RoleAccessMatrixModel>((ref) {
  return RoleAccessMatrixNotifier()..loadData();
});
