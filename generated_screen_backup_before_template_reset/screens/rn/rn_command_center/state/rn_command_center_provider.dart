import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/rn_command_center_model.dart';

class RnCommandCenterNotifier extends StateNotifier<RnCommandCenterModel> {
  RnCommandCenterNotifier() : super(const RnCommandCenterModel(isLoading: true));

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

final rn_command_centerProvider = StateNotifierProvider<RnCommandCenterNotifier, RnCommandCenterModel>((ref) {
  return RnCommandCenterNotifier()..loadData();
});
