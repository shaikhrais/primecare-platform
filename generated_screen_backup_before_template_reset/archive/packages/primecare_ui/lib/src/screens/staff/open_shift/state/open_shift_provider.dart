import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/open_shift_model.dart';

class OpenShiftNotifier extends StateNotifier<OpenShiftModel> {
  OpenShiftNotifier() : super(const OpenShiftModel(isLoading: true));

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

final open_shiftProvider = StateNotifierProvider<OpenShiftNotifier, OpenShiftModel>((ref) {
  return OpenShiftNotifier()..loadData();
});
