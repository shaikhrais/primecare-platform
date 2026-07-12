import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/intake_coordinator_follow_up_model.dart';

class IntakeCoordinatorFollowUpNotifier extends StateNotifier<IntakeCoordinatorFollowUpModel> {
  IntakeCoordinatorFollowUpNotifier() : super(const IntakeCoordinatorFollowUpModel(isLoading: true));

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

final intake_coordinator_follow_upProvider = StateNotifierProvider<IntakeCoordinatorFollowUpNotifier, IntakeCoordinatorFollowUpModel>((ref) {
  return IntakeCoordinatorFollowUpNotifier()..loadData();
});
