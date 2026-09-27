import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/controlled_substance_log_model.dart';

class ControlledSubstanceLogNotifier extends StateNotifier<ControlledSubstanceLogModel> {
  ControlledSubstanceLogNotifier() : super(const ControlledSubstanceLogModel(isLoading: true));

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

final controlled_substance_logProvider = StateNotifierProvider<ControlledSubstanceLogNotifier, ControlledSubstanceLogModel>((ref) {
  return ControlledSubstanceLogNotifier()..loadData();
});
