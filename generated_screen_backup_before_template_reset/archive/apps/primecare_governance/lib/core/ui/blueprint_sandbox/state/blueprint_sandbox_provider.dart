import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/blueprint_sandbox_model.dart';

class BlueprintSandboxNotifier extends StateNotifier<BlueprintSandboxModel> {
  BlueprintSandboxNotifier() : super(const BlueprintSandboxModel(isLoading: true));

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

final blueprint_sandboxProvider = StateNotifierProvider<BlueprintSandboxNotifier, BlueprintSandboxModel>((ref) {
  return BlueprintSandboxNotifier()..loadData();
});
