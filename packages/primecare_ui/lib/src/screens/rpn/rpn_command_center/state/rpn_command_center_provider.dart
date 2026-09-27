import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/rpn_command_center_model.dart';

class RpnCommandCenterNotifier extends StateNotifier<RpnCommandCenterModel> {
  RpnCommandCenterNotifier() : super(const RpnCommandCenterModel(isLoading: true));

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

final rpn_command_centerProvider = StateNotifierProvider<RpnCommandCenterNotifier, RpnCommandCenterModel>((ref) {
  return RpnCommandCenterNotifier()..loadData();
});
