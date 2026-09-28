import 'package:flutter_riverpod/legacy.dart';
import '../models/governance_hud_model.dart';

class GovernanceHudNotifier extends StateNotifier<GovernanceHudModel> {
  GovernanceHudNotifier() : super(const GovernanceHudModel(isLoading: true));

  Future<void> loadData() async {
    state = state.copyWith(isLoading: true);
    try {
      // TODO: Call API service
      state = state.copyWith(isLoading: false, data: const <String, dynamic>{});
    } catch (e) {
      state = state.copyWith(isLoading: false, errorMessage: e.toString());
    }
  }
}

final governance_hudProvider = StateNotifierProvider<GovernanceHudNotifier, GovernanceHudModel>((ref) {
  return GovernanceHudNotifier()..loadData();
});
