import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/coo_command_center_model.dart';

class CooCommandCenterNotifier extends StateNotifier<CooCommandCenterModel> {
  CooCommandCenterNotifier() : super(const CooCommandCenterModel(isLoading: true));

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

final coo_command_centerProvider = StateNotifierProvider<CooCommandCenterNotifier, CooCommandCenterModel>((ref) {
  return CooCommandCenterNotifier()..loadData();
});
