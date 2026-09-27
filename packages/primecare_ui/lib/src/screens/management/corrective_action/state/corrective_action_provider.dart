import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/corrective_action_model.dart';

class CorrectiveActionNotifier extends StateNotifier<CorrectiveActionModel> {
  CorrectiveActionNotifier() : super(const CorrectiveActionModel(isLoading: true));

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

final corrective_actionProvider = StateNotifierProvider<CorrectiveActionNotifier, CorrectiveActionModel>((ref) {
  return CorrectiveActionNotifier()..loadData();
});
