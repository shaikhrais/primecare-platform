import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/followup_model.dart';

class FollowupNotifier extends StateNotifier<FollowupModel> {
  FollowupNotifier() : super(const FollowupModel(isLoading: true));

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

final followupProvider = StateNotifierProvider<FollowupNotifier, FollowupModel>((ref) {
  return FollowupNotifier()..loadData();
});
