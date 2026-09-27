import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/substance_abuse_prevention_tracker_model.dart';

class SubstanceAbusePreventionTrackerNotifier extends StateNotifier<SubstanceAbusePreventionTrackerModel> {
  SubstanceAbusePreventionTrackerNotifier() : super(const SubstanceAbusePreventionTrackerModel(isLoading: true));

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

final substance_abuse_prevention_trackerProvider = StateNotifierProvider<SubstanceAbusePreventionTrackerNotifier, SubstanceAbusePreventionTrackerModel>((ref) {
  return SubstanceAbusePreventionTrackerNotifier()..loadData();
});
