import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/multi_center_trial_collaboration_model.dart';

class MultiCenterTrialCollaborationNotifier extends StateNotifier<MultiCenterTrialCollaborationModel> {
  MultiCenterTrialCollaborationNotifier() : super(const MultiCenterTrialCollaborationModel(isLoading: true));

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

final multi_center_trial_collaborationProvider = StateNotifierProvider<MultiCenterTrialCollaborationNotifier, MultiCenterTrialCollaborationModel>((ref) {
  return MultiCenterTrialCollaborationNotifier()..loadData();
});
