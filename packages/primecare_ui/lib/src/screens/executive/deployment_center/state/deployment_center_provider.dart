import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/deployment_center_model.dart';

class DeploymentCenterNotifier extends StateNotifier<DeploymentCenterModel> {
  DeploymentCenterNotifier() : super(const DeploymentCenterModel(isLoading: true));

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

final deployment_centerProvider = StateNotifierProvider<DeploymentCenterNotifier, DeploymentCenterModel>((ref) {
  return DeploymentCenterNotifier()..loadData();
});
