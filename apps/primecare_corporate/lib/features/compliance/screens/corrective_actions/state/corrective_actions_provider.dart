import 'package:flutter_riverpod/legacy.dart';
import '../models/corrective_actions_model.dart';

class CorrectiveActionsNotifier extends StateNotifier<CorrectiveActionsModel> {
  CorrectiveActionsNotifier() : super(const CorrectiveActionsModel(isLoading: true));

  Future<void> loadData() async {
    state = state.copyWith(isLoading: true);
    try {
      // TODO: Call API service
      state = state.copyWith(isLoading: false, data: const <String, dynamic>{});
    } catch (e) {
      state = state.copyWith(isLoading: false, errorMessage: e.toString());
    }
  }
}

final corrective_actionsProvider = StateNotifierProvider<CorrectiveActionsNotifier, CorrectiveActionsModel>((ref) {
  return CorrectiveActionsNotifier()..loadData();
});
