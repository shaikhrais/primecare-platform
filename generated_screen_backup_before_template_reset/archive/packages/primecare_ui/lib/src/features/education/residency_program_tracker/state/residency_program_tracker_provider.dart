import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/residency_program_tracker_model.dart';

class ResidencyProgramTrackerNotifier extends StateNotifier<ResidencyProgramTrackerModel> {
  ResidencyProgramTrackerNotifier() : super(const ResidencyProgramTrackerModel(isLoading: true));

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

final residency_program_trackerProvider = StateNotifierProvider<ResidencyProgramTrackerNotifier, ResidencyProgramTrackerModel>((ref) {
  return ResidencyProgramTrackerNotifier()..loadData();
});
