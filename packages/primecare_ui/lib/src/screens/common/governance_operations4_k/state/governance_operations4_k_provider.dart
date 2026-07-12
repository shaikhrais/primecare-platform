import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/governance_operations4_k_model.dart';

class GovernanceOperations4KNotifier extends StateNotifier<GovernanceOperations4KModel> {
  GovernanceOperations4KNotifier() : super(const GovernanceOperations4KModel(isLoading: true));

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

final governance_operations4_kProvider = StateNotifierProvider<GovernanceOperations4KNotifier, GovernanceOperations4KModel>((ref) {
  return GovernanceOperations4KNotifier()..loadData();
});
