import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/ecosystem_state_board_model.dart';

class EcosystemStateBoardNotifier extends StateNotifier<EcosystemStateBoardModel> {
  EcosystemStateBoardNotifier() : super(const EcosystemStateBoardModel(isLoading: true));

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

final ecosystem_state_boardProvider = StateNotifierProvider<EcosystemStateBoardNotifier, EcosystemStateBoardModel>((ref) {
  return EcosystemStateBoardNotifier()..loadData();
});
