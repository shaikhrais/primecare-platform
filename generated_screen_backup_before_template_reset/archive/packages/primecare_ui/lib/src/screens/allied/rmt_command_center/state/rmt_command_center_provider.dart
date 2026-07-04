import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/rmt_command_center_model.dart';

class RmtCommandCenterNotifier extends StateNotifier<RmtCommandCenterModel> {
  RmtCommandCenterNotifier() : super(const RmtCommandCenterModel(isLoading: true));

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

final rmt_command_centerProvider = StateNotifierProvider<RmtCommandCenterNotifier, RmtCommandCenterModel>((ref) {
  return RmtCommandCenterNotifier()..loadData();
});
