import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/psw_shift_tracker_model.dart';

class PswShiftTrackerNotifier extends StateNotifier<PswShiftTrackerModel> {
  PswShiftTrackerNotifier() : super(const PswShiftTrackerModel(isLoading: true));

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

final psw_shift_trackerProvider = StateNotifierProvider<PswShiftTrackerNotifier, PswShiftTrackerModel>((ref) {
  return PswShiftTrackerNotifier()..loadData();
});
