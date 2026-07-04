import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/control_center_model.dart';

class ControlCenterNotifier extends StateNotifier<ControlCenterModel> {
  ControlCenterNotifier() : super(const ControlCenterModel(isLoading: true));

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

final control_centerProvider = StateNotifierProvider<ControlCenterNotifier, ControlCenterModel>((ref) {
  return ControlCenterNotifier()..loadData();
});
