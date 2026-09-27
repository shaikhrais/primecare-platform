import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/policy_exception_tracker_model.dart';

class PolicyExceptionTrackerNotifier extends StateNotifier<PolicyExceptionTrackerModel> {
  PolicyExceptionTrackerNotifier() : super(const PolicyExceptionTrackerModel(isLoading: true));

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

final policy_exception_trackerProvider = StateNotifierProvider<PolicyExceptionTrackerNotifier, PolicyExceptionTrackerModel>((ref) {
  return PolicyExceptionTrackerNotifier()..loadData();
});
