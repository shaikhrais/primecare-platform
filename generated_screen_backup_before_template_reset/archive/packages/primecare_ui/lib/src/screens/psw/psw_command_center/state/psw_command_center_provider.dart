import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/psw_command_center_model.dart';

class PswCommandCenterNotifier extends StateNotifier<PswCommandCenterModel> {
  PswCommandCenterNotifier() : super(const PswCommandCenterModel(isLoading: true));

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

final psw_command_centerProvider = StateNotifierProvider<PswCommandCenterNotifier, PswCommandCenterModel>((ref) {
  return PswCommandCenterNotifier()..loadData();
});
